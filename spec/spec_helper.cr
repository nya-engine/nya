require "spec"
require "../src/nya/log"

{% unless flag? :nya_debug %}
	tfile = Tempfile.new("nya_log")
	Nya.log = Logger.new(tfile)

	puts "Nya engine log is saved to #{tfile.path}"
{% end %}
require "../src/nya"
require "../src/nya/render/backends/gl/glsl_compiler"


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
