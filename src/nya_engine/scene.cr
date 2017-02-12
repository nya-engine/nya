module Nya
  abstract class AbsScene
    abstract def update
    abstract def render
  end

  class Scene < AbsScene
    @root : Container

    def initialize(@root)
    end

    delegate update, render, to: @root
  end
end
