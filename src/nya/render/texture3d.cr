module Nya::Render
  class Texture3D < Texture
    property points = [] of CrystalEdge::Vector3

    serializable points : Array(CrystalEdge::Vector3)
  end
end
