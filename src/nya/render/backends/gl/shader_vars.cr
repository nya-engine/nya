module Nya::Render::Backends::GL::ShaderVars
  def apply_shader_var(prog : ShaderProgram, name : String, obj)
    raise "Passing #{obj.class.name} to shaders is not implemented"
  end
end
