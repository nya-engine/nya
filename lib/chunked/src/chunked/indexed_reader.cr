require "./reader"

module Chunked
  class IndexedReader(T) < Reader(T)
    @chunks = Hash(T, NamedTuple(size: T, offset: T, index: T)).new

    def open_chunk
      cinfo = super
      cdata = current_chunk_data(cinfo)
      @chunks[cinfo.index] = {size: cinfo.size, index: cinfo.index, offset: offset}
      cinfo
    end

    def index_chunks!
      begin
        while true
          cdata = open_chunk
          return if cdata.index == cdata.size && cdata.index == 0
          close_chunk
        end
      rescue e : IO::EOFError
      end
    end

    def [](index : T)
      raise "No chunk #{index} found" unless @chunks.has_key? index
      offset = @chunks[index][:offset]
      size = @chunks[index][:size]
      IORange.new(@io, UInt64.unsafe_cast(offset), UInt64.unsafe_cast(size))
    end

    def info(index : T)
      raise "No chunk #{index} found" unless @chunks.has_key? index
      @chunks[index]
    end

    getter chunks
  end
end
