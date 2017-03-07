require "../bindings/gl"

module Nya::Render
  enum ShaderType
    Vertex = LibGL::VERTEX_SHADER
    Fragment = LibGL::FRAGMENT_SHADER
    Geometry = LibGL::GEOMETRY_SHADER
    TessEvaluation = LibGL::TESS_EVALUATION_SHADER
    TessControl = LibGL::TESS_CONTROL_SHADER
  end
end
