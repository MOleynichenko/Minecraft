#version 120

//*-*-Skylec Shader-*-*

varying vec2 texcoord;

//*-*-Main-*-*
void main(){
gl_Position=ftransform();
texcoord=(gl_TextureMatrix[0]*gl_MultiTexCoord0).xy;
}