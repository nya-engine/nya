require "../object"
require "./shader_vars"

module Nya::Render
  class ShaderProgram < Nya::Component
    @shaders = [] of Shader
    @filenames = [] of String
    @program = 0u32
    @properties = Hash(String, Nya::Render::ShaderVars::Var).new

    property shaders, filenames, program, properties
    serializable_array filenames, of: String
    serializable_hash properties, of: Nya::Render::ShaderVars::Var

    def awake
      @program = ShaderCompiler.link(
        @filenames.map { |fn| ShaderCompiler.compile fn }
      )
      @properties.each do |k, v|
        v.apply(@program, k)
      end
    end

    def use!
      LibGL.use_program @program
    end

    def unuse!
      LibGL.use_program 0
    end

    def apply(&block)
      use!
      begin
        block.call
      ensure
        unuse!
      end
    end
  end
end
