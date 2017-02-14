require "crystaledge"

module Nya
  module Render
    abstract class Shape
      abstract def render(transform : ::Nya::Transform)
    end

    class Box < Shape
      @sides : CrystalEdge::Vector3

      def initialize(@sides)
      end

      def render(transform : ::Nya::Transform)

      end
    end
  end
end
