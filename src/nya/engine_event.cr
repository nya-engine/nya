require "./event"

module Nya
  class EngineEvent < Event
    property engine : Engine

    def initialize(@engine)
    end
  end
end
