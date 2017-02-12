require "./chunk_info"
module Chunked
  class Base(T)
    @io : IO::Positional

    def initialize(@io, @debug : Bool = false)
      @start_offsets = Array(T).new
      @end_offsets = Array(T).new
    end

    def debug(*str)
      puts *str if @debug
    end

    alias ChunkPosition = NamedTuple(info: ChunkInfo(T,T), offset: T)

    def close
      debug "Closing #{@io.closed?}"
      @io.close unless @io.closed?
    end

    def finalize
      debug "Finalizing"
      close
    end

    def offset
      T.unsafe_cast(@io.pos)
    end

    def offset=(t : T)
      @io.pos = @io.pos.class.unsafe_cast(t)
    end
  end
end
