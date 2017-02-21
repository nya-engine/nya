require "../../gl"

module Nya::Render
  enum ShaderType
    Vertex = GL::VERTEX_SHADER
    Fragment = GL::FRAGMENT_SHADER
    Geometry = GL::GEOMETRY_SHADER
    TessEvaluation = GL::TESS_EVALUATION_SHADER
    TessControl = GL::TESS_CONTROL_SHADER
  end
end
