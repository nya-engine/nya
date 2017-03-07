require "./rect"
require "../object"
require "crystaledge"

module Nya
  module Render
    class Camera < Component
      def awake
        Nya.camera_list << self
        LibGL.enable(LibGL::SCISSOR_TEST)
      end

      @depth = 1.0
      @near = 0.1
      @far = 1000.0
      @angle_of_view = 45.0
      @viewport = Rect.new(0.0, 0.0, 1.0, 1.0)

      protected def set_projection_matrix! : Void
        LibGL.matrix_mode(LibGL::PROJECTION)
        LibGL.load_identity
        vp = @viewport * CrystalEdge::Vector2.new(Nya.width, Nya.height)
        LibGL.viewport(vp.x.to_i, vp.y.to_i, vp.width.to_i, vp.height.to_i)
        LibGL.scissor(vp.x.to_i, vp.y.to_i, vp.width.to_i, vp.height.to_i)
        LibGLU.perspective(@angle_of_view, Nya.width/Nya.height, @near, @far)
        LibGL.rotatef(-parent.rotation.x, 1.0, 0.0, 0.0)
        LibGL.rotatef(-parent.rotation.y, 0.0, 1.0, 0.0)
        LibGL.rotatef(-parent.rotation.z, 0.0, 0.0, 1.0)
        LibGL.translatef(*(-parent.position).to_gl)
      end

      property depth, near, far, angle_of_view, viewport
      serializable depth, near, far, angle_of_view, as: Float64
      serializable viewport, as: Rect

      def render!
        return unless enabled?
        set_projection_matrix!
        LibGL.matrix_mode LibGL::MODELVIEW
        LibGL.load_identity
        SceneManager.render @tag
      end

      def update
      end
    end
  end
end
