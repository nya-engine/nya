require "nya_serializable"

module Nya
  module Render
    # Rectangle
    class Rect
      @x = 0.0
      @y = 0.0
      @width = 0.0
      @height = 0.0

      include ::Nya::Serializable
      property x, y, width, height
      serializable x : Float64, y : Float64, width : Float64, height : Float64

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

      # Returns a rectangle containing `self` and `other`
      def |(other : self)
        x, y = Math.min(@x, other.x), Math.min(@y, other.y)
        mx, my = Math.max(max_x, other.max_x), Math.max(max_y, other.max_y)
        Rect.new(x, y, mx - x, my - y)
      end

      # Multiplies rectangle by a vector
      def *(vec : CrystalEdge::Vector2)
        Rect.new(x * vec.x, y * vec.y, width * vec.x, height * vec.y)
      end
    end
  end
end
