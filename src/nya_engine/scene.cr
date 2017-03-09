module Nya
  abstract class AbsScene
    abstract def update
    abstract def render

    abstract def root : Array(GameObject)
    abstract def world_id : LibODE::Worldid
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



    def initialize(@root)
    end

    def initialize
    end

    serializable_array root, of: GameObject

    def update
      @root.each &.update
    end

    def render(tag : String? = nil)
      @root.each &.render(tag)
    end

    def awake
      Nya.log.debug "Scene direct children : #{@root.size}", "SceneManager"
      @root.each &.awake
    end
  end
end
