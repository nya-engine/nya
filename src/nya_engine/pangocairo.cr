require "../pangocairo"
require "../gl"
require "crystaledge"

module Nya
  class Pango

    property texture_id : UInt32
    property size : CrystalEdge::Vector2

    def initialize(@texture_id, @size)
    end

    def self.get_text_size(layout : PangoCairo::PangoLayout*)
      PangoCairo.layout_get_size(layout, out w, out h)
      return (CrystalEdge::Vector2.new(w.to_f64,h.to_f64)) / (PangoCairo::SCALE.to_f64)
    end

    def self.render_text(text : String, font : String, channels = 4u8)
      # Create a context
      temp_surface = PangoCairo.create_surf(PangoCairo::CairoFormat::ARGB32,0,0)
      context = PangoCairo.create(temp_surface)
      PangoCairo.destroy_surface(temp_surface)

      layout = PangoCairo.create_layout(context)

      PangoCairo.layout_set_text(layout,text,-1)


      desc = PangoCairo.font_desc_from_string(font)
      PangoCairo.layout_set_font_desc(layout,desc)
      PangoCairo.free_font_desc(desc)


      tsize = get_text_size(layout)
      buffer = Array(UInt32).build((tsize.x*tsize.y*channels).to_i){0}


      rendering_context = PangoCairo.create(PangoCairo.create_surf_for_data(
        buffer,
        PangoCairo::CairoFormat::ARGB32,
        tsize.x,
        tsize.y,
        channels*tsize.x
      ))


      PangoCairo.set_source_rgba(rendering_context,1,1,1,1)

      PangoCairo.show_layout(rendering_context,layout)

      texture_id = 0u32
      GL.gen_textures 1, pointerof(texture_id)
      GL.bind_texture(GL::TEXTURE_2D,texture_id)

      GL.tex_parameteri(GL::TEXTURE_2D,GL::TEXTURE_MIN_FILTER,GL::LINEAR)
      GL.tex_parameteri(GL::TEXTURE_2D,GL::TEXTURE_MAG_FILTER,GL::LINEAR)

      GL.tex_image2d(
        GL::TEXTURE_2D,
        0,
        GL::RGBA,
        tsize.x,
        tsize.y,
        0,
        GL::BGRA,
        GL::UNSIGNED_BYTE,
        buffer
      )


      PangoCairo.destroy(context)
      PangoCairo.destroy(rendering_context)

      puts __FILE__ + __LINE__.to_s

      new(texture_id, tsize)
    end
  end
end
