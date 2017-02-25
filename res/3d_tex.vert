#version 120
//@type vertex
attribute vec3 coord3d;
varying vec4 tex_c;
void main(void) {
  tex_c = gl_MultiTexCoord0;
  gl_Position = vec4(coord3d, 1.0);
}
