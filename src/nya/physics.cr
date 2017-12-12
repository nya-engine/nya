require "./physics/*"

module Nya
  module Physics
    class NearEvent < Nya::Event
      property first : Geom
      property second : Geom

      def initialize(@first, @second)
      end
    end
  end
end
