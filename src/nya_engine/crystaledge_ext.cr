require "crystaledge"
require "./bindings/ode"
require "./storage/serialization"


module CrystalEdge
  class Vector2
    include Nya::Serializable

    serializable x, y, as: Float64

    def initialize
      @x = 0.0
      @y = 0.0
    end


    def to_gl
      {@x, @y}
    end
  end

  class Vector3
    include Nya::Serializable

    serializable x, y, z, as: Float64

    def initialize
      @x = 0.0
      @y = 0.0
      @z = 0.0
    end

    def self.from(ode : LibODE::Vector3)
      new(ode[0], ode[1], ode[2])
    end

    def to_gl
      {@x, @y, @z}
    end
  end

  class Vector4
    include Nya::Serializable

    serializable x, y, z, w, as: Float64

    def initialize
      @x = 0.0
      @y = 0.0
      @z = 0.0
      @w = 0.0
    end

    def self.from(ode : LibODE::Vector4)
      new(ode[0], ode[1], ode[2], ode[3])
    end

    def to_gl
      {@x, @y, @z, @w}
    end
  end

  class Quaternion
    include Nya::Serializable

    serializable x, y, z, w, as: Float64

    def initialize
      @x = 0.0
      @y = 0.0
      @z = 0.0
      @w = 0.0
    end

    def self.from(ode : LibODE::Quaternion)
      new(ode[0], ode[1], ode[2], ode[3])
    end
  end
end
