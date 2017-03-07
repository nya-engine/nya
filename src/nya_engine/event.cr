module Nya
  enum EventStatus
    ACTIVE
    DEAD
  end

  class EventHandler
    @proc : Event ->
    @id : Int64
    getter id
    def initialize(&proc : Event ->)
      @id = Event.id
      @proc = proc
    end

    def call(e : Event)
      @proc.call e unless e.status == EventStatus::DEAD
    end
  end

  class Event
    @@events = Hash(String,Array(EventHandler)).new
    @@id = 0i64

    @status = EventStatus::ACTIVE
    property status

    def self.print!
      Nya.log.debug "Registered handlers for #{@@events.keys.size} event types", "Event"
    end

    def self.id
      i = @@id
      @@id += 1
      i
    end

    def self.subscribe(*events, handler)
      events.each do |e|
        @@events[e.to_s] ||= Array(EventHandler).new
        @@events[e.to_s].push handler
      end
    end

    def self.subscribe(*events, &handler : Event ->)
      events.each do |e|
        @@events[e.to_s] ||= Array(EventHandler).new
        @@events[e.to_s].push EventHandler.new(&handler)
      end
    end

    def self.unsubscribe(handler : EventHandler)
      @@events.each do |k,v|
        v.delete_if{|elem| elem.id == handler.id}
      end
    end

    def self.unsubscribe(id : Int64)
      @@events.each do |k,v|
        v.delete_if{|elem| elem.id == id}
      end
    end


    def self.send(name, event : Event)
      if @@events.has_key? name.to_s
        @@events[name.to_s].each do |h|
          h.call event
        end
      end
    end

    macro subscribe_typed(*args, as t, &proc)
      {% name = proc.args.first %}
      ::Nya::Event.subscribe {{*args}} do |%evt|
        {{name.id}} = %evt.as?({{t}})
        {{proc.body}}
      end
    end
  end

  class EventWrapper(T) < Event
    property inner : T

    def initialize(@inner)
    end
  end
end
