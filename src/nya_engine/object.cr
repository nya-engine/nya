require "./transform"
require "./drawutils"

module Nya
  abstract class Object
    #include DrawUtils

    abstract def update
    abstract def render
    @transform = Transform.zero
    property transform
  end

  class Container < Object
    @children : Array(Object)
    def initialize(@children)
    end

    def update
      @children.each{|e|e.update}
    end

    def render
      @children.each{|e|e.render}
    end
  end

  class GameObject < Container

  end

  class Component < Object
    def update

    end

    def render

    end
  end
end
