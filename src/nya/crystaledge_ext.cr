require "crystaledge"
require "nya_serializable"

module CrystalEdge
  struct Vector2
    include Nya::Serializable

    serializable x : Float64, y : Float64

    def initialize
      @x = 0.0
      @y = 0.0
    end

    def to_gl
      {@x, @y}
    end
  end

  struct Vector3
    include Nya::Serializable

    serializable x : Float64, y : Float64, z : Float64

    def initialize
      @x = 0.0
      @y = 0.0
      @z = 0.0
    end

    def to_gl
      {@x, @y, @z}
    end
  end

  struct Vector4
    include Nya::Serializable

    serializable x : Float64, y : Float64, z : Float64, w : Float64

    def initialize
      @x = 0.0
      @y = 0.0
      @z = 0.0
      @w = 0.0
    end

    def to_gl
      {@x, @y, @z, @w}
    end
  end

  struct Quaternion
    include Nya::Serializable

    serializable x : Float64, y : Float64, z : Float64, z : Float64

    def initialize
      @x = 0.0
      @y = 0.0
      @z = 0.0
      @w = 0.0
    end

  end
end
