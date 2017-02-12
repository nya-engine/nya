require "xml"

module Nya
  module Serializable
    alias Node = XML::Node
    alias Builder = XML::Builder
    @@children = Hash(String, Proc(Node, Serializable)).new

    macro serializable(name, type)
      %xpath = "property[@name='{{name}}']"
      @@deserialize[:{{name.id}}] = ->(s : self, xml : XML::Node) do
        {% if [Float, Bool, Node].any?{|elem| type.resolve <= elem} %}
          s.{{name.id}} = xml.xpath_{{type.resolve.name.downcase}}(%xpath)
        {% elsif type.resolve <= String %}
          n = xml.xpath(%xpath)
        	if n.is_a? XML::NodeSet
            s.{{name.id}} = n.first.content
          else
            s.{{name.id}} = n.to_s
          end
        {% elsif type.resolve <= ::Nya::Serializable %}
          n = xml.xpath_node(%xpath)

      	  unless n.nil?
            s.{{name.id}} = {{type}}.deserialize(n.not_nil!).as({{type}})
      	  end
        {%else%}
          s.{{name.id}} = xml.xpath(%xpath).as({{type}})
        {% end %}
        nil
      end

      @@serialize[:{{name.id}}] = ->(s : self, b : XML::Builder) do
        b.element("property", name: {{name.stringify}}) do
          {% if type.resolve <= ::Nya::Serializable %}
            s.as(self).{{name.id}}.serialize_part(b)
          {%else%}
            b.text s.as(self).{{name.id}}.to_s
          {%end%}
        end
  		  nil
      end

    end

    macro serializable_array(name, type)
      @@deserialize[:{{name.id}}] = ->(s : self, xml : XML::Node) do
        node = xml.xpath_node("property[@name='{{name}}']")
  		  unless node.nil?
          node.not_nil!.children.each do |ch|
            {% if type.resolve <= ::Nya::Serializable %}
              s.{{name.id}} << ::Nya::Serializable.deserialize(ch).as({{type}})
            {% elsif type.resolve <= String %}
              s.{{name.id}} << ch.content
            {% else %}
    		      s.{{name.id}} << {{type}}.new(ch.content)
            {% end %}
          end
        end
		    nil
      end

      @@serialize[:{{name.id}}] = ->(s : self, xml : XML::Builder) do
        xml.element("property", name: "{{name}}") do
  		      s.{{name.id}}.each do |elem|
              if elem.responds_to? :serialize_part
                elem.serialize_part(xml)
              else
                xml.element("item"){ xml.text elem.to_s }
              end
            end
        end
		    nil
      end
    end

    macro included
      ::Nya::Serializable.children["{{@type.name.id}}"] = ->(s : XML::Node) do
        {{@type.name.id}}.deserialize s
      end


      @@deserialize = Hash(Symbol, Proc(self, XML::Node, Void?)).new
      @@serialize = Hash(Symbol, Proc(self, XML::Builder, Void?)).new

      def self.deserialize(n)
        ::Nya::Serializable.deserialize(
          n.first_element_child.not_nil!,
          self.class,
          new,
          @@deserialize
        )
      end

      def self.deserialize(str : String)
        deserialize XML.parse(str)
      end
    end

    def serialize_part(xml : Builder)
      xml.element(self.class.name.to_s) do
        @@serialize.each_value &.call(self, xml)
      end
    end

    def serialize(io : IO)
      XML.build(io, indent: "\t") do |xml|
        serialize_part xml
      end
    end

    def serialize
	    XML.build(indent: "\t") do |xml|
		    serialize_part xml
      end
	  end

    def self.children; @@children end

    def self.deserialize(node : Node, tp = nil, initial = nil, ds = nil)
      if tp.nil?
        name = node.first_element_child.not_nil!.name
        if Serializable.children.has_key? name
          Serializable.children[name].call(node)
        else
          raise "#{name} is not Serializable"
        end
      else
		    raise "Cannot deserialize #{tp.name}" if initial.nil?
		    s = initial
        ds.not_nil!.each do |k, v|
          v.call(s, node)
        end
		    s
      end
    end

    def self.deserialize(str : String)
      deserialize XML.parse(str)
    end
  end
end
