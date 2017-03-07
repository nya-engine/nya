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

    def matches_tag?(tag)
      tag.nil? || self.tag.nil? || self.tag == tag
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
      @children.each do |ch|
        LibGL.push_matrix
        ch.render tag
        LibGL.pop_matrix
      end
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
end

require "./render/shader_program"

module Nya
  class GameObject < Container
    @components = [] of Component
    @position = CrystalEdge::Vector3.new(0.0, 0.0, 0.0)
    @rotation = CrystalEdge::Vector3.new(0.0, 0.0, 0.0)
    @parent : GameObject? = nil
    property parent
    property components, position, rotation
    serializable_array components, of: Nya::Component
    serializable position, rotation, as: CrystalEdge::Vector3

    def absolute_rotation
      rot = @rotation
      unless @parent.nil?
        rot += @parent.not_nil!.absolute_rotation
      end
      rot
    end

    def absolute_position
      pos = @position
      unless @parent.nil?
        pos = pos
          .rotate(CrystalEdge::Quaternion.from_euler @parent.not_nil!.rotation) + @parent.not_nil!.absolute_position
      end
      pos
    end

    def render(tag : String? = nil)
      return unless matches_tag? tag
      comp = find_component_of?(Nya::Render::ShaderProgram)
      comp.use! unless comp.nil?
      LibGL.matrix_mode LibGL::MODELVIEW
      LibGL.push_matrix
      LibGL.rotatef(@rotation.x, 1.0, 0.0, 0.0)
      LibGL.rotatef(@rotation.y, 0.0, 1.0, 0.0)
      LibGL.rotatef(@rotation.z, 0.0, 0.0, 1.0)
      LibGL.translatef(*@position.to_gl)
      super
      @components.each &.render(tag)
      comp.unuse! unless comp.nil?
      LibGL.matrix_mode LibGL::MODELVIEW
      LibGL.pop_matrix
    end

    def update
      super
      @components.each &.update
    end

    def awake
      Nya.log.debug "Position #{@position.to_s}"
      @children.each &.as(GameObject).parent=(self)
      super
      @components.each &.parent=(self)
      @components.each &.awake
    end

    def find_components_of(type : Component.class)
      @components.select(&.class.===(type)).map { |x| type.cast x }
    end

    def find_component_of?(type)
      find_components_of(type).first?
    end

    def find_component_of(type)
      find_component_of?(type).not_nil!
    end
  end
end
