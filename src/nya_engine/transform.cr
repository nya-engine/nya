require "crystaledge"
require "../gl"

module Nya
  class Transform
    @position : CrystalEdge::Vector3
    @euler_angles : CrystalEdge::Vector3

    def initialize(@position,@euler_angles)
    end

    def self.zero
      Transform.new(CrystalEdge::Vector3.zero,CrystalEdge::Vector3.zero)
    end

    def apply(&block : -> Void)
      GL.rotated(@euler_angles.x,1.0,0.0,0.0)
      GL.rotated(@euler_angles.y,0.0,1.0,0.0)
      GL.rotated(@euler_angles.z,0.0,0.0,1.0)
      GL.translated(@position.x,@position.y,@position.z)
      
    end
  end
end
