module Chunked
  class IORange
    include IO
    include IO::Positional

    @parent : IO::Positional
    @start : UInt64
    @size : UInt64
    @pos = 0u64

    getter size

    def pos=(t)
      @pos = UInt64.unsafe_cast(t)
    end

    def pos
      @pos
    end

    def initialize(@parent,@start,@size)
    end

    private def update_pos!
      pos = @pos + @start
      @parent.pos = pos unless @parent.pos == pos
    end

    def read(slice : Bytes)
      if slice.size + @pos > @size
        update_pos!
        size = @size-@pos
        cslice = Bytes.new(size)
        @parent.read(cslice)
        slice.copy_from(cslice)
        @pos = @size
        return size
      end

      update_pos!
      num = @parent.read(slice)
      @pos += num
      update_pos!
      num
    end

    def write(slice : Bytes)
      if slice.size + @pos > @size
        update_pos!
        @parent.write(slice[0,@size-@pos])
        raise EOFError.new
      end

      update_pos!
      size = @parent.write(slice) || 0
      @pos += size
      size
    end
  end
end
