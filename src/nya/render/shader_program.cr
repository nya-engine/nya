require "../object"
require "./shader_set"

module Nya::Render
  class ShaderProgram < Nya::Component
    @sets = [] of ShaderSet
    property sets
    serializable sets : Array(ShaderSet)

    def awake
      backend.compile_shaders self

      #@properties.each do |k, v|
      #  v.apply(@program, k)
      #end
    end


    def apply(&block)
      use!
      begin
        block.call
      ensure
        unuse!
      end
    end

    def finalize
      backend.delete_shaders self
    end
    
  end
end
