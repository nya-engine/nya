require "logger"

module Nya
  @@log = Logger.new(STDOUT)
  @@log.level = Logger::DEBUG
  class_property log

  module Log
    delegate debug, log, warn, error, fatal, unknown, to: Nya.log
  end
end
