require "stumpy_loader"
require "./nya/*"

macro nya_versions(const)
  {% if const.is_a? Path %}
    {% const = const.resolve %}
  {% end %}
  {% if const.type_vars.empty? %}
    {% if const.has_constant? "VERSION" %}
      {% if const.name.stringify =~ /Lib(GL|AL|GLU)/ %}
        %ptr = {{const}}.get_string({{const}}::VERSION).as(Pointer(UInt8))
        %version = (%ptr.null? ? "ersion unknown" : String.new(%ptr))
      {% else %}
        %version = {{const}}::VERSION
      {% end %}
      ::Nya.log.info "Using {{const.name}} v#{%version}", "Nya"
    {% end %}
    {% for cst in const.constants %}
      {% if cst.is_a? TypeNode %}
		    nya_versions {{const}}::{{cst.id}}
      {% end %}
    {% end %}
  {% end %}
end

macro nya_versions
  {% for cst in @type.constants %}
    {% if @type.constant(cst).is_a? TypeNode %}
		nya_versions {{cst}}
    {% end %}
  {% end %}
end

def print_versions!
  nya_versions
end

stumpy_load!
