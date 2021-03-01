require "./metadata"

module Nya::Render::Backends::GL
    class LocationMetadata < Backend::Metadata
        property location : LibGL::GLint
        
        def initialize(@location)
        end

        def object_type
            :shader_var_location
        end
    end
end