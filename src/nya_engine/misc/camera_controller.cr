module Nya
  module Misc
    class CameraController < Component
      property velocity
      @velocity = 100.0
      attribute velocity, as: Float64, nilable: false

      private def delta_p
        CrystalEdge::Vector3.new(0.0,0.0,1.0).rotate(Nya.to_rad(parent.rotation)) * Nya::Time.delta_time * @velocity
      end

      def update
        parent.position -= delta_p if Nya::Input.key? "W"


        parent.rotation.y -= Nya::Time.delta_time * @velocity if Nya::Input.key? "D"
        parent.rotation.y += Nya::Time.delta_time * @velocity if Nya::Input.key? "A"
      end
    end
  end
end
