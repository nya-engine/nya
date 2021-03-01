//@type fragment

uniform sampler2D baseTexture;
in vec2 texCoord;

void main()
{
  gl_FragColor = texture(baseTexture, texCoord);
}
