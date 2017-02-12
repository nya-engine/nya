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
        ::Nya::Serializable.children[{{@type.name.stringify}}.gsub("::","_")] = ->(s : XML::Node) do
          {{@type.name.id}}.deserialize(s).not_nil!.as(::Nya::Serializable)
        end
        NYA_REGISTERED = true
        {{puts "Registering #{@type}"}}
      {% end %}
    end

    macro serializable(name, type)
      register
      %xpath = "property[@name='{{name}}']"
      @@deserialize << ->(_s : Pointer(Void), xml : XML::Node) do
        s = _s.as(Pointer(self)).value
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
          s.{{name.id}} = {{type}}.new xml.xpath(%xpath).to_s
        {% end %}
        nil
      end

      @@serialize << ->(_s : Pointer(Void), b : XML::Builder) do
        s = Box(self).unbox(_s)
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
      @@deserialize << ->(_s : Pointer(Void), xml : XML::Node) do
        s = Box(self).unbox(_s)
        node = xml.xpath_node("property[@name='{{name}}']")
  		  unless node.nil?
          node.not_nil!.children.each do |ch|
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
        s = Box(self).unbox(_s)
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
        xml.attribute({{name.stringify}}, Box(self).unbox(s).value.{{name.id}})
	    end

      @@deserialize << ->(_s : Pointer(Void), xml : XML::Node) do
        s = Box(self).unbox(_s)
        {% if tp.resolve <= String %}
          s.{{name.id}} = xml[{{name.stringify}}].to_s
        {%else%}
          s.{{name.id}} = {{tp}}.new(xml[{{name.stringify}}].to_s)
        {%end%}
      end
    end

    macro included


      #puts "Included into {{@type}}"

      #@@deserialize = Hash(String, Array(Proc(Void*, XML::Node, Void?))).new
      #@@serialize = Hash(String, Array(Proc(Void*, XML::Builder, Void?))).new
      @@serialize = [] of Proc(Void*, XML::Builder, Void?)
      @@deserialize = [] of Proc(Void*, XML::Node, Void?)

      def self.deserialize(n : XML::Node)
        puts "Deserializing {{@type}}"
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

    def super_inst
      {{@type.superclass}}.new
    end

    def serialize_inner(xml : Builder)
      @@serialize.each &.call(Box(self).box(self), xml)
    end

    def serialize_part(xml : Builder)
      xml.element(self.class.name.to_s.gsub("::","_")) do
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

    def self.deserialize(node : Node, tp = nil, initial = nil, ds = nil)
      if tp.nil?
        nc = node.first_element_child
        if nc.nil?
          nc = node
          puts "Node is nil : #{node}"
          return nil
        end
          name = nc.not_nil!.name
          return nil if name == "text" || name == "property"
          if Serializable.children.has_key? name
            Serializable.children[name].call(node)
          else
            raise "#{name} is not Serializable (#{nc.class} : #{nc}) "
          end
      else
		    raise "Cannot deserialize #{tp.name}" if initial.nil?
		    s = initial
        ds.not_nil!.each do |v|
          v.call(s.box, node)
        end
		    s
      end
    end

    def self.deserialize(str : String)
      deserialize XML.parse(str)
    end
  end
end
