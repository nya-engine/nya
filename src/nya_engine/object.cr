require "./transform"
require "./drawutils"
require "./storage/*"

module Nya
  abstract class AbsObject

    abstract def update
    abstract def render
  end

  class Object
    include Nya::Serializable

    def update
    end

    def render
    end
  end

  class Container < Object
    @children : Array(Object)

    property children

    serializable_array children, of: Object

    def initialize(@children)
    end

    def initialize
      @children = [] of Object
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
