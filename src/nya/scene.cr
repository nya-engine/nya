module Nya
  # Abstract scene class
  abstract class AbsScene
    # Updates scene objects
    abstract def update

    # Renders scene objects with `tag`
    abstract def render(tag : String? = nil)

    # Returns root of this scene
    abstract def root : Array(GameObject)

    # Returns array of components found recursively
    abstract def find_components_of(type : U.class) : Array(U) forall U

  end

  class Scene < AbsScene
    include Nya::Serializable
    @root = [] of GameObject
    property root

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
      Nya.log.debug "Scene direct children : #{@root.size}", "SceneManager"
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
