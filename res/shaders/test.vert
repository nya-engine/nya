//@type vertex

out vec2 texCoord;

void main()
{
  gl_Position = ftransform();
  texCoord = gl_TexCoord;
}
