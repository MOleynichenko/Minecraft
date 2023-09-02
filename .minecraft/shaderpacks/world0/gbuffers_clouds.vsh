#version 120

//*-*-Skylec Shader-*-*

varying vec2 texcoord;
varying vec4 glcolor;

//*-*-Main-*-*
void main(){
gl_Position=ftransform();
texcoord=(gl_TextureMatrix[0]*gl_MultiTexCoord0).xy;
glcolor=gl_Color;
}