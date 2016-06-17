module Nya
  class Time
    @@last_utime : Float64
    @@last_rtime : Float64
    @@last_gtime : Float64
    @@time_scale = 1.0

    def self.update
      @@last_utime = Time.now.to_f
    end

    def self.render
      @@last_rtime = Time.now.to_f
    end

    def self.gui
      @@last_gtime = Time.now.to_f
    end

    def self.scale=(v : Float64)
      @@time_scale = v
    end

    def self.scale
      @@time_scale
    end

    def self.delta_time
      (Time.now.to_f - @@last_utime)*@@time_scale
    end

    def self.render_delta
      Time.now.to_f - @@last_rtime
    end

    def self.gui_delta
      Time.now.to_f - @@last_gtime
    end

    def self.init
      @@last_utime = @@last_gtime = @@last_rtime = Time.now.to_f
    end
  end
end
