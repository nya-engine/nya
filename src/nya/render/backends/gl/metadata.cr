module Nya::Render::Backends::GL
  class Metadata < Backend::Metadata
    getter object_type : Symbol
    getter id : LibGL::GLenum

    def initialize(@object_type, @id)
    end
  end
end
