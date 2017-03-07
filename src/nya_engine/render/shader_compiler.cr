require "../log"

module Nya::Render
  class ShaderCompiler
    @@shader_cache = Hash(String, UInt32).new
    @@program_cache = Hash(String, UInt32).new
    @@preprocessor_cache = Hash(String, String).new

    def self.flush_cache!
      Nya.log.warn "Flushing shader and shader program cache"
      [@@shader_cache,
       @@program_cache,
       @@preprocessor_cache].each &.clear
    end

    def self.preprocess(text : String)
      text.split("\n").map do |line|
        if md = line.match /^\s*\/\/\s*@require (?<name>.+)/
          Storage::Reader.read_to_end(md["name"])
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
      Nya.log.info "Compiling shader #{filename}", "Shader"
      text = Storage::Reader.read_to_end(filename)
      if @@preprocessor_cache.has_key? filename
        text = @@preprocessor_cache[filename]
      else
        while text =~ /\/\/\s*@require/
          text = preprocess text
        end
      end
      @@preprocessor_cache[filename] = text
      stype ||= detect_type text
      Nya.log.debug "Type is #{stype}", "Shader"

      shid = LibGL.create_shader stype.to_i
      Nya.log.debug "Allocated ID : 0x#{shid.to_s(16)}", "Shader"

      utext = text.to_unsafe

      LibGL.shader_source shid, 1, pointerof(utext), nil
      LibGL.compile_shader shid

      LibGL.get_shaderiv shid, LibGL::COMPILE_STATUS, out comp_ok
      LibGL.get_shaderiv shid, LibGL::INFO_LOG_LENGTH, out log_l
      bytes = Bytes.new(log_l)
      LibGL.get_shader_info_log shid, log_l, out len, bytes

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
      pid = LibGL.create_program
      Nya.log.debug "Allocated ID : #{pid}", "Shader"
      shaders.each { |s| LibGL.attach_shader pid, s }
      LibGL.link_program pid

      LibGL.get_programiv pid, LibGL::LINK_STATUS, out link_ok
      LibGL.get_programiv pid, LibGL::INFO_LOG_LENGTH, out log_l
      log = Bytes.new(log_l)
      LibGL.get_program_info_log pid, log_l, out len, log
      String.new(log).split("\n").each do |ln|
        if link_ok == 0
          Nya.log.error ln, "GL"
        else
          Nya.log.debug ln, "GL"
        end
      end

      raise "Cannot link shader program. See log for more details" if link_ok == 0
      Nya.log.debug "Linked successfully", "Shader"
      @@program_cache[ckey] = pid
      pid
    end

    def self.parse_vars(filename : String)
      unless @@preprocessor_cache.has_key? filename
        Nya.log.warn "Compiling shader #{filename} as it has been not compiled yet", "Shader"
      end
      text = @@preprocessor_cache[filename]
      text.split("\n").compact_map do |line|
        md = line.match(/^[^\/]*(?<kind>attribute|uniform)\s*(?<type>[a-z0-9A-Z]+)\s*(?<name>.+);/)
        if md.nil?
          nil
        else
          {
            kind: md["kind"].not_nil!,
            type: md["type"].not_nil!,
            name: md["name"].not_nil!,
          }
        end
      end
    end
  end
end
