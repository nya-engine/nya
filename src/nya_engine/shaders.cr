require "../gl"
require "./glerr"

module Nya
  SHADER_COORD = "coord"

  class ShaderCompileException < Exception

  end

  class ShaderLinkException < Exception

  end

  enum ShaderParamDirection
    IN
    OUT
  end

  class ShaderParam
    getter dir : ShaderParamDirection
    getter name : String
    getter type : String
    def initialize(@dir,@name,@type)

    end
  end

  class Shader
    @text : String
    @shader : Int32
    @params = Array(ShaderParam).new
    @type : Int32
    getter shader,type,params

    protected def parse_params
      @params = Array(ShaderParam).new
      @text.split("\n").each do |line|
        m = line.match(%r{//\s*@param\s+(?<pname>[^\s]+)\s+(?<ptype>[^\s]+)\s+(?<pdir>in|out)})
        unless m.nil?
          @params << ShaderParam.new(
            m[:pdir] == "in" ? ShaderParamDirection::IN : ShaderParamDirection::OUT,
            m[:pname],
            m[:ptype]
          )
        end
      end
    end

    def initialize(@text,@type = GL::VERTEX_SHADER)
      compile_ok = 0i16
      @shader = GL.create_shader(@type)
      GL.shader_source(@shader,1,@text,nil)
      GL.compile_shader(@shader)
      GL.get_shaderiv(vs,GL::COMPILE_STATUS,pointerof(compile_ok))
      raise ShaderCompileException, "Shader compile error : #{gl_error}" if compile_ok == 0
      parse_params
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
      @program = GL.create_program
      @shaders.each do |e|
        GL.attach_shader @program,e.shader
      end
      GL.link_program(@program)
      GL.get_programiv(@program,GL::LINK_STATUS,pointerof(link_ok))
      raise ShaderLinkException, "Shader linkage error : #{gl_error}" if link_ok == 0
    end
  end
end
