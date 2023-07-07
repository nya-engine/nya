require "obj"
require "./loader"

module Nya::Render
  class Mesh::OBJLoader < Nya::Render::Mesh::Loader
    extension ".obj"

    def load(file : String) : Nya::Render::Mesh?
      mesh = Mesh.new
      @@log.info {"Loading mesh #{file}"} 
      Storage::Reader.read_file(file) do |f|
        parser = OBJ::OBJParser.new f, file, true
        parser.custom_file_opener = ->(s : String) do
          Nya::Storage::Reader.read_file s
        end
        parser.on_warning { |s| @@log.warn {s} }
        begin
          parser.parse!
        rescue e : Exception
          @@log.error { e.to_s }
          e.backtrace.each do |c|
            @@log.error {c}
          end
          c = e.cause
          unless c.nil?
            @@log.error {c.to_s}
            c.backtrace.each { |loc| @@log.error { loc } }
          end
        end
        {% if flag? :obj_parser_debug %}
          File.tempfile("nya_obj_parser") do |f|
            parser.debug! f
            @@log.info { "Parser state has been saved to #{f.path}" }
          end
        {% end %}

        mesh.shapes = parser.objects
      end

      mesh
    end
  end
end
