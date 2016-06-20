require "./transform"

module Nya
  abstract class Object
    abstract def update
    abstract def render
    @transform = Transform.zero
    property transform
  end

  class Container < Object
    @objects : Array(Object)
    def initialize(@objects)
    end

    def update
      @objects.each{|e|e.update}
    end

    def render
      @objects.each{|e|e.render}
    end
  end
end
