module Nya
  module Misc
    # Simple component that writes some debug info on screen
    class DebugInfo < Component
      attribute debug, as: Bool, nilable: false
      property debug = false
      @text : Nya::Render::Text2D? = nil
      @last_utime = 0.0
      def awake
        @text = parent.find_component_of?(Nya::Render::Text2D)

        if @text.nil?
          Nya.log.warn "Cannot load Text2D for debugging", "DebugInfo"
        end

        Event.subscribe_typed :key_down, as: Input::KeyboardEvent do |e|
          if e.not_nil!.keycode.r?
            Nya.log.debug "Flushing shader cache...", "DebugMode"
            Nya::Render::ShaderCompiler.flush_cache!
            shaders = Nya::SceneManager.current_scene.find_components_of(Nya::Render::ShaderProgram)
            Nya.log.debug "Reloading #{shaders.size} shader(s)...", "DebugMode"
            shaders.each &.awake
            Nya.log.debug "Done!", "DebugMode"
          end
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
