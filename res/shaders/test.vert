//@type vertex
#version 130

varying vec4 texCoord;

void main()
{
  gl_Position = ftransform();
  texCoord = gl_TexCoord[0];
}
