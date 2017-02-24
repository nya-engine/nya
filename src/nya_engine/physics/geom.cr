require "../bindings/ode"
require "crystaledge"

module Nya
  module Physics
    class Geom
      @geom_id : LibODE::Geomid

      def initialize(@geom_id)

      end
    end
  end
end
