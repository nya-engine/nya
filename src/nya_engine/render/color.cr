require "../storage/*"

module Nya
  module Render
    class Color
      include Nya::Serializable

      @r = @g = @b = 0.0
      @a = 1.0
      property r,g,b,a
      serializable r, Float64
      serializable g, Float64
      serializable b, Float64
      serializable a, Float64

      def initialize
      end

      def initialize(@r, @g, @b, @a)
      end
    end
  end
end
