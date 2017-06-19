//precision highp float;
//@type fragment
uniform float time;
uniform vec2 resolution;
varying vec3 fPosition;
varying vec3 fNormal;

void main()
{
  gl_FragColor = vec4(fNormal, 1.0);
}
