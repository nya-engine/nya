require "./sdl2"
require "./gl"
require "./glu"
require "./nya_engine/**"
require "crystaledge"

width = 640
height = 480

WP_CENTERED = 0x2FFF0000

def update_loop
  Nya::Time.update
end

def p2(i : Int)
  j = 1i64
  while j<i
    j <<= 1
  end
  j
end

def render_loop
  puts __FILE__ + __LINE__.to_s
  GL.clear_color(0.0,0.0,0.0,1.0)
  GL.clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT)

  GL.raster_pos2i(0,0)

  puts __FILE__ + __LINE__.to_s
  font = Nya::Freetype.new("res/Ubuntu-R.ttf").gen_font(
    [
      'F','P','S','H','e','l','o','w','r','d',
      '1','2','3','4','5','6','7','8','9','0',
      ':',',','.','!',' '
    ],
    32u16
  )
  puts __FILE__ + __LINE__.to_s
  x = 0
  y = 0
  puts __FILE__ + __LINE__.to_s
  str = "FPS : #{(1/Nya::Time.delta_time).round(2)}\nHello OpenGL!"
  font.draw_string CrystalEdge::Vector2.zero, str
  puts __FILE__ + __LINE__.to_s
end

begin
  raise SDL2.get_error.as(String) if SDL2.init(SDL2::INIT_VIDEO) < 0

  SDL2.gl_set_attribute(SDL2::GLattr::GLDOUBLEBUFFER,1)
  SDL2.gl_set_attribute(SDL2::GLattr::GLREDSIZE,6)
  SDL2.gl_set_attribute(SDL2::GLattr::GLBLUESIZE,6)
  SDL2.gl_set_attribute(SDL2::GLattr::GLGREENSIZE,6)

  window = SDL2.create_window("Cube",WP_CENTERED,WP_CENTERED,width,height,SDL2::WindowFlags::WINDOWSHOWN|SDL2::WindowFlags::WINDOWOPENGL)
  gl_ctx = SDL2.gl_create_context(window)

  raise SDL2.get_error.as(String) if window.null?

  GL.clear_color(0.0,0.0,0.0,0.0)
  GL.clear_depth(1.0)
  GL.depth_func(GL::LESS)
  GL.enable(GL::DEPTH_TEST)
  GL.shade_model(GL::SMOOTH)
  GL.matrix_mode(GL::PROJECTION)
  GL.load_identity
  GLU.perspective(45.0,width.to_f/height.to_f,0.1,100.0)

  GL.matrix_mode(GL::MODELVIEW)

  x = 0.0
  y = 0.0
  z = 0.0
  running = true
  i = 0u8

  #Nya::Time.init

  while running
    i+=1
    i%=128
    SDL2.poll_event(out evt)
    #puts evt.type if i == 0
    raise "Terminated" if evt.type.to_s == "256" #Terminate program when window is closed
    x -= 0.5
    y -= 0.5
    z -= 0.5

    Nya::Event.send(:update,Nya::Event.new)
    update_loop
    puts __FILE__ + __LINE__.to_s
    puts "FPS : " + (1/Nya::Time.delta_time).round(2).to_s if i == 0
    render_loop
    puts __FILE__ + __LINE__.to_s
    GL.flush
    SDL2.gl_swap_window(window)
  end

ensure
  SDL2.quit
end
