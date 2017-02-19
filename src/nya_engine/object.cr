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

  class Component < Object
    @parent : GameObject? = nil

    setter parent

    def parent
      @parent.not_nil!
    end

    def parent?
      @parent
    end

    def awake

    end

    def update

    end

    def render

    end
  end

  class GameObject < Container
    @components = [] of Component
    @position = CrystalEdge::Vector3.new(0.0,0.0,0.0)
    @rotation = CrystalEdge::Vector3.new(0.0,0.0,0.0)
    property components, position, rotation
    serializable_array components, of: Nya::Component

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
      @components.each &.parent=(self)
      @components.each &.awake
    end
  end
end
