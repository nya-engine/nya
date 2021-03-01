require "./rect"
require "../object"
require "crystaledge"

module Nya
  module Render
    # Camera component
    class Camera < Component
      def awake
        Engine.instance.camera_list << self
        LibGL.enable(LibGL::SCISSOR_TEST)
      end

      @depth = 1.0
      @near = 0.1
      @far = 1000.0
      @angle_of_view = 45.0
      @viewport = Rect.new(0.0, 0.0, 1.0, 1.0)

      property depth, near, far, angle_of_view, viewport

      serializable depth : Float64, near : Float64, far : Float64, angle_of_view : Float64, viewport : Rect

      def render!
      end

      def update
      end
    end
  end
end
