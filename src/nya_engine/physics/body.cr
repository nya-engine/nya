require "../bindings/ode"
require "crystaledge"
require "./geom"

module Nya
  module Physics
    class Body < Nya::Component
      property geom : Geom = Geom.new
      serializable geom, as: Geom
      @body_id : LibODE::Bodyid? = nil

      setter body_id
      def body_id
        @body_id.not_nil!
      end

      def awake
        @body_id = LibODE.body_create(SceneManager.current_scene.world_id)
        geom.data = ::Box(self).box(self)
        geom.apply(@body_id)
      end
    end
  end
end
