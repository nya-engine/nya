@[Link(ldflags: "-lpangocairo-1.0 -lpango-1.0 -lcairo -lgobject-2.0 -lglib-2.0")]
lib PangoCairo
  type Cairo = Void
  type CairoSurface = Void

  SCALE = 1024

  enum CairoFormat
    ARGB32
    RGB24
    A8
    A1
    RGB16_565
  end

  type PangoFontDescription = Void
  type PangoLayout = Void

  fun create_surf_for_data = "cairo_image_surface_create_for_data"(buf : UInt32*, format : CairoFormat, width : Int32, height : Int32, stride : Int32) : CairoSurface*
  fun create = "cairo_create"(surface : CairoSurface*) : Cairo*
  fun create_surf = "cairo_image_surface_create"(format : CairoFormat, w : Int32, h : Int32) : CairoSurface*
  fun create_layout = "pango_cairo_create_layout"(ctx : Cairo*) : PangoLayout*

  fun destroy_surface = "cairo_surface_destroy"(c : CairoSurface*) : Void
  fun destroy = "cairo_destroy"(c : Cairo*) : Void

  fun layout_set_text = "pango_layout_set_text"(layout : PangoLayout*, text : UInt8*, length : Int32)
  fun font_desc_from_string = "pango_font_description_from_string"(font : UInt8*) : PangoFontDescription*

  fun layout_set_font_desc = "pango_layout_set_font_description"(layout : PangoLayout*, desc : PangoFontDescription*) : Void
  fun free_font_desc = "pango_font_description_free"(font : PangoFontDescription*) : Void
  fun layout_get_size = "pango_layout_get_size"(layout : PangoLayout*, width : UInt32*, height : UInt32*) : Void

  fun set_source_rgba = "cairo_set_source_rgba"(ctx : Cairo*, r : Float64,g : Float64,b : Float64,a : Float64) : Void

  fun show_layout = "pango_cairo_show_layout"(ctx : Cairo*, layout : PangoLayout*) : Void
end
