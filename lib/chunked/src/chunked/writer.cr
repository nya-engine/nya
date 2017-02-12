require "./base"

module Chunked
  class Writer(T) < Base(T)

    def initialize(io, debug = false)
      super io, debug
      debug "Writing to #{io.path}"
    end
    def open_chunk(index : T)
      debug "Opening chunk #{index}"
      cdata = ChunkInfo(T,T).new(index, T.new(0))
      cdata.write to: @io
      debug "Offset is #{offset} #{@io.pos}"
      @start_offsets << offset
    end

    delegate write, write_bytes, write_byte, write_utf8, puts, to: @io

    def close_chunk
      @io.flush
      debug "Closing chunk"
      start = @start_offsets.pop
      debug "Saving offset #{offset}"
      pos = offset
      _offset = start - sizeof(T)
      debug "New offset is #{_offset}"
      self.offset = self.offset.class.unsafe_cast _offset
      debug "Writing size #{pos - start}"
      @io.write_bytes(T.unsafe_cast(pos-start), IO::ByteFormat::LittleEndian)
      debug "Returning back to #{pos}"
      self.offset = pos
      @io.flush
    end

    def chunk(index)
      open_chunk index
      begin
        yield self
      ensure
        close_chunk
      end
    end

    def reset!
      self.offset = 0
    end
  end
end
