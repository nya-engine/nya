#version 130
//@type vertex
attribute vec3 coord3d;
varying vec3 texcoord;
void main(void) {
  texcoord = vec3(gl_MultiTexCoord0);
  gl_Position = vec4(coord3d, 1.0);
}
