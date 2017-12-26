//precision highp float;
attribute vec3 nya_Position;
attribute vec3 nya_Normal;
uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
varying vec3 fNormal;
varying vec3 fPosition;

void main()
{
  fNormal = normalize(gl_NormalMatrix * nya_Normal);
  vec4 pos = gl_ModelViewMatrix * vec4(nya_Position, 1.0);
  fPosition = pos.xyz;
  gl_Position = gl_ProjectionMatrix * pos;
}
