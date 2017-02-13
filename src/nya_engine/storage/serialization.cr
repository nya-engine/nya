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

        NYA_REGISTERED = true

        def deserialize(xml : XML::Node)
          #puts "D :; {{@type}}"
          {% if @type.superclass < ::Nya::Serializable %}
            super xml
            #puts "SUPER"
          {% end %}
          {% begin %}
            #puts "@@deserialize_{{@type.name.gsub(/::/,"_").id}}"
            @@deserialize_{{@type.name.gsub(/::/,"_").id}}.each &.call(self, xml)
          {% end %}
          self
        end
      {% end %}
    end

    macro serializable(name, type)
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

      @@serialize << ->(_s : Pointer(Void), b : XML::Builder) do
        s = Box({{@type}}).unbox(_s)
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

      @@serialize << ->(_s : Pointer(Void), xml : XML::Builder) do
        s = Box({{@type}}).unbox(_s)
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

    macro attribute(name, tp)
      register
	    @@serialize << ->(s : Pointer(Void), xml : XML::Builder) do
        xml.attribute({{name.stringify}}, Box({{@type}}).unbox(s).{{name.id}})
	    end

      @@deserialize_{{@type.name.gsub(/::/,"_").id}} << ->(s : self, xml : XML::Node) do
        {% if tp.resolve <= String %}
          s.{{name.id}} = xml[{{name.stringify}}].to_s
        {%else%}
          s.{{name.id}} = {{tp}}.new(xml[{{name.stringify}}].to_s)
        {%end%}
      end
    end

    macro included


      ##puts "Included into {{@type}}"

      #@@deserialize = Hash(String, Array(Proc(Void*, XML::Node, Void?))).new
      #@@serialize = Hash(String, Array(Proc(Void*, XML::Builder, Void?))).new
      @@serialize = [] of Proc(Void*, XML::Builder, Void?)
      #@@deserialize = [] of Proc(Void*, XML::Node, Void?)

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

    def serialize_inner(xml : Builder)
      @@serialize.each &.call(Box(self).box(self), xml)
    end

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
