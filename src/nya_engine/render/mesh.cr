require "../object"
require "models"

module Models
  struct Vertex
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

    @[AlwaysInline]
    private def place_at(buffer, offset, vec)
      x, y, z = vec.not_nil!.to_gl
      buffer[offset] = x
      buffer[offset + 1] = y
      buffer[offset + 2] = z
    end

    @[AlwaysInline]
    def normal_to_buffer(buffer, offset)
      place_at buffer, offset, normal unless normal.nil?
    end

    @[AlwaysInline]
    def texcoord_to_buffer(buffer, offset)
      place_at buffer,offset, texcoord unless texcoord.nil?
    end

    def to_buffer(buffer : Slice(Float64), offset, un, ut)
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

  class Shape
    @buffer = 0u32
    @count = 0i32
    @use_normal = false
    @use_texcoord = false

    def stride
      3 + (@use_normal ? 3 : 0)  + (@use_texcoord ? 3 : 0)
    end

    def render!
      if @buffer == 0
        faces.each do |f|
          LibGL.begin_ LibGL::POLYGON
          f.each &.render!
          LibGL.end_
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

        LibGL.draw_arrays(LibGL::TRIANGLES, 0, @count)
        subshapes.each &.render!
      end
    end

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

  class Mesh < Nya::Component

    include Nya::Serializable

    property shapes = {} of String => Shape
    @filename : String? = nil

    attribute filename, as: String, nilable: false

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
