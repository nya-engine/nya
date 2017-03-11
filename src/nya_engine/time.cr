module Nya
  class Time
    @@last_utime : Float64 = ::Time.now.epoch_f
    @@last_rtime : Float64 = ::Time.now.epoch_f
    @@time_scale = 1.0

    def self.update
      @@last_utime = ::Time.now.epoch_f
    end

    def self.render
      @@last_rtime = ::Time.now.epoch_f
    end

    def self.scale=(v : Float64)
      @@time_scale = v
    end

    def self.scale
      @@time_scale
    end

    def self.delta_time
      (::Time.now.epoch_f - @@last_utime)*@@time_scale
    end

    def self.render_delta
      ::Time.now.epoch_f - @@last_rtime
    end
  end
end
