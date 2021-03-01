module Nya::Render::Backends::GL::ShaderVars

  @max_textures : Int32 = 0

  def apply_shader_vars(prog : ShaderProgram)
    current_texture = 0

    pid = prog.metadata.as(Metadata).id

    prog.vars.each do |var|

      unless var.metadata.is_a? LocationMetadata
          var.metadata = LocationMetadata.new LibGL.get_uniform_location pid, var.name
      end

      location = var.metadata.as(LocationMetadata).location

      if var.is_a? Sampler
        if current_texture >= @max_textures
          raise "Exceeded maximum number of textures (#{var.name} #{@max_textures})"
        end
        LibGL.active_texture LibGL::TEXTURE0 + current_texture

        is_valid_metadata = var.texture.metadata?.is_a? Metadata && var.texture.metadata?.as(Metadata).object_type == :texture

        unless is_valid_metadata
          var.texture.prepare_metadata!
        end
        LibGL.bind_texture LibGL::TEXTURE_2D, var.texture.metadata?.as(Metadata).id
        LibGL.uniform1i location, current_texture

        current_texture += 1
      else
        raise "Cannot apply #{var.name}"
      end
    end
  end
end
