require "../ft"
require "../gl"

module Nya
  class FTException < RuntimeError
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
    @chars : Hash(Char,UInt16)
    def initialize(@size,@chars)

    end
  end

  class Freetype
    @ftlib = uninitialized Void
    @fontname : String
    @fontface = uninitialized FT::FaceRec
    def initialize(@fontname)
      if (e = FT.init_free_type(pointerof(@ftlib))) != 0
        raise FTException.new(e,"Failed to load Freetype library")
      end

      if (e = FT.new_face(pointerof(@ftlib),pointerof(@fontname).as(UInt8*),0,pointerof(@fontface).as(Void*))) != 0
        raise FTException.new(e,"Failed to load face #{@fontname}")
      end
    end

    def gen_texture(ch : Char,size : UInt16)
      FT.set_pixel_sizes(pointerof(@fontface),0,size)
      FT.load_char(pointerof(@fontface),ch,FT::LOAD_RENDER)
      texture : UInt16
      GL::gen_textures(pointerof(texture).as(Void*))
      GL::bind_texture(texture,GL::TEXTURE_2D)
      GL::tex_image2d(
        GL::TEXTURE_2D,
        0,
        GL::RED,
        @fontface.glyph.bitmap.width,
        @fontface.glyph.bitmap.rows,
        GL::RED,
        GL::UNSIGNED_BYTE,
        @fontface.glyph.bitmap.buffer
      )
      GL::tex_parameteri(GL::TEXTURE_2D,GL::TEXTURE_WRAP_S,GL::CLAMP_TO_EDGE)
      GL::tex_parameteri(GL::TEXTURE_2D,GL::TEXTURE_WRAP_T,GL::CLAMP_TO_EDGE)
      GL::tex_parameteri(GL::TEXTURE_2D,GL::TEXTURE_MIN_FILTER,GL::LINEAR)
      GL::tex_parameteri(GL::TEXTURE_2D,GL::TEXTURE_MAG_FILTER,GL::LINEAR)
      return texture
    end
  end
end
