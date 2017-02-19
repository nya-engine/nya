module Nya
  module Render
    class Rect
      @x = 0.0
      @y = 0.0
      @width = 0.0
      @height = 0.0

      include Nya::Serializable
      property x, y, width, height
      serializable x, y, width, height, as: Float64

      def max_x
        @x + @width
      end

      def max_x=(x)
        @width = x - @x
      end

      def max_y
        @y + @height
      end

      def max_y=(y)
        @height = y - @y
      end

      def initialize(@x, @y, @width, @height)
      end

      def initialize
      end

      def |(other : self)
        x, y = Math.min(@x, other.x), Math.min(@y, other.y)
        mx, my = Math.min(max_x, other.max_x), Math.min(max_y, other.max_y)
        Rect.new(x, y, mx - x, my - y)
      end

      def *(vec : CrystalEdge::Vector2)
        Rect.new(x * vec.x, y * vec.y, width * vec.x, height * vec.y)
      end
    end
  end
end
