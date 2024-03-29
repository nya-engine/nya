require "./storage"

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

    attribute tag : String, id : String, enabled : Bool

    @tag : String? = nil
    @id : String? = nil
    @enabled : Bool = true

    property enabled
    getter? enabled
    property tag, id

    def engine
      Engine.instance
    end

    def backend
      engine.backend
    end

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

    serializable children : Array(Object)

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
      @children.each &.render(tag)
    end
  end

  # Component class
  #
  # This class must be a superclass for all custom components (like Component in Unity3D)
  class Component < Object
    @parent : GameObject? = nil
    @metadata : Render::Backend::Metadata? = nil

    setter parent, metadata

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

    def metadata
      @metadata.not_nil!
    end

    def metadata?
      @metadata
    end

    def log
      Nya.log
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
    serializable components : Array(Component), position : CrystalEdge::Vector3, rotation : CrystalEdge::Vector3

    def absolute_rotation
      rot = @rotation
      unless @parent.nil?
        rot += @parent.not_nil!.absolute_rotation
      end
      rot
    end

    def children!
      @children.compact_map(&.as?(GameObject))
    end

    def absolute_position
      pos = @position
      unless @parent.nil?
        pos = pos
          .rotate(@parent.not_nil!.rotation) + @parent.not_nil!.absolute_position
      end
      pos
    end

    def render(tag : String? = nil)
      return unless matches_tag? tag

      # FIXME: inherit shader program if nil

      backend.with_shader_program find_component_of?(Render::ShaderProgram) do
        backend.draw_game_object self do
          children!.each &.render(tag)
          @components.each &.render(tag)
        end
      end
    end

    def update
      super
      @components.each &.update
    end

    def awake
      @children.each &.as(GameObject).parent=(self)
      super
      @components.each &.parent=(self)
      @components.each &.awake
    end

    # Find all components of given type in this GameObject
    def find_components_of(type : U.class) : Array(U) forall U
      {% unless U < Component %}
        {% raise "Not a component class" %}
      {% end %}
      @components.compact_map do |x|
        if x.ancestor_or_same? U
          x.as(U)
        else
          nil
        end
      end
    end

    # Find component of given type in this GameObject
    # Returns nil if there's no such component
    def find_component_of?(type : U.class) forall U
      {% unless U < Component %}
        {% raise "Not a component class" %}
      {% end %}
      @components.find(&.ancestor_or_same?(U)).as?(U)
    end

    # Find component of given type
    # Raises an exception if there is no such component
    def find_component_of(type)
      find_component_of?(type).not_nil!
    end

    # Find components of given type recursively
    # WARNING! This may be slow on big object structures, consider doing it in a separate fiber in that cases
    def find_in_children(type : U.class) : Array(U) forall U
      {% unless U < Component %}
        {% raise "Not a component class" %}
      {% end %}
      find_components_of(type) + children!.reduce([] of U) do |memo, e|
        memo + e.find_in_children type
      end
    end
  end
end
