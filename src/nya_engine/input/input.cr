require "./events"

module Nya
  module Input
    @@keymap = Hash(Int32, Bool).new

    Nya::Event.subscribe_typed :key_up , as: KeyboardEvent do |evt|
      if evt.nil?
        Nya.log.debug "KeyUp hook received Non-keyboard event", "Input"
      else
        #puts event.inner.keysym.scancode.to_s
      end
    end
  end
end
