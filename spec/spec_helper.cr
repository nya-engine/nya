require "spec"
require "../src/nya_engine"
require "../src/nya_engine/storage/serialization"

class Foo
	include Nya::Serializable
	property bar
	@bar = "LOL"

	serializable bar, String
end


class SomeProp
  include Nya::Serializable

	property x, y, foo
	@x = "hehe"
	@y = ["a","b"] of String
	@foo = Foo.new

	serializable x, String
	serializable foo, Foo
	serializable_array y, String
end

class Prop
	include Nya::Serializable

	property someprop : SomeProp
	@someprop = SomeProp.new
	serializable someprop, SomeProp
end
