require "./events"
require "bit_array"

module Nya
  # Input helper methods
  module Input
    @@log : Log = Nya.log.for(self)
    @@keymap = Hash(Keycode, Bool).new

    Nya::Event.subscribe_typed :key_up, as: KeyboardEvent do |evt|
      if evt.nil?
        @@log.warn { "KeyUp hook received Non-keyboard event" }
      else
        @@keymap[evt.keycode] = false if @@keymap.has_key? evt.keycode
      end
    end

    Nya::Event.subscribe_typed :key_down, as: KeyboardEvent do |evt|
      if evt.nil?
        @@log.warn { "KeyDown received Non-keyboard event" }
      else
        @@keymap[evt.keycode] = true
      end
    end

    # Returns true if given key is pressed
    def self.key?(kcode : Keycode)
      @@keymap[kcode]?
    end

    # ditto
    def self.key?(kcode)
      kc = Keycode.parse(kcode.to_s.upcase)
      key? kc
    end

    @@mouse = BitArray.new(256)

    Nya::Event.subscribe_typed :mouse_button_down, as: MouseButtonEvent do |e|
      if e.nil?
        @@log.warn { "MBDown hook received Non-MB event" }
      else
        @@mouse[e.button] = true
      end
    end

    Nya::Event.subscribe_typed :mouse_button_up, as: MouseButtonEvent do |e|
      if e.nil?
        @@log.warn { "MBUp hook received Non-MB event" }
      else
        @@mouse[e.button] = false
      end
    end

    # Returns true if the given mouse button is pressed
    def self.mouse?(button : UInt8)
      @@mouse[button]
    end

    # ditto
    @[AlwaysInline]
    def self.mouse?(b)
      mouse? b.to_u8
    end
  end
end
