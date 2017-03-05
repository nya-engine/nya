require "obj"
require "tempfile"
require "./loader"

module OBJ
  class Vertex
    def convert_to_nya(mtl = "")
      # TODO : Use color from material
      Nya::Render::Mesh::Vertex.new(
        @coord,
        @normal,
        @texcoord
      )
    end
  end

  class Face
    def convert_to_nya(mtl = "")
      Nya::Render::Mesh::Face.new(
        @vertices.map &.convert_to_nya(mtl)
      )
    end
  end

  class Group
    def convert_to_nya(mtl = "")
      mtl = @material if mtl.empty?
      Nya::Render::Mesh::Shape.new(
        @name,
        @faces.map(&.convert_to_nya(mtl)),
        [] of Nya::Render::Mesh::Shape
      )
    end
  end

  class NamedObject
    def convert_to_nya
      Nya::Render::Mesh::Shape.new(
        @name,
        @faces.map(&.convert_to_nya(@material)),
        @groups.map(&.convert_to_nya(@material))
      )
    end
  end
end

module Nya::Render

  class Mesh::OBJLoader < Nya::Render::Mesh::Loader
    extension ".obj"


    def load(file : String)
      mesh = Mesh.new
      Nya.log.info "Loading mesh #{file}", "OBJLoader"
      Storage::Reader.read_file(file) do |f|
        parser = OBJ::OBJParser.new f
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
            c.backtrace.each { |loc| Nya.log.error loc, "OBJParser"}
          end
        end
        Tempfile.open("nya_obj_parser") do |f|
          parser.debug! f
          Nya.log.info "Parser state has been saved to #{f.path}"
        end
        mesh.shapes = Hash(String, Shape).zip(parser.objects.keys, parser.objects.values.map &.convert_to_nya)
      end

      mesh
    end
  end
end
