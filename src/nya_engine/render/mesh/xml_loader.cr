require "./loader"
require "../../storage/*"

module Nya::Render
  class Mesh::XMLLoader < Mesh::Loader
    extension ".xml"

    def load(file : String)
      msh = Mesh.deserialize(Storage::Reader.read_to_end(file)).as?(Mesh)
      if msh.nil?
        Nya.log.error "Cannot deserialize Mesh", "XMLLoader"
      end
      msh
    end
  end
end
