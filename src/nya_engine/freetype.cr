require "../ft"
require "../gl"
require "./glmatrix"
require "crystaledge"

module Nya
  class FTException < Exception
    property ecode,reason
    @ecode : Int16
    @reason : String
    def initialize(@ecode,@reason = "Freetype error")
      super @reason
    end

    def to_s
      "#{@reason} [CODE : #{@ecode}]"
    end
  end

  class Font
    @size : UInt16
    @chars : Hash(Char,Tuple(UInt32,CrystalEdge::Vector2))
    def initialize(@size,@chars)

    end

    protected def draw_char(position : CrystalEdge::Vector2,ch : Char)
      puts __FILE__ + __LINE__.to_s
      GL.bind_texture GL::TEXTURE_2D, @chars[ch][0]
      size = @chars[ch][1]
      GL.begin_ GL::QUADS
      GL.tex_coord2d(0.0,0.0);
      GL.vertex3d(position.x,position.y,0)
      GL.tex_coord2d(1.0,0.0);
      GL.vertex3d(position.x+size.x,position.y,0)
      GL.tex_coord2d(1.0,1.0);
      GL.vertex3d(position.x+size.x,position.y+size.y,0)
      GL.tex_coord2d(0.0,1.0);
      GL.vertex3d(position.x,position.y+size.y,0)
      GL.end_
      return size
    end

    def draw_string(position : CrystalEdge::Vector2, str : String)
      puts __FILE__ + __LINE__.to_s
      x = position.x
      y = position.y
      GL.enable(GL::TEXTURE_2D)
      ls = CrystalEdge::Vector2.zero
      str.each_char do |char|
        if char == '\b'
          x -= ls.x
          y -= ls.y
        else
          ls = draw_char(CrystalEdge::Vector2.new(x,y),char)
          y += ls.y if char == '\n'
        end
      end
    end
  end

  class Freetype
    @ftlib : FT::LibraryRec
    @fontname : String
    @fontface : FT::FaceRec
    def initialize(@fontname)
      puts __FILE__ + __LINE__.to_s
      @ftlib = uninitialized FT::LibraryRec
      @fontface = uninitialized FT::FaceRec
      puts __FILE__ + __LINE__.to_s
      if (e = FT.init_free_type(pointerof(@ftlib) as Void*)) != 0
        raise FTException.new(e,"Failed to load Freetype library")
      end

      puts __FILE__ + __LINE__.to_s
      puts pointerof(@ftlib).to_s
      puts pointerof(@fontface).to_s
      puts @fontname.to_unsafe.to_s
      if (e = FT.new_face(pointerof(@ftlib),@fontname,0,pointerof(@fontface).as(Void*))) != 0
        raise FTException.new(e,"Failed to load face #{@fontname}")
      end

      puts __FILE__ + __LINE__.to_s
    end

    def gen_texture(ch : Char,size : UInt16)
      FT.set_pixel_sizes(pointerof(@fontface),0,size)
      FT.load_char(pointerof(@fontface),ch.ord.to_i64,FT::LOAD_RENDER)
      texture = 0u32
      GL.gen_textures(1,pointerof(texture) as Void*)
      GL.bind_texture(texture,GL::TEXTURE_2D)
      GL.tex_image2d(
        GL::TEXTURE_2D,
        0,
        GL::RED,
        @fontface.glyph.value.bitmap.width,
        @fontface.glyph.value.bitmap.rows,
        0,
        GL::RED,
        GL::UNSIGNED_BYTE,
        @fontface.glyph.value.bitmap.buffer as Void*
      )
      GL.tex_parameteri(GL::TEXTURE_2D,GL::TEXTURE_WRAP_S,GL::CLAMP_TO_EDGE)
      GL.tex_parameteri(GL::TEXTURE_2D,GL::TEXTURE_WRAP_T,GL::CLAMP_TO_EDGE)
      GL.tex_parameteri(GL::TEXTURE_2D,GL::TEXTURE_MIN_FILTER,GL::LINEAR)
      GL.tex_parameteri(GL::TEXTURE_2D,GL::TEXTURE_MAG_FILTER,GL::LINEAR)
      return {texture,CrystalEdge::Vector2.new(@fontface.glyph.value.bitmap.width.to_f,@fontface.glyph.value.bitmap.rows.to_f)}
    end

    def gen_font(symbols : Array(Char),size : UInt16)
      h = Hash(Char,Tuple(UInt32,CrystalEdge::Vector2)).new
      symbols.each do |s|
        h[s] = gen_texture(s,size)
      end
      Font.new(size,h)
    end
  end


end
