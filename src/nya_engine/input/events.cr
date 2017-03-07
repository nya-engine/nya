module Nya
  module Input
    alias Keycode = SDL2::Keycode
    alias Scancode = SDL2::Scancode

    class KeyboardEvent < Nya::EventWrapper(SDL2::KeyboardEvent)
      delegate keycode, scancode, to: inner.keysym
    end

    class MouseMotionEvent < Nya::EventWrapper(SDL2::MouseMotionEvent)
      delegate state, x, y, xrel, yrel, to: inner
    end

    class MouseWheelEvent < Nya::EventWrapper(SDL2::MouseWheelEvent)
      delegate x, y, which, to: inner
    end

    class MouseButtonEvent < Nya::EventWrapper(SDL2::MouseButtonEvent)
      delegate button, state, clicks, x, y, to: inner
    end
  end
end
