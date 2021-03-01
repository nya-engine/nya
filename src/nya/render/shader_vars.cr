require "./texture"

module Nya
    module Render
        class ShaderVar
            include Nya::Serializable

            property name = ""
            attribute name : String

            property metadata : Backend::Metadata? = nil
        end

        class Sampler < ShaderVar
            property texture = Texture.new
            serializable texture : Texture
        end
    end
end