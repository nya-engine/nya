require "../storage/serialization"

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
    abstract class AbsVar
      abstract def apply(program : UInt32, name : String) : Void

      macro apply_value(p,n,fsign,*v)
        case self.kind
        when "uniform"
          GL.uniform{{fsign.id}}(GL.get_uniform_location({{p}}, {{n}}), {{*v}})
        when "attibute"
          GL.vertex_attrib{{fsign.id}}(GL.get_attrib_location({{p}}, {{n}}), {{*v}})
        else
          Nya.log.error "Cannot apply {{@type}} : Invalid kind : #{self.kind}", "Shader"
        end
      end
    end

    class Var < AbsVar
      include Serializable
      property kind : String = "uniform"
      attribute kind, as: String, nilable: true
      def apply(p, n)
      end
    end
    # </editor-fold>

    # <editor-fold> Primitives
    class Bool < Var
      property value : String = ""
      attribute value, as: String, nilable: true
      also_known_as "glsl_bool"
      def apply(p, n)
        value = case @value
        when "yes" || "true" || "1"
          1
        else
          0
        end

        apply_value p, n, "1i", value
      end
    end

    class Int < Var
      property value : Int32 = 0
      attribute value, as: Int32, nilable: false
      also_known_as "glsl_int"

      def apply(p, n)
        apply_value p, n, "1i", @value
      end
    end

    class Float < Var
      property value : Float32 = 0f32
      attribute value, as: Float32, nilable: false
      also_known_as "glsl_float"

      def apply(p, n)
        apply_value p, n, "1f", @value
      end
    end

    # </editor-fold>

    # <editor-fold> FP vectors
    class Vec2 < Var
      property x = 0f32
      property y = 0f32
      attribute x, as: Float32, nilable: false
      attribute y, as: Float32, nilable: false
      also_known_as "glsl_v2"

      def apply(p, n)
        apply_value p, n, "2f", @x, @y
      end
    end

    class Vec3 < Vec2
      property z = 0f32
      attribute z, as: Float32, nilable: false
      also_known_as "glsl_v3"

      def apply(p, n)
        apply_value p, n, "3f", self.x, self.y, @z
      end
    end

    class Vec4 < Vec3
      property w = 0f32
      attribute z, as: Float32, nilable: false
      also_known_as "glsl_v4"

      def apply(p, n)
        apply_value p, n, "4f", self.z, self.y, self.z, @w
      end
    end
    # </editor-fold>

  end
end
