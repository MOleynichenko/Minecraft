#version 120
#include "/settings/lib.h"

//*-*-Skylec Shader-*-*

attribute vec4 mc_Entity;

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform float frameTimeCounter;
uniform vec3 sunPosition;
uniform vec3 cameraPosition;

varying float isWater;
varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 cPos;//Chunked Position
varying vec3 wPos;//World Position
varying vec3 sunPos;//Sun Position
varying vec3 glnormal;
varying vec4 glcolor;

//*-*-Main-*-*
void main(){

isWater=0.;
gl_Position=ftransform();

texcoord=(gl_TextureMatrix[0]*gl_MultiTexCoord0).xy;
lmcoord=(gl_TextureMatrix[1]*gl_MultiTexCoord1).xy;
glcolor=gl_Color;
glnormal=gl_Normal;

float e=mc_Entity.x;
if(e==8.||e==9.)isWater=1.;

sunPos=(vec4(sunPosition,1.)*gl_ModelViewMatrix).xyz;
vec4 pos=gbufferModelViewInverse*gl_ModelViewMatrix*gl_Vertex;
cPos=pos.xyz+cameraPosition;

#ifdef WAVE
float wind=cos(frameTimeCounter*.3+cPos.x*.02+cPos.y*.04+cPos.z*.002);
if(isWater>.5)pos.y-=cos(frameTimeCounter*4.+dot(cPos,vec3(1.1)))*.08*wind;
#endif

wPos=pos.xyz;

gl_Position=gl_ProjectionMatrix*gbufferModelView*pos;
}