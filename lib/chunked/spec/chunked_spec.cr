require "./spec_helper"

describe Int do
  it "crops" do
    dword = 0x01020304i32
    Int8.crop(dword).should eq(0x04)
  end

  it "expands" do
    byte = 0x02i8
    (Int16.expand(byte) | 0x0100).should eq(0x0102)
  end

  it "can perform unsafe_cast" do
    short = 0x0203i16
    (Int32.unsafe_cast(short) | 0x010000).should eq(0x010203)
    Int8.unsafe_cast(short).should eq(0x03)
  end
end

describe Chunked::Writer do


  it "writes data" do
    writer = Writer.new(File.open(TMP,"w"), debug: ENV.has_key?("CHUNKED_DEBUG"))
    writer.chunk 0i64 do |w|
      w.write_byte 1u8
      w.write_byte 2u8
      w.write_byte 3u8
    end

    writer.chunk 1i64 do |w|
      w.write_byte 4u8
      w.write_byte 5u8
      w.write_byte 6u8
    end

    writer.close

    File.read(TMP).bytes.should eq([
      0u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8, # INDEX = 0x0000000000000000
      3u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8, # SIZE = 0x0000000000000003
      1u8,2u8,3u8,     # 3 bytes of data

      1u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8, # INDEX = 0x0000000000000001
      3u8,0u8,0u8,0u8,0u8,0u8,0u8,0u8, # SIZE = 0x0000000000000003
      4u8,5u8,6u8
    ])
  end

  it "writes data using other integral types" do
    writer = Writer32.new(File.open(TMP32,"w"), debug: ENV.has_key?("CHUNKED_DEBUG"))
    writer.chunk 0u32 do |w|
      w.write_byte 1u8
      w.write_byte 2u8
      w.write_byte 3u8
    end

    writer.chunk 1u32 do |w|
      w.write_byte 4u8
      w.write_byte 5u8
      w.write_byte 6u8
    end

    writer.close

    File.read(TMP32).bytes.should eq([
      0u8,0u8,0u8,0u8, # INDEX = 0x00000000
      3u8,0u8,0u8,0u8, # SIZE = 0x00000003
      1u8,2u8,3u8,     # 3 bytes of data

      1u8,0u8,0u8,0u8, # INDEX = 0x00000001
      3u8,0u8,0u8,0u8, # SIZE = 0x00000003
      4u8,5u8,6u8
    ])
  end

end

describe Chunked::Reader do
  it "reads data" do
    reader = Reader.new(File.open(TMP), debug: ENV.has_key?("CHUNKED_DEBUG"))
    cdata = reader.open_chunk
    cdata.index.should eq(0i64)
    cdata.size.should eq(3i64)
    reader.current_chunk.to_a.should eq([1u8,2u8,3u8])
    reader.close_chunk
    cdata = reader.open_chunk
    cdata.index.should eq(1i64)
    cdata.size.should eq(3i64)
    reader.current_chunk.to_a.should eq([4u8,5u8,6u8])
    reader.close
  end

  it "reads data using other integral types" do
    reader = Reader32.new(File.open(TMP32), debug: ENV.has_key?("CHUNKED_DEBUG"))
    cdata = reader.open_chunk
    cdata.index.should eq(0i32)
    cdata.size.should eq(3i32)
    reader.current_chunk.to_a.should eq([1u8,2u8,3u8])
    reader.close_chunk
    cdata = reader.open_chunk
    cdata.index.should eq(1i32)
    cdata.size.should eq(3i32)
    reader.current_chunk.to_a.should eq([4u8,5u8,6u8])
    reader.close
  end

  it "reads chunks with blocks" do
    reader = Reader32.new(File.open(TMP32), debug: ENV.has_key?("CHUNKED_DEBUG"))
    reader.chunk do |io|
      io.gets_to_end.bytes.should eq([1u8,2u8,3u8])
    end
    reader.chunk do |io|
      io.gets_to_end.bytes.should eq([4u8,5u8,6u8])
    end
    reader.close
  end

  it "iterates through chunks" do
    reader = Reader.new(File.open(TMP), debug: ENV.has_key?("CHUNKED_DEBUG"))
    reader.each_chunk do |io, chk|
      io.size.should eq(chk.size)
      io.size.should eq(3i64)
      io.gets_to_end.bytes.should eq([1u8,2u8,3u8].map{ |x| x + 3*chk.index })
    end
  end
end

describe Chunked::IndexedReader do

  it "indexes chunks" do
    reader = IReader.new(File.open(TMP), debug: ENV.has_key?("CHUNKED_DEBUG"))
    reader.index_chunks!
    reader.info(0i64)[:size].should eq(3)
    reader.info(1i64)[:size].should eq(3)
    reader.info(0i64)[:index].should eq(0)
    reader[0i64].gets_to_end.bytes.should eq([1u8,2u8,3u8])
  end

  it "indexes chunks using other integral types" do
    reader = IReader32.new(File.open(TMP32), debug: ENV.has_key?("CHUNKED_DEBUG"))
    reader.index_chunks!
    reader.info(0i32)[:size].should eq(3)
    reader.info(1i32)[:size].should eq(3)
    reader.info(0i32)[:index].should eq(0)
    reader[0i32].gets_to_end.bytes.should eq([1u8,2u8,3u8])
  end

end
