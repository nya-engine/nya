require "./spec_helper"

describe Nya::Render::ShaderCompiler do
  it "detects shader type" do
    Nya::Render::ShaderCompiler.detect_type("\n\n//@type geome\n\n").should eq(Nya::Render::ShaderType::Geometry)
  end

  it "detects shader type by filename extension" do
    Nya::Render::ShaderCompiler.detect_type("kekekekekekekekekek", "shader.vert").should eq(Nya::Render::ShaderType::Vertex)
    Nya::Render::ShaderCompiler.detect_type("kekus", "shader.frag").should eq(Nya::Render::ShaderType::Fragment)
  end

  it "prefers type detected by directives over extension" do
    Nya::Render::ShaderCompiler.detect_type("//@type vertex", "shader.frag").should eq(Nya::Render::ShaderType::Vertex)
    Nya::Render::ShaderCompiler.detect_type("//@type tess_control", "shader.geom").should eq(Nya::Render::ShaderType::TessControl)
  end
end

describe Nya::GameObject do
  it "finds components" do
    obj = Nya::GameObject.new
    obj.components << SampleComponent.new
    obj.find_component_of(SampleComponent).foo.should eq(:foo)
    obj.find_component_of?(AnotherComponent).should eq(nil)
    obj.components[0] = AnotherComponent.new
    obj.find_component_of(SampleComponent).foo.should eq(:bar)
  end

  it "raises when there is no such component" do
    obj = Nya::GameObject.new
    obj.components << SampleComponent.new
    expect_raises Exception do
      obj.find_component_of(AnotherComponent)
    end
  end

  it "finds objects recursively" do
    obj = Nya::GameObject.new
    obj.components << SampleComponent.new
    obj.children << Nya::GameObject.new
    3.times { obj.children!.first.components << AnotherComponent.new }
    obj.find_in_children(SampleComponent).map(&.foo).should eq([:foo, :bar, :bar, :bar])
  end
end

describe Nya::Scene do
  it "finds components" do
    obj1 = Nya::GameObject.new
    obj2 = Nya::GameObject.new

    obj1.components << SampleComponent.new
    obj2.components << SampleComponent.new << AnotherComponent.new

    scene = Nya::Scene.new [obj1, obj2]

    scene.find_components_of(SampleComponent).map(&.foo).should eq([:foo, :foo, :bar])
  end
end
