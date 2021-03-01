module Nya::Render
  # Interface for graphics backend
  abstract class Backend
    abstract class Metadata
      abstract def object_type : Symbol

      def finalize
        Engine.instance.backend.delete_object self
      end
    end

    abstract def create_object(objtype : Symbol) : Metadata
    abstract def delete_object(m : Metadata)

    abstract def load_texture(m : Metadata, w, h, texture : Bytes)

    # Wraps the execution of a block with calls required to render a camera
    abstract def draw_camera(camera : Camera, &block)

    abstract def current_camera : Camera

    # Draws a game object
    abstract def draw_game_object(object : ::Nya::GameObject, &block)

    # Draws a texture
    abstract def draw_texture(texture : Texture2D)

    # Draws a texture
    abstract def draw_texture(texture : Texture3D)

    # Draws a texture at specified position
    abstract def draw_texture(texture : Texture, x, y, w, h)

    # Draws a texture specified by low-level texture id at specified position
    abstract def draw_texture(texture : Metadata, x, y, w, h)

    # Draws a 3D texture
    abstract def draw_texture(texture : Texture, pts : Array(CrystalEdge::Vector3))

    # ditto
    abstract def draw_texture(texture : Metadata, pts : Array(CrystalEdge::Vector3))

    # Draws a mesh
    abstract def draw_mesh(mesh : Mesh)

    abstract def supports_shaders? : Bool
    abstract def shader_formats : Array(String)
    abstract def shader_extensions : Array(String)
    abstract def compile_shaders(program : ShaderProgram)
    abstract def use_shader_program(prog : ShaderProgram)
    abstract def unuse_shader_program
    abstract def with_shader_program(shp : ShaderProgram?, &block)
    abstract def delete_shaders(shp : ShaderProgram)

    abstract def relink_program(prog : ShaderProgram)

    abstract def apply_shader_vars(prog : ShaderProgram)

    abstract def max_textures : Int32

    abstract def project(point : CrystalEdge::Vector3) : CrystalEdge::Vector3
    abstract def unproject(point : CrystalEdge::Vector3) : CrystalEdge::Vector3

    abstract def project(camera : Camera, point : CrystalEdge::Vector3) : CrystalEdge::Vector3
    abstract def unproject(camera : Camera, point : CrystalEdge::Vector3) : CrystalEdge::Vector3

    abstract def resizeable? : Bool
    abstract def size=(size : CrystalEdge::Vector2)
    abstract def size : CrystalEdge::Vector2
    abstract def has_title? : Bool
    abstract def title=(title : String)
    abstract def title : String

    abstract def update
    abstract def render(&block)
    abstract def quit

    @@backends = {} of String => Backend.class

    class_property backends

    macro inherited
      ::Nya::Render::Backend.backends[{{@type}}.backend_name] = {{@type}}
    end
  end
end
