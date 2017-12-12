module Nya
  abstract class AbstractLoader(T)
    abstract def load(filename : String) : T?

    macro inherited
      @@loaders = {} of String => self

      def self.register(ext, ldr)
        Nya.log.info "Registered loader #{ldr.class.name} for extension #{ext.upcase}", "Loader"
        @@loaders[ext.downcase] = ldr
      end

      def self.exists_for?(extname : String)
        extname = "." + extname unless extname.starts_with? "."
        @@loaders.has_key? extname.downcase
      end

      def self.load_from(filename : String) : T?
        Nya.log.debug "Trying to load #{filename}", "Loader"
        if exists_for? File.extname(filename)
          @@loaders[File.extname(filename).downcase].load filename
        else
          Nya.log.error "Cannot find mesh loader for #{File.extname filename}", "Loader"
          nil
        end
      end
    end
  end
end
