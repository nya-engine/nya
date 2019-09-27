module Nya
  class Plugin

    class_property plugins = [] of self

    def name
      "<unknown>"
    end

    def version
      "0.0.0"
    end

    def engine_pre_init(e : Engine)
    end

    def engine_post_init(e : Engine)
    end

    def engine_update(e : Engine)
    end

    macro inherited
      %plugin = {{@type}}.new

      ::Nya::Event.subscribe_typed(:engine_pre_init, as: ::Nya::EngineEvent) do |%e|
        %plugin.engine_pre_init %e.engine
      end

      ::Nya::Event.subscribe_typed(:engine_post_init, as: ::Nya::EngineEvent) do |%e|
        %plugin.engine_post_init %e.engine
      end

      ::Nya::Event.subscribe_typed(:update, as: ::Nya::EngineEvent) do |%e|
        %plugin.engine_update %e.engine
      end

      ::Nya.log.info "Registered plugin #{%plugin.name} #{%plugin.version}", "Plugin"
    end
  end
end
