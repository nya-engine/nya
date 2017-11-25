module Nya
  # Abstract scene class
  abstract class AbsScene
    # Updates scene objects
    abstract def update

    # Renders scene objects with `tag`
    abstract def render(tag : String? = nil)

    # Returns root of this scene
    abstract def root : Array(GameObject)

    # Returns world ID of this scene
    abstract def world_id : LibODE::Worldid

    # Returns space ID of this scene
    abstract def space_id : LibODE::Spaceid

  end

  class Scene < AbsScene
    include Nya::Serializable
    @root = [] of GameObject
    @world_id = LibODE.world_create
    @space_id = LibODE.hash_space_create nil
    property root
    property world_id
    property space_id

    # Initializes scene with `root`
    def initialize(@root)
    end

    # Initializes scene with empty root
    def initialize
    end

    serializable_array root, of: GameObject

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
  end
end
