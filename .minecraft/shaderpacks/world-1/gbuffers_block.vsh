#version 120
#include "/settings/lib.h"

//*-*-Skylec Shader-*-*

attribute vec4 mc_Entity;

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform float frameTimeCounter;
uniform vec3 sunPosition;
uniform vec3 cameraPosition;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 cPos;//Chunked Position
varying vec3 wPos;//World Position
varying vec3 sunPos;//Sun Position
varying vec3 glnormal;
varying vec4 glcolor;

//*-*-Main-*-*
void main(){

gl_Position=ftransform();

texcoord=(gl_TextureMatrix[0]*gl_MultiTexCoord0).xy;
lmcoord=(gl_TextureMatrix[1]*gl_MultiTexCoord1).xy;
glcolor=gl_Color;
glnormal=gl_Normal;

sunPos=(vec4(sunPosition,1.)*gl_ModelViewMatrix).xyz;
vec4 pos=gbufferModelViewInverse*gl_ModelViewMatrix*gl_Vertex;
cPos=pos.xyz+cameraPosition;
wPos=pos.xyz;

gl_Position=gl_ProjectionMatrix*gbufferModelView*pos;
}