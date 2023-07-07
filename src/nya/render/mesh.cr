require "../object"
require "models"
require "./backend"


# Extension for `models` shard
module Models
  # Vertex structure
  struct Vertex
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
    @metadata : Nya::Render::Backend::Metadata? = nil

    setter metadata

    def metadata
      @metadata.not_nil!
    end

    def metadata?
      @metadata
    end
  end
end

module Nya::Render
  include Models

  # Mesh component
  class Mesh < Nya::Component
    @@log : Log = Nya.log.for(self)

    include Nya::Serializable

    property shapes = {} of String => Shape
    @filename : String? = nil

    attribute filename : String

    # Separate setter for filename used to load a model
    def filename=(f)
      # return if f.to_s.empty?
      mesh = Loader.load_from f.to_s
      if mesh.nil?
        @@log.error { "Cannot load mesh #{f}" }
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
      @@log.info { "#{@filename} loaded : #{@shapes.values.size} shapes" }
      @@log.debug { "First 10 shapes' faces' count : #{@shapes.first(10).map(&.last.faces.size)}" }

      GC.collect
    end

    def update
    end

    def render(tag : String? = nil)
      return unless matches_tag? tag
      backend.draw_mesh self
    end
  end
end

require "./mesh/*"
