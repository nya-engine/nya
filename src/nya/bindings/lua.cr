@[Link("lua")]
lib LibLua
  fun newstate = lua_newstate(f : Alloc, ud : Void*) : State
  alias Alloc = (Void*, Void*, LibC::SizeT, LibC::SizeT -> Void*)
  type State = Void*
  fun close = lua_close(l : State)
  fun newthread = lua_newthread(l : State) : State
  fun atpanic = lua_atpanic(l : State, panicf : CFunction) : CFunction
  alias CFunction = (State -> LibC::Int)
  fun gettop = lua_gettop(l : State) : LibC::Int
  fun settop = lua_settop(l : State, idx : LibC::Int)
  fun pushvalue = lua_pushvalue(l : State, idx : LibC::Int)
  fun remove = lua_remove(l : State, idx : LibC::Int)
  fun insert = lua_insert(l : State, idx : LibC::Int)
  fun replace = lua_replace(l : State, idx : LibC::Int)
  fun checkstack = lua_checkstack(l : State, sz : LibC::Int) : LibC::Int
  fun xmove = lua_xmove(from : State, to : State, n : LibC::Int)
  fun isnumber = lua_isnumber(l : State, idx : LibC::Int) : LibC::Int
  fun isstring = lua_isstring(l : State, idx : LibC::Int) : LibC::Int
  fun iscfunction = lua_iscfunction(l : State, idx : LibC::Int) : LibC::Int
  fun isuserdata = lua_isuserdata(l : State, idx : LibC::Int) : LibC::Int
  fun type = lua_type(l : State, idx : LibC::Int) : LibC::Int
  fun typename = lua_typename(l : State, tp : LibC::Int) : LibC::Char*
  fun equal = lua_equal(l : State, idx1 : LibC::Int, idx2 : LibC::Int) : LibC::Int
  fun rawequal = lua_rawequal(l : State, idx1 : LibC::Int, idx2 : LibC::Int) : LibC::Int
  fun lessthan = lua_lessthan(l : State, idx1 : LibC::Int, idx2 : LibC::Int) : LibC::Int
  fun tonumber = lua_tonumber(l : State, idx : LibC::Int) : Number
  alias Number = LibC::Double
  fun tointeger = lua_tointeger(l : State, idx : LibC::Int) : Integer
  alias PtrdiffT = LibC::Long
  alias Integer = PtrdiffT
  fun toboolean = lua_toboolean(l : State, idx : LibC::Int) : LibC::Int
  fun tolstring = lua_tolstring(l : State, idx : LibC::Int, len : LibC::SizeT*) : LibC::Char*
  fun objlen = lua_objlen(l : State, idx : LibC::Int) : LibC::SizeT
  fun tocfunction = lua_tocfunction(l : State, idx : LibC::Int) : CFunction
  fun touserdata = lua_touserdata(l : State, idx : LibC::Int) : Void*
  fun tothread = lua_tothread(l : State, idx : LibC::Int) : State
  fun topointer = lua_topointer(l : State, idx : LibC::Int) : Void*
  fun pushnil = lua_pushnil(l : State)
  fun pushnumber = lua_pushnumber(l : State, n : Number)
  fun pushinteger = lua_pushinteger(l : State, n : Integer)
  fun pushlstring = lua_pushlstring(l : State, s : LibC::Char*, l : LibC::SizeT)
  fun pushstring = lua_pushstring(l : State, s : LibC::Char*)
  fun pushvfstring = lua_pushvfstring(l : State, fmt : LibC::Char*, argp : VaList) : LibC::Char*
  alias VaList = Void*
  fun pushfstring = lua_pushfstring(l : State, fmt : LibC::Char*, ...) : LibC::Char*
  fun pushcclosure = lua_pushcclosure(l : State, fn : CFunction, n : LibC::Int)
  fun pushboolean = lua_pushboolean(l : State, b : LibC::Int)
  fun pushlightuserdata = lua_pushlightuserdata(l : State, p : Void*)
  fun pushthread = lua_pushthread(l : State) : LibC::Int
  fun gettable = lua_gettable(l : State, idx : LibC::Int)
  fun getfield = lua_getfield(l : State, idx : LibC::Int, k : LibC::Char*)
  fun rawget = lua_rawget(l : State, idx : LibC::Int)
  fun rawgeti = lua_rawgeti(l : State, idx : LibC::Int, n : LibC::Int)
  fun createtable = lua_createtable(l : State, narr : LibC::Int, nrec : LibC::Int)
  fun newuserdata = lua_newuserdata(l : State, sz : LibC::SizeT) : Void*
  fun getmetatable = lua_getmetatable(l : State, objindex : LibC::Int) : LibC::Int
  fun getfenv = lua_getfenv(l : State, idx : LibC::Int)
  fun settable = lua_settable(l : State, idx : LibC::Int)
  fun setfield = lua_setfield(l : State, idx : LibC::Int, k : LibC::Char*)
  fun rawset = lua_rawset(l : State, idx : LibC::Int)
  fun rawseti = lua_rawseti(l : State, idx : LibC::Int, n : LibC::Int)
  fun setmetatable = lua_setmetatable(l : State, objindex : LibC::Int) : LibC::Int
  fun setfenv = lua_setfenv(l : State, idx : LibC::Int) : LibC::Int
  fun call = lua_call(l : State, nargs : LibC::Int, nresults : LibC::Int)
  fun pcall = lua_pcall(l : State, nargs : LibC::Int, nresults : LibC::Int, errfunc : LibC::Int) : LibC::Int
  fun cpcall = lua_cpcall(l : State, func : CFunction, ud : Void*) : LibC::Int
  fun load = lua_load(l : State, reader : Reader, dt : Void*, chunkname : LibC::Char*) : LibC::Int
  alias Reader = (State, Void*, LibC::SizeT* -> LibC::Char*)
  fun dump = lua_dump(l : State, writer : Writer, data : Void*) : LibC::Int
  alias Writer = (State, Void*, LibC::SizeT, Void* -> LibC::Int)
  fun yield = lua_yield(l : State, nresults : LibC::Int) : LibC::Int
  fun resume = lua_resume(l : State, narg : LibC::Int) : LibC::Int
  fun status = lua_status(l : State) : LibC::Int
  fun gc = lua_gc(l : State, what : LibC::Int, data : LibC::Int) : LibC::Int
  fun error = lua_error(l : State) : LibC::Int
  fun next = lua_next(l : State, idx : LibC::Int) : LibC::Int
  fun concat = lua_concat(l : State, n : LibC::Int)
  fun getallocf = lua_getallocf(l : State, ud : Void**) : Alloc
  fun setallocf = lua_setallocf(l : State, f : Alloc, ud : Void*)
  fun setlevel = lua_setlevel(from : State, to : State)
  struct Debug
    event : LibC::Int
    name : LibC::Char*
    namewhat : LibC::Char*
    what : LibC::Char*
    source : LibC::Char*
    currentline : LibC::Int
    nups : LibC::Int
    linedefined : LibC::Int
    lastlinedefined : LibC::Int
    short_src : LibC::Char[60]
    i_ci : LibC::Int
  end
  fun getstack = lua_getstack(l : State, level : LibC::Int, ar : Debug*) : LibC::Int
  fun getinfo = lua_getinfo(l : State, what : LibC::Char*, ar : Debug*) : LibC::Int
  fun getlocal = lua_getlocal(l : State, ar : Debug*, n : LibC::Int) : LibC::Char*
  fun setlocal = lua_setlocal(l : State, ar : Debug*, n : LibC::Int) : LibC::Char*
  fun getupvalue = lua_getupvalue(l : State, funcindex : LibC::Int, n : LibC::Int) : LibC::Char*
  fun setupvalue = lua_setupvalue(l : State, funcindex : LibC::Int, n : LibC::Int) : LibC::Char*
  fun sethook = lua_sethook(l : State, func : Hook, mask : LibC::Int, count : LibC::Int) : LibC::Int
  alias Hook = (State, Debug* -> Void)
  fun gethook = lua_gethook(l : State) : Hook
  fun gethookmask = lua_gethookmask(l : State) : LibC::Int
  fun gethookcount = lua_gethookcount(l : State) : LibC::Int
  fun openlibs = luaL_openlibs(l : State)
  struct Reg
    name : LibC::Char*
    func : CFunction
  end
  fun openlib = luaL_openlib(l : State, libname : LibC::Char*, l : Reg*, nup : LibC::Int)
  fun register = luaL_register(l : State, libname : LibC::Char*, l : Reg*)
  fun getmetafield = luaL_getmetafield(l : State, obj : LibC::Int, e : LibC::Char*) : LibC::Int
  fun callmeta = luaL_callmeta(l : State, obj : LibC::Int, e : LibC::Char*) : LibC::Int
  fun typerror = luaL_typerror(l : State, narg : LibC::Int, tname : LibC::Char*) : LibC::Int
  fun argerror = luaL_argerror(l : State, numarg : LibC::Int, extramsg : LibC::Char*) : LibC::Int
  fun checklstring = luaL_checklstring(l : State, num_arg : LibC::Int, l : LibC::SizeT*) : LibC::Char*
  fun optlstring = luaL_optlstring(l : State, num_arg : LibC::Int, def : LibC::Char*, l : LibC::SizeT*) : LibC::Char*
  fun checknumber = luaL_checknumber(l : State, num_arg : LibC::Int) : Number
  fun optnumber = luaL_optnumber(l : State, n_arg : LibC::Int, def : Number) : Number
  fun checkinteger = luaL_checkinteger(l : State, num_arg : LibC::Int) : Integer
  fun optinteger = luaL_optinteger(l : State, n_arg : LibC::Int, def : Integer) : Integer
  fun checkstack = luaL_checkstack(l : State, sz : LibC::Int, msg : LibC::Char*)
  fun checktype = luaL_checktype(l : State, narg : LibC::Int, t : LibC::Int)
  fun checkany = luaL_checkany(l : State, narg : LibC::Int)
  fun newmetatable = luaL_newmetatable(l : State, tname : LibC::Char*) : LibC::Int
  fun checkudata = luaL_checkudata(l : State, ud : LibC::Int, tname : LibC::Char*) : Void*
  fun where = luaL_where(l : State, lvl : LibC::Int)
  fun error = luaL_error(l : State, fmt : LibC::Char*, ...) : LibC::Int
  fun checkoption = luaL_checkoption(l : State, narg : LibC::Int, def : LibC::Char*, lst : LibC::Char**) : LibC::Int
  fun ref = luaL_ref(l : State, t : LibC::Int) : LibC::Int
  fun unref = luaL_unref(l : State, t : LibC::Int, ref : LibC::Int)
  fun loadfile = luaL_loadfile(l : State, filename : LibC::Char*) : LibC::Int
  fun loadbuffer = luaL_loadbuffer(l : State, buff : LibC::Char*, sz : LibC::SizeT, name : LibC::Char*) : LibC::Int
  fun loadstring = luaL_loadstring(l : State, s : LibC::Char*) : LibC::Int
  fun newstate = luaL_newstate : State
  fun gsub = luaL_gsub(l : State, s : LibC::Char*, p : LibC::Char*, r : LibC::Char*) : LibC::Char*
  fun findtable = luaL_findtable(l : State, idx : LibC::Int, fname : LibC::Char*, szhint : LibC::Int) : LibC::Char*
  struct Buffer
    p : LibC::Char*
    lvl : LibC::Int
    l : State
    buffer : LibC::Char[8192]
  end
  fun buffinit = luaL_buffinit(l : State, b : Buffer*)
  fun prepbuffer = luaL_prepbuffer(b : Buffer*) : LibC::Char*
  fun addlstring = luaL_addlstring(b : Buffer*, s : LibC::Char*, l : LibC::SizeT)
  fun addstring = luaL_addstring(b : Buffer*, s : LibC::Char*)
  fun addvalue = luaL_addvalue(b : Buffer*)
  fun pushresult = luaL_pushresult(b : Buffer*)
end

