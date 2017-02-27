require "xml"
require "../log"

module Nya
  module Serializable
    include Nya::Log
    alias Node = XML::Node
    alias Builder = XML::Builder
    @@children = Hash(String, Proc(Node, Serializable)).new

    def box
      Box(self).box(self)
    end

    macro also_known_as(name)
      ::Nya::Serializable.children[{{name.stringify}}] = ::Nya::Serializable.children[{{@type.name.stringify}}.gsub(/::/,"_")]
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

          {% if @type.superclass < ::Nya::Serializable %}
            super xml
          {% end %}
          {% begin %}
            {{@type}}.deserialize_{{@type.name.gsub(/::/,"_").id}}.each &.call(self, xml)
          {% end %}
          self
        end

        def serialize_inner(xml : XML::Builder)
          super xml
          {{@type}}.serialize_{{@type.name.gsub(/::/,"_").id}}.each &.call(self, xml)
        end

      {% end %}

    end

    macro serializable(*names, as type)
      register
      {% for name in names %}
        @@deserialize_{{@type.name.gsub(/::/,"_").id}} << ->(s : self, xml : XML::Node) do
          Nya.log.debug "Deserializing {{name}} ({{@type.name}})", "XML"
          {% if type.resolve <= String %}

            n = xml.xpath("property[@name='{{name}}']")
            if n.is_a? XML::NodeSet

              s.{{name.id}} = n[0].content
            else
              s.{{name.id}} = n.to_s
            end
          {% elsif type.resolve <= ::Nya::Serializable %}
            n = xml.xpath_node("property[@name='{{name}}']")

            if n.nil?
              Nya.log.warn "Cannot deserialize node {{name}}", "XML"
            else
              obj = ::Nya::Serializable.deserialize(n.first_element_child.not_nil!)
              unless obj.nil?
                s.{{name.id}} = obj.as({{type}})
              end
            end
          {% elsif type.resolve <= Bool %}
            obj = xml.xpath("property[@name='{{name}}']")
            ns.obj.as?(XML::NodeSet)

            if ns.nil?
              Nya.log.warn "Cannot deserialize {{name}} as it doesnt exist", "XML"
            else
              str = ns.first.content
              case str
              when "true" || "1" || "yes"
                s.{{name.id}} = true
              when "false" || "0" || "no"
                s.{{name.id}} = false
              else
                Nya.log.warn "Invalid value for {{name}} : #{str}", "XML"
              end

            end

          {% else %}
            #s.{{name.id}} = {{type}}.new xml.xpath(%xpath).to_s
            obj = xml.xpath("property[@name='{{name}}']")
            ns = obj.as?(XML::NodeSet)
            if ns.nil? || ns.empty?
              Nya.log.warn "Cannot deserialize {{name}} as it doesnt exist", "XML"
            else
              {% if type.resolve <= Enum %}
                s.{{name.id}} = {{type}}.from_value ns.first.content
              {% else %}
                s.{{name.id}} = {{type}}.new ns.first.content
              {% end %}
            end

          {% end %}
          nil
        end

        @@serialize_{{@type.name.gsub(/::/,"_").id}} << ->(s : self, b : XML::Builder) do
          Nya.log.debug "Serializing {{name}} ({{@type.name}})", "XML"
          b.element("property", name: {{name.stringify}}) do
            {% if type.resolve <= ::Nya::Serializable %}
              s.as(self).{{name.id}}.serialize_part(b)
            {%else%}
              b.text s.as(self).{{name.id}}.to_s
            {%end%}
          end
          nil
        end
      {% end %}
    end

    macro serializable_array(*names, of type)
      register
      {%for name in names %}
        @@deserialize_{{@type.name.gsub(/::/,"_").id}} << ->(s : self, xml : XML::Node) do
          Nya.log.debug "Deserializing [{{name}}] ({{@type.name}})", "XML"
          node = xml.xpath_node("property[@name='{{name}}']")
          unless node.nil?
            Nya.log.debug "Found #{node.not_nil!.children.size} children", "XML"
            node.not_nil!.children.each do |ch|
              next if ch.name == "text"
              {% if type.resolve <= ::Nya::Serializable %}
                obj = ::Nya::Serializable.deserialize(ch).as({{type}})
                if obj.nil?
                  Nya.log.warn "Cannot deserialize item (#{ch})", "XML"
                else
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
      {% end %}
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
          obj = xml[{{name.stringify}}]?
          if obj.nil?
            s.{{name.id}} = nil
          else
            s.{{name.id}} = {{tp}}.new(obj.to_s)
          end
        {% elsif tp.resolve <= Bool %}
          str = xml[{{name.stringify}}]?.to_s
          case str
          when "true" || "1" || "yes"
            s.{{name.id}} = true
          when "false" || "0" || "no"
            s.{{name.id}} = false
          else
            Nya.log.warn "Invalid value for {{name}} : #{str}", "XML"
          end
        {% else %}
          s.{{name.id}} = {{tp}}.new(xml[{{name.stringify}}]{%if nl%}?{%end%}.to_s)
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
                {% elsif type.resolve.methods.any?{|x| x.name == "serialize_part"}%}
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
        self
      end

      def self.deserialize(n : XML::Node)
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
        nc = node
        name = node.name
        if name == "text"
          raise node.parent.to_s
        end
        if Serializable.children.has_key? name
          Serializable.children[name].call(nc)
        elsif name == "property"
          deserialize node.first_element_child.not_nil!
        else
          puts Serializable.children.keys.join("\n")
          raise "#{name} is not Serializable (#{nc.class} : #{nc}) "
        end
    end

    def self.deserialize(str : String)
      deserialize XML.parse(str).first_element_child.not_nil!
    end
  end
end
