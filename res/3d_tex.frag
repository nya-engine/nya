//@type fragment
#version 130
uniform sampler3D tex;
varying vec3 texcoord;

void main()
{
  gl_FragColor = texture(tex, texcoord).rgba;
}
