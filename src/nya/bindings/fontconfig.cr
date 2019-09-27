{% begin %}
  @[Link(ldflags: {{ `pkgconf --libs fontconfig`.stringify }} )]
{% end %}
lib LibFontConfig
    type FcBool = LibC::Int

    type Config = Void

    fun config_get_current = "FcConfigGetCurrent"() : Config*
    fun config_app_add_font_file = "FcConfigAppFontAddFile"(conf : Config*, file : UInt8*) : FcBool
end
