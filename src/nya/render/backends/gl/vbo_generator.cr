require "models"
require "./metadata"

module Nya::Render::Backends::GL::VBOGenerator
  class VBOMetadata < GL::Metadata
    property stride = 3u64
    property count = 0u64
    property use_normal = false
    property use_texcoord = false

    def raw_stride
        @stride * sizeof(Float64)
    end

    def initialize(meta)
      @object_type = meta.object_type
      @id = meta.id
    end
  end

  class MeshMetadata < Nya::Render::Backend::Metadata
    def object_type : Symbol
      :mesh
    end

    property? has_buffers = false
  end

  def generate_buffer!(shape : Models::Shape, force = false) : Models::Shape
    metadata = shape.metadata?

    return shape if metadata.is_a?(VBOMetadata) && !force

    meta = VBOMetadata.new create_object(:vertex_buffer).as(Metadata)

    use_normal = use_texcoord = false

    shape.faces.each do |face|
      use_normal = true if face.any? &.normal
      use_texcoord = true if face.any? &.texcoord

      break if use_normal && use_texcoord
    end

    meta.count = shape.faces.size.to_u64 * 3

    meta.stride = 3u64 + (use_normal ? 3 : 0) + (use_texcoord ? 3 : 0)

    buffer = Slice(Float64).new((meta.count * meta.stride).to_i32, 0.0)

    shape.faces.each_with_index do |face, i|
      face.each_with_index do |vertex, j|
        vertex.to_buffer buffer, (i * 3 + j) * meta.stride, use_normal, use_texcoord
      end
    end

    LibGL.bind_buffer LibGL::ARRAY_BUFFER, meta.id

    LibGL.buffer_data(
      LibGL::ARRAY_BUFFER,
      buffer.size,
      buffer,
      LibGL::STATIC_DRAW
    )

    LibGL.bind_buffer LibGL::ARRAY_BUFFER, 0

    shape.subshapes.map! &->generate_buffer!(Models::Shape)

    meta.use_normal, meta.use_texcoord = use_normal, use_texcoord
    shape.metadata = meta
    return shape
  end

  def generate_buffers!(mesh : Mesh, force = false)
    meta = mesh.metadata?.as?(MeshMetadata)
    return if !meta.nil? && meta.not_nil!.has_buffers? && !force
    shapes = typeof(mesh.shapes).new
    mesh.shapes.each do |k, v|
      shapes[k] = generate_buffer! v, force
    end

    meta ||= MeshMetadata.new

    meta.has_buffers = true

    mesh.shapes = shapes
    mesh.metadata = meta.not_nil!

  end
end
