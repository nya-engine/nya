require "./bindings/gl"
require "./bindings/glu"

module Nya
  class DrawUtils
    def self.draw(mode = LibGL::QUADS, &block : -> Void)
      LibGL.begin_(mode)
      block.call
      LibGL.end_
    end

    def self.un_project(v : CrystalEdge::Vector3) : CrystalEdge::Vector3
      mm = uninitialized Float64[16]
      pm = uninitialized Float64[16]
      vp = uninitialized Int32[4]
      LibGL.get_doublev(LibGL::MODELVIEW_MATRIX, pointerof(mm).as(Pointer(Void)))
      LibGL.get_doublev(LibGL::PROJECTION_MATRIX, pointerof(pm).as(Pointer(Void)))
      LibGL.get_integerv(LibGL::VIEWPORT, pointerof(vp).as(Pointer(Void)))

      ox = uninitialized Float64
      oy = uninitialized Float64
      oz = uninitialized Float64

      LibGLU.un_project(
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
      vec = CrystalEdge::Vector3.new(ox, oy, oz)
      vec /= -vec.z
      # puts vec.to_s
      vec
    end

    def self.draw_texture(x, y, w, h : Float64, t : UInt32, c : Tuple(Float64, Float64, Float64))
      va = un_project(CrystalEdge::Vector3.new(x, y, -20.0))
      vb = un_project(CrystalEdge::Vector3.new(x + w, y + h, -20.0))
      LibGL.push_matrix
      LibGL.translatef(0.0, 0.0, va.z)
      LibGL.enable(LibGL::TEXTURE_2D)
      LibGL.bind_texture(LibGL::TEXTURE_2D, t)
      LibGL.color3d(*c)

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
    end
  end
end
