@[Link(ldflags: "src/ext/tinyobj.o")]
@[Include(
  "tinyobj_loader_c.h", flags: "-I./ext -I/usr/lib/llvm-3.8/lib/clang/3.8.0/include/",
  prefix: %w(tinyobj_ TINYOBJ_)
  )]
lib TinyOBJ
end
