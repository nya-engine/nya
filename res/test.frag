//precision highp float;
uniform float time;
uniform vec2 resolution;
varying vec3 fPosition;
varying vec3 fNormal;
varying vec4 tex_c;
//@type fragment
void main()
{
  gl_FragColor = tex_c;

}
