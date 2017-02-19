require "./rect"
require "../object"
require "crystaledge"

module Nya
  module Render
    class Camera < Nya::Object

      def awake
        Nya.camera_list << self
        GL.enable(GL::SCISSOR_TEST)
      end

      @position = CrystalEdge::Vector3.new(0.0,0.0,0.0)
      @rotation = CrystalEdge::Vector3.new(0.0,0.0,0.0)
      @depth = 1.0
      @near = 0.1
      @far = 100.0
      @angle_of_view = 45.0
      @viewport = Rect.new(0.0,0.0,1.0,1.0)


      protected def set_projection_matrix! : Void
        GL.matrix_mode(GL::PROJECTION)
        GL.load_identity
        vp = @viewport * CrystalEdge::Vector2.new(Nya.width, Nya.height)
        GL.viewport(vp.x.to_i, vp.y.to_i, vp.width.to_i, vp.height.to_i)
        GL.scissor(vp.x.to_i, vp.y.to_i, vp.width.to_i, vp.height.to_i)
        GLU.perspective(@angle_of_view, Nya.width/Nya.height, @near, @far)
        GL.rotatef(-@rotation.x, 1.0, 0.0, 0.0)
        GL.rotatef(-@rotation.y, 0.0, 1.0, 0.0)
        GL.rotatef(-@rotation.z, 0.0, 0.0, 1.0)
        GL.translatef(*(-@position).to_gl)

      end

      property position, rotation, depth, near, far, angle_of_view, viewport
      serializable position, rotation, as: CrystalEdge::Vector3
      serializable depth, near, far, angle_of_view, as: Float64
      serializable viewport, as: Rect

      def render!
        set_projection_matrix!
        SceneManager.render @tag
      end

    end
  end
end
