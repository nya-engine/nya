module Nya
  module Misc
    class DebugInfo < Component
      attribute debug, as: Bool, nilable: false
      property debug = false
      @text : Nya::Render::Text2D? = nil
      @last_utime = 0.0
      def awake
        @text = parent.find_components_by_type_name(Nya::Render::Text2D).first?

        if @text.nil?
          Nya.log.warn "Cannot load Text2D for debugging", "DebugInfo"
        end
      end

      def update
        @last_utime = Nya::Time.delta_time
      end

      def render(t)
        return if @text.nil?
        @text.not_nil!.text = "dT : #{@last_utime}\n dTr : #{Nya::Time.render_delta}\n UPS: #{@last_utime == 0 ? "NaN" : 1/@last_utime}"
      end
    end
  end
end
