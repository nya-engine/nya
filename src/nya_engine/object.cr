require "./transform"

module Nya
  class Object
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
      
    end

    def render

    end
  end
end
