require "xml"

module Nya
  module Serializable
    alias Node = XML::Node
    alias Builder = XML::Builder
    @@children = Hash(String, Proc(Node, Serializable)).new

    def box
      Box(self).box(self)
    end

    macro register
      {% unless @type.has_constant?("NYA_REGISTERED") %}
        ::Nya::Serializable.children[{{@type.name.stringify}}.gsub(/::/,"_")] = ->(s : XML::Node) do
          {{@type.name.id}}.deserialize(s).not_nil!.as(::Nya::Serializable)
        end

        @@deserialize_{{@type.name.gsub(/::/,"_").id}} = Array(Proc(self, XML::Node, Void?)).new
        @@serialize_{{@type.name.gsub(/::/,"_").id}} = Array(Proc(self, XML::Builder, Void?)).new

        def self.serialize_{{@type.name.gsub(/::/,"_").id}}
          @@serialize_{{@type.name.gsub(/::/,"_").id}}
        end

        def self.deserialize_{{@type.name.gsub(/::/,"_").id}}
          @@deserialize_{{@type.name.gsub(/::/,"_").id}}
        end
        NYA_REGISTERED = true

        def deserialize(xml : XML::Node)
          #puts "D :; {{@type}}"
          {% if @type.superclass < ::Nya::Serializable %}
            super xml
            #puts "SUPER"
          {% end %}
          {% begin %}
            #puts "@@deserialize_{{@type.name.gsub(/::/,"_").id}}"
            {{@type}}.deserialize_{{@type.name.gsub(/::/,"_").id}}.each &.call(self, xml)
          {% end %}
          self
        end

        def serialize_inner(xml : XML::Builder)
          #puts "S {{@type}}"
          super xml
          #puts "S {{@type}}  : #{@@serialize_{{@type.name.gsub(/::/,"_").id}}.size}"
          {{@type}}.serialize_{{@type.name.gsub(/::/,"_").id}}.each &.call(self, xml)
        end
      {% end %}
    end

    macro serializable(*names, as tp)

      {% for name in names %}
        _serializable {{name}}, as: {{tp}}
      {% end %}
    end

    macro serializable_array(*names, of tp)
      {%for name in names %}
        _serializable_array {{name}}, of: {{tp}}
      {%end%}
    end

    macro _serializable(name, as type)
      register

      %xpath = "property[@name='{{name}}']"
      @@deserialize_{{@type.name.gsub(/::/,"_").id}} << ->(s : self, xml : XML::Node) do
        #puts "& {{name}}"
        {% if [Float, Bool, Node].any?{|elem| type.resolve <= elem} %}
          s.{{name.id}} = xml.xpath_{{type.resolve.name.downcase}}(%xpath)
        {% elsif type.resolve <= String %}
          #puts "STR"
          n = xml.xpath(%xpath)
        	if n.is_a? XML::NodeSet
            #puts "NODESET #{xml}"
            s.{{name.id}} = n[0].content
          else
            s.{{name.id}} = n.to_s
          end
        {% elsif type.resolve <= ::Nya::Serializable %}
          n = xml.xpath_node(%xpath)

      	  if n.nil?
            #puts "Node is nil! #{xml}"
          else
            obj = ::Nya::Serializable.deserialize(n.first_element_child.not_nil!)
            unless obj.nil?
              s.{{name.id}} = obj.as({{type}})
            end
      	  end
        {%else%}
          s.{{name.id}} = {{type}}.new xml.xpath(%xpath).to_s
        {% end %}
        nil
      end

      @@serialize_{{@type.name.gsub(/::/,"_").id}} << ->(s : self, b : XML::Builder) do
        #puts "SERIALIZE {{@type}}\# {{name}}"
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

    macro _serializable_array(name, of type)
      register
      @@deserialize_{{@type.name.gsub(/::/,"_").id}} << ->(s : self, xml : XML::Node) do
        node = xml.xpath_node("property[@name='{{name}}']")
  		  unless node.nil?
          node.not_nil!.children.each do |ch|
            next if ch.name == "text"
            {% if type.resolve <= ::Nya::Serializable %}
              obj = ::Nya::Serializable.deserialize(ch).as({{type}}?)
              unless obj.nil?
                s.{{name.id}} << obj.not_nil!
              end
            {% elsif type.resolve <= String %}
              s.{{name.id}} << ch.content
            {% else %}
    		      s.{{name.id}} << {{type}}.new(ch.content)
            {% end %}
          end
        end
		    nil
      end

      @@serialize_{{@type.name.gsub(/::/,"_").id}} << ->(s : self, xml : XML::Builder) do
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

    macro attribute(name, as tp, nilable nl)
      register
	    @@serialize_{{@type.name.gsub(/::/,"_").id}} << ->(s : self, xml : XML::Builder) do
        xml.attribute({{name.stringify}}, s.{{name.id}})
	    end

      @@deserialize_{{@type.name.gsub(/::/,"_").id}} << ->(s : self, xml : XML::Node) do
        {% if tp.resolve <= String %}
          s.{{name.id}} = xml[{{name.stringify}}]{%if nl%}?{%end%}.to_s
        {% elsif nl %}
          obj = xml[{{name.stringify}}]
          if obj.nil?
            s.{{name.id}} = nil
          else
            s.{{name.id}} = {{tp}}.new(obj.to_s)
          end
        {% else %}
          s.{{name.id}} = {{tp}}.new(xml[{{name.stringify}}].to_s)
        {% end %}
      end
    end

    macro serializable_hash(*names, of type)
      {% for name in names %}
        @@deserialize_{{@type.name.gsub(/::/,"_").id}} << ->(s : self, xml : XML::Node) do
          node = xml.xpath_node("property[@name='{{name}}']")
          unless node.nil?
            node.xpath_nodes("item").each do |pair|
              {% if type.resolve <= String %}
                s.{{name.id}}[pair["key"]] = pair.content
              {% elsif type.resolve <= ::Nya::Serializable %}
                s.{{name.id}}[pair["key"]] = {{type}}.deserialize(pair.children.first)
              {% else %}
                s.{{name.id}}[pair["key"]] = {{type}}.new(pair.content)
              {% end %}
            end
          end
          nil
        end

        @@serialize_{{@type.name.gsub(/::/,"_").id}} << ->(s : self, xml : XML::Builder) do
          xml.element "property", name: {{name.stringify}} do
            s.{{name}}.each do |k,v|
              xml.element "item", key: k do
                {% if type.resolve <= String %}
                  xml.text v
                {% elsif type.resolve.has_method("serialize_part") %}
                  v.serialize_part xml
                {% else %}
                  xml.text v.to_s
                {% end %}
              end
            end
          end
          nil
        end
      {% end %}
    end

    macro included

      def deserialize(n : XML::Node)
        #puts "D:: {{@type}} "
        self
      end

      def self.deserialize(n : XML::Node)
        #puts "[[[[[[[[[[#{n}]]]]]]]]]]"
        new.deserialize n
      end

      def self.deserialize(str : String)
        deserialize XML.parse(str)
      end
    end

    def super_inst
      {{@type.superclass}}.new
    end

    def serialize_inner(xml); end

    def serialize_part(xml : Builder)
      xml.element(self.class.name.to_s.gsub(/::/,"_")) do
        serialize_inner xml
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

    def self.deserialize(node : Node)
        #puts "D<#{node.name}>"
        #nc = node.first_element_child
        ##puts "D[#{nc}]"
        #if nc.nil?
        #  nc = node
        #  raise "Node is nil : #{node}"
        #end
        ##puts "N #{node.name}"
        #if nc.not_nil!.name == "property"
        #  nc = nc.not_nil!.children.first
        #  #puts "NC : #{nc.to_s} "
        #end
        nc = node
        name = node.name
        if name == "text"
          raise name
        end

        if Serializable.children.has_key? name
          ##puts "D(#{name})"
          Serializable.children[name].call(nc)
        else
          raise "#{name} is not Serializable (#{nc.class} : #{nc}) "
        end
    end

    def self.deserialize(str : String)
      deserialize XML.parse(str).first_element_child.not_nil!
    end
  end
end
