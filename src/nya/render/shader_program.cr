require "../object"
require "./shader_vars"

module Nya::Render
  class ShaderProgram < Nya::Component
    @shaders = [] of Shader
    @filenames = [] of String
    @program = 0u32
    @properties = Hash(String, Nya::Render::ShaderVars::Var).new

    property shaders, filenames, program, properties
    serializable filenames : Array(String), properties : Hash(String, Nya::Render::ShaderVars::Var)

    def awake
      @program = ShaderCompiler.link(
        @filenames.map { |fn| ShaderCompiler.compile fn }
      )
      @properties.each do |k, v|
        v.apply(@program, k)
      end
    end

    def use!
      ::Nya.shader_stack.push @program
      LibGL.use_program @program
    end

    def unuse!
      ::Nya.shader_stack.pop unless ::Nya.shader_stack.empty?
      LibGL.use_program ::Nya.shader_stack.last? || 0u32
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
