require "../pangocairo"
require "../drawutils"

module Nya
  module Render
    class Text2D < ::Nya::Component
      @texture_id = 0u32
      @color = Color.white
      @text = ""
      @position = CrystalEdge::Vector2.new(0.0,0.0)
      @size = CrystalEdge::Vector2.new(0.0,0.0)
      @font = "Ubuntu Bold 12"

      property color, position, size, text, font

      serializable position, size, as: CrystalEdge::Vector2
      serializable color, as: Color
      serializable text, font, as: String

      def text=(t)
        @text = t
      end

      def font=(f)
        @font = f
      end

      def update
      end

      def awake
        pango = Pango.render_text(@text, @font)
        if @size.x + @size.y == 0.0
          @size = pango.size
        end
        @texture_id = pango.texture_id
      end

      def render(tag : String? = nil)
        return if !tag.nil? && !self.tag.nil? && tag.to_s != self.tag.to_s
        ::Nya::DrawUtils.draw_texture(
          @position.x,
          @position.y,
          @size.x,
          @size.y,
          @texture_id,
          @color.to_gl
        )
      end
    end
  end
end