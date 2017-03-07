require "./nya_engine/**"
require "crystaledge"

WP_CENTERED = 0x2FFF0000

def update_loop
  Nya::Time.update
  Nya::SceneManager.update
end

def render_loop
  GL.clear_color(0.0,0.0,0.0,1.0)
  GL.clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT)
  Nya.camera_list.each &.render!
  err = Nya.gl_error?
  unless err.nil?
    Nya.log.error err.to_s, "GL"
  end
end

begin
  raise SDL2.get_error.to_s if SDL2.init(SDL2::INIT_VIDEO) < 0

  SDL2.gl_set_attribute(SDL2::GLattr::GLDOUBLEBUFFER,1)
  SDL2.gl_set_attribute(SDL2::GLattr::GLREDSIZE,6)
  SDL2.gl_set_attribute(SDL2::GLattr::GLBLUESIZE,6)
  SDL2.gl_set_attribute(SDL2::GLattr::GLGREENSIZE,6)

  Nya.window = SDL2.create_window("Cube",WP_CENTERED,WP_CENTERED,Nya.width,Nya.height,SDL2::WindowFlags::WINDOWSHOWN|SDL2::WindowFlags::WINDOWOPENGL)
  gl_ctx = SDL2.gl_create_context(Nya.window)

  raise SDL2.get_error.as(String) if Nya.window?.is_a?(Nil) || Nya.window.not_nil!.null?

  GL.clear_color(0.0,0.0,0.0,0.0)
  GL.clear_depth(1.0)
  GL.depth_func(GL::LESS)
  GL.enable(GL::DEPTH_TEST)
  GL.enable(GL::TEXTURE_2D)
  GL.shade_model(GL::SMOOTH)
  GL.matrix_mode(GL::PROJECTION)
  GL.blend_func(GL::SRC_ALPHA,GL::ONE_MINUS_SRC_ALPHA)
  GL.load_identity
  GLU.perspective(45.0,Nya.width/Nya.height,0.1,100.0)

  GL.matrix_mode(GL::MODELVIEW)
  Nya::SceneManager.load_from_file("res/testscene2.xml")
  while true
    Nya::Event.send(:update,Nya::Event.new)
    update_loop
    while SDL2.poll_event(out evt) != 0
      case evt.type
      when SDL2::EventType::KEYUP
        Nya::Event.send :key_up, Nya::Input::KeyboardEvent.new(evt.key)
      when SDL2::EventType::KEYDOWN
        Nya::Event.send :key_down, Nya::Input::KeyboardEvent.new(evt.key)
      when SDL2::EventType::QUIT
        evt = Nya::Event.new
        Nya::Event.send :quit, evt
        exit 0 unless evt.status.dead?
      when SDL2::EventType::MOUSEMOTION
        Nya::Event.send :mouse_motion, Nya::Input::MouseMotionEvent.new(evt.motion)
      when SDL2::EventType::MOUSEWHEEL
        Nya::Event.send :mouse_wheel, Nya::Input::MouseWheelEvent.new(evt.wheel)
      when SDL2::EventType::MOUSEBUTTONUP
        Nya::Event.send :mouse_button_up, Nya::Input::MouseButtonEvent(evt.button)
      when SDL2::EventType::MOUSEBUTTONDOWN
        Nya::Event.send :mouse_button_down, Nya::Input::MouseButtonEvent(evt.button)
      end
    end


    render_loop
    GL.flush
    SDL2.gl_swap_window(Nya.window)
  end

ensure
  SDL2.quit
end
