module Nya::Render
  # Wrapper enum for OpenGL drawing mode
  enum Mode
    QUADS          = LibGL::QUADS
    TRIANGLES      = LibGL::TRIANGLES
    TRIANGLE_STRIP = LibGL::TRIANGLE_STRIP
  end
end
