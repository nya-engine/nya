require "../pangocairo"
require "../drawutils"

module Nya
  module Render
    class 2DText < ::Nya::Object
      @texture_id = 0u32
      @size = Rect.zero
      @color = {1.0,1.0,1.0}
      property color
      def initialize(@text : String, @font : String, @position : CrystalEdge::Vector2)
        @pango = ::Nya::Pango.render_text(@text, @font)
      end

      def update
      end

      def render
        ::Nya::DrawUtils.draw_texture(
          @position.x,
          @position.y,
          @pango.size.x,
          @pango.size.y,
          @pango.texture_id,
          @color
        )
      end
    end
  end
end
