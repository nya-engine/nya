module Nya
  # Status of event
  enum EventStatus
    ACTIVE
    DEAD
  end

  # Event handler class
  class EventHandler
    @proc : Event ->
    @id : Int64

    # Handler ID
    getter id

    def initialize(&proc : Event ->)
      @id = Event.id
      @proc = proc
    end

    # Call handler
    def call(e : Event)
      @proc.call e unless e.status == EventStatus::DEAD
    end
  end

  # Base class for events
  class Event
    @@events = Hash(String, Array(EventHandler)).new
    @@id = 0i64

    @status = EventStatus::ACTIVE

    # Status of event
    property status

    # :nodoc:
    def self.print!
      Nya.log.debug { "Registered handlers for #{@@events.keys.size} event types" }
    end

    # :nodoc:
    def self.id
      i = @@id
      @@id += 1
      i
    end

    # Subscribe handler to event types (`events`)
    def self.subscribe(*events, handler)
      events.each do |e|
        @@events[e.to_s] ||= Array(EventHandler).new
        @@events[e.to_s].push handler
      end
    end

    # Subscribe proc to event types
    def self.subscribe(*events, &handler : Event ->)
      events.each do |e|
        @@events[e.to_s] ||= Array(EventHandler).new
        @@events[e.to_s].push EventHandler.new(&handler)
      end
    end

    # Unsubscribe handler
    def self.unsubscribe(handler : EventHandler)
      @@events.each do |k, v|
        v.delete_if { |elem| elem.id == handler.id }
      end
    end

    # Unsubscribe handler by `ID`
    def self.unsubscribe(id : Int64)
      @@events.each do |k, v|
        v.delete_if { |elem| elem.id == id }
      end
    end

    # Fire an event. Calls #send_async if called not from engine main fiber
    def self.send(name, event : Event)
      if Fiber.current.name != Nya::Engine::FIBER_NAME
        send_async name, event
      end
      if @@events.has_key? name.to_s
        @@events[name.to_s].each do |h|
          h.call event
        end
      end
    end

    # Helper macro to automatically cast event passed to handler
    macro subscribe_typed(*args, as t, &proc)
      {% name = proc.args.first %}
      ::Nya::Event.subscribe {{*args}} do |%evt|
        {{name.id}} = %evt.as?({{t}})
        {{proc.body}}
      end
    end

    # :nodoc:
    record Message, name : String, event : Event

    @@async_events = Channel(Message).new
    @@event_mutex = Mutex.new

    # Send an event that will be triggered from update fiber
    def self.send_async(name, e : Event)
      @@event_mutex.synchronize do
        @@async_events.send Message.new(event: e.as(Event), name: name.to_s)
      end
      Fiber.yield
    end

    # :nodoc:
    def self.update
      while evt = @@async_events.receive?
        send evt.name, evt.event
      end
      Fiber.yield
    end
  end

  # Helper class to wrap low level SDL events
  class EventWrapper(T) < Event
    property inner : T

    def initialize(@inner)
    end
  end
end
