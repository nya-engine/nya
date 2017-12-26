require "stumpy_core"

module StumpyCore
  class Canvas
    def to_gl
      slice = Bytes.new(pixels.size * 4)
      pixels.size.times do |idx|
        data = pixels[idx].to_rgba
        4.times do |offset|
          slice[4 * idx + offset] = data[offset]
        end
      end
      slice
    end
  end
end
