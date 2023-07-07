module Nya
  abstract class AbstractLoader(T)
    abstract def load(filename : String) : T?

    macro inherited
      {% if @type.superclass.name.starts_with? "Nya::AbstractLoader" %}
        @@log : Log = Nya.log.for(self)
        @@loaders = {} of String => self

        def self.register(ext, ldr)
          @@log.info { "Registered loader #{ldr.class.name} for extension #{ext.upcase}" }
          @@loaders[ext.downcase] = ldr
        end

        def self.exists_for?(extname : String)
          extname = "." + extname unless extname.starts_with? "."
          @@loaders.has_key? extname.downcase
        end

        def self.load_from(filename : String) : T?
          @@log.debug { "Trying to load #{filename}" }
          if exists_for? File.extname(filename)
            @@loaders[File.extname(filename).downcase].load filename
          else
            @@log.error { "Cannot find mesh loader for #{File.extname filename}" }
            nil
          end
        end
      {% end %}
    end
  end
end
