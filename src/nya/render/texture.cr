module Nya::Render
  class Texture < Component

    @data : Bytes = Bytes.new 0
    property width = 0u32
    property height = 0u32

    property src : String = ""

    attribute src : String, width : UInt32, height : UInt32

    def prepare_metadata!
      if @data.empty?
        raise "Empty texture" if @src.empty?
        canvas = StumpyLoader.load(@src).to_gl
      end

      if @metadata.nil?
        @metadata = Engine.instance.backend.create_object :texture
      else

      end

      Engine.instance.backend.load_texture metadata, width, height, @data
    end

    def awake
      Event.subscribe :prefetch do |_|
        prepare_metadata!
      end
    end
  end
end
