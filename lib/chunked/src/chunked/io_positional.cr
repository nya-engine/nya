module IO
  module Positional
    abstract def pos
    abstract def pos=(t)
  end

  class FileDescriptor
    include Positional
  end
end
