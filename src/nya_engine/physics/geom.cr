module Nya
  module Physics
    class Geom
      include Nya::Serializable
      property density = 0.0
      @geom_id : LibODE::Geomid? = nil
      setter geom_id

      def geom_id
        @geom_id.not_nil!
      end

      attribute density, as: Float64, nilable: false

      def apply(body_id) : LibODE::Geomid
        raise "Cannot use raw Geom"
      end

      def data=(ptr : Pointer(Void))
        LibODE.geom_set_data(@geom_id.not_nil!,ptr)
      end
    end

    class Box < Geom
      property x, y, z : Float64
      @x, @y, @z = 0.0, 0.0, 0.0

      attribute x, as: Float64, nilable: false
      attribute z, as: Float64, nilable: false
      attribute y, as: Float64, nilable: false

      def apply(bid)
        space = SceneManager.current_scene.space_id
        m = uninitialized LibODE::Mass
        LibODE.mass_set_box(pointerof(m), @density, @x, @y, @z)
        gid = LibODE.create_box(space, @x, @y, @z)
        LibODE.geom_set_body(gid, bid.not_nil!)
        @geom_id = gid
      end
    end
  end
end
