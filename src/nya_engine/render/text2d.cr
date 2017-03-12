require "../pangocairo"
require "../drawutils"

module Nya
  module Render
    class Text2D < ::Nya::Component
      @texture_id = 0u32
      @color = Color.white
      @text = ""
      @position = CrystalEdge::Vector2.new(0.0, 0.0)
      @size = CrystalEdge::Vector2.new(0.0, 0.0)
      @font = "Ubuntu Bold 12"
      @autosize = true
      property autosize

      attribute autosize, as: Bool, nilable: false

      property color, position, size, text, font

      serializable position, size, as: CrystalEdge::Vector2
      serializable color, as: Color
      serializable text, font, as: String

      private def refresh_text!(ntxt, nfnt, nclr)
        if ntxt != @text || nfnt != @font || nclr != @color
          pango = Pango.render_text(ntxt, nfnt, @color)
          if @autosize
            @size = pango.size
          end
          LibGL.delete_textures(1, pointerof(@texture_id))
          @texture_id = pango.texture_id
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
        Nya.log.info "Set color : #{c.r} #{c.g} #{c.b} #{c.a}"
        @color = c
      end

      def update
      end

      def awake
        Nya.log.debug "Awake text : #{@texture_id}", "Text2D"
      end

      def render(tag : String? = nil)
        return if !tag.nil? && !self.tag.nil? && tag.to_s != self.tag.to_s
        ::Nya::DrawUtils.draw_texture(
          @position.x,
          @position.y,
          @size.x,
          @size.y,
          @texture_id
        )
      end
    end
  end
end
