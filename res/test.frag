//precision highp float;
uniform float time;
uniform vec2 resolution;
varying vec3 fPosition;
varying vec3 fNormal;
//@type fragment
void main()
{
  gl_FragColor = vec4(fNormal, 1.0) + gl_FragCoord/20.0;

}
