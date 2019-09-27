require "./*"

module Nya::Render::Backends::GL
  class CameraMetadata < Metadata
    property modelview = StaticArray(Float64, 16).new(0.0)
    property projection = StaticArray(Float64, 16).new(0.0)
    property viewport = StaticArray(Int32, 4).new(0)
    def initialize(id)
      super :camera, id
    end
  end
end
