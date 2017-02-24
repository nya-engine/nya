all:

precompile_ext: tinyobj.o

tinyobj.o:
	mkdir -p src/nya_engine/ext
	gcc -o src/nya_engine/ext/tinyobj.o ext/tinyobj.c -c
