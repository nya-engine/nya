module Nya
  abstract class AbsScene
    abstract def update
    abstract def render
  end

  class Scene < AbsScene
    include Nya::Serializable
    @root = [] of GameObject
    property root

    def initialize(@root)
    end

    def initialize
    end

    serializable_array root, of: GameObject

    def update
      @root.each &.update
    end

    def render(tag : String? = nil)
      #GL.load_identity
      @root.each &.render(tag)
    end

    def awake
      Nya.log.debug "Scene direct children : #{@root.size}", "SceneManager"
      @root.each &.awake
    end
  end
end
