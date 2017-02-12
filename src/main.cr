require "./sdl2"
require "./gl"
require "./glu"
require "./nya_engine/**"
require "crystaledge"

WIDTH = 640
HEIGHT = 480

WP_CENTERED = 0x2FFF0000


def update_loop
  Nya::Time.update
  Nya::SceneManager.update
end

def p2(i : Int)
  j = 1i64
  while j<i
    j <<= 1
  end
  j
end

def render_loop
  GL.clear_color(0.0,0.0,0.0,1.0)
  GL.clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT)
  Nya::SceneManager.render
end

begin
  raise SDL2.get_error.to_s if SDL2.init(SDL2::INIT_VIDEO) < 0

  SDL2.gl_set_attribute(SDL2::GLattr::GLDOUBLEBUFFER,1)
  SDL2.gl_set_attribute(SDL2::GLattr::GLREDSIZE,6)
  SDL2.gl_set_attribute(SDL2::GLattr::GLBLUESIZE,6)
  SDL2.gl_set_attribute(SDL2::GLattr::GLGREENSIZE,6)

  window = SDL2.create_window("Cube",WP_CENTERED,WP_CENTERED,@@width,@@height,SDL2::WindowFlags::WINDOWSHOWN|SDL2::WindowFlags::WINDOWOPENGL)
  gl_ctx = SDL2.gl_create_context(window)

  raise SDL2.get_error.as(String) if window.null?

  GL.clear_color(0.0,0.0,0.0,0.0)
  GL.clear_depth(1.0)
  GL.depth_func(GL::LESS)
  GL.enable(GL::DEPTH_TEST)
  GL.enable(GL::TEXTURE_2D)
  GL.shade_model(GL::SMOOTH)
  GL.matrix_mode(GL::PROJECTION)
  GL.blend_func(GL::SRC_ALPHA,GL::ONE_MINUS_SRC_ALPHA)
  GL.load_identity
  GLU.perspective(45.0,WIDTH.to_f/HEIGHT.to_f,0.1,100.0)

  GL.matrix_mode(GL::MODELVIEW)
  running = true
  i=0u8

  #Nya::Time.init
  #@@tex = Nya::Pango.render_text("Hello OpenGL world!","Ubuntu Bold 12")

  while running
    i+=1
    i%=128
    SDL2.poll_event(out evt)
    #puts evt.type if i == 0
    raise "Terminated" if evt.type.to_s == "256" #Terminate program when window is closed
    Nya::Event.send(:update,Nya::Event.new)
    update_loop
    puts "FPS : " + (1/Nya::Time.delta_time).round(2).to_s if i == 0
    render_loop
    GL.flush
    SDL2.gl_swap_window(window)
  end

ensure
  SDL2.quit
end
