module Nya
  class Scene
    include Nya::Serializable
    @root = [] of GameObject
    property root : Array(GameObject)

    # Initializes scene with `root`
    def initialize(@root)
    end

    # Initializes scene with empty root
    def initialize
    end

    serializable root : Array(GameObject)

    def update
      @root.each &.update
    end

    def render(tag : String? = nil)
      @root.each &.render(tag)
    end

    # Post-initializes scene objects
    def awake
      @root.each &.awake
    end

    def find_components_of(type : U.class) : Array(U) forall U
      {% unless U < Component %}
        {% raise "Non-component class" %}
      {% end %}
      @root.reduce([] of U) { |memo, e| memo + e.find_in_children type }
    end
  end
end
