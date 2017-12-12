@[Link("ode")]
lib LibODE
  DOUBLE = 1
  fun printf = dprintf(__fd : LibC::Int, __fmt : LibC::Char*, ...) : LibC::Int
  fun rand48 = drand48 : LibC::Double

  struct Rand48Data
    __x : LibC::UShort[3]
    __old_x : LibC::UShort[3]
    __c : LibC::UShort
    __init : LibC::UShort
    __a : LibC::ULongLong
  end

  fun rand48_r = drand48_r(__buffer : Rand48Data*, __result : LibC::Double*) : LibC::Int
  fun rem = drem(__x : LibC::Double, __y : LibC::Double) : LibC::Double
  fun remf = dremf(__x : LibC::Float, __y : LibC::Float) : LibC::Float
  # fun reml = dreml(__x : LibC::LongDouble, __y : LibC::LongDouble) : LibC::LongDouble
  # fun set_error_handler = dSetErrorHandler(fn : (LibC::Int, LibC::Char*, VaList -> Void))
  # alias X__GnucVaList = LibC::VaList
  # alias VaList = X__GnucVaList
  # fun set_debug_handler = dSetDebugHandler(fn : (LibC::Int, LibC::Char*, VaList -> Void))
  # fun set_message_handler = dSetMessageHandler(fn : (LibC::Int, LibC::Char*, VaList -> Void))
  # fun get_error_handler = dGetErrorHandler : (LibC::Int, LibC::Char*, VaList -> Void)
  # fun get_debug_handler = dGetDebugHandler : (LibC::Int, LibC::Char*, VaList -> Void)
  # fun get_message_handler = dGetMessageHandler : (LibC::Int, LibC::Char*, VaList -> Void)
  fun error = dError(num : LibC::Int, msg : LibC::Char*, ...)
  fun debug = dDebug(num : LibC::Int, msg : LibC::Char*, ...)
  fun message = dMessage(num : LibC::Int, msg : LibC::Char*, ...)
  alias Xworld = Void
  alias Xspace = Void
  alias Xbody = Void
  alias Xgeom = Void
  alias Xjoint = Void
  alias Xjointnode = Void
  alias Xjointgroup = Void
  X_ErrUnknown        =   0
  X_ErrIassert        =   1
  X_ErrUassert        =   2
  X_ErrLcp            =   3
  Jointtypenone       =   0
  Jointtypeball       =   1
  Jointtypehinge      =   2
  Jointtypeslider     =   3
  Jointtypecontact    =   4
  Jointtypeuniversal  =   5
  Jointtypehinge2     =   6
  Jointtypefixed      =   7
  Jointtypenull       =   8
  Jointtypeamotor     =   9
  Jointtypelmotor     =  10
  Jointtypeplane2d    =  11
  Jointtypepr         =  12
  Jointtypepu         =  13
  Jointtypepiston     =  14
  Paramlostop         =   0
  Paramhistop         =   1
  Paramvel            =   2
  Paramfmax           =   3
  Paramfudgefactor    =   4
  Parambounce         =   5
  Paramcfm            =   6
  Paramstoperp        =   7
  Paramstopcfm        =   8
  Paramsuspensionerp  =   9
  Paramsuspensioncfm  =  10
  Paramerp            =  11
  Paramsingroup       =  12
  Paramgroup1         =   0
  Paramlostop1        =   0
  Paramhistop1        =   1
  Paramvel1           =   2
  Paramfmax1          =   3
  Paramfudgefactor1   =   4
  Parambounce1        =   5
  Paramcfm1           =   6
  Paramstoperp1       =   7
  Paramstopcfm1       =   8
  Paramsuspensionerp1 =   9
  Paramsuspensioncfm1 =  10
  Paramerp1           =  11
  Paramgroup2         = 256
  Paramlostop2        = 256
  Paramhistop2        = 257
  Paramvel2           = 258
  Paramfmax2          = 259
  Paramfudgefactor2   = 260
  Parambounce2        = 261
  Paramcfm2           = 262
  Paramstoperp2       = 263
  Paramstopcfm2       = 264
  Paramsuspensionerp2 = 265
  Paramsuspensioncfm2 = 266
  Paramerp2           = 267
  Paramgroup3         = 512
  Paramlostop3        = 512
  Paramhistop3        = 513
  Paramvel3           = 514
  Paramfmax3          = 515
  Paramfudgefactor3   = 516
  Parambounce3        = 517
  Paramcfm3           = 518
  Paramstoperp3       = 519
  Paramstopcfm3       = 520
  Paramsuspensionerp3 = 521
  Paramsuspensioncfm3 = 522
  Paramerp3           = 523
  Paramgroup          = 256
  Amotoruser          =   0
  Amotoreuler         =   1

  struct Jointfeedback
    f1 : Vector3
    t1 : Vector3
    f2 : Vector3
    t2 : Vector3
  end

  alias Real = LibC::Double
  alias Vector3 = Real[4]
  fun geom_moved = dGeomMoved(x0 : Geomid)
  type Geomid = Void*
  fun geom_get_body_next = dGeomGetBodyNext(x0 : Geomid) : Geomid
  fun get_configuration = dGetConfiguration : LibC::Char*
  fun check_configuration = dCheckConfiguration(token : LibC::Char*) : LibC::Int

  struct Contactgeom
    pos : Vector3
    normal : Vector3
    epth : Real
    g1 : Geomid
    g2 : Geomid
    side1 : LibC::Int
    side2 : LibC::Int
  end

  fun simple_space_create = dSimpleSpaceCreate(space : Spaceid) : Spaceid
  type Spaceid = Void*
  fun hash_space_create = dHashSpaceCreate(space : Spaceid) : Spaceid
  fun quad_tree_space_create = dQuadTreeSpaceCreate(space : Spaceid, center : Vector3, extents : Vector3, depth : LibC::Int) : Spaceid
  fun sweep_and_prune_space_create = dSweepAndPruneSpaceCreate(space : Spaceid, axisorder : LibC::Int) : Spaceid
  fun space_destroy = dSpaceDestroy(x0 : Spaceid)
  fun hash_space_set_levels = dHashSpaceSetLevels(space : Spaceid, minlevel : LibC::Int, maxlevel : LibC::Int)
  fun hash_space_get_levels = dHashSpaceGetLevels(space : Spaceid, minlevel : LibC::Int*, maxlevel : LibC::Int*)
  fun space_set_cleanup = dSpaceSetCleanup(space : Spaceid, mode : LibC::Int)
  fun space_get_cleanup = dSpaceGetCleanup(space : Spaceid) : LibC::Int
  fun space_set_sublevel = dSpaceSetSublevel(space : Spaceid, sublevel : LibC::Int)
  fun space_get_sublevel = dSpaceGetSublevel(space : Spaceid) : LibC::Int
  fun space_set_manual_cleanup = dSpaceSetManualCleanup(space : Spaceid, mode : LibC::Int)
  fun space_get_manual_cleanup = dSpaceGetManualCleanup(space : Spaceid) : LibC::Int
  fun space_add = dSpaceAdd(x0 : Spaceid, x1 : Geomid)
  fun space_remove = dSpaceRemove(x0 : Spaceid, x1 : Geomid)
  fun space_query = dSpaceQuery(x0 : Spaceid, x1 : Geomid) : LibC::Int
  fun space_clean = dSpaceClean(x0 : Spaceid)
  fun space_get_num_geoms = dSpaceGetNumGeoms(x0 : Spaceid) : LibC::Int
  fun space_get_geom = dSpaceGetGeom(x0 : Spaceid, i : LibC::Int) : Geomid
  fun space_get_class = dSpaceGetClass(space : Spaceid) : LibC::Int
  Contactmu2      =     1
  Contactfdir1    =     2
  Contactbounce   =     4
  Contactsofterp  =     8
  Contactsoftcfm  =    16
  Contactmotion1  =    32
  Contactmotion2  =    64
  Contactmotionn  =   128
  Contactslip1    =   256
  Contactslip2    =   512
  Contactapprox0  =     0
  Contactapprox11 =  4096
  Contactapprox12 =  8192
  Contactapprox1  = 12288

  struct Surfaceparameters
    mode : LibC::Int
    mu : Real
    mu2 : Real
    bounce : Real
    bounce_vel : Real
    soft_erp : Real
    soft_cfm : Real
    motion1 : Real
    motion2 : Real
    motion_n : Real
    slip1 : Real
    slip2 : Real
  end

  struct Contact
    surface : Surfaceparameters
    geom : Contactgeom
    fdir1 : Vector3
  end

  fun init_ode = dInitODE
  fun init_od_e2 = dInitODE2(ui_init_flags : LibC::UInt) : LibC::Int
  fun allocate_ode_data_for_thread = dAllocateODEDataForThread(ui_allocate_flags : LibC::UInt) : LibC::Int
  fun cleanup_ode_all_data_for_thread = dCleanupODEAllDataForThread
  fun close_ode = dCloseODE
  fun geom_destroy = dGeomDestroy(geom : Geomid)
  fun geom_set_data = dGeomSetData(geom : Geomid, ata : Void*)
  fun geom_get_data = dGeomGetData(geom : Geomid) : Void*
  fun geom_set_body = dGeomSetBody(geom : Geomid, body : Bodyid)
  type Bodyid = Void*
  fun geom_get_body = dGeomGetBody(geom : Geomid) : Bodyid
  fun geom_set_position = dGeomSetPosition(geom : Geomid, x : Real, y : Real, z : Real)
  fun geom_set_rotation = dGeomSetRotation(geom : Geomid, r : Matrix3)
  alias Matrix3 = Real[12]
  fun geom_set_quaternion = dGeomSetQuaternion(geom : Geomid, q : Quaternion)
  alias Quaternion = Real[4]
  fun geom_get_position = dGeomGetPosition(geom : Geomid) : Real*
  fun geom_copy_position = dGeomCopyPosition(geom : Geomid, pos : Vector3)
  fun geom_get_rotation = dGeomGetRotation(geom : Geomid) : Real*
  fun geom_copy_rotation = dGeomCopyRotation(geom : Geomid, r : Matrix3)
  fun geom_get_quaternion = dGeomGetQuaternion(geom : Geomid, result : Quaternion)
  fun geom_get_aabb = dGeomGetAABB(geom : Geomid, aabb : Real[6])
  fun geom_is_space = dGeomIsSpace(geom : Geomid) : LibC::Int
  fun geom_get_space = dGeomGetSpace(x0 : Geomid) : Spaceid
  fun geom_get_class = dGeomGetClass(geom : Geomid) : LibC::Int
  fun geom_set_category_bits = dGeomSetCategoryBits(geom : Geomid, bits : LibC::ULong)
  fun geom_set_collide_bits = dGeomSetCollideBits(geom : Geomid, bits : LibC::ULong)
  fun geom_get_category_bits = dGeomGetCategoryBits(x0 : Geomid) : LibC::ULong
  fun geom_get_collide_bits = dGeomGetCollideBits(x0 : Geomid) : LibC::ULong
  fun geom_enable = dGeomEnable(geom : Geomid)
  fun geom_disable = dGeomDisable(geom : Geomid)
  fun geom_is_enabled = dGeomIsEnabled(geom : Geomid) : LibC::Int
  fun geom_set_offset_position = dGeomSetOffsetPosition(geom : Geomid, x : Real, y : Real, z : Real)
  fun geom_set_offset_rotation = dGeomSetOffsetRotation(geom : Geomid, r : Matrix3)
  fun geom_set_offset_quaternion = dGeomSetOffsetQuaternion(geom : Geomid, q : Quaternion)
  fun geom_set_offset_world_position = dGeomSetOffsetWorldPosition(geom : Geomid, x : Real, y : Real, z : Real)
  fun geom_set_offset_world_rotation = dGeomSetOffsetWorldRotation(geom : Geomid, r : Matrix3)
  fun geom_set_offset_world_quaternion = dGeomSetOffsetWorldQuaternion(geom : Geomid, x1 : Quaternion)
  fun geom_clear_offset = dGeomClearOffset(geom : Geomid)
  fun geom_is_offset = dGeomIsOffset(geom : Geomid) : LibC::Int
  fun geom_get_offset_position = dGeomGetOffsetPosition(geom : Geomid) : Real*
  fun geom_copy_offset_position = dGeomCopyOffsetPosition(geom : Geomid, pos : Vector3)
  fun geom_get_offset_rotation = dGeomGetOffsetRotation(geom : Geomid) : Real*
  fun geom_copy_offset_rotation = dGeomCopyOffsetRotation(geom : Geomid, r : Matrix3)
  fun geom_get_offset_quaternion = dGeomGetOffsetQuaternion(geom : Geomid, result : Quaternion)
  fun collide = dCollide(o1 : Geomid, o2 : Geomid, flags : LibC::Int, contact : Contactgeom*, skip : LibC::Int) : LibC::Int
  fun space_collide = dSpaceCollide(space : Spaceid, ata : Void*, callback : (Void*, Geomid, Geomid -> Void))
  fun space_collide2 = dSpaceCollide2(space1 : Geomid, space2 : Geomid, ata : Void*, callback : (Void*, Geomid, Geomid -> Void))
  Maxuserclasses          =  4
  Sphereclass             =  0
  Boxclass                =  1
  Capsuleclass            =  2
  Cylinderclass           =  3
  Planeclass              =  4
  Rayclass                =  5
  Convexclass             =  6
  Geomtransformclass      =  7
  Trimeshclass            =  8
  Heightfieldclass        =  9
  Firstspaceclass         = 10
  Simplespaceclass        = 10
  Hashspaceclass          = 11
  Sweepandprunespaceclass = 12
  Quadtreespaceclass      = 13
  Lastspaceclass          = 13
  Firstuserclass          = 14
  Lastuserclass           = 17
  Geomnumclasses          = 18
  fun create_sphere = dCreateSphere(space : Spaceid, radius : Real) : Geomid
  fun geom_sphere_set_radius = dGeomSphereSetRadius(sphere : Geomid, radius : Real)
  fun geom_sphere_get_radius = dGeomSphereGetRadius(sphere : Geomid) : Real
  fun geom_sphere_point_depth = dGeomSpherePointDepth(sphere : Geomid, x : Real, y : Real, z : Real) : Real
  fun create_convex = dCreateConvex(space : Spaceid, _planes : Real*, _planecount : LibC::UInt, _points : Real*, _pointcount : LibC::UInt, _polygons : LibC::UInt*) : Geomid
  fun geom_set_convex = dGeomSetConvex(g : Geomid, _planes : Real*, _count : LibC::UInt, _points : Real*, _pointcount : LibC::UInt, _polygons : LibC::UInt*)
  fun create_box = dCreateBox(space : Spaceid, lx : Real, ly : Real, lz : Real) : Geomid
  fun geom_box_set_lengths = dGeomBoxSetLengths(box : Geomid, lx : Real, ly : Real, lz : Real)
  fun geom_box_get_lengths = dGeomBoxGetLengths(box : Geomid, result : Vector3)
  fun geom_box_point_depth = dGeomBoxPointDepth(box : Geomid, x : Real, y : Real, z : Real) : Real
  fun create_plane = dCreatePlane(space : Spaceid, a : Real, b : Real, c : Real, d : Real) : Geomid
  fun geom_plane_set_params = dGeomPlaneSetParams(plane : Geomid, a : Real, b : Real, c : Real, d : Real)
  fun geom_plane_get_params = dGeomPlaneGetParams(plane : Geomid, result : Vector4)
  alias Vector4 = Real[4]
  fun geom_plane_point_depth = dGeomPlanePointDepth(plane : Geomid, x : Real, y : Real, z : Real) : Real
  fun create_capsule = dCreateCapsule(space : Spaceid, radius : Real, length : Real) : Geomid
  fun geom_capsule_set_params = dGeomCapsuleSetParams(ccylinder : Geomid, radius : Real, length : Real)
  fun geom_capsule_get_params = dGeomCapsuleGetParams(ccylinder : Geomid, radius : Real*, length : Real*)
  fun geom_capsule_point_depth = dGeomCapsulePointDepth(ccylinder : Geomid, x : Real, y : Real, z : Real) : Real
  fun create_cylinder = dCreateCylinder(space : Spaceid, radius : Real, length : Real) : Geomid
  fun geom_cylinder_set_params = dGeomCylinderSetParams(cylinder : Geomid, radius : Real, length : Real)
  fun geom_cylinder_get_params = dGeomCylinderGetParams(cylinder : Geomid, radius : Real*, length : Real*)
  fun create_ray = dCreateRay(space : Spaceid, length : Real) : Geomid
  fun geom_ray_set_length = dGeomRaySetLength(ray : Geomid, length : Real)
  fun geom_ray_get_length = dGeomRayGetLength(ray : Geomid) : Real
  fun geom_ray_set = dGeomRaySet(ray : Geomid, px : Real, py : Real, pz : Real, x : Real, y : Real, z : Real)
  fun geom_ray_get = dGeomRayGet(ray : Geomid, start : Vector3, ir : Vector3)
  fun geom_ray_set_params = dGeomRaySetParams(g : Geomid, first_contact : LibC::Int, backface_cull : LibC::Int)
  fun geom_ray_get_params = dGeomRayGetParams(g : Geomid, first_contact : LibC::Int*, backface_cull : LibC::Int*)
  fun geom_ray_set_closest_hit = dGeomRaySetClosestHit(g : Geomid, closest_hit : LibC::Int)
  fun geom_ray_get_closest_hit = dGeomRayGetClosestHit(g : Geomid) : LibC::Int
  alias Xtrimeshdata = Void
  fun geom_tri_mesh_data_create = dGeomTriMeshDataCreate : Trimeshdataid
  type Trimeshdataid = Void*
  fun geom_tri_mesh_data_destroy = dGeomTriMeshDataDestroy(g : Trimeshdataid)
  fun geom_tri_mesh_data_set = dGeomTriMeshDataSet(g : Trimeshdataid, ata_id : LibC::Int, in_data : Void*)
  fun geom_tri_mesh_data_get = dGeomTriMeshDataGet(g : Trimeshdataid, ata_id : LibC::Int) : Void*
  fun geom_tri_mesh_set_last_transform = dGeomTriMeshSetLastTransform(g : Geomid, last_trans : Matrix4)
  alias Matrix4 = Real[16]
  fun geom_tri_mesh_get_last_transform = dGeomTriMeshGetLastTransform(g : Geomid) : Real*
  fun geom_tri_mesh_data_build_single = dGeomTriMeshDataBuildSingle(g : Trimeshdataid, vertices : Void*, vertex_stride : LibC::Int, vertex_count : LibC::Int, indices : Void*, index_count : LibC::Int, tri_stride : LibC::Int)
  fun geom_tri_mesh_data_build_single1 = dGeomTriMeshDataBuildSingle1(g : Trimeshdataid, vertices : Void*, vertex_stride : LibC::Int, vertex_count : LibC::Int, indices : Void*, index_count : LibC::Int, tri_stride : LibC::Int, normals : Void*)
  fun geom_tri_mesh_data_build_double = dGeomTriMeshDataBuildDouble(g : Trimeshdataid, vertices : Void*, vertex_stride : LibC::Int, vertex_count : LibC::Int, indices : Void*, index_count : LibC::Int, tri_stride : LibC::Int)
  fun geom_tri_mesh_data_build_double1 = dGeomTriMeshDataBuildDouble1(g : Trimeshdataid, vertices : Void*, vertex_stride : LibC::Int, vertex_count : LibC::Int, indices : Void*, index_count : LibC::Int, tri_stride : LibC::Int, normals : Void*)
  fun geom_tri_mesh_data_build_simple = dGeomTriMeshDataBuildSimple(g : Trimeshdataid, vertices : Real*, vertex_count : LibC::Int, indices : Triindex*, index_count : LibC::Int)
  alias Uint32 = LibC::UInt
  alias Triindex = Uint32
  fun geom_tri_mesh_data_build_simple1 = dGeomTriMeshDataBuildSimple1(g : Trimeshdataid, vertices : Real*, vertex_count : LibC::Int, indices : Triindex*, index_count : LibC::Int, normals : LibC::Int*)
  fun geom_tri_mesh_data_preprocess = dGeomTriMeshDataPreprocess(g : Trimeshdataid)
  fun geom_tri_mesh_data_get_buffer = dGeomTriMeshDataGetBuffer(g : Trimeshdataid, buf : UInt8**, buf_len : LibC::Int*)
  fun geom_tri_mesh_data_set_buffer = dGeomTriMeshDataSetBuffer(g : Trimeshdataid, buf : UInt8*)
  fun geom_tri_mesh_set_callback = dGeomTriMeshSetCallback(g : Geomid, callback : (Geomid, Geomid, LibC::Int -> LibC::Int))
  fun geom_tri_mesh_get_callback = dGeomTriMeshGetCallback(g : Geomid) : (Geomid, Geomid, LibC::Int -> LibC::Int)
  fun geom_tri_mesh_set_array_callback = dGeomTriMeshSetArrayCallback(g : Geomid, array_callback : (Geomid, Geomid, LibC::Int*, LibC::Int -> Void))
  fun geom_tri_mesh_get_array_callback = dGeomTriMeshGetArrayCallback(g : Geomid) : (Geomid, Geomid, LibC::Int*, LibC::Int -> Void)
  fun geom_tri_mesh_set_ray_callback = dGeomTriMeshSetRayCallback(g : Geomid, callback : (Geomid, Geomid, LibC::Int, Real, Real -> LibC::Int))
  fun geom_tri_mesh_get_ray_callback = dGeomTriMeshGetRayCallback(g : Geomid) : (Geomid, Geomid, LibC::Int, Real, Real -> LibC::Int)
  fun geom_tri_mesh_set_tri_merge_callback = dGeomTriMeshSetTriMergeCallback(g : Geomid, callback : (Geomid, LibC::Int, LibC::Int -> LibC::Int))
  fun geom_tri_mesh_get_tri_merge_callback = dGeomTriMeshGetTriMergeCallback(g : Geomid) : (Geomid, LibC::Int, LibC::Int -> LibC::Int)
  fun create_tri_mesh = dCreateTriMesh(space : Spaceid, data : Trimeshdataid, callback : (Geomid, Geomid, LibC::Int -> LibC::Int), array_callback : (Geomid, Geomid, LibC::Int*, LibC::Int -> Void), ray_callback : (Geomid, Geomid, LibC::Int, Real, Real -> LibC::Int)) : Geomid
  fun geom_tri_mesh_set_data = dGeomTriMeshSetData(g : Geomid, data : Trimeshdataid)
  fun geom_tri_mesh_get_data = dGeomTriMeshGetData(g : Geomid) : Trimeshdataid
  fun geom_tri_mesh_enable_tc = dGeomTriMeshEnableTC(g : Geomid, geom_class : LibC::Int, enable : LibC::Int)
  fun geom_tri_mesh_is_tc_enabled = dGeomTriMeshIsTCEnabled(g : Geomid, geom_class : LibC::Int) : LibC::Int
  fun geom_tri_mesh_clear_tc_cache = dGeomTriMeshClearTCCache(g : Geomid)
  fun geom_tri_mesh_get_tri_mesh_data_id = dGeomTriMeshGetTriMeshDataID(g : Geomid) : Trimeshdataid
  fun geom_tri_mesh_get_triangle = dGeomTriMeshGetTriangle(g : Geomid, index : LibC::Int, v0 : Vector3*, v1 : Vector3*, v2 : Vector3*)
  fun geom_tri_mesh_get_point = dGeomTriMeshGetPoint(g : Geomid, index : LibC::Int, u : Real, v : Real, out : Vector3)
  fun geom_tri_mesh_get_triangle_count = dGeomTriMeshGetTriangleCount(g : Geomid) : LibC::Int
  fun geom_tri_mesh_data_update = dGeomTriMeshDataUpdate(g : Trimeshdataid)
  fun create_geom_transform = dCreateGeomTransform(space : Spaceid) : Geomid
  fun geom_transform_set_geom = dGeomTransformSetGeom(g : Geomid, obj : Geomid)
  fun geom_transform_get_geom = dGeomTransformGetGeom(g : Geomid) : Geomid
  fun geom_transform_set_cleanup = dGeomTransformSetCleanup(g : Geomid, mode : LibC::Int)
  fun geom_transform_get_cleanup = dGeomTransformGetCleanup(g : Geomid) : LibC::Int
  fun geom_transform_set_info = dGeomTransformSetInfo(g : Geomid, mode : LibC::Int)
  fun geom_transform_get_info = dGeomTransformGetInfo(g : Geomid) : LibC::Int
  alias Xheightfielddata = Void
  fun create_heightfield = dCreateHeightfield(space : Spaceid, ata : Heightfielddataid, b_placeable : LibC::Int) : Geomid
  type Heightfielddataid = Void*
  fun geom_heightfield_data_create = dGeomHeightfieldDataCreate : Heightfielddataid
  fun geom_heightfield_data_destroy = dGeomHeightfieldDataDestroy(h : Heightfielddataid)
  fun geom_heightfield_data_build_callback = dGeomHeightfieldDataBuildCallback(h : Heightfielddataid, p_user_data : Void*, p_callback : (Void*, LibC::Int, LibC::Int -> Real), width : Real, epth : Real, width_samples : LibC::Int, epth_samples : LibC::Int, scale : Real, offset : Real, thickness : Real, b_wrap : LibC::Int)
  fun geom_heightfield_data_build_byte = dGeomHeightfieldDataBuildByte(h : Heightfielddataid, p_height_data : UInt8*, b_copy_height_data : LibC::Int, width : Real, epth : Real, width_samples : LibC::Int, epth_samples : LibC::Int, scale : Real, offset : Real, thickness : Real, b_wrap : LibC::Int)
  fun geom_heightfield_data_build_short = dGeomHeightfieldDataBuildShort(h : Heightfielddataid, p_height_data : LibC::Short*, b_copy_height_data : LibC::Int, width : Real, epth : Real, width_samples : LibC::Int, epth_samples : LibC::Int, scale : Real, offset : Real, thickness : Real, b_wrap : LibC::Int)
  fun geom_heightfield_data_build_single = dGeomHeightfieldDataBuildSingle(h : Heightfielddataid, p_height_data : LibC::Float*, b_copy_height_data : LibC::Int, width : Real, epth : Real, width_samples : LibC::Int, epth_samples : LibC::Int, scale : Real, offset : Real, thickness : Real, b_wrap : LibC::Int)
  fun geom_heightfield_data_build_double = dGeomHeightfieldDataBuildDouble(h : Heightfielddataid, p_height_data : LibC::Double*, b_copy_height_data : LibC::Int, width : Real, epth : Real, width_samples : LibC::Int, epth_samples : LibC::Int, scale : Real, offset : Real, thickness : Real, b_wrap : LibC::Int)
  fun geom_heightfield_data_set_bounds = dGeomHeightfieldDataSetBounds(h : Heightfielddataid, min_height : Real, max_height : Real)
  fun geom_heightfield_set_heightfield_data = dGeomHeightfieldSetHeightfieldData(g : Geomid, h : Heightfielddataid)
  fun geom_heightfield_get_heightfield_data = dGeomHeightfieldGetHeightfieldData(g : Geomid) : Heightfielddataid
  fun closest_line_segment_points = dClosestLineSegmentPoints(a1 : Vector3, a2 : Vector3, b1 : Vector3, b2 : Vector3, cp1 : Vector3, cp2 : Vector3)
  fun box_touches_box = dBoxTouchesBox(_p1 : Vector3, r1 : Matrix3, side1 : Vector3, _p2 : Vector3, r2 : Matrix3, side2 : Vector3) : LibC::Int
  fun box_box = dBoxBox(p1 : Vector3, r1 : Matrix3, side1 : Vector3, p2 : Vector3, r2 : Matrix3, side2 : Vector3, normal : Vector3, epth : Real*, return_code : LibC::Int*, flags : LibC::Int, contact : Contactgeom*, skip : LibC::Int) : LibC::Int
  fun infinite_aabb = dInfiniteAABB(geom : Geomid, aabb : Real[6])

  struct Geomclass
    bytes : LibC::Int
    collider : (LibC::Int -> (Geomid, Geomid, LibC::Int, Contactgeom*, LibC::Int -> LibC::Int))
    aabb : (Geomid, Real[6] -> Void)
    aabb_test : (Geomid, Geomid, Real[6] -> LibC::Int)
    tor : (Geomid -> Void)
  end

  fun create_geom_class = dCreateGeomClass(classptr : Geomclass*) : LibC::Int
  fun geom_get_class_data = dGeomGetClassData(x0 : Geomid) : Void*
  fun create_geom = dCreateGeom(classnum : LibC::Int) : Geomid
  fun set_collider_override = dSetColliderOverride(i : LibC::Int, j : LibC::Int, fn : (Geomid, Geomid, LibC::Int, Contactgeom*, LibC::Int -> LibC::Int))
  fun world_export_dif = dWorldExportDIF(w : Worldid, file : File*, world_name : LibC::Char*)
  type Worldid = Void*

  struct X_IoFile
    _flags : LibC::Int
    _io_read_ptr : LibC::Char*
    _io_read_end : LibC::Char*
    _io_read_base : LibC::Char*
    _io_write_base : LibC::Char*
    _io_write_ptr : LibC::Char*
    _io_write_end : LibC::Char*
    _io_buf_base : LibC::Char*
    _io_buf_end : LibC::Char*
    _io_save_base : LibC::Char*
    _io_backup_base : LibC::Char*
    _io_save_end : LibC::Char*
    _markers : X_IoMarker*
    _chain : X_IoFile*
    _fileno : LibC::Int
    _flags2 : LibC::Int
    _old_offset : X__OffT
    _cur_column : LibC::UShort
    _vtable_offset : LibC::Char
    _shortbuf : LibC::Char[1]
    _lock : X_IoLockT*
    _offset : X__Off64T
    __pad1 : Void*
    __pad2 : Void*
    __pad3 : Void*
    __pad4 : Void*
    __pad5 : LibC::SizeT
    _mode : LibC::Int
    _unused2 : LibC::Char[20]
  end

  type File = X_IoFile

  struct X_IoMarker
    _next : X_IoMarker*
    _sbuf : X_IoFile*
    _pos : LibC::Int
  end

  alias X__OffT = LibC::Long
  alias X_IoLockT = Void
  alias X__Off64T = LibC::Long

  struct Mass
    mass : Real
    c : Vector3
    i : Matrix3
  end

  fun mass_check = dMassCheck(m : Mass*) : LibC::Int
  fun mass_set_zero = dMassSetZero(x0 : Mass*)
  fun mass_set_parameters = dMassSetParameters(x0 : Mass*, themass : Real, cgx : Real, cgy : Real, cgz : Real, i11 : Real, i22 : Real, i33 : Real, i12 : Real, i13 : Real, i23 : Real)
  fun mass_set_sphere = dMassSetSphere(x0 : Mass*, ensity : Real, radius : Real)
  fun mass_set_sphere_total = dMassSetSphereTotal(x0 : Mass*, total_mass : Real, radius : Real)
  fun mass_set_capsule = dMassSetCapsule(x0 : Mass*, ensity : Real, irection : LibC::Int, radius : Real, length : Real)
  fun mass_set_capsule_total = dMassSetCapsuleTotal(x0 : Mass*, total_mass : Real, irection : LibC::Int, radius : Real, length : Real)
  fun mass_set_cylinder = dMassSetCylinder(x0 : Mass*, ensity : Real, irection : LibC::Int, radius : Real, length : Real)
  fun mass_set_cylinder_total = dMassSetCylinderTotal(x0 : Mass*, total_mass : Real, irection : LibC::Int, radius : Real, length : Real)
  fun mass_set_box = dMassSetBox(x0 : Mass*, ensity : Real, lx : Real, ly : Real, lz : Real)
  fun mass_set_box_total = dMassSetBoxTotal(x0 : Mass*, total_mass : Real, lx : Real, ly : Real, lz : Real)
  fun mass_set_trimesh = dMassSetTrimesh(x0 : Mass*, ensity : Real, g : Geomid)
  fun mass_set_trimesh_total = dMassSetTrimeshTotal(m : Mass*, total_mass : Real, g : Geomid)
  fun mass_adjust = dMassAdjust(x0 : Mass*, newmass : Real)
  fun mass_translate = dMassTranslate(x0 : Mass*, x : Real, y : Real, z : Real)
  fun mass_rotate = dMassRotate(x0 : Mass*, r : Matrix3)
  fun mass_add = dMassAdd(a : Mass*, b : Mass*)
  fun mass_set_capped_cylinder = dMassSetCappedCylinder(a : Mass*, b : Real, c : LibC::Int, d : Real, e : Real)
  fun mass_set_capped_cylinder_total = dMassSetCappedCylinderTotal(a : Mass*, b : Real, c : LibC::Int, d : Real, e : Real)
  fun set_zero = dSetZero(a : Real*, n : LibC::Int)
  fun set_value = dSetValue(a : Real*, n : LibC::Int, value : Real)
  fun dot = dDot(a : Real*, b : Real*, n : LibC::Int) : Real
  fun multiply0 = dMultiply0(a : Real*, b : Real*, c : Real*, p : LibC::Int, q : LibC::Int, r : LibC::Int)
  fun multiply1 = dMultiply1(a : Real*, b : Real*, c : Real*, p : LibC::Int, q : LibC::Int, r : LibC::Int)
  fun multiply2 = dMultiply2(a : Real*, b : Real*, c : Real*, p : LibC::Int, q : LibC::Int, r : LibC::Int)
  fun factor_cholesky = dFactorCholesky(a : Real*, n : LibC::Int) : LibC::Int
  fun solve_cholesky = dSolveCholesky(l : Real*, b : Real*, n : LibC::Int)
  fun invert_pd_matrix = dInvertPDMatrix(a : Real*, ainv : Real*, n : LibC::Int) : LibC::Int
  fun is_positive_definite = dIsPositiveDefinite(a : Real*, n : LibC::Int) : LibC::Int
  fun factor_ldlt = dFactorLDLT(a : Real*, d : Real*, n : LibC::Int, nskip : LibC::Int)
  fun solve_l1 = dSolveL1(l : Real*, b : Real*, n : LibC::Int, nskip : LibC::Int)
  fun solve_l1t = dSolveL1T(l : Real*, b : Real*, n : LibC::Int, nskip : LibC::Int)
  fun vector_scale = dVectorScale(a : Real*, d : Real*, n : LibC::Int)
  fun solve_ldlt = dSolveLDLT(l : Real*, d : Real*, b : Real*, n : LibC::Int, nskip : LibC::Int)
  fun ldlt_add_tl = dLDLTAddTL(l : Real*, d : Real*, a : Real*, n : LibC::Int, nskip : LibC::Int)
  fun ldlt_remove = dLDLTRemove(a : Real**, p : LibC::Int*, l : Real*, d : Real*, n1 : LibC::Int, n2 : LibC::Int, r : LibC::Int, nskip : LibC::Int)
  fun remove_row_col = dRemoveRowCol(a : Real*, n : LibC::Int, nskip : LibC::Int, r : LibC::Int)
  fun set_alloc_handler = dSetAllocHandler(fn : (LibC::SizeT -> Void*))
  fun set_realloc_handler = dSetReallocHandler(fn : (Void*, LibC::SizeT, LibC::SizeT -> Void*))
  fun set_free_handler = dSetFreeHandler(fn : (Void*, LibC::SizeT -> Void))
  fun get_alloc_handler = dGetAllocHandler : (LibC::SizeT -> Void*)
  fun get_realloc_handler = dGetReallocHandler : (Void*, LibC::SizeT, LibC::SizeT -> Void*)
  fun get_free_handler = dGetFreeHandler : (Void*, LibC::SizeT -> Void)
  fun alloc = dAlloc(size : LibC::SizeT) : Void*
  fun realloc = dRealloc(ptr : Void*, oldsize : LibC::SizeT, newsize : LibC::SizeT) : Void*
  fun free = dFree(ptr : Void*, size : LibC::SizeT)
  fun test_rand = dTestRand : LibC::Int
  fun rand = dRand : LibC::ULong
  fun rand_get_seed = dRandGetSeed : LibC::ULong
  fun rand_set_seed = dRandSetSeed(s : LibC::ULong)
  fun rand_int = dRandInt(n : LibC::Int) : LibC::Int
  fun rand_real = dRandReal : Real
  fun print_matrix = dPrintMatrix(a : Real*, n : LibC::Int, m : LibC::Int, fmt : LibC::Char*, f : File*)
  fun make_random_vector = dMakeRandomVector(a : Real*, n : LibC::Int, range : Real)
  fun make_random_matrix = dMakeRandomMatrix(a : Real*, n : LibC::Int, m : LibC::Int, range : Real)
  fun clear_upper_triangle = dClearUpperTriangle(a : Real*, n : LibC::Int)
  fun max_difference = dMaxDifference(a : Real*, b : Real*, n : LibC::Int, m : LibC::Int) : Real
  fun max_difference_lower_triangle = dMaxDifferenceLowerTriangle(a : Real*, b : Real*, n : LibC::Int) : Real
  fun world_create = dWorldCreate : Worldid
  fun world_destroy = dWorldDestroy(world : Worldid)
  fun world_set_gravity = dWorldSetGravity(x0 : Worldid, x : Real, y : Real, z : Real)
  fun world_get_gravity = dWorldGetGravity(x0 : Worldid, gravity : Vector3)
  fun world_set_erp = dWorldSetERP(x0 : Worldid, erp : Real)
  fun world_get_erp = dWorldGetERP(x0 : Worldid) : Real
  fun world_set_cfm = dWorldSetCFM(x0 : Worldid, cfm : Real)
  fun world_get_cfm = dWorldGetCFM(x0 : Worldid) : Real
  fun world_step = dWorldStep(x0 : Worldid, stepsize : Real)
  fun world_impulse_to_force = dWorldImpulseToForce(x0 : Worldid, stepsize : Real, ix : Real, iy : Real, iz : Real, force : Vector3)
  fun world_quick_step = dWorldQuickStep(w : Worldid, stepsize : Real)
  fun world_set_quick_step_num_iterations = dWorldSetQuickStepNumIterations(x0 : Worldid, num : LibC::Int)
  fun world_get_quick_step_num_iterations = dWorldGetQuickStepNumIterations(x0 : Worldid) : LibC::Int
  fun world_set_quick_step_w = dWorldSetQuickStepW(x0 : Worldid, over_relaxation : Real)
  fun world_get_quick_step_w = dWorldGetQuickStepW(x0 : Worldid) : Real
  fun world_set_contact_max_correcting_vel = dWorldSetContactMaxCorrectingVel(x0 : Worldid, vel : Real)
  fun world_get_contact_max_correcting_vel = dWorldGetContactMaxCorrectingVel(x0 : Worldid) : Real
  fun world_set_contact_surface_layer = dWorldSetContactSurfaceLayer(x0 : Worldid, epth : Real)
  fun world_get_contact_surface_layer = dWorldGetContactSurfaceLayer(x0 : Worldid) : Real
  fun world_step_fast1 = dWorldStepFast1(x0 : Worldid, stepsize : Real, maxiterations : LibC::Int)
  fun world_set_auto_enable_depth_s_f1 = dWorldSetAutoEnableDepthSF1(x0 : Worldid, auto_enable_depth : LibC::Int)
  fun world_get_auto_enable_depth_s_f1 = dWorldGetAutoEnableDepthSF1(x0 : Worldid) : LibC::Int
  fun world_get_auto_disable_linear_threshold = dWorldGetAutoDisableLinearThreshold(x0 : Worldid) : Real
  fun world_set_auto_disable_linear_threshold = dWorldSetAutoDisableLinearThreshold(x0 : Worldid, linear_threshold : Real)
  fun world_get_auto_disable_angular_threshold = dWorldGetAutoDisableAngularThreshold(x0 : Worldid) : Real
  fun world_set_auto_disable_angular_threshold = dWorldSetAutoDisableAngularThreshold(x0 : Worldid, angular_threshold : Real)
  fun world_get_auto_disable_linear_average_threshold = dWorldGetAutoDisableLinearAverageThreshold(x0 : Worldid) : Real
  fun world_set_auto_disable_linear_average_threshold = dWorldSetAutoDisableLinearAverageThreshold(x0 : Worldid, linear_average_threshold : Real)
  fun world_get_auto_disable_angular_average_threshold = dWorldGetAutoDisableAngularAverageThreshold(x0 : Worldid) : Real
  fun world_set_auto_disable_angular_average_threshold = dWorldSetAutoDisableAngularAverageThreshold(x0 : Worldid, angular_average_threshold : Real)
  fun world_get_auto_disable_average_samples_count = dWorldGetAutoDisableAverageSamplesCount(x0 : Worldid) : LibC::Int
  fun world_set_auto_disable_average_samples_count = dWorldSetAutoDisableAverageSamplesCount(x0 : Worldid, average_samples_count : LibC::UInt)
  fun world_get_auto_disable_steps = dWorldGetAutoDisableSteps(x0 : Worldid) : LibC::Int
  fun world_set_auto_disable_steps = dWorldSetAutoDisableSteps(x0 : Worldid, steps : LibC::Int)
  fun world_get_auto_disable_time = dWorldGetAutoDisableTime(x0 : Worldid) : Real
  fun world_set_auto_disable_time = dWorldSetAutoDisableTime(x0 : Worldid, time : Real)
  fun world_get_auto_disable_flag = dWorldGetAutoDisableFlag(x0 : Worldid) : LibC::Int
  fun world_set_auto_disable_flag = dWorldSetAutoDisableFlag(x0 : Worldid, o_auto_disable : LibC::Int)
  fun world_get_linear_damping_threshold = dWorldGetLinearDampingThreshold(w : Worldid) : Real
  fun world_set_linear_damping_threshold = dWorldSetLinearDampingThreshold(w : Worldid, threshold : Real)
  fun world_get_angular_damping_threshold = dWorldGetAngularDampingThreshold(w : Worldid) : Real
  fun world_set_angular_damping_threshold = dWorldSetAngularDampingThreshold(w : Worldid, threshold : Real)
  fun world_get_linear_damping = dWorldGetLinearDamping(w : Worldid) : Real
  fun world_set_linear_damping = dWorldSetLinearDamping(w : Worldid, scale : Real)
  fun world_get_angular_damping = dWorldGetAngularDamping(w : Worldid) : Real
  fun world_set_angular_damping = dWorldSetAngularDamping(w : Worldid, scale : Real)
  fun world_set_damping = dWorldSetDamping(w : Worldid, linear_scale : Real, angular_scale : Real)
  fun world_get_max_angular_speed = dWorldGetMaxAngularSpeed(w : Worldid) : Real
  fun world_set_max_angular_speed = dWorldSetMaxAngularSpeed(w : Worldid, max_speed : Real)
  fun body_get_auto_disable_linear_threshold = dBodyGetAutoDisableLinearThreshold(x0 : Bodyid) : Real
  fun body_set_auto_disable_linear_threshold = dBodySetAutoDisableLinearThreshold(x0 : Bodyid, linear_average_threshold : Real)
  fun body_get_auto_disable_angular_threshold = dBodyGetAutoDisableAngularThreshold(x0 : Bodyid) : Real
  fun body_set_auto_disable_angular_threshold = dBodySetAutoDisableAngularThreshold(x0 : Bodyid, angular_average_threshold : Real)
  fun body_get_auto_disable_average_samples_count = dBodyGetAutoDisableAverageSamplesCount(x0 : Bodyid) : LibC::Int
  fun body_set_auto_disable_average_samples_count = dBodySetAutoDisableAverageSamplesCount(x0 : Bodyid, average_samples_count : LibC::UInt)
  fun body_get_auto_disable_steps = dBodyGetAutoDisableSteps(x0 : Bodyid) : LibC::Int
  fun body_set_auto_disable_steps = dBodySetAutoDisableSteps(x0 : Bodyid, steps : LibC::Int)
  fun body_get_auto_disable_time = dBodyGetAutoDisableTime(x0 : Bodyid) : Real
  fun body_set_auto_disable_time = dBodySetAutoDisableTime(x0 : Bodyid, time : Real)
  fun body_get_auto_disable_flag = dBodyGetAutoDisableFlag(x0 : Bodyid) : LibC::Int
  fun body_set_auto_disable_flag = dBodySetAutoDisableFlag(x0 : Bodyid, o_auto_disable : LibC::Int)
  fun body_set_auto_disable_defaults = dBodySetAutoDisableDefaults(x0 : Bodyid)
  fun body_get_world = dBodyGetWorld(x0 : Bodyid) : Worldid
  fun body_create = dBodyCreate(x0 : Worldid) : Bodyid
  fun body_destroy = dBodyDestroy(x0 : Bodyid)
  fun body_set_data = dBodySetData(x0 : Bodyid, ata : Void*)
  fun body_get_data = dBodyGetData(x0 : Bodyid) : Void*
  fun body_set_position = dBodySetPosition(x0 : Bodyid, x : Real, y : Real, z : Real)
  fun body_set_rotation = dBodySetRotation(x0 : Bodyid, r : Matrix3)
  fun body_set_quaternion = dBodySetQuaternion(x0 : Bodyid, q : Quaternion)
  fun body_set_linear_vel = dBodySetLinearVel(x0 : Bodyid, x : Real, y : Real, z : Real)
  fun body_set_angular_vel = dBodySetAngularVel(x0 : Bodyid, x : Real, y : Real, z : Real)
  fun body_get_position = dBodyGetPosition(x0 : Bodyid) : Real*
  fun body_copy_position = dBodyCopyPosition(body : Bodyid, pos : Vector3)
  fun body_get_rotation = dBodyGetRotation(x0 : Bodyid) : Real*
  fun body_copy_rotation = dBodyCopyRotation(x0 : Bodyid, r : Matrix3)
  fun body_get_quaternion = dBodyGetQuaternion(x0 : Bodyid) : Real*
  fun body_copy_quaternion = dBodyCopyQuaternion(body : Bodyid, quat : Quaternion)
  fun body_get_linear_vel = dBodyGetLinearVel(x0 : Bodyid) : Real*
  fun body_get_angular_vel = dBodyGetAngularVel(x0 : Bodyid) : Real*
  fun body_set_mass = dBodySetMass(x0 : Bodyid, mass : Mass*)
  fun body_get_mass = dBodyGetMass(x0 : Bodyid, mass : Mass*)
  fun body_add_force = dBodyAddForce(x0 : Bodyid, fx : Real, fy : Real, fz : Real)
  fun body_add_torque = dBodyAddTorque(x0 : Bodyid, fx : Real, fy : Real, fz : Real)
  fun body_add_rel_force = dBodyAddRelForce(x0 : Bodyid, fx : Real, fy : Real, fz : Real)
  fun body_add_rel_torque = dBodyAddRelTorque(x0 : Bodyid, fx : Real, fy : Real, fz : Real)
  fun body_add_force_at_pos = dBodyAddForceAtPos(x0 : Bodyid, fx : Real, fy : Real, fz : Real, px : Real, py : Real, pz : Real)
  fun body_add_force_at_rel_pos = dBodyAddForceAtRelPos(x0 : Bodyid, fx : Real, fy : Real, fz : Real, px : Real, py : Real, pz : Real)
  fun body_add_rel_force_at_pos = dBodyAddRelForceAtPos(x0 : Bodyid, fx : Real, fy : Real, fz : Real, px : Real, py : Real, pz : Real)
  fun body_add_rel_force_at_rel_pos = dBodyAddRelForceAtRelPos(x0 : Bodyid, fx : Real, fy : Real, fz : Real, px : Real, py : Real, pz : Real)
  fun body_get_force = dBodyGetForce(x0 : Bodyid) : Real*
  fun body_get_torque = dBodyGetTorque(x0 : Bodyid) : Real*
  fun body_set_force = dBodySetForce(b : Bodyid, x : Real, y : Real, z : Real)
  fun body_set_torque = dBodySetTorque(b : Bodyid, x : Real, y : Real, z : Real)
  fun body_get_rel_point_pos = dBodyGetRelPointPos(x0 : Bodyid, px : Real, py : Real, pz : Real, result : Vector3)
  fun body_get_rel_point_vel = dBodyGetRelPointVel(x0 : Bodyid, px : Real, py : Real, pz : Real, result : Vector3)
  fun body_get_point_vel = dBodyGetPointVel(x0 : Bodyid, px : Real, py : Real, pz : Real, result : Vector3)
  fun body_get_pos_rel_point = dBodyGetPosRelPoint(x0 : Bodyid, px : Real, py : Real, pz : Real, result : Vector3)
  fun body_vector_to_world = dBodyVectorToWorld(x0 : Bodyid, px : Real, py : Real, pz : Real, result : Vector3)
  fun body_vector_from_world = dBodyVectorFromWorld(x0 : Bodyid, px : Real, py : Real, pz : Real, result : Vector3)
  fun body_set_finite_rotation_mode = dBodySetFiniteRotationMode(x0 : Bodyid, mode : LibC::Int)
  fun body_set_finite_rotation_axis = dBodySetFiniteRotationAxis(x0 : Bodyid, x : Real, y : Real, z : Real)
  fun body_get_finite_rotation_mode = dBodyGetFiniteRotationMode(x0 : Bodyid) : LibC::Int
  fun body_get_finite_rotation_axis = dBodyGetFiniteRotationAxis(x0 : Bodyid, result : Vector3)
  fun body_get_num_joints = dBodyGetNumJoints(b : Bodyid) : LibC::Int
  fun body_get_joint = dBodyGetJoint(x0 : Bodyid, index : LibC::Int) : Jointid
  type Jointid = Void*
  fun body_set_dynamic = dBodySetDynamic(x0 : Bodyid)
  fun body_set_kinematic = dBodySetKinematic(x0 : Bodyid)
  fun body_is_kinematic = dBodyIsKinematic(x0 : Bodyid) : LibC::Int
  fun body_enable = dBodyEnable(x0 : Bodyid)
  fun body_disable = dBodyDisable(x0 : Bodyid)
  fun body_is_enabled = dBodyIsEnabled(x0 : Bodyid) : LibC::Int
  fun body_set_gravity_mode = dBodySetGravityMode(b : Bodyid, mode : LibC::Int)
  fun body_get_gravity_mode = dBodyGetGravityMode(b : Bodyid) : LibC::Int
  fun body_set_moved_callback = dBodySetMovedCallback(b : Bodyid, callback : (Bodyid -> Void))
  fun body_get_first_geom = dBodyGetFirstGeom(b : Bodyid) : Geomid
  fun body_get_next_geom = dBodyGetNextGeom(g : Geomid) : Geomid
  fun body_set_damping_defaults = dBodySetDampingDefaults(b : Bodyid)
  fun body_get_linear_damping = dBodyGetLinearDamping(b : Bodyid) : Real
  fun body_set_linear_damping = dBodySetLinearDamping(b : Bodyid, scale : Real)
  fun body_get_angular_damping = dBodyGetAngularDamping(b : Bodyid) : Real
  fun body_set_angular_damping = dBodySetAngularDamping(b : Bodyid, scale : Real)
  fun body_set_damping = dBodySetDamping(b : Bodyid, linear_scale : Real, angular_scale : Real)
  fun body_get_linear_damping_threshold = dBodyGetLinearDampingThreshold(b : Bodyid) : Real
  fun body_set_linear_damping_threshold = dBodySetLinearDampingThreshold(b : Bodyid, threshold : Real)
  fun body_get_angular_damping_threshold = dBodyGetAngularDampingThreshold(b : Bodyid) : Real
  fun body_set_angular_damping_threshold = dBodySetAngularDampingThreshold(b : Bodyid, threshold : Real)
  fun body_get_max_angular_speed = dBodyGetMaxAngularSpeed(b : Bodyid) : Real
  fun body_set_max_angular_speed = dBodySetMaxAngularSpeed(b : Bodyid, max_speed : Real)
  fun body_get_gyroscopic_mode = dBodyGetGyroscopicMode(b : Bodyid) : LibC::Int
  fun body_set_gyroscopic_mode = dBodySetGyroscopicMode(b : Bodyid, enabled : LibC::Int)
  fun joint_create_ball = dJointCreateBall(x0 : Worldid, x1 : Jointgroupid) : Jointid
  type Jointgroupid = Void*
  fun joint_create_hinge = dJointCreateHinge(x0 : Worldid, x1 : Jointgroupid) : Jointid
  fun joint_create_slider = dJointCreateSlider(x0 : Worldid, x1 : Jointgroupid) : Jointid
  fun joint_create_contact = dJointCreateContact(x0 : Worldid, x1 : Jointgroupid, x2 : Contact*) : Jointid
  fun joint_create_hinge2 = dJointCreateHinge2(x0 : Worldid, x1 : Jointgroupid) : Jointid
  fun joint_create_universal = dJointCreateUniversal(x0 : Worldid, x1 : Jointgroupid) : Jointid
  fun joint_create_pr = dJointCreatePR(x0 : Worldid, x1 : Jointgroupid) : Jointid
  fun joint_create_pu = dJointCreatePU(x0 : Worldid, x1 : Jointgroupid) : Jointid
  fun joint_create_piston = dJointCreatePiston(x0 : Worldid, x1 : Jointgroupid) : Jointid
  fun joint_create_fixed = dJointCreateFixed(x0 : Worldid, x1 : Jointgroupid) : Jointid
  fun joint_create_null = dJointCreateNull(x0 : Worldid, x1 : Jointgroupid) : Jointid
  fun joint_create_a_motor = dJointCreateAMotor(x0 : Worldid, x1 : Jointgroupid) : Jointid
  fun joint_create_l_motor = dJointCreateLMotor(x0 : Worldid, x1 : Jointgroupid) : Jointid
  fun joint_create_plane2d = dJointCreatePlane2D(x0 : Worldid, x1 : Jointgroupid) : Jointid
  fun joint_destroy = dJointDestroy(x0 : Jointid)
  fun joint_group_create = dJointGroupCreate(max_size : LibC::Int) : Jointgroupid
  fun joint_group_destroy = dJointGroupDestroy(x0 : Jointgroupid)
  fun joint_group_empty = dJointGroupEmpty(x0 : Jointgroupid)
  fun joint_get_num_bodies = dJointGetNumBodies(x0 : Jointid) : LibC::Int
  fun joint_attach = dJointAttach(x0 : Jointid, body1 : Bodyid, body2 : Bodyid)
  fun joint_enable = dJointEnable(x0 : Jointid)
  fun joint_disable = dJointDisable(x0 : Jointid)
  fun joint_is_enabled = dJointIsEnabled(x0 : Jointid) : LibC::Int
  fun joint_set_data = dJointSetData(x0 : Jointid, ata : Void*)
  fun joint_get_data = dJointGetData(x0 : Jointid) : Void*
  fun joint_get_type = dJointGetType(x0 : Jointid) : Jointtype
  enum Jointtype
    Jointtypenone      =  0
    Jointtypeball      =  1
    Jointtypehinge     =  2
    Jointtypeslider    =  3
    Jointtypecontact   =  4
    Jointtypeuniversal =  5
    Jointtypehinge2    =  6
    Jointtypefixed     =  7
    Jointtypenull      =  8
    Jointtypeamotor    =  9
    Jointtypelmotor    = 10
    Jointtypeplane2d   = 11
    Jointtypepr        = 12
    Jointtypepu        = 13
    Jointtypepiston    = 14
  end
  fun joint_get_body = dJointGetBody(x0 : Jointid, index : LibC::Int) : Bodyid
  fun joint_set_feedback = dJointSetFeedback(x0 : Jointid, x1 : Jointfeedback*)
  fun joint_get_feedback = dJointGetFeedback(x0 : Jointid) : Jointfeedback*
  fun joint_set_ball_anchor = dJointSetBallAnchor(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_ball_anchor2 = dJointSetBallAnchor2(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_ball_param = dJointSetBallParam(x0 : Jointid, parameter : LibC::Int, value : Real)
  fun joint_set_hinge_anchor = dJointSetHingeAnchor(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_hinge_anchor_delta = dJointSetHingeAnchorDelta(x0 : Jointid, x : Real, y : Real, z : Real, ax : Real, ay : Real, az : Real)
  fun joint_set_hinge_axis = dJointSetHingeAxis(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_hinge_axis_offset = dJointSetHingeAxisOffset(j : Jointid, x : Real, y : Real, z : Real, angle : Real)
  fun joint_set_hinge_param = dJointSetHingeParam(x0 : Jointid, parameter : LibC::Int, value : Real)
  fun joint_add_hinge_torque = dJointAddHingeTorque(joint : Jointid, torque : Real)
  fun joint_set_slider_axis = dJointSetSliderAxis(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_slider_axis_delta = dJointSetSliderAxisDelta(x0 : Jointid, x : Real, y : Real, z : Real, ax : Real, ay : Real, az : Real)
  fun joint_set_slider_param = dJointSetSliderParam(x0 : Jointid, parameter : LibC::Int, value : Real)
  fun joint_add_slider_force = dJointAddSliderForce(joint : Jointid, force : Real)
  fun joint_set_hinge2anchor = dJointSetHinge2Anchor(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_hinge2axis1 = dJointSetHinge2Axis1(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_hinge2axis2 = dJointSetHinge2Axis2(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_hinge2param = dJointSetHinge2Param(x0 : Jointid, parameter : LibC::Int, value : Real)
  fun joint_add_hinge2torques = dJointAddHinge2Torques(joint : Jointid, torque1 : Real, torque2 : Real)
  fun joint_set_universal_anchor = dJointSetUniversalAnchor(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_universal_axis1 = dJointSetUniversalAxis1(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_universal_axis1offset = dJointSetUniversalAxis1Offset(x0 : Jointid, x : Real, y : Real, z : Real, offset1 : Real, offset2 : Real)
  fun joint_set_universal_axis2 = dJointSetUniversalAxis2(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_universal_axis2offset = dJointSetUniversalAxis2Offset(x0 : Jointid, x : Real, y : Real, z : Real, offset1 : Real, offset2 : Real)
  fun joint_set_universal_param = dJointSetUniversalParam(x0 : Jointid, parameter : LibC::Int, value : Real)
  fun joint_add_universal_torques = dJointAddUniversalTorques(joint : Jointid, torque1 : Real, torque2 : Real)
  fun joint_set_pr_anchor = dJointSetPRAnchor(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_pr_axis1 = dJointSetPRAxis1(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_pr_axis2 = dJointSetPRAxis2(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_pr_param = dJointSetPRParam(x0 : Jointid, parameter : LibC::Int, value : Real)
  fun joint_add_pr_torque = dJointAddPRTorque(j : Jointid, torque : Real)
  fun joint_set_pu_anchor = dJointSetPUAnchor(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_pu_anchor_delta = dJointSetPUAnchorDelta(x0 : Jointid, x : Real, y : Real, z : Real, x : Real, y : Real, z : Real)
  fun joint_set_pu_anchor_offset = dJointSetPUAnchorOffset(x0 : Jointid, x : Real, y : Real, z : Real, x : Real, y : Real, z : Real)
  fun joint_set_pu_axis1 = dJointSetPUAxis1(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_pu_axis2 = dJointSetPUAxis2(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_pu_axis3 = dJointSetPUAxis3(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_pu_axis_p = dJointSetPUAxisP(id : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_pu_param = dJointSetPUParam(x0 : Jointid, parameter : LibC::Int, value : Real)
  fun joint_add_pu_torque = dJointAddPUTorque(j : Jointid, torque : Real)
  fun joint_set_piston_anchor = dJointSetPistonAnchor(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_piston_anchor_offset = dJointSetPistonAnchorOffset(j : Jointid, x : Real, y : Real, z : Real, x : Real, y : Real, z : Real)
  fun joint_set_piston_axis = dJointSetPistonAxis(x0 : Jointid, x : Real, y : Real, z : Real)
  fun joint_set_piston_axis_delta = dJointSetPistonAxisDelta(j : Jointid, x : Real, y : Real, z : Real, ax : Real, ay : Real, az : Real)
  fun joint_set_piston_param = dJointSetPistonParam(x0 : Jointid, parameter : LibC::Int, value : Real)
  fun joint_add_piston_force = dJointAddPistonForce(joint : Jointid, force : Real)
  fun joint_set_fixed = dJointSetFixed(x0 : Jointid)
  fun joint_set_fixed_param = dJointSetFixedParam(x0 : Jointid, parameter : LibC::Int, value : Real)
  fun joint_set_a_motor_num_axes = dJointSetAMotorNumAxes(x0 : Jointid, num : LibC::Int)
  fun joint_set_a_motor_axis = dJointSetAMotorAxis(x0 : Jointid, anum : LibC::Int, rel : LibC::Int, x : Real, y : Real, z : Real)
  fun joint_set_a_motor_angle = dJointSetAMotorAngle(x0 : Jointid, anum : LibC::Int, angle : Real)
  fun joint_set_a_motor_param = dJointSetAMotorParam(x0 : Jointid, parameter : LibC::Int, value : Real)
  fun joint_set_a_motor_mode = dJointSetAMotorMode(x0 : Jointid, mode : LibC::Int)
  fun joint_add_a_motor_torques = dJointAddAMotorTorques(x0 : Jointid, torque1 : Real, torque2 : Real, torque3 : Real)
  fun joint_set_l_motor_num_axes = dJointSetLMotorNumAxes(x0 : Jointid, num : LibC::Int)
  fun joint_set_l_motor_axis = dJointSetLMotorAxis(x0 : Jointid, anum : LibC::Int, rel : LibC::Int, x : Real, y : Real, z : Real)
  fun joint_set_l_motor_param = dJointSetLMotorParam(x0 : Jointid, parameter : LibC::Int, value : Real)
  fun joint_set_plane2dx_param = dJointSetPlane2DXParam(x0 : Jointid, parameter : LibC::Int, value : Real)
  fun joint_set_plane2dy_param = dJointSetPlane2DYParam(x0 : Jointid, parameter : LibC::Int, value : Real)
  fun joint_set_plane2d_angle_param = dJointSetPlane2DAngleParam(x0 : Jointid, parameter : LibC::Int, value : Real)
  fun joint_get_ball_anchor = dJointGetBallAnchor(x0 : Jointid, result : Vector3)
  fun joint_get_ball_anchor2 = dJointGetBallAnchor2(x0 : Jointid, result : Vector3)
  fun joint_get_ball_param = dJointGetBallParam(x0 : Jointid, parameter : LibC::Int) : Real
  fun joint_get_hinge_anchor = dJointGetHingeAnchor(x0 : Jointid, result : Vector3)
  fun joint_get_hinge_anchor2 = dJointGetHingeAnchor2(x0 : Jointid, result : Vector3)
  fun joint_get_hinge_axis = dJointGetHingeAxis(x0 : Jointid, result : Vector3)
  fun joint_get_hinge_param = dJointGetHingeParam(x0 : Jointid, parameter : LibC::Int) : Real
  fun joint_get_hinge_angle = dJointGetHingeAngle(x0 : Jointid) : Real
  fun joint_get_hinge_angle_rate = dJointGetHingeAngleRate(x0 : Jointid) : Real
  fun joint_get_slider_position = dJointGetSliderPosition(x0 : Jointid) : Real
  fun joint_get_slider_position_rate = dJointGetSliderPositionRate(x0 : Jointid) : Real
  fun joint_get_slider_axis = dJointGetSliderAxis(x0 : Jointid, result : Vector3)
  fun joint_get_slider_param = dJointGetSliderParam(x0 : Jointid, parameter : LibC::Int) : Real
  fun joint_get_hinge2anchor = dJointGetHinge2Anchor(x0 : Jointid, result : Vector3)
  fun joint_get_hinge2anchor2 = dJointGetHinge2Anchor2(x0 : Jointid, result : Vector3)
  fun joint_get_hinge2axis1 = dJointGetHinge2Axis1(x0 : Jointid, result : Vector3)
  fun joint_get_hinge2axis2 = dJointGetHinge2Axis2(x0 : Jointid, result : Vector3)
  fun joint_get_hinge2param = dJointGetHinge2Param(x0 : Jointid, parameter : LibC::Int) : Real
  fun joint_get_hinge2angle1 = dJointGetHinge2Angle1(x0 : Jointid) : Real
  fun joint_get_hinge2angle1rate = dJointGetHinge2Angle1Rate(x0 : Jointid) : Real
  fun joint_get_hinge2angle2rate = dJointGetHinge2Angle2Rate(x0 : Jointid) : Real
  fun joint_get_universal_anchor = dJointGetUniversalAnchor(x0 : Jointid, result : Vector3)
  fun joint_get_universal_anchor2 = dJointGetUniversalAnchor2(x0 : Jointid, result : Vector3)
  fun joint_get_universal_axis1 = dJointGetUniversalAxis1(x0 : Jointid, result : Vector3)
  fun joint_get_universal_axis2 = dJointGetUniversalAxis2(x0 : Jointid, result : Vector3)
  fun joint_get_universal_param = dJointGetUniversalParam(x0 : Jointid, parameter : LibC::Int) : Real
  fun joint_get_universal_angles = dJointGetUniversalAngles(x0 : Jointid, angle1 : Real*, angle2 : Real*)
  fun joint_get_universal_angle1 = dJointGetUniversalAngle1(x0 : Jointid) : Real
  fun joint_get_universal_angle2 = dJointGetUniversalAngle2(x0 : Jointid) : Real
  fun joint_get_universal_angle1rate = dJointGetUniversalAngle1Rate(x0 : Jointid) : Real
  fun joint_get_universal_angle2rate = dJointGetUniversalAngle2Rate(x0 : Jointid) : Real
  fun joint_get_pr_anchor = dJointGetPRAnchor(x0 : Jointid, result : Vector3)
  fun joint_get_pr_position = dJointGetPRPosition(x0 : Jointid) : Real
  fun joint_get_pr_position_rate = dJointGetPRPositionRate(x0 : Jointid) : Real
  fun joint_get_pr_angle = dJointGetPRAngle(x0 : Jointid) : Real
  fun joint_get_pr_angle_rate = dJointGetPRAngleRate(x0 : Jointid) : Real
  fun joint_get_pr_axis1 = dJointGetPRAxis1(x0 : Jointid, result : Vector3)
  fun joint_get_pr_axis2 = dJointGetPRAxis2(x0 : Jointid, result : Vector3)
  fun joint_get_pr_param = dJointGetPRParam(x0 : Jointid, parameter : LibC::Int) : Real
  fun joint_get_pu_anchor = dJointGetPUAnchor(x0 : Jointid, result : Vector3)
  fun joint_get_pu_position = dJointGetPUPosition(x0 : Jointid) : Real
  fun joint_get_pu_position_rate = dJointGetPUPositionRate(x0 : Jointid) : Real
  fun joint_get_pu_axis1 = dJointGetPUAxis1(x0 : Jointid, result : Vector3)
  fun joint_get_pu_axis2 = dJointGetPUAxis2(x0 : Jointid, result : Vector3)
  fun joint_get_pu_axis3 = dJointGetPUAxis3(x0 : Jointid, result : Vector3)
  fun joint_get_pu_axis_p = dJointGetPUAxisP(id : Jointid, result : Vector3)
  fun joint_get_pu_angles = dJointGetPUAngles(x0 : Jointid, angle1 : Real*, angle2 : Real*)
  fun joint_get_pu_angle1 = dJointGetPUAngle1(x0 : Jointid) : Real
  fun joint_get_pu_angle1rate = dJointGetPUAngle1Rate(x0 : Jointid) : Real
  fun joint_get_pu_angle2 = dJointGetPUAngle2(x0 : Jointid) : Real
  fun joint_get_pu_angle2rate = dJointGetPUAngle2Rate(x0 : Jointid) : Real
  fun joint_get_pu_param = dJointGetPUParam(x0 : Jointid, parameter : LibC::Int) : Real
  fun joint_get_piston_position = dJointGetPistonPosition(x0 : Jointid) : Real
  fun joint_get_piston_position_rate = dJointGetPistonPositionRate(x0 : Jointid) : Real
  fun joint_get_piston_angle = dJointGetPistonAngle(x0 : Jointid) : Real
  fun joint_get_piston_angle_rate = dJointGetPistonAngleRate(x0 : Jointid) : Real
  fun joint_get_piston_anchor = dJointGetPistonAnchor(x0 : Jointid, result : Vector3)
  fun joint_get_piston_anchor2 = dJointGetPistonAnchor2(x0 : Jointid, result : Vector3)
  fun joint_get_piston_axis = dJointGetPistonAxis(x0 : Jointid, result : Vector3)
  fun joint_get_piston_param = dJointGetPistonParam(x0 : Jointid, parameter : LibC::Int) : Real
  fun joint_get_a_motor_num_axes = dJointGetAMotorNumAxes(x0 : Jointid) : LibC::Int
  fun joint_get_a_motor_axis = dJointGetAMotorAxis(x0 : Jointid, anum : LibC::Int, result : Vector3)
  fun joint_get_a_motor_axis_rel = dJointGetAMotorAxisRel(x0 : Jointid, anum : LibC::Int) : LibC::Int
  fun joint_get_a_motor_angle = dJointGetAMotorAngle(x0 : Jointid, anum : LibC::Int) : Real
  fun joint_get_a_motor_angle_rate = dJointGetAMotorAngleRate(x0 : Jointid, anum : LibC::Int) : Real
  fun joint_get_a_motor_param = dJointGetAMotorParam(x0 : Jointid, parameter : LibC::Int) : Real
  fun joint_get_a_motor_mode = dJointGetAMotorMode(x0 : Jointid) : LibC::Int
  fun joint_get_l_motor_num_axes = dJointGetLMotorNumAxes(x0 : Jointid) : LibC::Int
  fun joint_get_l_motor_axis = dJointGetLMotorAxis(x0 : Jointid, anum : LibC::Int, result : Vector3)
  fun joint_get_l_motor_param = dJointGetLMotorParam(x0 : Jointid, parameter : LibC::Int) : Real
  fun joint_get_fixed_param = dJointGetFixedParam(x0 : Jointid, parameter : LibC::Int) : Real
  fun connecting_joint = dConnectingJoint(x0 : Bodyid, x1 : Bodyid) : Jointid
  fun connecting_joint_list = dConnectingJointList(x0 : Bodyid, x1 : Bodyid, x2 : Jointid*) : LibC::Int
  fun are_connected = dAreConnected(x0 : Bodyid, x1 : Bodyid) : LibC::Int
  fun are_connected_excluding = dAreConnectedExcluding(body1 : Bodyid, body2 : Bodyid, joint_type : LibC::Int) : LibC::Int
  fun safe_normalize3 = dSafeNormalize3(a : Vector3) : LibC::Int
  fun safe_normalize4 = dSafeNormalize4(a : Vector4) : LibC::Int
  fun normalize3 = dNormalize3(a : Vector3)
  fun normalize4 = dNormalize4(a : Vector4)
  fun plane_space = dPlaneSpace(n : Vector3, p : Vector3, q : Vector3)
  fun orthogonalize_r = dOrthogonalizeR(m : Matrix3)

  struct Stopwatch
    time : LibC::Double
    cc : LibC::ULong[2]
  end

  fun stopwatch_reset = dStopwatchReset(x0 : Stopwatch*)
  fun stopwatch_start = dStopwatchStart(x0 : Stopwatch*)
  fun stopwatch_stop = dStopwatchStop(x0 : Stopwatch*)
  fun stopwatch_time = dStopwatchTime(x0 : Stopwatch*) : LibC::Double
  fun timer_start = dTimerStart(escription : LibC::Char*)
  fun timer_now = dTimerNow(escription : LibC::Char*)
  fun timer_end = dTimerEnd
  fun timer_report = dTimerReport(fout : File*, average : LibC::Int)
  fun timer_ticks_per_second = dTimerTicksPerSecond : LibC::Double
  fun timer_resolution = dTimerResolution : LibC::Double
  fun r_set_identity = dRSetIdentity(r : Matrix3)
  fun r_from_axis_and_angle = dRFromAxisAndAngle(r : Matrix3, ax : Real, ay : Real, az : Real, angle : Real)
  fun r_from_euler_angles = dRFromEulerAngles(r : Matrix3, phi : Real, theta : Real, psi : Real)
  fun r_from2axes = dRFrom2Axes(r : Matrix3, ax : Real, ay : Real, az : Real, bx : Real, by : Real, bz : Real)
  fun r_from_z_axis = dRFromZAxis(r : Matrix3, ax : Real, ay : Real, az : Real)
  fun q_set_identity = dQSetIdentity(q : Quaternion)
  fun q_from_axis_and_angle = dQFromAxisAndAngle(q : Quaternion, ax : Real, ay : Real, az : Real, angle : Real)
  fun q_multiply0 = dQMultiply0(qa : Quaternion, qb : Quaternion, qc : Quaternion)
  fun q_multiply1 = dQMultiply1(qa : Quaternion, qb : Quaternion, qc : Quaternion)
  fun q_multiply2 = dQMultiply2(qa : Quaternion, qb : Quaternion, qc : Quaternion)
  fun q_multiply3 = dQMultiply3(qa : Quaternion, qb : Quaternion, qc : Quaternion)
  fun rfrom_q = dRfromQ(r : Matrix3, q : Quaternion)
  fun qfrom_r = dQfromR(q : Quaternion, r : Matrix3)
  fun d_qfrom_w = dDQfromW(q : Real[4], w : Vector3, q : Quaternion)
end
