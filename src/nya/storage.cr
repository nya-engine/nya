require "chunked"

module Nya
  module Storage
    class Reader
      alias CReader = Chunked::IndexedReader(UInt64)

      @readers = Hash(String, CReader).new
      @files_index = Hash(String, String).new

      @@instance : self? = nil

      def self.instance
        @@instance.not_nil!
      end

      def self.instance?
        @@instance
      end

      class_setter instance

      protected def add_file(file : String)
        @readers[file] = CReader.new(File.open(file))
        @readers[file].index_chunks!
        idx = 0
        @readers[file][0u64].each_line("\0") do |line|
          unless line.nil?
            @files_index[line.chomp] = "#{file}/$#{idx}"
            idx += 1
          end
        end
      end

      def initialize(@files : Array(String))
        @files.each do |file|
          add_file file
        end
      end

      def read_file(name)
        if @files_index.has_key?(name)
          name, idx = @files_index[name].split("/$", 2)
          @readers[name][idx.to_u64]
        else
          File.open(name)
        end
      end

      def exists?(name)
        if @files_index.has_key?(name)
          true
        else
          File.exists?(name)
        end
      end

      def read_file(name, &block : IO ->)
        begin
          f = read_file name
          block.call f
        ensure
          f.not_nil!.close unless f.nil?
        end
      end

      def self.read_to_end(name)
        f = read_file name
        s = f.gets_to_end
        f.close
        s
      end

      def self.init(files)
        self.instance = new files
      end

      def self.read_file(*args, &b : IO ->)
        init [] of String if @@instance.nil?
        self.instance.read_file(*args, &b)
      end

      def self.read_file(name)
        init [] of String if @@instance.nil?
        self.instance.read_file(name)
      end

      def self.exists?(n)
        self.instance.exists? n
      end
    end
  end
end
