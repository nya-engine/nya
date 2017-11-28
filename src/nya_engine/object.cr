require "./storage/*"

module Nya
  # Abstract base class for objects
  abstract class AbsObject
    # Updates state of this object
    abstract def update

    # Renders object with given `tag`
    abstract def render(tag : String?)

    # Post-initializes this object
    abstract def awake(engine : Engine)

    # Post-initializes this object
    abstract def awake

    abstract def ancestor_or_same?(t : U.class) forall U
  end

  # Base class for all in-game objects
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



    # Post-initializes this object
    #
    # Override this method to implement custom post-initialization behaviour
    # Remember to call super when necessary (for example, before custom logic)
    def awake
    end

    def update
    end

    # Returns `true` if this object must be rendered with given `tag`
    def matches_tag?(tag)
      tag.nil? || self.tag.nil? || self.tag == tag
    end

    # Renders object
    #
    # Override this method to implement custom render logic.
    def render(tag : String? = nil)
    end

    def ancestor_or_same?(u : U.class) forall U
      return {{@type <= U}}
    end
  end

  # Object that can store other objects
  class Container < Object
    @children : Array(Object)

    property children

    serializable_array children, of: Object

    def initialize(@children)
    end

    def initialize
      @children = [] of Object
    end

    # Post-initializes object and its children
    #
    # See Nya::Object#awake
    # Remember that you MUST call super in overridden method in order to make this work properly
    def awake
      @children.each(&.awake)
    end

    def update
      @children.each(&.update)
    end

    # Renders object
    #
    # Remember that you MUST call super in overridden method in order to make this work properly
    def render(tag : String? = nil)
      @children.each do |ch|
        LibGL.push_matrix
        ch.render tag
        LibGL.pop_matrix
      end
    end
  end

  # Component class
  #
  # This class must be a superclass for all custom components (like Component in Unity3D)
  class Component < Object
    @parent : GameObject? = nil

    setter parent

    # Returns parent of component
    #
    # Raises an exception if parent is nil
    def parent
      @parent.not_nil!
    end

    # Returns parent or nil
    def parent?
      @parent
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
    serializable position, as: CrystalEdge::Vector3
    serializable rotation, as: CrystalEdge::Vector3

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
          .rotate(Quaternion.from_euler @parent.not_nil!.rotation) + @parent.not_nil!.absolute_position
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

    def find_components_of(type : U.class) : Array(U) forall U
      {% unless U < Component %}
        {% raise "Cannot find non-component classes" %}
      {% end %}
      @components.compact_map do |x|
        if x.ancestor_or_same? U
          x.as(U)
        else
          nil
        end
      end
    end

    def find_component_of?(type : U.class) forall U
      {% unless U < Component %}
        {% raise "Cannot find non-component classes" %}
      {% end %}
      @components.find(&.ancestor_or_same?(U)).as?(U)
    end

    def find_component_of(type)
      find_component_of?(type).not_nil!
    end
  end
end
