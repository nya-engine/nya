require "./bindings/gl"
require "./bindings/glu"

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
      GL.color3d(*c)

      draw do
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

    def self.un_project(v : CrystalEdge::Vector3) : CrystalEdge::Vector3
      mm = uninitialized Float64[16]
      pm = uninitialized Float64[16]
      vp = uninitialized Int32[4]
      GL.get_doublev(GL::MODELVIEW_MATRIX, pointerof(mm).as(Pointer(Void)))
      GL.get_doublev(GL::PROJECTION_MATRIX, pointerof(pm).as(Pointer(Void)))
      GL.get_integerv(GL::VIEWPORT, pointerof(vp).as(Pointer(Void)))

      ox = uninitialized Float64
      oy = uninitialized Float64
      oz = uninitialized Float64

      GLU.un_project(
        v.x,
        v.y,
        v.z,
        pointerof(mm).as(Pointer(Void)),
        pointerof(pm).as(Pointer(Void)),
        pointerof(vp).as(Pointer(Void)),
        pointerof(ox).as(Pointer(Void)),
        pointerof(oy).as(Pointer(Void)),
        pointerof(oz).as(Pointer(Void))
      )
      vec = CrystalEdge::Vector3.new(ox,oy,oz)
      vec /= -vec.z
      #puts vec.to_s
      vec
    end

    def self.draw_texture(x,y,w,h : Float64, t : UInt32, c : Tuple(Float64, Float64, Float64))
      GL.matrix_mode(GL::MODELVIEW)
      GL.load_identity

      GL.clear(GL::COLOR_BUFFER_BIT)
      #GL.push_matrix
      #
      va = un_project(CrystalEdge::Vector3.new(x,y,-20.0))
      vb = un_project(CrystalEdge::Vector3.new(x + w, y + h, -20.0))
      GL.translatef(0.0,0.0,va.z)
      GL.bind_texture(GL::TEXTURE_2D,t)
      GL.color3d(*c)

      draw do
        GL.tex_coord2d(0.0,0.0)
        GL.vertex2d(va.x,vb.y)
        GL.tex_coord2d(1.0,0.0)
        GL.vertex2d(vb.x, vb.y)
        GL.tex_coord2d(1.0,1.0)
        GL.vertex2d(vb.x, va.y)
        GL.tex_coord2d(0.0,1.0)
        GL.vertex2d(va.x, va.y)
      end
      GL.pop_matrix
    end
  end
end
