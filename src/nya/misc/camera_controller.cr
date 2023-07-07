module Nya
  module Misc
    # Simple camera controller component
    class CameraController < Component
      property velocity
      @velocity = 100.0
      attribute velocity : Float64

      private def delta_p
        CrystalEdge::Vector3.new(0.0,0.0,-1.0).rotate(Nya.to_rad parent.rotation) * Nya::Time.delta_time * @velocity
      end

      private def delta_h
        CrystalEdge::Vector3.new(@velocity * Nya::Time.delta_time, 0.0, 0.0)
      end

      private def delta_v
        CrystalEdge::Vector3.new(0.0, @velocity * Nya::Time.delta_time, 0.0)
      end

      def update
        parent.position += delta_p if Nya::Input.key? "W"
        parent.position -= delta_p if Nya::Input.key? "S"

        parent.rotation -= delta_v if Nya::Input.key? "D"
        parent.rotation += delta_v if Nya::Input.key? "A"

        parent.rotation += delta_h if Nya::Input.key? "R"
        parent.rotation -= delta_h if Nya::Input.key? "F"
      end

      def awake
      end
    end
  end
end
