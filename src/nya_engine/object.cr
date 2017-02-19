require "./drawutils"
require "./storage/*"

module Nya
  abstract class AbsObject

    abstract def update
    abstract def render(tag : String?)
    abstract def awake
  end

  class Object
    include Nya::Serializable

    attribute tag, as: String, nilable: true
    attribute id, as: String, nilable: true
    attribute enabled, as: Bool, nilable: false

    @tag : String? = nil
    @id : String? = nil
    @enabled : Bool = true

    property enabled
    getter? enabled
    property tag, id

    def awake
    end

    def update
    end

    def render(tag : String? = nil)
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

    def awake
      @children.each(&.awake)
    end

    def update
      @children.each(&.update)
    end

    def render(tag : String? = nil)
      @children.each(&.render(tag))
    end
  end

  class GameObject < Container
    @components = [] of Object
    property components
    serializable_array components, of: Object

    def render(tag : String? = nil)
      super
      @components.each &.render(tag)
    end

    def update
      super
      @components.each &.update
    end

    def awake
      super
      @components.each &.awake
    end
  end

  class Component < Object
    def update

    end

    def render

    end
  end
end
