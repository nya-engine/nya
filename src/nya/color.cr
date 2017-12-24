require "./storage"
require "nya_serializable"

module Nya
  alias RawRGBA = Tuple(Float64, Float64, Float64, Float64)

  class Color
    @@predef = Hash(String, Color).new

    include Nya::Serializable
    @r = 255u8
    @g = 255u8
    @b = 255u8
    @a = 255u8
    property r, g, b, a

    def initialize(@r, @g, @b, @a)
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
        {% for name in %w(r g b a) %}
          self.{{name.id}} = @@predef[n].{{name.id}}
        {% end %}
        Nya.log.debug "Found color #{n}", "Color"
      else
        Nya.log.warn "Cannot find color #{n}", "Color"
      end
    end

    serializable r : UInt8, g : UInt8, b : UInt8, a : UInt8
    attribute name : String

    def to_gl
      {
        @r.to_f64 / 255.0,
        @g.to_f64 / 255.0,
        @b.to_f64 / 255.0,
      }
    end

    def to_gl4
      {
        @r.to_f64 / 255.0,
        @g.to_f64 / 255.0,
        @b.to_f64 / 255.0,
        @a.to_f64 / 255.0,
      }
    end

    def +(other : Color)
      alpha = other.a
      ia = 256 - alpha
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
    predef red, 255u8, 0u8, 0u8

    def_equals r, g, b, a

    def !=(other : self)
      !(other == self)
    end
  end
end
