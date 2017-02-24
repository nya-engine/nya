@[Link(ldflags: "src/ext/tinyobj.o")]
lib TinyOBJ
  fun parse_obj = tinyobj_parse_obj(attrib : AttribT*, shapes : ShapeT**, num_shapes : LibC::SizeT*, materials : MaterialT**, num_materials : LibC::SizeT*, buf : LibC::Char*, len : LibC::SizeT, flags : LibC::UInt) : LibC::Int
  struct AttribT
    num_vertices : LibC::UInt
    num_normals : LibC::UInt
    num_texcoords : LibC::UInt
    num_faces : LibC::UInt
    num_face_num_verts : LibC::UInt
    pad0 : LibC::Int
    vertices : LibC::Float*
    normals : LibC::Float*
    texcoords : LibC::Float*
    faces : VertexIndexT*
    face_num_verts : LibC::Int*
    material_ids : LibC::Int*
  end
  struct VertexIndexT
    v_idx : LibC::Int
    vt_idx : LibC::Int
    vn_idx : LibC::Int
  end
  struct ShapeT
    name : LibC::Char*
    face_offset : LibC::UInt
    length : LibC::UInt
  end
  struct MaterialT
    name : LibC::Char*
    ambient : LibC::Float[3]
    diffuse : LibC::Float[3]
    specular : LibC::Float[3]
    transmittance : LibC::Float[3]
    emission : LibC::Float[3]
    shininess : LibC::Float
    ior : LibC::Float
    dissolve : LibC::Float
    illum : LibC::Int
    pad0 : LibC::Int
    ambient_texname : LibC::Char*
    diffuse_texname : LibC::Char*
    specular_texname : LibC::Char*
    specular_highlight_texname : LibC::Char*
    bump_texname : LibC::Char*
    displacement_texname : LibC::Char*
    alpha_texname : LibC::Char*
  end
  fun attrib_init = tinyobj_attrib_init(attrib : AttribT*)
  fun attrib_free = tinyobj_attrib_free(attrib : AttribT*)
  fun shapes_free = tinyobj_shapes_free(shapes : ShapeT*, num_shapes : LibC::SizeT)
  fun materials_free = tinyobj_materials_free(materials : MaterialT*, num_materials : LibC::SizeT)
end
