@[Link("lua")]
@[Include("lua.h", "lualib.h", "lauxlib.h", flags: "-I/usr/lib64/clang/5.0.1/include/", prefix: %w(lua_ luaL_))]
lib LibLua

end
