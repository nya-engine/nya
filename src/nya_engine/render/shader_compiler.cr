require "../log"

module Nya::Render
  class ShaderCompiler
    def self.preprocess(text : String)
      text.split("\n").map do |line|
        if md = line.match /^\s*\/\/\s*@require (?<name>.+)/
          Storage::Reader.read_fully(md["name"])
        else
          line
        end
      end.join("\n")
    end

    def self.detect_type(text)
      md = text.match(/\/\/@type (?<type>.*)/)
      tp = ShaderType::Vertex
      if md
        tp = case md["type"].downcase
        when /^frag/
          ShaderType::Fragment
        when /^tess.*c/
          ShaderType::TessControl
        when /^tess.*e/
          ShaderType::TessEvaluation
        when /^geom/
          ShaderType::Geometry
        else
          ShaderType::Vertex
        end
      end
      tp
    end

    def self.compile(filename : String, stype : ShaderType? = nil)
      Nya.log.debug "Compiling shader #{filename}", "Shader"
      text = Storage::Reader.read_fully(filename)
      while text =~ /\/\/\s*@require/
        text = preprocess text
      end

      stype ||= detect_type text
      Nya.log.debug "Type is #{stype}", "Shader"

      shid = GL.create_shader
      Nya.log.debug "Allocated ID : 0x#{shid.to_s(16)}", "Shader"

      GL.shader_source shid, 1, pointerof(text.to_unsafe), 0
      GL.compile_shader shid

      GL.get_shaderiv shid, GL::COMPILE_STATUS, out comp_ok
      GL.get_shaderiv shid, GL::INFO_LOG_LENGTH, out log_l
      bytes = Bytes.new(log_l)
      GL.get_shader_info_log shid, log_l, out len, bytes

      String.new(bytes).split("\n").each do |ln|
        if comp_ok
          Nya.log.debug ln, "GL"
        else
          Nya.log.error ln, "GL"
        end
      end

      raise "Cannot compile shader. See log for more details" unless comp_ok
      return shid
    end
  end
end
