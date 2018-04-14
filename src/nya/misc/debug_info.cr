module Nya
  module Misc
    # Simple component that writes some debug info on screen
    class DebugInfo < Component
      attribute debug : Bool
      property debug = false
      @text : Nya::Render::Text2D? = nil
      @last_utime = 0.0
      def awake
        @text = parent.find_component_of?(Nya::Render::Text2D)

        if @text.nil?
          Nya.log.warn "Cannot load Text2D for debugging", "DebugInfo"
        end
      end

      def update
        @last_utime = Nya::Time.delta_time
      end

      def render(t)
        return if @text.nil? || !matches_tag? t || !enabled?
        @text.not_nil!.text = "dT : #{@last_utime.round(3)}\ndTr : #{Nya::Time.render_delta.round(3)}\nUPS: #{@last_utime == 0 ? "NaN" : (1/@last_utime).to_i}\n#{parent.position.to_s}\n#{parent.rotation.to_s}"
      end
    end
  end
end
