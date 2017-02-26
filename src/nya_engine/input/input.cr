require "./events"

module Nya
  module Input
    @@keymap = Hash(Int32, Bool).new

    Nya::Event.subscribe :raw_key_up do |evt|
      event = evt.as?(KeyboardEvent)
      if event.nil?
        Nya.log.debug "KeyUp hook received Non-keyboard event", "Input"
      else
        #puts event.inner.keysym.scancode.to_s
      end
    end
  end
end
