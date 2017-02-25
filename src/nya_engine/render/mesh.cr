require "../object"

module Nya::Render
  class Mesh < Nya::Component
    @vertices = [] of CrystalEdge::Vector3
    @normals = [] of CrystalEdge::Vector3
    @texcoords = [] of CrystalEdge::Vector3
    @filename = ""
    serializable_array vertices, normals, texcoords, of: CrystalEdge::Vector3
    property vertices, normals, texcoords
    attribute filename, as: String, nilable: true

    def filename=(f)
      return if f.to_s.empty?
      mesh = Loader.load_from f.to_s
      unless mesh.nil?
        @vertices = mesh.vertices
        @normals = mesh.normals
        @texcoords = mesh.texcoords
      end
      @filename = f
    end

    def filename
      @filename
    end

    STRIDE = 9
    @raw_vb_data = [] of Float32
    @vb = 0u32
    @valid_cache = false
    @size = 0u64

    def invalidate_cache!
      @valid_cache = false
    end

    def refresh_vertexbuffer!
      Nya.log.debug "Refreshing vertex buffer"
      @size = Math.max(@vertices.size,Math.max(@normals.size, @texcoords.size)).to_u64
      @raw_vb_data = Array(Float32).new(@size*STRIDE, 0f32)
      @size.times do |i|
        if @vertices.size > i
          @raw_vb_data[STRIDE*i] = @vertices[i].x.to_f32
          @raw_vb_data[STRIDE*i + 1] = @vertices[i].y.to_f32
          @raw_vb_data[STRIDE*i + 2] = @vertices[i].z.to_f32
        end

        if @normals.size > i
          @raw_vb_data[STRIDE*i + 3] = @normals[i].x.to_f32
          @raw_vb_data[STRIDE*i + 4] = @normals[i].y.to_f32
          @raw_vb_data[STRIDE*i + 5] = @normals[i].z.to_f32
        end

        if @texcoords.size > i
          @raw_vb_data[STRIDE*i + 6] = @texcoords[i].x.to_f32
          @raw_vb_data[STRIDE*i + 7] = @texcoords[i].y.to_f32
          @raw_vb_data[STRIDE*i + 8] = @texcoords[i].z.to_f32
        end
      end

      GL.bind_buffer GL::ARRAY_BUFFER, @vb
      GL.buffer_data GL::ARRAY_BUFFER, @raw_vb_data.size * 4, @raw_vb_data, GL::STATIC_DRAW
      @valid_cache = true
    end

    def awake
      super
      GL.gen_buffers 1, pointerof(@vb)
      refresh_vertexbuffer!
    end

    def update
      unless @valid_cache
        refresh_vertexbuffer!
      end
    end

    def render(tag : String? = nil)
      return unless matches_tag? tag
      GL.bind_buffer GL::ARRAY_BUFFER, @vb
      GL.enable_client_state GL::VERTEX_ARRAY
      GL.enable_client_state GL::NORMAL_ARRAY
      GL.enable_client_state GL::TEXTURE_COORD_ARRAY
      GL.vertex_pointer 3, GL::FLOAT, 36, Pointer(Void).new(0)
      GL.normal_pointer GL::FLOAT, 36, Pointer(Void).new(12)
      GL.tex_coord_pointer 3, GL::FLOAT, 36, Pointer(Void).new(24)
      GL.draw_arrays GL::TRIANGLES, 0, @size * 3
    end

  end
end

require "./mesh/*"
