require "./events"
require "bit_array"

module Nya
  module Input
    @@keymap = Hash(Keycode, Bool).new

    Nya::Event.subscribe_typed :key_up, as: KeyboardEvent do |evt|
      if evt.nil?
        Nya.log.warn "KeyUp hook received Non-keyboard event", "Input"
      else
        @@keymap[evt.keycode] = false if @@keymap.has_key? evt.keycode
      end
    end

    Nya::Event.subscribe_typed :key_down, as: KeyboardEvent do |evt|
      if evt.nil?
        Nya.log.warn "KeyDown received Non-keyboard event", "Input"
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

    @@mouse = BitArray.new(256)

    Nya::Event.subscribe_typed :mouse_button_down, as: MouseButtonEvent do |e|
      if e.nil?
        Nya.log.warn "MBDown hook received Non-MB event","Input"
      else
        @@mouse[e.button] = true
      end
    end

    Nya::Event.subscribe_typed :mouse_button_up, as: MouseButtonEvent do |e|
      if e.nil?
        Nya.log.warn "MBDown hook received Non-MB event","Input"
      else
        @@mouse[e.button] = false
      end
    end

    def self.mouse?(button : UInt8)
      @@mouse[button]
    end

    @[AlwaysInline]
    def self.mouse?(b)
      mouse? b.to_u8
    end
  end
end
