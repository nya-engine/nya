module Nya
  abstract class AbsScene
    abstract def update
    abstract def render
  end

  class Scene < AbsScene
    include Nya::Serializable
    property root : Container
    property id : String? = nil

    def initialize(@root)
    end

    def initialize
      @root = Container.new
    end

    attribute id, String, nilable: true

    delegate update, render, to: @root
  end
end
