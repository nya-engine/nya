require "./gl/*"
require "log/entry"

module Nya::Render::Backends::GL

  @@log : Log = Nya.log.for(self)

  include ShaderVars
  include VBOGenerator

  @current_camera : Camera? = nil

  def current_camera : Camera
    @current_camera.not_nil!
  end

  enum DebugSource
    API             = LibGL::DEBUG_SOURCE_API
    WINDOW_SYSTEM   = LibGL::DEBUG_SOURCE_WINDOW_SYSTEM
    SHADER_COMPILER = LibGL::DEBUG_SOURCE_SHADER_COMPILER
    THIRD_PARTY     = LibGL::DEBUG_SOURCE_THIRD_PARTY
    APPLICATION     = LibGL::DEBUG_SOURCE_APPLICATION
    OTHER           = LibGL::DEBUG_SOURCE_OTHER
    DONT_CARE       = LibGL::DONT_CARE
  end

  enum DebugType
    ERROR                = LibGL::DEBUG_TYPE_ERROR
    DEPRECATED_BEHAVIOUR = LibGL::DEBUG_TYPE_DEPRECATED_BEHAVIOR
    UNDEFINED_BEHAVIOUR  = LibGL::DEBUG_TYPE_UNDEFINED_BEHAVIOR
    PORTABILITY          = LibGL::DEBUG_TYPE_PORTABILITY
    PERFORMANCE          = LibGL::DEBUG_TYPE_PERFORMANCE
    MARKER               = LibGL::DEBUG_TYPE_MARKER
    PUSH_GROUP           = LibGL::DEBUG_TYPE_PUSH_GROUP
    POP_GROUP            = LibGL::DEBUG_TYPE_POP_GROUP
    OTHER                = LibGL::DEBUG_TYPE_OTHER
    DONT_CARE            = LibGL::DONT_CARE

    def to_severity
      case self
      when .error?
        ::Log::Severity::Error
      when .portability?, .performance?, .undefined_behaviour?, .deprecated_behaviour?
        ::Log::Severity::Warn
      when .marker?
        ::Log::Severity::Info
      else
        ::Log::Severity::Debug
      end
    end
  end

  def create_object(objtype : Symbol) : Render::Backend::Metadata
    id = uninitialized LibGL::GLuint
    Metadata.new(objtype, case objtype
    when :texture
      LibGL.gen_textures 1, pointerof(id)
      id
    when :vertex_buffer
      LibGL.gen_buffers 1, pointerof(id)
      id
    else
      raise "Unknown object type #{objtype}"
    end)
  end

  def delete_object(object : Render::Backend::Metadata)
    obj = object.as?(Metadata)
    return if obj.nil?
    id = obj.not_nil!.id
    case obj.not_nil!.object_type
    when :texture
      LibGL.delete_textures(1, pointerof(id))
    when :vertex_buffer
      LibGL.delete_buffers(1, pointerof(id))
    else
      raise "Invalid object type #{obj.object_type}"
    end
  end

  def draw_texture(tex : Nya::Render::Backend::Metadata, pts : Array(CrystalEdge::Vector3))
    raise "#{tex} is not a valid metadata!" unless tex.is_a? Metadata
    raise "#{tex} is not a valid texture!" unless tex.object_type == :texture
    LibGL.active_texture LibGL::TEXTURE0
    LibGL.enable(LibGL::TEXTURE_2D)
    LibGL.enable(LibGL::ALPHA_TEST)
    LibGL.bind_texture(LibGL::TEXTURE_2D, tex.as(Metadata).id)
    draw do
      LibGL.tex_coord2d(0.0, 0.0)
      LibGL.vertex3d(*pts[0].to_gl)
      LibGL.tex_coord2d(1.0, 0.0)
      LibGL.vertex3d(*pts[1].to_gl)
      LibGL.tex_coord2d(1.0, 1.0)
      LibGL.vertex3d(*pts[2].to_gl)
      LibGL.tex_coord2d(0.0, 1.0)
      LibGL.vertex3d(*pts[3].to_gl)
    end
    LibGL.disable(LibGL::TEXTURE_2D)
    LibGL.disable(LibGL::ALPHA_TEST)
  end

  def draw_texture(tex : Nya::Render::Backend::Metadata, x, y, w, h)
    va = unproject(CrystalEdge::Vector3.new(x, y, 0.1))
    vb = unproject(CrystalEdge::Vector3.new(x + w, y + h, 0.1))
    #pts = [v2(x, y + h), v2(x + w, y + h), v2(x + w, y), v2(x, y)].map { |x| un_project x }

    pts = [
      {x, y + h, 0.1},
      {x + w, y + h, 0.1},
      {x + w, y, 0.1},
      {x, y, 0.1}
    ].map{ |x| unproject CrystalEdge::Vector3.new(*x) }
    draw_texture tex, pts
  end

  def draw_texture(texture : Texture, x, y, w, h)
    texture.prepare_metadata!

    draw_texture texture.metadata x, y, w, h
  end

  def draw_texture(texture : Texture, pts : Array(CrystalEdge::Vector3))
    texture.prepare_metadata!

    draw_texture texture.metadata pts
  end

  def draw_texture(texture : Texture2D)
    draw_texture texture, *texture.position.to_gl, *texture.size.to_gl
  end

  def draw_texture(texture : Texture3D)
    draw_texture texture, texture.points
  end

  def draw_shape(shape : Models::Shape)
    meta = shape.metadata.as(VBOMetadata)
    LibGL.enable_client_state LibGL::VERTEX_ARRAY
    if meta.use_normal
      LibGL.enable_client_state LibGL::NORMAL_ARRAY
    else
      LibGL.disable_client_state LibGL::NORMAL_ARRAY
    end
    
    if meta.use_texcoord
      LibGL.enable_client_state LibGL::TEXTURE_COORD_ARRAY 
    else
      LibGL.disable_client_state LibGL::TEXTURE_COORD_ARRAY 
    end

    LibGL.bind_buffer LibGL::ARRAY_BUFFER, meta.id
    LibGL.vertex_pointer 3, LibGL::DOUBLE, meta.raw_stride, Pointer(Void).new(0)

    offset = 0

    if meta.use_normal
      offset += 3
      LibGL.normal_pointer LibGL::DOUBLE, meta.raw_stride, Pointer(Void).new(offset * sizeof(Float64))
    end

    if meta.use_texcoord
      offset += 3
      LibGL.tex_coord_pointer 3, LibGL::DOUBLE, meta.raw_stride, Pointer(Void).new(offset * sizeof(Float64))
    end

    LibGL.draw_arrays(LibGL::TRIANGLES, 0, meta.count)
  end

  def draw_mesh(mesh : Mesh)
    generate_buffers! mesh
    mesh.shapes.each do |key, shape|
      draw_shape shape
    end
  end

  def load_texture(m : Nya::Render::Backend::Metadata, w, h, texture : Bytes)
    LibGL.bind_texture(LibGL::TEXTURE_2D, m.as(Metadata).id)

    LibGL.tex_parameteri(LibGL::TEXTURE_2D, LibGL::TEXTURE_MIN_FILTER, LibGL::LINEAR)
    LibGL.tex_parameteri(LibGL::TEXTURE_2D, LibGL::TEXTURE_MAG_FILTER, LibGL::LINEAR)
    LibGL.tex_image2d(
      LibGL::TEXTURE_2D,
      0,
      LibGL::RGBA,
      w,
      h,
      0,
      LibGL::BGRA,
      LibGL::UNSIGNED_BYTE,
      texture
    )
  end

  def draw_camera(c : Camera, &block)
    @current_camera = c
    return unless c.enabled?

    with_matrix(LibGL::PROJECTION) do
      LibGL.load_identity
      vp = c.viewport * size
      LibGL.viewport(vp.x.to_i, vp.y.to_i, vp.width.to_i, vp.height.to_i)
      LibGL.scissor(vp.x.to_i, vp.y.to_i, vp.width.to_i, vp.height.to_i)
      LibGLU.perspective(c.angle_of_view, c.viewport.width/c.viewport.height, c.near, c.far)
      LibGL.rotatef(-c.parent.rotation.z, 0.0, 0.0, 1.0)
      LibGL.rotatef(-c.parent.rotation.y, 1.0, 0.0, 0.0)
      LibGL.rotatef(-c.parent.rotation.x, 0.0, 0.0, 1.0)
      LibGL.translatef(*(-c.parent.position).to_gl)
      with_matrix(LibGL::MODELVIEW) do
        LibGL.load_identity
        unless c.metadata?.is_a? Nya::Render::Backends::GL::Metadata
          c.metadata = CameraMetadata.new(0u32)
        end
        if md = c.metadata?.as?(CameraMetadata)
          md.not_nil!.modelview = get_modelview_matrix
          md.not_nil!.projection = get_projection_matrix
          md.not_nil!.viewport = get_viewport
        else
          @@log.warn { "Camera has invalid metadata : #{c.metadata.class.name}" }
        end
        yield
      end
    end
  end

  def compile_shaders(sh : ShaderProgram)
    id = GL::GLSLCompiler.link sh.sets.select(&.format.==("glsl")).first.files.map(&->GL::GLSLCompiler.compile(String))
    sh.metadata = Metadata.new(:shader_program, id)
  end

  def delete_shaders(sh : ShaderProgram)
    meta = sh.metadata
    if meta.nil?
      @@log.error { "Cannot delete shader program #{sh} : metadata is nil" }
    else
      if meta.object_type == :shader_program
        LibGL.delete_program meta.as(GL::Metadata).id
        sh.metadata = nil
      else
        @@log.error { "Cannot delete shader program #{sh} : probably not a shader program" } 
      end
    end
  end

  def relink_program(shp : ShaderProgram)
    GL::GLSLCompiler.link_program! sh.metadata.as(Metadata).id
  end

  @shader_stack = Deque(ShaderProgram?).new

  def use_shader_program(shp : ShaderProgram?)
    @shader_stack << shp
    if shp.nil?
      LibGL.use_program 0
    else
      LibGL.use_program shp.metadata.as(Metadata).id
      apply_shader_vars shp
    end
  end

  def unuse_shader_program
    shp = @shader_stack.pop?
    shp = @shader_stack.last?
    LibGL.use_program(shp.nil? ? 0u32 : shp.not_nil!.metadata.as(Metadata).id)
  end

  def with_shader_program(shp : ShaderProgram?, &block)
    begin
      use_shader_program shp
      yield
    ensure
      unuse_shader_program
    end
  end

  # Unprojects screen point to world coordinates
  def unproject(v : CrystalEdge::Vector3) : CrystalEdge::Vector3
    mm = get_modelview_matrix
    pm = get_projection_matrix
    vp = get_viewport
    ox = uninitialized Float64
    oy = uninitialized Float64
    oz = uninitialized Float64

    LibGLU.un_project(
      *v.to_gl,
      mm,
      pm,
      vp,
      pointerof(ox).as(Pointer(Void)),
      pointerof(oy).as(Pointer(Void)),
      pointerof(oz).as(Pointer(Void))
    )
    CrystalEdge::Vector3.new(ox, oy, oz)
  end

  def unproject(c : Camera, v) : CrystalEdge::Vector3
    meta = c.metadata.not_nil!.as(CameraMetadata)
    mm = meta.modelview
    pm = meta.projection
    vp = meta.viewport
    ox = uninitialized Float64
    oy = uninitialized Float64
    oz = uninitialized Float64

    LibGLU.un_project(
      *v.to_gl,
      mm,
      pm,
      vp,
      pointerof(ox).as(Pointer(Void)),
      pointerof(oy).as(Pointer(Void)),
      pointerof(oz).as(Pointer(Void))
    )
    CrystalEdge::Vector3.new(ox, oy, oz)
  end

  def project(c : Camera, v) : CrystalEdge::Vector3
    meta = c.metadata.not_nil!.as(CameraMetadata)
    mm = meta.modelview
    pm = meta.projection
    vp = meta.viewport
    ox = uninitialized Float64
    oy = uninitialized Float64
    oz = uninitialized Float64

    LibGLU.project(
      *v.to_gl,
      mm,
      pm,
      vp,
      pointerof(ox).as(Pointer(Void)),
      pointerof(oy).as(Pointer(Void)),
      pointerof(oz).as(Pointer(Void))
    )
    CrystalEdge::Vector3.new(ox, oy, oz)
  end

  def project(v : CrystalEdge::Vector3) : CrystalEdge::Vector3
    mm = get_modelview_matrix
    pm = get_projection_matrix
    vp = get_viewport
    ox = uninitialized Float64
    oy = uninitialized Float64
    oz = uninitialized Float64

    LibGLU.project(
      *v.to_gl,
      mm,
      pm,
      vp,
      pointerof(ox).as(Pointer(Void)),
      pointerof(oy).as(Pointer(Void)),
      pointerof(oz).as(Pointer(Void))
    )
    CrystalEdge::Vector3.new(ox, oy, oz)
  end

  def draw_game_object(obj : ::Nya::GameObject, &block)
    with_matrix LibGL::MODELVIEW do
      LibGL.rotatef(obj.rotation.x, 0.0, 0.0, 1.0)
      LibGL.rotatef(obj.rotation.y, 1.0, 0.0, 0.0)
      LibGL.rotatef(obj.rotation.z, 0.0, 0.0, 1.0)
      LibGL.translatef(*obj.position.to_gl)
      yield
    end
  end

  def draw(mode = LibGL::QUADS, &block)
    LibGL.begin mode
    begin
      yield
    ensure
      LibGL._end
    end
  end

  def supports_shaders? : Bool
    true
  end

  def shader_formats : Array(String)
    %w(glsl)
  end

  def shader_extensions : Array(String)
    %w(glsl frag vert tcsh tesh comp geom)
  end

  def max_textures : Int32
    LibGL.get_integerv LibGL::MAX_TEXTURE_UNITS, out m

    m
  end

  # :nodoc:
  alias DebugCallback = LibGL::Gldebugproc

  @debug_cb = DebugCallback.new do |source, type, id, severity, length, msg, param|
    this = Box(self).unbox(param)
    this.debug source, type, id, severity, String.new(msg, length)
    nil
  end

  # :nodoc:
  private def set_debug_callback!
    LibGL.debug_message_callback @debug_cb, Box(self).box(self)
    @@log.debug { "GL Debug callback set!" }
  end

  # :nodoc:
  def debug(s, t, i, sev, msg)
    src = DebugSource.from_value s
    type = DebugType.from_value t
    raise msg if type.error?
    {% for level in {:trace, :info, :notice, :debug, :warn, :error, :fatal} %}
        if type.to_severity.{{ level.id }}?
          @@log.{{level.id}} { "[#{src}]#{msg}" }
        end
    {% end %}
    
  end

  private def with_matrix(mode, &block)
    LibGL.matrix_mode mode
    LibGL.push_matrix
    yield
    LibGL.matrix_mode mode
    LibGL.pop_matrix
  end

  private def get_matrix(mat, type : U.class) : U forall U
    matrix = uninitialized U
    {% if U.type_vars.first <= Int %}
      LibGL.get_integerv(mat, matrix)
    {% else %}
      LibGL.get_doublev(mat, matrix)
    {% end %}
    matrix
  end

  private def get_modelview_matrix
    get_matrix LibGL::MODELVIEW_MATRIX, StaticArray(Float64, 16)
  end

  private def get_projection_matrix
    get_matrix LibGL::PROJECTION_MATRIX, StaticArray(Float64, 16)
  end

  private def get_viewport
    get_matrix LibGL::VIEWPORT, StaticArray(Int32, 4)
  end


end
