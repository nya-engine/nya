@[Link("GL")]
@[Include("GL/glcorearb.h", "GL/gl.h", flags: "-D GL_GLEXT_PROTOTYPES -I/usr/lib64/clang/5.0.1/include/", prefix: %w(gl GL_))]
lib LibGL

end
