module Nya
  # Time utils
  class Time
    @@last_utime : Float64 = ::Time.local.to_unix_f
    @@last_rtime : Float64 = ::Time.local.to_unix_f
    @@time_scale = 1.0

    # :nodoc:
    def self.update
      @@last_utime = ::Time.local.to_unix_f
    end

    # :nodoc:
    def self.render
      @@last_rtime = ::Time.local.to_unix_f
    end

    # :nodoc:
    def self.scale=(v : Float64)
      @@time_scale = v
    end

    # Returns the time scale
    def self.scale
      @@time_scale
    end

    # Returns time passed since last update
    def self.delta_time
      (::Time.local.to_unix_f - @@last_utime)*@@time_scale
    end

    # Returns time passed since last render call
    def self.render_delta
      ::Time.local.to_unix_f - @@last_rtime
    end
  end
end
