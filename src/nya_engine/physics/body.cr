require "../bindings/ode"
require "crystaledge"

module Nya
  module Physics
    class Body
      @world_id : LibODE::Worldid
      @body_id : LibODE::Bodyid

      def initialize(@world_id)
        @body_id = LibODE.body_create(@world_id)
      end

      def add_force(f : CrystalEdge::Vector3)
        LibODE.body_add_force(@body_id, f.x, f.y, f.z)
      end
    end
  end
end
