require "spec"
require "../src/chunked"
require "tempfile"

alias Writer = Chunked::Writer(Int64)
alias Writer32 = Chunked::Writer(UInt32)
alias Reader = Chunked::Reader(Int64)
alias Reader32 = Chunked::Reader(Int32)
alias IReader = Chunked::IndexedReader(Int64)
alias IReader32 = Chunked::IndexedReader(Int32)
TMP = Tempfile.new("chunked").path
TMP32 = Tempfile.new("chunked32").path
