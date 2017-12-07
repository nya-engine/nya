require "spec"
require "../src/nya_engine/log"

{% unless flag? :nya_debug %}
	tfile = Tempfile.new("nya_log")
	Nya.log = Logger.new(tfile)

	puts "Nya engine log is saved to #{tfile.path}"
{% end %}

require "../src/nya_engine/storage/serialization"
require "../src/nya_engine"
require "../src/nya_engine/render/shader_compiler"


class Foo
	include Nya::Serializable
	property bar
	@bar = "LOL"

	serializable bar, as: String
end

class Bar < Foo
	property biz : String = "lal"
	serializable biz, as: String
end

class FooBar < Bar
	property fb : String = "kekus"
	serializable fb, as: String
end


class SomeProp
  include Nya::Serializable

	property x, y, foo, hash
	@x = "hehe"
	@y = ["a","b"] of String
	@foo = Foo.new
	@hash = Hash(String, String).new
	serializable x, as: String
	serializable foo, as: Foo
	serializable_array y, of: String
	serializable_hash hash, of: String
end

class Prop
	include Nya::Serializable

	property someprop : SomeProp
	@someprop = SomeProp.new
	serializable someprop, as: SomeProp
end

class SampleComponent < Nya::Component
	def foo
		:foo
	end
end

class AnotherComponent < SampleComponent
	def foo
		:bar
	end
end
