require "./shader_type"
require "../storage"

module Nya::Render
  class Shader
    @shader = 0u32
    property shader

    def shader_type
      raise "#{@shader} is not a shader!" unless LibGL.is_shader? @shader

      LibGL.get_shaderiv(@shader, LibGL::SHADER_TYPE, out stp)

      sh_type = ShaderType.from_value? stp
      if sh_type.nil?
        raise "Unknown type #{stp} for shader #{@shader}"
      end

      sh_type.not_nil!
    end

    def initialize(@shader)
    end

    def initialize(filename : String)
      @shader = ShaderCompiler.compile(filename)
    end
  end
end
