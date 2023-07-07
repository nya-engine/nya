require "../../bindings/gl"
require "../../bindings/glu"
require "../../bindings/sdl2"
require "./gl"
require "./sdl2"

module Nya::Render::Backends
  class GL_SDL < Backend

    include GL
    include SDL2

    alias Metadata = GL::Metadata

    @window : Pointer(LibSDL2::Window)

    def self.backend_name
      "OpenGL + SDL2"
    end



    def initialize(size : CrystalEdge::Vector2, title : String, fullscreen = false)
      raise LibSDL2.get_error.to_s if LibSDL2.init(LibSDL2::INIT_VIDEO) < 0

      LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLDOUBLEBUFFER, 1)
      LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLREDSIZE, 6)
      LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLBLUESIZE, 6)
      LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLGREENSIZE, 6)

      @window = LibSDL2.create_window(title, WP_CENTERED, WP_CENTERED, size.x.to_i32, size.y.to_i32, LibSDL2::WindowFlags::WINDOWSHOWN | LibSDL2::WindowFlags::WINDOWOPENGL)
      raise LibSDL2.get_error.as(String) if @window.null?
      LibSDL2.set_window_resizable(@window, LibSDL2::Bool::TRUE)
      @gl_ctx = LibSDL2.gl_create_context(@window)

      raise LibSDL2.get_error.as(String) if @gl_ctx.null?

      Nya.log.info { "Max GL lights : #{Render::Light.max_lights}" }
 
      LibGL.clear_color(0.0, 0.0, 0.0, 0.0)
      LibGL.clear_depth(1.0)
      LibGL.depth_func(LibGL::LESS)
      LibGL.enable(LibGL::DEPTH_TEST)
      LibGL.enable(LibGL::COLOR_MATERIAL)
      LibGL.enable LibGL::LIGHTING
      LibGL.alpha_func(LibGL::GREATER, 0.1)
      LibGL.shade_model(LibGL::SMOOTH)
      LibGL.blend_func(LibGL::SRC_ALPHA, LibGL::ONE_MINUS_SRC_ALPHA)

      LibGL.enable LibGL::DEBUG_OUTPUT
      LibGL.enable LibGL::DEBUG_OUTPUT_SYNCHRONOUS
      set_debug_callback!

      @max_textures = max_textures
    end

    def render(&block)
      LibGL.clear_color(0.0, 0.0, 0.0, 1.0)
      LibGL.clear(LibGL::COLOR_BUFFER_BIT | LibGL::DEPTH_BUFFER_BIT)
      block.call
      LibGL.flush
      LibSDL2.gl_swap_window(@window)
    end
  end
end
