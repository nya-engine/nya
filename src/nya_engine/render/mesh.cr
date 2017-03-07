require "../object"

module Nya::Render
  class Mesh < Nya::Component
    class Vertex
      include Nya::Serializable
      @coord : CrystalEdge::Vector3
      @normal : CrystalEdge::Vector3?
      @texture_coord : CrystalEdge::Vector3?
      @color : CrystalEdge::Vector3?
      property coord, normal, texture_coord, color
      serializable coord, normal, texture_coord, color, as: CrystalEdge::Vector3

      def render
        LibGL.vertex3d(@coord.x, @coord.y, @coord.z)
        unless @normal.nil?
          n = @normal.not_nil!
          LibGL.normal3d(n.x, n.y, n.z)
        end

        if @texture_coord
          t = @texture_coord.not_nil!
          LibGL.tex_coord3d(t.x, t.y, t.z)
        elsif @color
          c = @color.not_nil!
          LibGL.color3d(c.x, c.y, c.z)
        else
          LibGL.color3d(@coord.x, @coord.y, @coord.z)
        end
      end

      def initialize(@coord, @normal = nil, @texture_coord = nil, @color = nil)
      end

      def initialize
        @coord = CrystalEdge::Vector3.new(0.0, 0.0, 0.0)
        @normal = @texture_coord = @color = nil
      end
    end

    class Face
      include Nya::Serializable
      property vertices : Array(Vertex)
      @vertices = [] of Vertex
      serializable_array vertices, of: Vertex

      def render
        LibGL.begin_(LibGL::POLYGON)
        vertices.each &.render
        LibGL.end_
      end

      def initialize(@vertices)
      end

      def initialize
      end
    end

    class Shape
      include Nya::Serializable

      property faces = [] of Face
      property name = "$root"
      property subshapes = [] of Shape
      serializable_array faces, of: Face
      serializable_array subshapes, of: Shape
      attribute name, as: String, nilable: false

      def render
        @faces.each &.render
        @subshapes.each &.render
      end

      def initialize(@name, @faces, @subshapes)
      end

      def initialize
      end
    end

    include Nya::Serializable

    property shapes = {} of String => Shape
    @filename : String? = nil
    serializable_hash shapes, of: Shape
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
    end

    def update
      parent.rotation.x += 10000 * Nya::Time.delta_time
      parent.rotation.y += 10000 * Nya::Time.delta_time
      parent.rotation.z += 10000 * Nya::Time.delta_time
    end

    def render(tag : String? = nil)
      return unless matches_tag? tag
      shapes.each_value &.render
    end
  end
end

require "./mesh/*"
