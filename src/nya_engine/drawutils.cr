require "../gl"
require "../glu"

module Nya
  class DrawUtils
    def self.draw(mode = GL::QUADS,&block : -> Void)
      GL.begin_(mode)
      block.call
      GL.end_
    end

    def self.draw_texture(x,y,w,h : Float64, t : UInt32, c : Tuple(Float64,Float64,Float64), z : Float64)
      GL.matrix_mode(GL::MODELVIEW)
      GL.load_identity
      GL.clear(GL::COLOR_BUFFER_BIT)
      GL.push_matrix
      #GL.ortho(x,y,w,h,-z,z*2)
      GL.translatef(0.0,0.0,z)
      GL.bind_texture(GL::TEXTURE_2D,t)
      GL.color3d(c[0],c[1],c[2])

      draw(GL::POLYGON) do
        GL.tex_coord2d(0.0,0.0)
        GL.vertex2d(x,y+h)
        GL.tex_coord2d(1.0,0.0)
        GL.vertex2d(x+w,y+h)
        GL.tex_coord2d(1.0,1.0)
        GL.vertex2d(x+w,y)
        GL.tex_coord2d(0.0,1.0)
        GL.vertex2d(x,y)
      end
      GL.pop_matrix
    end

    def self.draw_texture(x,y,w,h : Float64, t : UInt32, c : Tuple(Float64, Float64, Float64))
      mm = uninitialized Float64[16]
      pm = uninitialized Float64[16]
      vp = uninitialized Int32[4]
      GL.get_doublev(GL::MODELVIEW_MATRIX, pointerof(mm).as(Pointer(Void)))
      GL.get_doublev(GL::PROJECTION_MATRIX, pointerof(pm).as(Pointer(Void)))
      GL.get_integerv(GL::VIEWPORT, pointerof(vp).as(Pointer(Void)))

      GLU.un_project(
        x,
        y,
        -5.0,
        pointerof(mm).as(Pointer(Void)),
        pointerof(pm).as(Pointer(Void)),
        pointerof(vp).as(Pointer(Void)),
        out ox, out oy, out oz
      )

      draw_texture ox, oy, w, h, t, c, oz
    end
  end
end
