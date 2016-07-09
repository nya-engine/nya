require "../gl"
require "../glu"

module Nya
  class DrawUtils
    def self.draw(mode = GL::QUADS,&block : -> Void)
      GL.begin_(mode)
      block.call
      GL.end_
    end

    def self.draw_texture(x,y,w,h : Float64, t : UInt32, c : Tuple(Float64,Float64,Float64), z : Float64 = -10.0)
      GL.matrix_mode(GL::MODELVIEW)
      GL.load_identity
      GL.clear(GL::COLOR_BUFFER_BIT)
      GL.push_matrix

      GL.translatef(0.0,0.0,z)
      GL.bind_texture(GL::TEXTURE_2D,t)
      GL.color3d(c[0],c[1],c[2])
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
  end
end
