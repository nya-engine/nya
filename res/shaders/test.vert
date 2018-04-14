//precision highp float;
#version 130
attribute vec3 nya_Position;
attribute vec3 nya_Normal;
uniform mat3 normalMatrix;
uniform mat4 nya_ModelView;
uniform mat4 nya_Projection;
varying vec3 fNormal;
varying vec3 fPosition;

void main()
{
  /*fNormal = normalize(gl_NormalMatrix * nya_Normal);
  vec4 pos = nya_ModelView * vec4(nya_Position, 1.0);
  fPosition = pos.xyz;
  //gl_Position = nya_Projection * pos;
  gl_Position = vec4(0.0, 0.0, 10.0, 1.0);*/
  vec3 pos = nya_Position;
  pos.z -= 500;
  gl_Position = vec4(pos, 1.0);
}
