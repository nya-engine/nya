module Nya
  class Transform < Component
    property position = CrystalEdge::Vector3.new(0.0,0.0,0.0)
    property rotation = CrystalEdge::Vector3.new(0.0,0.0,0.0)
    property scale = CrystalEdge::Vector3.new(0.0,0.0,0.0)

    property parent : Transform? = nil
  end
end
