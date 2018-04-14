module Nya::Render::Backends::SDL2
  # :nodoc:
  WP_CENTERED = 0x2FFF0000

  def resizeable?
    true
  end

  def size
    LibSDL2.get_window_size @window, out x, out y
    CrystalEdge::Vector2.new(x.to_f64, y.to_f64)
  end

  def size=(v : CrystalEdge::Vector2)
    LibSDL2.set_window_size(@window, v.x.to_i32, v.y.to_i32)
  end

  def has_title?
    true
  end

  def title
    String.new LibSDL2.get_window_title @window
  end

  def title=(t)
    LibSDL2.set_window_title @window, t
    t
  end

  def quit
    LibSDL2.quit
  end

  def update
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
    # TODO
  end
end
