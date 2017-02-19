require "./storage/*"

module Nya
  class Color
    @@predef = Hash(String, Color).new

    include Serializable
    @r = 255u8
    @g = 255u8
    @b = 255u8
    @a = 255u8
    property r,g,b,a


    def initialize(@r,@g,@b,@a)
    end

    def initialize
    end

    # Completely useless method. Used for serialization purposes
    # Returns empty string
    def name
      ""
    end

    def name=(n : String)
      if @@predef.has_key? n

      else

      end
    end

    serializable r, g, b, a, as: UInt8

    def to_gl
      {
        @r.to_f / 255.0,
        @g.to_f / 255.0,
        @b.to_f / 255.0
      }
    end

    def to_gl_4
      {
        @r.to_f / 255.0,
        @g.to_f / 255.0,
        @b.to_f / 255.0,
        @a.to_f / 255.0
      }
    end

    def +(other : Color)
      alpha = other.a
      ia = 256-alpha
      Color.new(
        ((alpha*other.r + ia*self.r) >> 8).as(UInt8),
        ((alpha*other.g + ia*self.g) >> 8).as(UInt8),
        ((alpha*other.b + ia*self.b) >> 8).as(UInt8),
        255
      )
    end

    macro predef(name, r, g, b)
      def self.{{name.id}}
        new({{r}},{{g}},{{b}},255u8)
      end

      @@predef[{{name.stringify}}] = {{name.id}}
    end

    predef white, 255u8, 255u8, 255u8
    predef black, 0u8, 0u8, 0u8

  end
end
