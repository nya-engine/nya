module Nya
  enum EventStatus
    ACTIVE
    DEAD
  end

  class Event
    @@events = Hash(Symbol,Array(EventHandler)).new
    @@id = 0i64

    @status = EventStatus::ACTIVE
    property status

    def self.id
      i = @@id
      @@id += 1
      i
    end

    def self.subscribe(*events : Symbol,handler : EventHandler)
      events.each do |e|
        @@events[e] ||= Array(EventHandler).new
        @@events[e].push handler
      end
    end

    def self.subscribe(*events : Symbol, &handler : Event ->)
      e = EventHandler.new(&handler)
      subscribe(*events,e)
      e
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


    def self.send(name : Symbol, event : Event)
      if @@events.has_key? name
        @@events[name].each do |h|
          h.call event
        end
      end
    end
  end

  class EventHandler
    @proc : Event ->
    @id : Int64
    getter id
    def initialize(&@proc)
      @id = Event.id
    end

    def call(e : Event)
      @proc.call e unless e.status == EventStatus::DEAD
    end
  end
end
