require "obj"
require "tempfile"
require "./loader"
require "benchmark"

module Nya::Render
  class Mesh::OBJLoader < Nya::Render::Mesh::Loader
    extension ".obj"

    def load(file : String)
      mesh = Mesh.new
      Nya.log.info "Loading mesh #{file}", "OBJLoader"
      Storage::Reader.read_file(file) do |f|
        parser = OBJ::OBJParser.new f, file, true
        parser.custom_file_opener = ->(s : String) do
          Nya::Storage::Reader.read_file s
        end
        parser.on_warning { |s| Nya.log.warn s, "OBJParser"}
        begin
          parser.parse!
        rescue e : Exception
          Nya.log.error e.to_s, "OBJParser"
          e.backtrace.each do |c|
            Nya.log.error c, "OBJParser"
          end
          c = e.cause
          unless c.nil?
            Nya.log.error c.to_s, "OBJParser"
            c.backtrace.each { |loc| Nya.log.error loc, "OBJParser" }
          end
        end
        {% if flag? :obj_parser_debug %}
          Tempfile.open("nya_obj_parser") do |f|
            parser.debug! f
            Nya.log.info "Parser state has been saved to #{f.path}"
          end
        {% end %}
      end

      mesh
    end
  end
end
