require "./light_mode"

module Nya::Render
  class Light < Component
    @@lights = {} of Int32 => self

    @light_id = -1
    @gl_light : Int32

    def self.max_lights
      ml = 0i32
      LibGL.get_integerv LibGL::MAX_LIGHTS, pointerof(ml)
      ml
    end

    property mode = LightMode::DIRECTIONAL
    property ambient = Color.white
    property diffuse = Color.white
    property specular = Color.white

    attribute mode : LightMode
    serializable ambient : Color, diffuse : Color, specular : Color

    def initialize
      @gl_light = LibGL::LIGHT0
      self.class.max_lights.times do |i|
        unless @@lights.has_key? i
          @@lights[i] = self
          @light_id = i
          break
        end
      end
      @gl_light = LibGL::LIGHT0 + @light_id
      raise "Cannot allocate light" if @light_id < 0


      Nya.log.info "Allocated light #{@light_id} (0x#{gl_light.to_s(16)})", "Light"

    end

    def enabled=(x)
      super x
      if x
        LibGL.enable gl_light
      else
        LibGL.disable gl_light
      end
    end

    def awake
      if enabled?
        LibGL.enable gl_light
      else
        LibGL.disable gl_light
      end
    end

    getter gl_light

    def render(tag = nil)
      return unless enabled?
      LibGL.lightfv(gl_light, LibGL::POSITION, (parent.position.to_gl + { @mode.directional? ? 0 : 1 }).map(&.to_f32).to_a)
      LibGL.lightfv(gl_light, LibGL::AMBIENT, @ambient.to_gl4.map(&.to_f32).to_a)
      LibGL.lightfv(gl_light, LibGL::SPECULAR, @specular.to_gl4.map(&.to_f32).to_a)
      LibGL.lightfv(gl_light, LibGL::DIFFUSE, @diffuse.to_gl4.map(&.to_f32).to_a)
    end
  end
end
