require "./spec_helper"

TARGET_XML = <<-XML
<?xml version="1.0"?>
<Prop>
  <property name="someprop">
    <SomeProp>
      <property name="x">hehe</property>
      <property name="foo">
        <Foo>
          <property name="bar">KEK</property>
        </Foo>
      </property>
      <property name="y">
        <item>a</item>
        <item>b</item>
      </property>
    </SomeProp>
  </property>
</Prop>
XML

describe Nya::Serializable do
  it "serializes objects" do
    prop = Prop.new
    prop.someprop.foo.bar = "KEK"
    prop.serialize.gsub(/[\t\n\s]/,"").should eq(TARGET_XML.gsub(/[\t\n\s]/,""))
  end

  it "deserializes objects" do
    prop = Nya::Serializable.deserialize(TARGET_XML).as(Prop)
    prop.someprop.foo.bar.should eq("KEK")
  end
end
