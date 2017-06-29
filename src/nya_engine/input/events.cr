module Nya
  module Input
    alias Keycode = LibSDL2::Keycode
    alias Scancode = LibSDL2::Scancode

    # Wrapper for SDL KeyboardEvent
    class KeyboardEvent < Nya::EventWrapper(LibSDL2::KeyboardEvent)
      delegate keycode, scancode, to: inner.keysym
    end

    # Wrapper for SDL MouseMotionEvent
    class MouseMotionEvent < Nya::EventWrapper(LibSDL2::MouseMotionEvent)
      delegate state, x, y, xrel, yrel, to: inner
    end

    # Wrapper for SDL MouseWheelEvent
    class MouseWheelEvent < Nya::EventWrapper(LibSDL2::MouseWheelEvent)
      delegate x, y, which, to: inner
    end

    # Wrapper for SDL MouseButtonEvent
    class MouseButtonEvent < Nya::EventWrapper(LibSDL2::MouseButtonEvent)
      delegate button, state, clicks, x, y, to: inner
    end
  end
end
