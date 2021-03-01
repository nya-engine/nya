require "../object"
require "./shader_set"
require "./shader_vars"

module Nya::Render
  class ShaderProgram < Nya::Component
    @sets = [] of ShaderSet
    property sets
    serializable sets : Array(ShaderSet)
    
    property vars = [] of ShaderVar

    serializable vars : Array(ShaderVar)

    def awake
      backend.compile_shaders self
    end


    def apply(&block)
      use!
      begin
        block.call
      ensure
        unuse!
      end
    end

    def apply_variables!
      backend.apply_shader_vars self
    end

    def finalize
      backend.delete_shaders self
    end
    
  end
end
