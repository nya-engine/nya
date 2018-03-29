require "../bindings/gl"
require "../bindings/glu"

module Nya::Render
  # Low level drawing utilities
  class DrawUtils
    # Calls `block` wrapped in glBegin and glEnd
    def self.draw(mode = LibGL::QUADS, &block : -> Void)
      LibGL.begin(mode)
      block.call
      LibGL._end
    end


    def self.get_matrix(mat, type : U.class) : U forall U
      matrix = uninitialized U
      {% if U.type_vars.first <= Int %}
        LibGL.get_integerv(mat, matrix)
      {% else %}
        LibGL.get_doublev(mat, matrix)
      {% end %}
      matrix
    end

    def self.get_modelview_matrix
      get_matrix LibGL::MODELVIEW_MATRIX, StaticArray(Float64, 16)
    end

    def self.get_projection_matrix
      get_matrix LibGL::PROJECTION_MATRIX, StaticArray(Float64, 16)
    end

    def self.get_viewport
      get_matrix LibGL::VIEWPORT, StaticArray(Int32, 4)
    end

    # Unprojects screen point to world coordinates
    def self.un_project(v : CrystalEdge::Vector2) : CrystalEdge::Vector3
      mm = get_modelview_matrix
      pm = get_projection_matrix
      vp = get_viewport
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

    private def self.v2(x, y)
      CrystalEdge::Vector2.new(x, y)
    end

    # Draws OpenGL texture `t` on screen coordinates `x` and `y` with width `w` and height `h`
    def self.draw_texture(x, y, w, h : Float64, t : UInt32)
      LibGL.push_matrix
      va = un_project(CrystalEdge::Vector2.new(x, y))
      vb = un_project(CrystalEdge::Vector2.new(x + w, y + h))
      pts = [v2(x,y + h), v2(x + w, y + h), v2(x + w, y), v2(x, y)].map{ |x| un_project x }
      #LibGL.translatef(0.0, 0.0, va.z)
      LibGL.enable(LibGL::TEXTURE_2D)
      LibGL.enable(LibGL::ALPHA_TEST)
      LibGL.bind_texture(LibGL::TEXTURE_2D, t)
      draw do
        LibGL.tex_coord2d(0.0, 0.0)
        LibGL.vertex3d(*pts[0].to_gl)
        LibGL.tex_coord2d(1.0, 0.0)
        LibGL.vertex3d(*pts[1].to_gl)
        LibGL.tex_coord2d(1.0, 1.0)
        LibGL.vertex3d(*pts[2].to_gl)
        LibGL.tex_coord2d(0.0, 1.0)
        LibGL.vertex3d(*pts[3].to_gl)
      end
      LibGL.pop_matrix
      LibGL.disable(LibGL::TEXTURE_2D)
      LibGL.disable(LibGL::ALPHA_TEST)
    end

    # :nodoc:
    def self.log_pts(x,y,w,h)
      va = un_project(CrystalEdge::Vector2.new(x, y))
      vb = un_project(CrystalEdge::Vector2.new(x + w, y + h))
      Nya.log.debug va.to_s
      Nya.log.debug vb.to_s
    end

    def self.load_texture(path, type)
      canvas = StumpyLoader.load(path)
      tex = 0u32
      LibGL.gen_textures 1, pointerof(tex)
      LibGL.bind_texture type, tex
      LibGL.tex_image2d(
        type,
        0,
        LibGL::RGBA,
        canvas.width,
        canvas.height,
        0,
        LibGL::RGBA,
        LibGL::UNSIGNED_BYTE,
        canvas.to_gl
      )
      LibGL.tex_parameteri(type, LibGL::TEXTURE_MIN_FILTER, LibGL::LINEAR)
      LibGL.tex_parameteri(type, LibGL::TEXTURE_MAG_FILTER, LibGL::LINEAR_MIPMAP_LINEAR)
      #LibGL.generate_mipmap type
      tex
    end
  end
end
