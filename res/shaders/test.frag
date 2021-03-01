//@type fragment
#version 130

uniform sampler2D baseTexture;
varying vec4 texCoord;

void main()
{
  //gl_FragColor = texture(baseTexture, texCoord.xy);
  gl_FragColor = gl_FragCoord;
}
