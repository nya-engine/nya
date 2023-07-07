require "../bindings/fontconfig"

module Nya::Render
  class Font < Component
    property src = ""
    attribute src : String

    property awaken = false

    def awake
      return if @awaken

      config = LibFontConfig.config_get_current
      result = LibFontConfig.config_app_add_font_file(config, @src)

      Nya.log.error{ "Cannot load #{@src}"} if result == 0

      @awaken = true
    end
  end
end
