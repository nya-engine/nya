require "log"

module Nya
  @@log = Log.for("Nya")
  @@log.level = ::Log::Severity::Trace
  class_property log : Log
end
