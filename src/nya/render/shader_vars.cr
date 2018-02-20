require "nya_serializable"
require "stumpy_loader"

# <editor-fold> Status
# [x] bool
# [x] int
# [x] float
# [x] vec2
# [x] vec3
# [x] vec4
# [ ] bvec2
# [ ] bvec3
# [ ] bvec4
# [ ] ivec2
# [ ] ivec3
# [ ] ivec4
# [ ] mat2
# [ ] mat3
# [ ] mat4
# [ ] sampler1D, sampler2D, sampler3D, samplerCube, ...
# </editor-fold>

module Nya::Render
  module ShaderVars
    # <editor-fold> Base classes

    # Abstract shader variable class
    abstract class AbsVar

      # Applies variable to a shader program
      abstract def apply(program : UInt32, name : String) : Void

      # :nodoc:
      macro apply_value(p, n, fsign, *v)
        case self.kind
        when "uniform"
          LibGL.uniform{{fsign.id}}(LibGL.get_uniform_location({{p}}, {{n}}), {{*v}})
        when "attibute"
          LibGL.vertex_attrib{{fsign.id}}(LibGL.get_attrib_location({{p}}, {{n}}), {{*v}})
        else
          Nya.log.error "Cannot apply {{@type}} : Invalid kind : #{self.kind}", "Shader"
        end
      end
    end

    # Base class for variables. Needed for Serializable to work
    class Var < AbsVar
      include Serializable
      property kind : String = "uniform"
      attribute kind : String

      def apply(p, n)
      end
    end

    # </editor-fold>

    # <editor-fold> Primitives

    # Boolean value (also has an alias `glsl_bool`)
    class Bool < Var
      property value = false
      attribute value : Bool
      also_known_as glsl_bool

      def apply(p, n)
        val = @value ? 1 : 0
        apply_value p, n, "1i", val
      end
    end

    # 32bit integer value (also has an alias `glsl_int`)
    class Int < Var
      property value : Int32 = 0
      attribute value : Int32
      also_known_as glsl_int

      def apply(p, n)
        apply_value p, n, "1i", @value
      end
    end

    # 32bot floating point value (also has an alias `glsl_float`)
    class Float < Var
      property value : Float32 = 0f32
      attribute value : Float32
      also_known_as glsl_float

      def apply(p, n)
        apply_value p, n, "1f", @value
      end
    end

    # </editor-fold>

    # <editor-fold> FP vectors

    class Vec2 < Var
      property x = 0f32
      property y = 0f32
      attribute x : Float32, y : Float32
      also_known_as glsl_v2

      def apply(p, n)
        apply_value p, n, "2f", @x, @y
      end
    end

    class Vec3 < Vec2
      property z = 0f32
      attribute z : Float32
      also_known_as glsl_v3

      def apply(p, n)
        apply_value p, n, "3f", self.x, self.y, @z
      end
    end

    class Vec4 < Vec3
      property w = 0f32
      attribute w : Float32
      also_known_as glsl_v4

      def apply(p, n)
        apply_value p, n, "4f", self.z, self.y, self.z, @w
      end
    end
    # </editor-fold>

    # <editor-fold> Samplers
    class Sampler < Var
      attribute src : String
      property src = ""
      property tex_id = 0u32
    end

    {% for d in (1..3) %}
      class Sampler{{d}}D < Sampler
        register
        also_known_as :glsl_sampler{{d}}d

        def src=(x)
          @tex_id = DrawUtils.load_texture src, LibGL::TEXTURE_{{d}}D
        end

        def apply(p, n)
          apply_value p, n, "1i", @tex_id
        end
      end
    {% end %}
    # </editor-fold>

    {% for size in (3..4) %}
      class Matrix{{size}} < Var
        register
        also_known_as :glsl_mat{{size}}
        property inner = StaticArray(Float64, {{size**2}}).new(0.0)

        serializable inner : StaticArray(Float64, {{size**2}})

        macro apply_matrix(p, n, s, *v)
          case self.kind
          when "uniform"
            LibGL.uniform_matrix\{{s.id}}(LibGL.get_uniform_location(\{{p}}, \{{n}}), 1, false, \{{*v}})
          else
            Nya.log.error "Cannot apply {{@type}} : Invalid kind : #{self.kind}", "Shader"
          end
        end

        def apply(p, n)
          value = inner.map(&.to_f32)
          apply_matrix p, n, "{{size}}fv", value
        end
      end
    {% end %}
  end
end
