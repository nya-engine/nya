struct Int
  def self.crop(other : Int) : self
    if sizeof(self) > sizeof(typeof(other))
      raise "Size of cropped int is bigger than input"
    end
    return other if other.is_a? self
    io = IO::Memory.new sizeof(typeof(other))
    io.write_bytes(other, IO::ByteFormat::LittleEndian)
    io.flush
    io.pos = 0
    io.read_bytes(self, IO::ByteFormat::LittleEndian)
  end

  def self.expand(other : Int) : self
    if sizeof(self) < sizeof(typeof(other))
      raise "Size of expanded int is smaller than input"
    end
    return other if other.is_a? self
    io = IO::Memory.new sizeof(self)
    io.write_bytes(other, IO::ByteFormat::LittleEndian)
    (sizeof(self) - sizeof(typeof(other))).times{ io.write_byte(0u8) }
    io.flush
    io.pos = 0
    io.read_bytes(self, IO::ByteFormat::LittleEndian)
  end

  def self.unsafe_cast(other : Int) : self
    if sizeof(self) < sizeof(typeof(other))
      crop other
    else
      expand other
    end
  end
end
