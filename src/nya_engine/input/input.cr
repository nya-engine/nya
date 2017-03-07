require "./events"

module Nya
  module Input
    @@keymap = Hash(Keycode, Bool).new

    Nya::Event.subscribe_typed :key_up, as: KeyboardEvent do |evt|
      if evt.nil?
        Nya.log.debug "KeyUp hook received Non-keyboard event", "Input"
      else
        @@keymap[evt.keycode] = false if @@keymap.has_key? evt.keycode
      end
    end

    Nya::Event.subscribe_typed :key_down, as: KeyboardEvent do |evt|
      if evt.nil?
        Nya.log.debug "KeyDown received Non-keyboard event"
      else
        @@keymap[evt.keycode] = true
      end
    end

    def self.key?(kcode : Keycode)
      @@keymap[kcode]
    end

    def self.key?(kcode)
      kc = Keycode.from_value(kcode.to_s.upcase)
      key? kc
    end
  end
end
