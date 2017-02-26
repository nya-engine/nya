@[Link("openal")]
@[Include("AL/al.h","AL/alc.h","AL/alu.h","AL/alut.h", flags: "-I./ext -I/usr/lib/llvm-3.8/lib/clang/3.8.0/include/", prefix: %w(al AL_ alc))]
lib AL

end
