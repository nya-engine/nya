require "../gl"
require "./glerr"

module Nya
  class ShaderCompileException < RuntimeError

  end

  class ShaderLinkException < RuntimeError

  end

  class Shader
    @text : String
    @shader : Int32
    getter shader,type
    def initialize(@text,@type : Int = GL::VERTEX_SHADER)
      compile_ok = 0i16
      @shader = GL::create_shader(@type)
      GL::shader_source(@shader,1,@text,nil)
      GL::compile_shader(@shader)
      GL::get_shaderiv(vs,GL::COMPILE_STATUS,pointerof(compile_ok))
      raise ShaderCompileException, "Shader compile error : #{gl_error}" if compile_ok == 0
    end
  end

  class VShader < Shader
    def initialize(text : String)
      super text
    end
  end

  class FShader < Shader
    def initialize(text : String)
      super text,GL::FRAGMENT_SHADER
    end
  end

  class ShaderProgram
    @shaders : Array(Shader)
    property shaders
    @program : Int32
    def initialize(@shaders)
      link_ok = 0i16
      @program = GL::create_program
      @shaders.each do |e|
        GL::attach_shader @program,e.shader
      end
      GL::link_program(@program)
      GL::get_programiv(@program,GL::LINK_STATUS,pointerof(link_ok))
      raise ShaderLinkException, "Shader linkage error : #{gl_error}" if compile_ok == 0
    end
  end

  class Drawable(V)
    @shader : ShaderProgram

    def initialize(@shader)

    end

    def draw(position : V)
      
    end

  end
end
