require "../bindings/gl"
require "../bindings/glu"

module Nya::Render
  class DrawUtils
    def self.draw(mode = LibGL::QUADS, &block : -> Void)
      LibGL.begin_(mode)
      block.call
      LibGL.end_
    end

    def self.un_project(v : CrystalEdge::Vector2) : CrystalEdge::Vector3
      mm = uninitialized Float64[16]
      pm = uninitialized Float64[16]
      vp = uninitialized Int32[4]
      LibGL.get_doublev(LibGL::MODELVIEW_MATRIX, mm)
      LibGL.get_doublev(LibGL::PROJECTION_MATRIX, pm)
      LibGL.get_integerv(LibGL::VIEWPORT, vp)


      z = 0.1f32
      ox = uninitialized Float64
      oy = uninitialized Float64
      oz = uninitialized Float64

      LibGLU.un_project(
        v.x,
        v.y,
        z,
        mm,
        pm,
        vp,
        pointerof(ox).as(Pointer(Void)),
        pointerof(oy).as(Pointer(Void)),
        pointerof(oz).as(Pointer(Void))
      )
      CrystalEdge::Vector3.new(ox, oy, oz)
    end

    def self.draw_texture(x, y, w, h : Float64, t : UInt32)
      LibGL.push_matrix
      va = un_project(CrystalEdge::Vector2.new(x, y))
      vb = un_project(CrystalEdge::Vector2.new(x + w, y + h))
      LibGL.translatef(0.0, 0.0, va.z)
      LibGL.enable(LibGL::TEXTURE_2D)
      LibGL.enable(LibGL::ALPHA_TEST)
      LibGL.bind_texture(LibGL::TEXTURE_2D, t)
      draw do
        LibGL.tex_coord2d(0.0, 0.0)
        LibGL.vertex2d(va.x, vb.y)
        LibGL.tex_coord2d(1.0, 0.0)
        LibGL.vertex2d(vb.x, vb.y)
        LibGL.tex_coord2d(1.0, 1.0)
        LibGL.vertex2d(vb.x, va.y)
        LibGL.tex_coord2d(0.0, 1.0)
        LibGL.vertex2d(va.x, va.y)
      end
      LibGL.pop_matrix
      LibGL.disable(LibGL::TEXTURE_2D)
      LibGL.disable(LibGL::ALPHA_TEST)
    end

    def self.log_pts(x,y,w,h)
      va = un_project(CrystalEdge::Vector2.new(x, y))
      vb = un_project(CrystalEdge::Vector2.new(x + w, y + h))
      Nya.log.debug va.to_s
      Nya.log.debug vb.to_s
    end
  end
end
