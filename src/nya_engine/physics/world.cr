require "../ode"
require "crystaledge"

module Nya
  module Physics
    class World
      @world_id : LibODE::Worldid

      def initialize
        @world_id = LibODE.world_create
      end

      def initialize(@world_id)
      end

      def destroy
        LibODE.world_destroy @world_id
      end

      def gravity : CrystalEdge::Vector3
        gr = LibODE.world_get_gravity(@world_id)
        CrystalEdge::Vector3.from gr
      end

      def gravity=(v : CrystalEdge::Vector3)
        LibODE.world_set_gravity(@world_id, v.x, v.y, v.z)
      end

      def create_body
        Body.new(@world_id)
      end
    end
  end
end
