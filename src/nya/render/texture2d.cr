module Nya::Render
  class Texture2D < Texture
    property position = CrystalEdge::Vector2.new(0.0,0.0)
    property size = CrystalEdge::Vector2.new(0.0,0.0)

    serializable position : CrystalEdge::Vector2, size : CrystalEdge::Vector2
  end
end
