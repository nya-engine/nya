module Nya::Render
  class ShaderSet < Nya::Object
    property format = "glsl"
    property files = [] of String

    attribute format : String
    serializable files : Array(String)
  end
end
