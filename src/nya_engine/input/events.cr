module Nya
  module Input
    class KeyboardEvent < Nya::Event
      @inner : SDL2::KeyboardEvent

      property inner

      def initialize(@inner)
      end
    end
  end
end
