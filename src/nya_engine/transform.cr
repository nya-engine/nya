require "crystaledge"

module Nya
  class Transform
    @position : CrystalEdge::Vector3
    @euler_angles : CrystalEdge::Vector3

    def initialize(@position,@euler_angles)
    end

    def zero
      Transform.new(CrystalEdge::Vector3.zero,CrystalEdge::Vector3.zero)
    end
  end
end
