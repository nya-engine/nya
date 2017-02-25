all:

precompile_ext: src/nya_engine/ext/libtinyobj.a

src/nya_engine/ext/libtinyobj.a : src/nya_engine/ext/tinyobj.o
	ar rcs src/nya_engine/ext/libtinyobj.a src/nya_engine/ext/tinyobj.o

src/nya_engine/ext/tinyobj.o:
	mkdir -p src/nya_engine/ext
	gcc -o src/nya_engine/ext/tinyobj.o ext/tinyobj.c -c

.PHONY: recompile_ext
