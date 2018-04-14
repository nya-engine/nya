require "../../bindings/gl"
require "../../bindings/glu"
require "../../bindings/sdl2"
require "./gl/*"

module Nya::Render::Backends
  class GL_SDL < Backend
    include GL::ShaderVars
    include GL::VBOGenerator

    alias Metadata = GL::Metadata

    @window : Pointer(LibSDL2::Window)

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
          Logger::Severity::ERROR
        when .portability?, .performance?, .undefined_behaviour?, .deprecated_behaviour?
          Logger::Severity::WARN
        when .marker?
          Logger::Severity::INFO
        else
          Logger::Severity::DEBUG
        end
      end
    end

    # :nodoc:
    WP_CENTERED = 0x2FFF0000

    def self.backend_name
      "OpenGL + SDL2"
    end

    def supports_shaders?
      true
    end

    def shader_formats
      %w(glsl)
    end

    def shader_extensions
      %w(glsl frag vert tcsh tesh comp geom)
    end

    def resizeable?
      true
    end

    def size
      LibSDL2.get_window_size @window, out x, out y
      CrystalEdge::Vector2.new(x.to_f64, y.to_f64)
    end

    def size=(v : CrystalEdge::Vector2)
      LibSDL2.set_window_size(@window, v.x.to_i32, v.y.to_i32)
    end

    def has_title?
      true
    end

    def title
      String.new LibSDL2.get_window_title @window
    end

    def title=(t)
      LibSDL2.set_window_title @window, t
      t
    end

    def quit
      LibSDL2.quit
    end

    def initialize(size : CrystalEdge::Vector2, title : String, fullscreen = false)
      raise LibSDL2.get_error.to_s if LibSDL2.init(LibSDL2::INIT_VIDEO) < 0

      LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLDOUBLEBUFFER, 1)
      LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLREDSIZE, 6)
      LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLBLUESIZE, 6)
      LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLGREENSIZE, 6)

      @window = LibSDL2.create_window(title, WP_CENTERED, WP_CENTERED, size.x.to_i32, size.y.to_i32, LibSDL2::WindowFlags::WINDOWSHOWN | LibSDL2::WindowFlags::WINDOWOPENGL)
      raise LibSDL2.get_error.as(String) if @window.null?
      LibSDL2.set_window_resizable(@window, LibSDL2::Bool::TRUE)
      @gl_ctx = LibSDL2.gl_create_context(@window)

      raise LibSDL2.get_error.as(String) if @gl_ctx.null?

      Nya.log.info "Max GL lights : #{Render::Light.max_lights}"

      LibGL.clear_color(0.0, 0.0, 0.0, 0.0)
      LibGL.clear_depth(1.0)
      LibGL.depth_func(LibGL::LESS)
      LibGL.enable(LibGL::DEPTH_TEST)
      LibGL.enable(LibGL::COLOR_MATERIAL)
      LibGL.enable LibGL::LIGHTING
      LibGL.alpha_func(LibGL::GREATER, 0.1)
      LibGL.shade_model(LibGL::SMOOTH)
      LibGL.blend_func(LibGL::SRC_ALPHA, LibGL::ONE_MINUS_SRC_ALPHA)

      LibGL.enable LibGL::DEBUG_OUTPUT
      LibGL.enable LibGL::DEBUG_OUTPUT_SYNCHRONOUS
      set_debug_callback!
    end

    def draw(mode = LibGL::QUADS, &block)
      LibGL.begin mode
      begin
        yield
      ensure
        LibGL._end
      end
    end

    def update
      while LibSDL2.poll_event(out evt) != 0
        case evt.type
        when LibSDL2::EventType::KEYUP
          Nya::Event.send :key_up, Nya::Input::KeyboardEvent.new(evt.key)
        when LibSDL2::EventType::KEYDOWN
          Nya::Event.send :key_down, Nya::Input::KeyboardEvent.new(evt.key)
        when LibSDL2::EventType::QUIT
          evt = Nya::Event.new
          Nya::Event.send :quit, evt
          exit 0 unless evt.status.dead?
        when LibSDL2::EventType::MOUSEMOTION
          Nya::Event.send :mouse_motion, Nya::Input::MouseMotionEvent.new(evt.motion)
        when LibSDL2::EventType::MOUSEWHEEL
          Nya::Event.send :mouse_wheel, Nya::Input::MouseWheelEvent.new(evt.wheel)
        when LibSDL2::EventType::MOUSEBUTTONUP
          Nya::Event.send :mouse_button_up, Nya::Input::MouseButtonEvent.new(evt.button)
        when LibSDL2::EventType::MOUSEBUTTONDOWN
          Nya::Event.send :mouse_button_down, Nya::Input::MouseButtonEvent.new(evt.button)
        end
      end
      # TODO
    end

    def render(&block)
      LibGL.clear_color(0.0, 0.0, 0.0, 1.0)
      LibGL.clear(LibGL::COLOR_BUFFER_BIT | LibGL::DEPTH_BUFFER_BIT)
      block.call
      LibGL.flush
      LibSDL2.gl_swap_window(@window)
    end

    def create_object(objtype : Symbol)
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
      LibGL.enable_client_state LibGL::NORMAL_ARRAY if meta.use_normal
      LibGL.enable_client_state LibGL::TEXTURE_COORD_ARRAY if meta.use_texcoord

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
      return unless c.enabled?

      with_matrix(LibGL::PROJECTION) do
        LibGL.load_identity
        vp = c.viewport * size
        LibGL.viewport(vp.x.to_i, vp.y.to_i, vp.width.to_i, vp.height.to_i)
        LibGL.scissor(vp.x.to_i, vp.y.to_i, vp.width.to_i, vp.height.to_i)
        LibGLU.perspective(c.angle_of_view, c.viewport.width/c.viewport.height, c.near, c.far)
        LibGL.rotatef(-c.parent.rotation.x, 1.0, 0.0, 0.0)
        LibGL.rotatef(-c.parent.rotation.y, 0.0, 1.0, 0.0)
        LibGL.rotatef(-c.parent.rotation.z, 0.0, 0.0, 1.0)
        LibGL.translatef(*(-c.parent.position).to_gl)
        with_matrix(LibGL::MODELVIEW) do
          LibGL.load_identity
          yield
        end
      end
    end

    def compile_shaders(sh : ShaderProgram)
      id = GL::GLSLCompiler.link sh.sets.select(&.format.==("glsl")).first.files.map(&->GL::GLSLCompiler.compile(String))
      sh.metadata = Metadata.new(:shader_program, id)
    end

    def relink_program(shp : ShaderProgram)
      GL::GLSLCompiler.link_program! sh.metadata.as(Metadata).id
    end

    @shader_stack = Deque(ShaderProgram).new

    def use_shader_program(shp : ShaderProgram)
      @shader_stack << shp
      LibGL.use_program shp.metadata.as(Metadata).id
    end

    def unuse_shader_program
      shp = @shader_stack.pop?
      LibGL.use_program(shp.nil? ? 0u32 : shp.not_nil!.metadata.as(Metadata).id)
    end

    def with_shader_program(shp : ShaderProgram?, &block)
      begin
        use_shader_program shp.not_nil! unless shp.nil?
        yield
      ensure
        unuse_shader_program unless shp.nil?
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
        LibGL.rotatef(obj.rotation.x, 1.0, 0.0, 0.0)
        LibGL.rotatef(obj.rotation.y, 0.0, 1.0, 0.0)
        LibGL.rotatef(obj.rotation.z, 0.0, 0.0, 1.0)
        LibGL.translatef(*obj.position.to_gl)
        yield
      end
    end



    # :nodoc:
    alias DebugCallback = LibGL::Gldebugproc

    @debug_cb = DebugCallback.new do |source, type, id, severity, length, msg, param|
      this = Box(self).unbox(param)
      this.debug source, type, id, severity, String.new(msg, length)
    end

    # :nodoc:
    private def set_debug_callback!
      LibGL.debug_message_callback @debug_cb, Box(self).box(self)
      Nya.log.debug "GL Debug callback set!", "Nya"
    end

    # :nodoc:
    def debug(s, t, i, sev, msg)
      src = DebugSource.from_value s
      type = DebugType.from_value t
      raise msg if type.error?
      Nya.log.log type.to_severity, msg, src.to_s
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
end
