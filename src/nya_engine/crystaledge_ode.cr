require "crystaledge"
require "../ode"

module CrystalEdge
  class Vector3
    def self.from(ode : LibODE::Vector3)
      new(ode[0], ode[1], ode[2])
    end
  end

  class Vector4
    def self.from(ode : LibODE::Vector4)
      new(ode[0], ode[1], ode[2], ode[3])
    end
  end

  class Quaternion
    def self.from(ode : LibODE::Quaternion)
      new(ode[0], ode[1], ode[2], ode[3])
    end
  end
end
