require "../object"
require "models"
require "./shader_compiler"
require "./shader_vars"

# Extension for `models` shard
module Models
  # Vertex structure
  struct Vertex
    # Renders vertex using OpenGL subroutines
    # Prefer use vertex buffers as they are much faster on models with many vertices
    @[AlwaysInline]
    def render!
      LibGL.vertex3d *coord.to_gl

      unless normal.nil?
        LibGL.normal3d *normal.not_nil!.to_gl
      end

      if texcoord.nil?
        LibGL.color3d *coord.to_gl
      else
        LibGL.tex_coord3d *texcoord.not_nil!.to_gl
      end
    end

    # :nodoc:
    @[AlwaysInline]
    private def place_at(buffer, offset, vec)
      x, y, z = vec.not_nil!.to_gl
      buffer[offset] = x
      buffer[offset + 1] = y
      buffer[offset + 2] = z
    end

    # :nodoc:
    @[AlwaysInline]
    def normal_to_buffer(buffer, offset)
      place_at buffer, offset, normal unless normal.nil?
    end

    # :nodoc:
    @[AlwaysInline]
    def texcoord_to_buffer(buffer, offset)
      place_at buffer,offset, texcoord unless texcoord.nil?
    end

    # Places vertex to `buffer` with `offset`.
    # `un` is for Use normals
    # `ut` is for Use Texture coords
    # Disabling normals and texcoords saves memory, about 33% each
    def to_buffer(buffer : Slice(Float64), offset, un : Bool, ut : Bool)
      place_at buffer, offset, coord

      if un && ut
        normal_to_buffer buffer, offset + 3
        texcoord_to_buffer buffer, offset + 6
      elsif un || ut
        if un
          normal_to_buffer buffer, offset + 3
        else
          texcoord_to_buffer buffer, offset + 3
        end
      end
    end
  end

  # Shape structure
  class Shape
    @buffer = 0u32
    @count = 0i32
    @use_normal = false
    @use_texcoord = false

    # Returns a stride ( = number of floating-point 64-bit numbers used to represent each vertex)
    def stride
      3 + (@use_normal ? 3 : 0)  + (@use_texcoord ? 3 : 0)
    end

    private def color(r,g,b)
      var = Nya::Render::ShaderVars::Vec3.new
      var.x, var.y, var.z = r.to_f32, g.to_f32, b.to_f32
      var
    end

    private def float(x)
      var = Nya::Render::ShaderVars::Float.new
      var.value = x.to_f32
      var
    end

    private def texture(file)
      var = Nya::Render::ShaderVars::Sampler3D.new
      var.src = file
      var
    end

    private def mat4(arr : StaticArray(Float64, 16))
      var = Nya::Render::ShaderVars::Matrix4.new
      var.inner = arr
      var
    end

    private def material(pname, value : Array(Float32))
      LibGL.materialfv(LibGL::FRONT_AND_BACK, pname, value)
    end

    private def material(pname, value : Float32)
      LibGL.materialf(LibGL::FRONT_AND_BACK, pname, value)
    end

    # Renders shape using vertex buffers
    # Renders each vertex separately if buffer is not generated
    # Prefer generating buffer with `generate_buffer!` in any non-critical moment, for example, right after loading a model.
    def render!
      if @buffer == 0
        faces.each do |f|
          LibGL.begin LibGL::POLYGON
          f.each &.render!
          LibGL._end
        end
        subshapes.each &.render!
      else
        raw_stride = sizeof(Float64) * stride
        LibGL.enable_client_state LibGL::VERTEX_ARRAY
        LibGL.enable_client_state LibGL::NORMAL_ARRAY if @use_normal
        LibGL.enable_client_state LibGL::TEXTURE_COORD_ARRAY if @use_texcoord
        LibGL.bind_buffer LibGL::ARRAY_BUFFER, @buffer
        LibGL.vertex_pointer 3, LibGL::DOUBLE, raw_stride, Pointer(Void).new(0)

        offset = 0

        if @use_normal
          offset += 3
          LibGL.normal_pointer LibGL::DOUBLE, raw_stride, Pointer(Void).new(offset * sizeof(Float64))
        end

        if @use_texcoord
          offset += 3
          LibGL.tex_coord_pointer 3, LibGL::DOUBLE, raw_stride, Pointer(Void).new(offset * sizeof(Float64))
        end

        if Nya.shader_stack.last?
          program = Nya.shader_stack.last

          unless @material.nil?
            @material.not_nil!.colors.each do |k, v|
              color(v.x, v.y, v.z).apply(program, "nya_Color_#{k}")
            end

            float(@material.not_nil!.dissolvance).apply(program, "nya_Dissolvance")
            float(1.0 - @material.not_nil!.dissolvance).apply(program, "nya_Transparency")

            @material.not_nil!.maps.each do |k,v|
              texture(v).apply(program, "nya_Map_#{k}")
            end

            # TODO: Reflection
          end
          LibGL.bind_attrib_location program, 0, "nya_Position"
          LibGL.bind_attrib_location program, 1, "nya_Normal" if @use_normal

          if @use_texcoord
            LibGL.bind_attrib_location program, (@use_normal ? 2 : 1), "nya_TexCoord"
          end

          mat4(Nya::Render::DrawUtils.get_modelview_matrix).apply(program, "nya_ModelView")
          mat4(Nya::Render::DrawUtils.get_projection_matrix).apply(program, "nya_Projection")

          Nya::Render::ShaderCompiler.link_program! program, true
        elsif !@material.nil?
          mat = @material.not_nil!
          #col = mat.colors["Ka"]? || mat.colors.first_value? || CrystalEdge::Vector3.new(0.0, 0.0, 0.0)
          #LibGL.color4d(*col.values, mat.dissolvance)

          {LibGL::AMBIENT => "Ka", LibGL::DIFFUSE => "Kd", LibGL::SPECULAR => "Ks"}.each do |k, v|
            if mat.colors.has_key? v
              col = mat.colors[v]
              floats = [col.x, col.y, col.z, 1.0 - mat.dissolvance].map &.to_f32
              material k, floats
            end
          end

          material LibGL::SHININESS, mat.specular_exponent.to_f32


        end

        LibGL.draw_arrays(LibGL::TRIANGLES, 0, @count)
        subshapes.each &.render!
      end
    end

    getter? use_normal, use_texcoord

    # Generates a vertex buffer with shape data
    def generate_buffer!
      # Delete old buffer
      # TODO : Use new buffer only if size is changed
      LibGL.delete_buffers(1, pointerof(@buffer)) if @buffer != 0u32

      # Create new buffer
      LibGL.gen_buffers(1, pointerof(@buffer))


      # Check if we can skip normals and texcoords
      faces.each do |face|
        @use_normal = true if face.any? &.normal
        @use_texcoord = true if face.any? &.texcoord

        break if @use_normal && @use_texcoord
      end

      # Calculate count of vertices
      @count = faces.size * 3

      # Allocate temporary buffer
      buffer = Slice(Float64).new(@count * stride, 0.0)

      # Place data into buffer
      faces.each_with_index do |face, i|
        face.each_with_index do |vertex, j|
          vertex.to_buffer buffer, (i * 3 + j) * stride, @use_normal, @use_texcoord
        end
      end

      Nya.log.debug "Buffer size : #{buffer.size}", "Mesh"

      # Bind buffer
      LibGL.bind_buffer LibGL::ARRAY_BUFFER, @buffer

      # Copy data to OpenGL buffer
      LibGL.buffer_data(
        LibGL::ARRAY_BUFFER,
        buffer.size,
        buffer,
        LibGL::STATIC_DRAW
      )

      LibGL.bind_buffer LibGL::ARRAY_BUFFER, 0
      Nya.log.debug "Buffer ID : #{@buffer}", "Mesh"
      subshapes.each &.generate_buffer!
    end
  end
end

module Nya::Render
  include Models

  # Mesh component
  class Mesh < Nya::Component

    include Nya::Serializable

    property shapes = {} of String => Shape
    @filename : String? = nil

    attribute filename : String

    # Separate setter for filename used to load a model
    def filename=(f)
      # return if f.to_s.empty?
      mesh = Loader.load_from f.to_s
      if mesh.nil?
        Nya.log.error "Cannot load mesh #{f}", "Mesh"
      else
        @shapes = mesh.shapes
      end
      @filename = f
    end

    def filename
      @filename
    end

    def awake
      super
      Nya.log.unknown "#{@filename} loaded : #{@shapes.values.size} shapes", "Mesh"
      Nya.log.unknown "First 10 shapes' faces' count : #{@shapes.first(10).map(&.last.faces.size)}", "Mesh"
      @shapes.each_value &.generate_buffer!

      GC.collect
    end

    def update
    end

    def render(tag : String? = nil)
      return unless matches_tag? tag
      shapes.each_value &.render!
    end
  end
end

require "./mesh/*"
