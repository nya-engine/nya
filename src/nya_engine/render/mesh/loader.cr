require "../../log"
require "../mode"

module Nya::Render
  class Mesh
    abstract class Loader
      @@loaders = {} of String => Loader

      abstract def load(filename : String) : Mesh?

      def self.register(ext, ldr)
        Nya.log.info "Registered loader #{ldr.class.name} for extension #{ext.upcase}", "MeshLoader"
        @@loaders[ext.downcase] = ldr
      end

      def self.exists_for?(extname : String)
        extname = "." + extname unless extname.starts_with? "."
        @@loaders.has_key? extname.downcase
      end

      def self.load_from(filename : String) : Mesh?
        Nya.log.debug "Trying to load mesh #{filename}", "MeshLoader"
        if exists_for? File.extname(filename)
          @@loaders[File.extname(filename).downcase].load filename
        else
          Nya.log.error "Cannot find mesh loader for #{File.extname filename}", "MeshLoader"
          nil
        end
      end

      macro extension(ext)
        TARGET_EXT = {{ext}}
        ::Nya::Render::Mesh::Loader.register TARGET_EXT, new
      end
    end
  end
end
