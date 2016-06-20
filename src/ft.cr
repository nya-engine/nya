@[Link("freetype")]
lib FT
  OPEN_MEMORY = 0x1
  OPEN_STREAM = 0x2
  OPEN_PATHNAME = 0x4
  OPEN_DRIVER = 0x8
  OPEN_PARAMS = 0x10
  LOAD_DEFAULT = 0x0
  LOAD_RENDER = 0x4
  SUBGLYPH_FLAG_ARGS_ARE_WORDS = 1
  SUBGLYPH_FLAG_ARGS_ARE_XY_VALUES = 2
  SUBGLYPH_FLAG_ROUND_XY_TO_GRID = 4
  SUBGLYPH_FLAG_SCALE = 8
  SUBGLYPH_FLAG_XY_SCALE = 0x40
  SUBGLYPH_FLAG_2X2 = 0x80
  SUBGLYPH_FLAG_USE_MY_METRICS = 0x200
  FSTYPE_INSTALLABLE_EMBEDDING = 0x0000
  FSTYPE_RESTRICTED_LICENSE_EMBEDDING = 0x0002
  FSTYPE_PREVIEW_AND_PRINT_EMBEDDING = 0x0004
  FSTYPE_EDITABLE_EMBEDDING = 0x0008
  FSTYPE_NO_SUBSETTING = 0x0100
  FSTYPE_BITMAP_EMBEDDING_ONLY = 0x0200
  FREETYPE_MAJOR = 2
  FREETYPE_MINOR = 5
  FREETYPE_PATCH = 2
  enum Encoding
    ENCODINGNONE = 0
    ENCODINGMSSYMBOL = 1
    ENCODINGUNICODE = 2
    ENCODINGSJIS = 3
    ENCODINGGB2312 = 4
    ENCODINGBIG5 = 5
    ENCODINGWANSUNG = 6
    ENCODINGJOHAB = 7
    ENCODINGADOBESTANDARD = 8
    ENCODINGADOBEEXPERT = 9
    ENCODINGADOBECUSTOM = 10
    ENCODINGADOBELATIN1 = 11
    ENCODINGOLDLATIN2 = 12
    ENCODINGAPPLEROMAN = 13
  end

  enum SizeRequestType
    SIZEREQUESTTYPENOMINAL = 0
    SIZEREQUESTTYPEREALDIM = 1
    SIZEREQUESTTYPEBBOX = 2
    SIZEREQUESTTYPECELL = 3
    SIZEREQUESTTYPESCALES = 4
    SIZEREQUESTTYPEMAX = 5
  end

  enum RenderMode
    RENDERMODENORMAL = 0
    RENDERMODELIGHT = 1
    RENDERMODEMONO = 2
    RENDERMODELCD = 3
    RENDERMODELCDV = 4
    RENDERMODEMAX = 5
  end

  enum KerningMode
    KERNINGDEFAULT = 0
    KERNINGUNFITTED = 1
    KERNINGUNSCALED = 2
  end

  alias LibraryRec = UInt64

  alias ModuleRec = Void

  alias DriverRec = Void

  alias RendererRec = Void

  alias FaceInternalRec = Void

  alias SizeInternalRec = Void


  struct GlyphMetrics
    width: Int32
    height: Int32
    hori_bearing_x: Int32
    hori_bearing_y: Int32
    hori_advance: Int32
    vert_bearing_x: Int32
    vert_bearing_y: Int32
    vert_advance: Int32
  end

  struct BitmapSize
    height: Int16
    width: Int16
    size: Int32
    x_ppem: Int32
    y_ppem: Int32
  end



  struct CharMapRec
    face: FaceRec*
    encoding: Encoding
    platform_id: UInt16
    encoding_id: UInt16
  end

  struct FaceRec
    num_faces: Int32
    face_index: Int32
    face_flags: Int32
    style_flags: Int32
    num_glyphs: Int32
    family_name: UInt8*
    style_name: UInt8*
    num_fixed_sizes: Int16
    available_sizes: BitmapSize*
    num_charmaps: Int16
    charmaps: Void*
    generic: Int32
    bbox: Int32
    units_per_em: UInt16
    ascender: Int16
    descender: Int16
    height: Int16
    max_advance_width: Int16
    max_advance_height: Int16
    underline_position: Int16
    underline_thickness: Int16
    glyph: GlyphSlotRec*
    size: SizeRec*
    charmap: CharMapRec*
    driver: DriverRec*
    memory: Void*
    stream: Void*
    sizes_list: Int32
    autohint: Int32
    extensions: Void*
    internal: FaceInternalRec*
  end

  struct SizeMetrics
    x_ppem: UInt16
    y_ppem: UInt16
    x_scale: Int32
    y_scale: Int32
    ascender: Int32
    descender: Int32
    height: Int32
    max_advance: Int32
  end

  struct SizeRec
    face: FaceRec*
    generic: Int32
    metrics: SizeMetrics
    internal: SizeInternalRec*
  end

  alias SubGlyphRec = Void

  alias SlotInternalRec = Void

  struct Bitmap
    rows,width : UInt32
    pitch : Int32
    buffer : UInt8*
    num_grays : UInt16
    pixel_mode,palette_mode : UInt8
    palette : Void*
  end

  struct GlyphSlotRec
    library: LibraryRec*
    face: FaceRec*
    next_: GlyphSlotRec*
    reserved: UInt16
    generic: Int32
    metrics: GlyphMetrics
    linear_hori_advance: Int32
    linear_vert_advance: Int32
    advance: Int32
    format: Int32
    bitmap: Bitmap
    bitmap_left: Int16
    bitmap_top: Int16
    outline: Int32
    num_subglyphs: UInt16
    subglyphs: SubGlyphRec*
    control_data: Void*
    control_len: Int32
    lsb_delta: Int32
    rsb_delta: Int32
    other: Void*
    internal: SlotInternalRec*
  end

  struct Parameter
    tag: UInt32
    data: Void*
  end

  struct OpenArgs
    flags: UInt16
    memory_base: Void*
    memory_size: Int32
    pathname: UInt8*
    stream: Void*
    driver: ModuleRec*
    num_params: Int16
    params: Parameter*
  end

  struct SizeRequestRec
    type: SizeRequestType
    width: Int32
    height: Int32
    hori_resolution: UInt16
    vert_resolution: UInt16
  end

  fun init_free_type = "FT_Init_FreeType"(alibrary : Void*) : Int16
  fun done_free_type = "FT_Done_FreeType"(library : LibraryRec*) : Int16
  fun new_face = "FT_New_Face"(library : LibraryRec*, filepathname : UInt8*, face_index : Int32, aface : Void*) : Int16
  fun new_memory_face = "FT_New_Memory_Face"(library : LibraryRec*, file_base : Void*, file_size : Int32, face_index : Int32, aface : Void*) : Int16
  fun open_face = "FT_Open_Face"(library : LibraryRec*, args : OpenArgs*, face_index : Int32, aface : Void*) : Int16
  fun attach_file = "FT_Attach_File"(face : FaceRec*, filepathname : UInt8*) : Int16
  fun attach_stream = "FT_Attach_Stream"(face : FaceRec*, parameters : OpenArgs*) : Int16
  fun reference_face = "FT_Reference_Face"(face : FaceRec*) : Int16
  fun done_face = "FT_Done_Face"(face : FaceRec*) : Int16
  fun select_size = "FT_Select_Size"(face : FaceRec*, strike_index : Int16) : Int16
  fun request_size = "FT_Request_Size"(face : FaceRec*, req : SizeRequestRec*) : Int16
  fun set_char_size = "FT_Set_Char_Size"(face : FaceRec*, char_width : Int32, char_height : Int32, horz_resolution : UInt16, vert_resolution : UInt16) : Int16
  fun set_pixel_sizes = "FT_Set_Pixel_Sizes"(face : FaceRec*, pixel_width : UInt16, pixel_height : UInt16) : Int16
  fun load_glyph = "FT_Load_Glyph"(face : FaceRec*, glyph_index : UInt16, load_flags : Int16) : Int16
  fun load_char = "FT_Load_Char"(face : FaceRec*, char_code : UInt32, load_flags : Int16) : Int16
  fun set_transform = "FT_Set_Transform"(face : FaceRec*, matrix : Void*, delta : Void*) : Void
  fun render_glyph = "FT_Render_Glyph"(slot : GlyphSlotRec*, render_mode : RenderMode) : Int16
  fun get_kerning = "FT_Get_Kerning"(face : FaceRec*, left_glyph : UInt16, right_glyph : UInt16, kern_mode : UInt16, akerning : Void*) : Int16
  fun get_track_kerning = "FT_Get_Track_Kerning"(face : FaceRec*, point_size : Int32, degree : Int16, akerning : Void*) : Int16
  fun get_glyph_name = "FT_Get_Glyph_Name"(face : FaceRec*, glyph_index : UInt16, buffer : Void*, buffer_max : UInt16) : Int16
  fun get_postscript_name = "FT_Get_Postscript_Name"(face : FaceRec*) : UInt8*
  fun select_charmap = "FT_Select_Charmap"(face : FaceRec*, encoding : Encoding) : Int16
  fun set_charmap = "FT_Set_Charmap"(face : FaceRec*, charmap : CharMapRec*) : Int16
  fun get_charmap_index = "FT_Get_Charmap_Index"(charmap : CharMapRec*) : Int16
  fun get_char_index = "FT_Get_Char_Index"(face : FaceRec*, charcode : UInt32) : UInt16
  fun get_first_char = "FT_Get_First_Char"(face : FaceRec*, agindex : Void*) : UInt32
  fun get_next_char = "FT_Get_Next_Char"(face : FaceRec*, char_code : UInt32, agindex : Void*) : UInt32
  fun get_name_index = "FT_Get_Name_Index"(face : FaceRec*, glyph_name : UInt8*) : UInt16
  fun get_sub_glyph_info = "FT_Get_SubGlyph_Info"(glyph : GlyphSlotRec*, sub_index : UInt16, p_index : Void*, p_flags : Void*, p_arg1 : Void*, p_arg2 : Void*, p_transform : Void*) : Int16
  fun get_fs_type_flags = "FT_Get_FSType_Flags"(face : FaceRec*) : UInt16
  fun face_get_char_variant_index = "FT_Face_GetCharVariantIndex"(face : FaceRec*, charcode : UInt32, variant_selector : UInt32) : UInt16
  fun face_get_char_variant_is_default = "FT_Face_GetCharVariantIsDefault"(face : FaceRec*, charcode : UInt32, variant_selector : UInt32) : Int16
  fun face_get_variant_selectors = "FT_Face_GetVariantSelectors"() : Void*
  fun face_get_variants_of_char = "FT_Face_GetVariantsOfChar"() : Void*
  fun face_get_chars_of_variant = "FT_Face_GetCharsOfVariant"() : Void*
  fun mul_div = "FT_MulDiv"(a : Int32, b : Int32, c : Int32) : Int32
  fun div_fix = "FT_DivFix"(a : Int32, b : Int32) : Int32
  fun round_fix = "FT_RoundFix"(a : Int32) : Int32
  fun ceil_fix = "FT_CeilFix"(a : Int32) : Int32
  fun floor_fix = "FT_FloorFix"(a : Int32) : Int32
  fun vector_transform = "FT_Vector_Transform"(vec : Void*, matrix : Void*) : Void
  fun library_version = "FT_Library_Version"(library : LibraryRec*, amajor : Void*, aminor : Void*, apatch : Void*) : Void
  fun face_check_true_type_patents = "FT_Face_CheckTrueTypePatents"(face : FaceRec*) : UInt8
  fun face_set_unpatented_hinting = "FT_Face_SetUnpatentedHinting"(face : FaceRec*, value : UInt8) : UInt8
end
