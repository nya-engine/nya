require "../log"

module Nya::Render
  class ShaderCompiler
    @@shader_cache = Hash(String, UInt32).new
    @@program_cache = Hash(String, UInt32).new

    def self.flush_cache!
      Nya.log.warn "Flushing shader and shader program cache"
      @@shader_cache = Hash(String, UInt32).new
      @@program_cache = Hash(String, UInt32).new
    end

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
      ckey = "#{filename}$#{stype}"
      if @@shader_cache.has_key? ckey
        Nya.log.debug "Found cached shader for #{filename}"
        return @@shader_cache[ckey]
      end
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
        if comp_ok != 0
          Nya.log.debug ln, "GL"
        else
          Nya.log.error ln, "GL"
        end
      end

      raise "Cannot compile shader. See log for more details" if comp_ok == 0
      Nya.log.debug "Compiled shader successfully", "Shader"
      @@shader_cache[ckey] = shid
      shid
    end

    def self.link(shaders : Array(UInt32))
      ckey = shaders.join(";")
      if @@program_cache.has_key? ckey
        Nya.log.debug "Found cached shader for #{ckey}"
        return @@program_cache[ckey]
      end
      Nya.log.debug "Linking shader program", "Shader"
      pid = GL.create_program
      Nya.log.debug "Allocated ID : #{pid}", "Shader"
      shaders.each{ |s| GL.attach_shader pid, s }
      GL.link_program pid

      GL.get_programiv pid, GL::LINK_STATUS, out link_ok
      GL.get_programiv pid, GL::INFO_LOG_LENGTH, out log_l
      log = Bytes.new(log_l)
      GL.get_program_info_log pid, log_l, out len, log
      String.new(log).split("\n").each do |ln|
        if link_ok == 0
          Nya.log.error ln, "GL"
        else
          Nya.log.debug ln, "GL"
        end
      end

      raise "Cannot link shader program. See log for more details" if comp_ok == 0
      Nya.log.debug "Linked successfully", "Shader"
      @@program_cache[ckey] = pid
      pid
    end
  end
end
