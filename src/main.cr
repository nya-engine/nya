require "./nya_engine/**"
require "crystaledge"

WP_CENTERED = 0x2FFF0000

def update_loop
  Nya::SceneManager.update
  Nya::Time.update
end

def render_loop
  LibGL.clear_color(0.0, 0.0, 0.0, 1.0)
  LibGL.clear(LibGL::COLOR_BUFFER_BIT | LibGL::DEPTH_BUFFER_BIT)
  Nya.camera_list.each &.render!
  err = Nya.gl_error?
  unless err.nil?
    Nya.log.error err.to_s, "GL"
  end
  Nya::Time.render
end

alias PhysCallback = LibODE::Geomid, LibODE::Geomid ->

begin
  raise LibSDL2.get_error.to_s if LibSDL2.init(LibSDL2::INIT_VIDEO) < 0

  LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLDOUBLEBUFFER, 1)
  LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLREDSIZE, 6)
  LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLBLUESIZE, 6)
  LibSDL2.gl_set_attribute(LibSDL2::GLattr::GLGREENSIZE, 6)

  Nya.window = LibSDL2.create_window("Cube", WP_CENTERED, WP_CENTERED, Nya.width, Nya.height, LibSDL2::WindowFlags::WINDOWSHOWN | LibSDL2::WindowFlags::WINDOWOPENGL)
  gl_ctx = LibSDL2.gl_create_context(Nya.window)

  raise LibSDL2.get_error.as(String) if Nya.window?.is_a?(Nil) || Nya.window.not_nil!.null?

  LibGL.clear_color(0.0, 0.0, 0.0, 0.0)
  LibGL.clear_depth(1.0)
  LibGL.depth_func(LibGL::LESS)
  LibGL.enable(LibGL::DEPTH_TEST)
  LibGL.enable(LibGL::ALPHA_TEST)
  LibGL.alpha_func(LibGL::GREATER, 0.5)
  LibGL.enable(LibGL::TEXTURE_2D)
  LibGL.shade_model(LibGL::SMOOTH)
  LibGL.matrix_mode(LibGL::PROJECTION)
  LibGL.blend_func(LibGL::SRC_ALPHA, LibGL::ONE_MINUS_SRC_ALPHA)
  #LibGL.blend_func(LibGL::ONE, LibGL::ONE)
  LibGL.load_identity
  LibGLU.perspective(45.0, Nya.width/Nya.height, 0.1, 100.0)

  LibGL.matrix_mode(LibGL::MODELVIEW)
  Nya::SceneManager.load_from_file("res/testscene2.xml")

  phys_cb = ->(o1 : LibODE::Geomid, o2 : LibODE::Geomid) do
    dptr1, dptr2 = LibODE.geom_get_data(o1), LibODE.geom_get_data(o2)
    Nya::Event.send :physics_near_cb, Nya::Physics::NearEvent.new(
      Box(Nya::Physics::Geom).unbox(dptr1),
      Box(Nya::Physics::Geom).unbox(dptr2)
    )
  end

  while true

    LibODE.space_collide(
      Nya::SceneManager.current_scene.space_id,
      Box(PhysCallback).box(phys_cb),
      ->(ptr : Void*, o1 : LibODE::Geomid, o2 : LibODE::Geomid) do
        Box(PhysCallback).unbox(ptr).call(o1,o2)
      end
    )

    Nya::Event.send(:update, Nya::Event.new)
    update_loop
    while LibSDL2.poll_event(out evt) != 0
      case evt.type
      when LibSDL2::EventType::KEYUP
        Nya::Event.send :key_up, Nya::Input::KeyboardEvent.new(evt.key)
      when LibSDL2::EventType::KEYDOWN
        Nya::Event.send :key_down, Nya::Input::KeyboardEvent.new(evt.key)
      when LibSDL2::EventType::QUIT
        evt = Nya::Event.new
        Nya::Event.send :quit, evt
        exit 0 unless evt.status.dead?
      when LibSDL2::EventType::MOUSEMOTION
        Nya::Event.send :mouse_motion, Nya::Input::MouseMotionEvent.new(evt.motion)
      when LibSDL2::EventType::MOUSEWHEEL
        Nya::Event.send :mouse_wheel, Nya::Input::MouseWheelEvent.new(evt.wheel)
      when LibSDL2::EventType::MOUSEBUTTONUP
        Nya::Event.send :mouse_button_up, Nya::Input::MouseButtonEvent.new(evt.button)
      when LibSDL2::EventType::MOUSEBUTTONDOWN
        Nya::Event.send :mouse_button_down, Nya::Input::MouseButtonEvent.new(evt.button)
      end
    end

    render_loop
    LibGL.flush
    LibSDL2.gl_swap_window(Nya.window)
  end
ensure
  LibSDL2.quit
end
