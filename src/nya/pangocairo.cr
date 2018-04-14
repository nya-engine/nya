require "./bindings/pangocairo"
require "./bindings/gl"
require "crystaledge"

module Nya
  # :nodoc:
  class Pango
    property buffer : Bytes
    property size : CrystalEdge::Vector2

    def initialize(@buffer, @size)
    end

    def self.get_text_size(layout : LibPangoCairo::PangoLayout*)
      LibPangoCairo.layout_get_size(layout, out w, out h)
      return (CrystalEdge::Vector2.new(w.to_f64, h.to_f64)) / (LibPangoCairo::SCALE.to_f64)
    end

    @[AlwaysInline]
    def self.render_text(txt, fnt, fg : Nya::Color, bg : Nya::Color = Nya::Color.new(0u8,0u8,0u8,0u8))
      render_text txt, fnt, fg.to_gl4, bg.to_gl4
    end

    def self.render_text(text : String, font : String, color : RawRGBA = {1.0, 1.0, 1.0, 1.0}, bg : RawRGBA = {0.0, 0.0, 0.0, 0.0})
      # Create a context
      temp_surface = LibPangoCairo.create_surf(LibPangoCairo::CairoFormat::ARGB32, 0, 0)
      context = LibPangoCairo.create(temp_surface)
      LibPangoCairo.destroy_surface(temp_surface)

      layout = LibPangoCairo.create_layout(context)

      LibPangoCairo.layout_set_text(layout, text, -1)

      desc = LibPangoCairo.font_desc_from_string(font)
      LibPangoCairo.layout_set_font_desc(layout, desc)
      LibPangoCairo.free_font_desc(desc)

      tsize = get_text_size(layout)
      buffer = Slice(UInt8).new (tsize.x*tsize.y*4).to_i32, 0u8

      rendering_context = LibPangoCairo.create(LibPangoCairo.create_surf_for_data(
        buffer,
        LibPangoCairo::CairoFormat::ARGB32,
        tsize.x,
        tsize.y,
        4*tsize.x
      ))

      LibPangoCairo.set_source_rgba(rendering_context, *bg)
      LibPangoCairo.paint rendering_context
      LibPangoCairo.set_source_rgba(rendering_context, *color)

      LibPangoCairo.show_layout(rendering_context, layout)

      LibPangoCairo.destroy(context)
      LibPangoCairo.destroy(rendering_context)

      new(buffer, tsize)
    end
  end
end
