require "../../log"
require "../mode"
require "../../abstract_loader"

module Nya::Render
  class Mesh
    abstract class Loader < ::Nya::AbstractLoader(Mesh)
      macro extension(e)
        ::Nya::Render::Mesh::Loader.register {{e}}, new
      end
    end
  end
end
