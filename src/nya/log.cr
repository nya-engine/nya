require "logger"

module Nya
  @@log = Logger.new(STDOUT)
  @@log.level = Logger::DEBUG
  class_property log

  # Helper module to shorten logger's method calls
  module Log
    delegate debug, log, warn, error, fatal, unknown, to: Nya.log
  end
end
