require "../pangocairo"

module Nya
  module Render
    class Text2D < ::Nya::Component
      @color = Color.white
      @text = ""
      @position = CrystalEdge::Vector2.new(0.0, 0.0)
      @size = CrystalEdge::Vector2.new(0.0, 0.0)
      @font = "Ubuntu Bold 12"
      @autosize = true
      property autosize

      attribute autosize : Bool

      property color, position, size, text, font

      serializable position : CrystalEdge::Vector2, size : CrystalEdge::Vector2
      serializable color : Color, text : String, font : String

      private def refresh_text!(ntxt, nfnt, nclr)
        if ntxt != @text || nfnt != @font || nclr != @color
          pango = Pango.render_text(ntxt, nfnt, nclr)
          if @autosize
            @size = pango.size
          end
          @metadata = backend.create_object :texture if @metadata.nil?
          backend.load_texture self.metadata, pango.size.x, pango.size.y, pango.buffer
        end
      end

      def text=(t)
        refresh_text! t, @font, @color
        @text = t
      end

      def font=(f)
        refresh_text! @text, f, @color
        @font = f
      end

      def color=(c)
        refresh_text! @text, @font, c
        @color = c
      end

      def update
      end

      def render(tag : String? = nil)
        return if !tag.nil? && !self.tag.nil? && tag.to_s != self.tag.to_s
        backend.draw_texture(
          metadata,
          @position.x,
          @position.y,
          @size.x,
          @size.y,
        )
      end
    end
  end
end
