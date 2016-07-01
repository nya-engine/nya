require "../gl"
require "../glu"

module Nya
  class DrawUtils
    def self.draw(mode = GL::QUADS,&block : -> Void)
      GL.begin_(mode)
      block.call
      GL.end_
    end

    def self.draw_texture(x,y,w,h : Float64, t : UInt32, c : Tuple(Float64,Float64,Float64))
      GL.matrix_mode(GL::MODELVIEW)
      GL.push_matrix
      GL.load_identity
      GL.translatef(0.0,0.0,-10.0)
      GL.bind_texture(GL::TEXTURE_2D,t)
      GL.color3d(c[0],c[1],c[2])
      draw do
        GL.tex_coord3d(0.0,0.0,0.0)
        GL.vertex3d(x,y,0.0)
        GL.tex_coord3d(1.0,0.0,0.0)
        GL.vertex3d(x+w,y,0.0)
        GL.tex_coord3d(1.0,1.0,0.0)
        GL.vertex3d(x+w,y+h,0.0)
        GL.tex_coord3d(0.0,1.0,0.0)
        GL.vertex3d(x,y+h,0.0)
      end
      GL.pop_matrix
    end
  end
end
