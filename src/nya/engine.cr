require "./**"

module Nya
  # An engine class
  class Engine
    # :nodoc:
    WP_CENTERED = 0x2FFF0000

    # Main engine fiber name
    FIBER_NAME = "Nya Engine"

    enum DebugSource
      API = LibGL::DEBUG_SOURCE_API
      WINDOW_SYSTEM = LibGL::DEBUG_SOURCE_WINDOW_SYSTEM
      SHADER_COMPILER = LibGL::DEBUG_SOURCE_SHADER_COMPILER
      THIRD_PARTY = LibGL::DEBUG_SOURCE_THIRD_PARTY
      APPLICATION = LibGL::DEBUG_SOURCE_APPLICATION
      OTHER = LibGL::DEBUG_SOURCE_OTHER
      DONT_CARE = LibGL::DONT_CARE
    end

    enum DebugType
      ERROR = LibGL::DEBUG_TYPE_ERROR
      DEPRECATED_BEHAVIOUR = LibGL::DEBUG_TYPE_DEPRECATED_BEHAVIOR
      UNDEFINED_BEHAVIOUR = LibGL::DEBUG_TYPE_UNDEFINED_BEHAVIOR
      PORTABILITY = LibGL::DEBUG_TYPE_PORTABILITY
      PERFORMANCE= LibGL::DEBUG_TYPE_PERFORMANCE
      MARKER = LibGL::DEBUG_TYPE_MARKER
      PUSH_GROUP = LibGL::DEBUG_TYPE_PUSH_GROUP
      POP_GROUP = LibGL::DEBUG_TYPE_POP_GROUP
      OTHER = LibGL::DEBUG_TYPE_OTHER
      DONT_CARE = LibGL::DONT_CARE

      def to_severity
        case self
        when .error?
          Logger::Severity::ERROR
        when .portability?, .performance?, .undefined_behaviour?, .deprecated_behaviour?
          Logger::Severity::WARN
        when .marker?
          Logger::Severity::DEBUG
        else
          Logger::Severity::UNKNOWN
        end
      end
    end

    # :nodoc:
    alias PhysCallback = LibODE::Geomid, LibODE::Geomid ->

    # :nodoc:
    alias DebugCallback = LibGL::Gldebugproc

    @phys_cb : PhysCallback
    @debug_cb = DebugCallback.new do |source, type, id, severity, length, msg, param |
      this = Box(self).unbox(param)
      this.debug source, type, id, severity, String.new(msg, length)
    end

    private def set_debug_callback!
      LibGL.debug_message_callback @debug_cb, Box(self).box(self)
      Nya.log.debug "GL Debug callback set!", "Nya"
    end

    def debug(s, t, i, sev, msg)
      src = DebugSource.from_value s
      type = DebugType.from_value t
      raise msg if type.error?
      Nya.log.log type.to_severity, msg, src.to_s
    end

    def initialize(title, w, h)
      Fiber.current.name = FIBER_NAME

      raise LibSDL2.get_error.to_s if LibSDL2.init(LibSDL2::INIT_VIDEO) < 0

      LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLDOUBLEBUFFER, 1)
      LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLREDSIZE, 6)
      LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLBLUESIZE, 6)
      LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLGREENSIZE, 6)

      @window = LibSDL2.create_window("Cube", WP_CENTERED, WP_CENTERED, w, h, LibSDL2::WindowFlags::WINDOWSHOWN | LibSDL2::WindowFlags::WINDOWOPENGL)
      raise LibSDL2.get_error.as(String) if @window.null?
      LibSDL2.set_window_resizable(@window, LibSDL2::Bool::TRUE)
      @gl_ctx = LibSDL2.gl_create_context(@window)

      raise LibSDL2.get_error.as(String) if @gl_ctx.null?

      print_versions!

      Nya.log.info "Max GL lights : #{Render::Light.max_lights}"

      LibGL.clear_color(0.0, 0.0, 0.0, 0.0)
      LibGL.clear_depth(1.0)
      LibGL.depth_func(LibGL::LESS)
      LibGL.enable(LibGL::DEPTH_TEST)
      LibGL.enable(LibGL::COLOR_MATERIAL)
      LibGL.enable LibGL::LIGHTING
      LibGL.alpha_func(LibGL::GREATER, 0.1)
      LibGL.shade_model(LibGL::SMOOTH)
      LibGL.blend_func(LibGL::SRC_ALPHA, LibGL::ONE_MINUS_SRC_ALPHA)

      @phys_cb = ->(o1 : LibODE::Geomid, o2 : LibODE::Geomid) do
        dptr1, dptr2 = LibODE.geom_get_data(o1), LibODE.geom_get_data(o2)
        Nya::Event.send :physics_near_cb, Nya::Physics::NearEvent.new(
          Box(Nya::Physics::Geom).unbox(dptr1),
          Box(Nya::Physics::Geom).unbox(dptr2)
        )
      end

      LibGL.enable LibGL::DEBUG_OUTPUT
      LibGL.enable LibGL::DEBUG_OUTPUT_SYNCHRONOUS

      set_debug_callback!
    end

    # Update engine state.
    #
    # Run this in a loop
    def frame!
      LibODE.space_collide(
        Nya::SceneManager.current_scene.space_id,
        Box(PhysCallback).box(@phys_cb),
        ->(ptr : Void*, o1 : LibODE::Geomid, o2 : LibODE::Geomid) do
          Box(PhysCallback).unbox(ptr).call(o1,o2)
        end
      )

      Nya::Event.send(:update, Nya::Event.new)
      update_loop
      while LibSDL2.poll_event(out evt) != 0
        case evt.type
        when LibSDL2::EventType::KEYUP
          Nya::Event.send :key_up, Nya::Input::KeyboardEvent.new(evt.key)
        when LibSDL2::EventType::KEYDOWN
          Nya::Event.send :key_down, Nya::Input::KeyboardEvent.new(evt.key)
        when LibSDL2::EventType::QUIT
          evt = Nya::Event.new
          Nya::Event.send :quit, evt
          exit 0 unless evt.status.dead?
        when LibSDL2::EventType::MOUSEMOTION
          Nya::Event.send :mouse_motion, Nya::Input::MouseMotionEvent.new(evt.motion)
        when LibSDL2::EventType::MOUSEWHEEL
          Nya::Event.send :mouse_wheel, Nya::Input::MouseWheelEvent.new(evt.wheel)
        when LibSDL2::EventType::MOUSEBUTTONUP
          Nya::Event.send :mouse_button_up, Nya::Input::MouseButtonEvent.new(evt.button)
        when LibSDL2::EventType::MOUSEBUTTONDOWN
          Nya::Event.send :mouse_button_down, Nya::Input::MouseButtonEvent.new(evt.button)
        end
      end

      render_loop
      LibGL.flush
      LibSDL2.gl_swap_window(@window)
    end

    def update_loop
      Nya::SceneManager.update
      Nya::Event.update
      Nya::Time.update
    end

    private def render_loop
      LibGL.clear_color(0.0, 0.0, 0.0, 1.0)
      LibGL.clear(LibGL::COLOR_BUFFER_BIT | LibGL::DEPTH_BUFFER_BIT)
      Nya.camera_list.each &.render!
      Nya.gl_check_error
      Nya::Time.render
    end

    # :nodoc:
    def finalize
      LibSDL2.quit
    end
  end
end
