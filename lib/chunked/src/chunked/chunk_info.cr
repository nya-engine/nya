module Chunked
  struct ChunkInfo(I,S)
    @index : I
    @size : S
    property index, size
    def initialize(@index,@size)
    end

    def self.read(io : IO)
      self.new(
        io.read_bytes(I, IO::ByteFormat::LittleEndian),
        io.read_bytes(S, IO::ByteFormat::LittleEndian)
      )
    end

    def write(to : IO)
      to.write_bytes(@index, IO::ByteFormat::LittleEndian)
      to.write_bytes(@size, IO::ByteFormat::LittleEndian)
      to.flush
      # to.unbuffered_flush if to.responds_to? :unbuffered_flush
    end
  end
end
