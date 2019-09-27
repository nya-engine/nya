require "./**"
require "./render/backend"
require "./render/backends/gl_sdl"

module Nya
  # An engine class
  class Engine
    # Main engine fiber name
    FIBER_NAME = "Nya Engine"

    property! backend : Render::Backend?


    @@instance : self? = nil

    def self.instance
      @@instance.not_nil!
    end

    def initialize(title, w, h)
      Nya::Event.send(:engine_pre_init, Nya::EngineEvent.new(self))

      Fiber.current.name = FIBER_NAME

      Nya.log.level = Logger::INFO

      # TODO
      @backend = Nya::Render::Backends::GL_SDL.new(CrystalEdge::Vector2.new(w.to_f64, h.to_f64), title)
      @@instance = self
      print_versions!

      Nya::Event.send(:engine_post_init, Nya::EngineEvent.new(self))
    end

    property camera_list = [] of Render::Camera

    # Update engine state.
    #
    # Run this in a loop
    def frame!
      Nya::Event.send(:update, Nya::EngineEvent.new(self))

      backend.update
      Nya::SceneManager.update
      Nya::Event.update
      Nya::Time.update

      backend.render do
        @camera_list.each do |cam|
          backend.draw_camera cam do
            SceneManager.render cam.tag
          end
        end
        Nya::Time.render
      end

    end

    # :nodoc:
    def finalize
      backend.quit
    end
  end
end
