require "../object"
require "models"

module Models
  struct Vertex
    @[AlwaysInline]
    def render
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
  end

  struct Shape
    def render
      faces.each do |f|
        LibGL.begin_ LibGL::POLYGON
        f.each &.render
        LibGL.end_
      end
      subshapes.each &.render
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
      GC.collect
    end

    def update
    end

    def render(tag : String? = nil)
      return unless matches_tag? tag
      shapes.each_value &.render
    end
  end
end

require "./mesh/*"
