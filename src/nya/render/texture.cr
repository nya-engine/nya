module Nya::Render
  class Texture < Component

    @data : Bytes = Bytes.new 0
    property width = 0u32
    property height = 0u32

    property src : String = ""
    property data

    attribute src : String, width : UInt32, height : UInt32

    def prepare_metadata!
      if @data.empty?
        raise "Empty texture" if @src.empty?
        @data = StumpyLoader.load(@src).to_gl
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

    def self.from_stumpy(stp)
      new.tap do |this|
        this.width = stp.width.to_u32
        this.height = stp.height.to_u32
        this.data = stp.to_gl
      end
    end
  end
end
