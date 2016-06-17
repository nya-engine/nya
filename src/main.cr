require "./sdl2"
require "./gl"
require "./glu"
require "crystaledge"

width = 640
height = 480

WP_CENTERED = 0x2FFF0000

class Plane
  @vert : Array(Tuple(Float64,Float64,Float64))
  @color : Tuple(Float64,Float64,Float64)
  def initialize(@vert,@color)

  end

  def draw(ox : Float64 = 0.0, oy : Float64 = 0.0, oz : Float64 = 0.0)
    GL.color3f(@color[0],@color[1],@color[2])
    @vert.each do |v|
      GL.vertex3f(v[0],v[1],v[2])
    end
  end
end

def draw(mode : UInt16=GL::QUADS,&block : -> Void)
  GL.begin_(mode)
  block.call
  GL.end_
end

class Transform
  property position,rotation
  @position : CrystalEdge::Vector3
  @rotation : CrystalEdge::Vector3
  def initialize(@position,@rotation)

  end
end

def at(t : Transform = Transform.new(CrystalEdge::Vector3.zero,CrystalEdge::Vector3.zero),&block)
  GL.translatef(t.position.x,t.position.y,t.position.z)
  #puts "P #{t.position.to_s} R #{t.rotation.to_s}"
  #puts t.position.z
  GL.rotatef(t.rotation.x,1.0,0.0,0.0)
  GL.rotatef(t.rotation.y,0.0,1.0,0.0)
  GL.rotatef(t.rotation.z,0.0,0.0,1.0)
  block.call
end

def at(p : CrystalEdge::Vector3,r : CrystalEdge::Vector3,&b)
  at(Transform.new(p,r),&b)
end

def draw_cube(x,y,z)
  GL.clear(GL::COLOR_BUFFER_BIT|GL::DEPTH_BUFFER_BIT)
  GL.load_identity

  at(CrystalEdge::Vector3.new(0.0,0.0,-7.0),CrystalEdge::Vector3.new(x,y,z)) do

    draw do
      #puts "Drawing..."
      planes = [
        Plane.new(
          [
            {1.0,1.0,-1.0},
            {-1.0,1.0,-1.0},
            {-1.0,1.0,1.0},
            {1.0,1.0,1.0}
          ],
          {0.0,1.0,0.0}
        ),
        Plane.new(
          [
            {1.0,-1.0,1.0},
            {-1.0,-1.0,1.0},
            {-1.0,-1.0,-1.0},
            {1.0,-1.0,-1.0}
          ],
          {1.0,0.5,0.0}
        )
      ]

      planes.each{|p|p.draw}

    end
  end
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

  while running
    i+=1
    i%=128
    SDL2.poll_event(out evt)
    puts evt.type if i == 0
    raise "Terminated" if evt.type.to_s == "256" #Terminate program when window is closed
    x -= 0.5
    y -= 0.5
    z -= 0.5

    draw_cube x,y,z
    GL.flush
    SDL2.gl_swap_window(window)
  end

ensure
  SDL2.quit
end
