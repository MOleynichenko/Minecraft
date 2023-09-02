#version 120
#include "/settings/lib.h"

//*-*-Skylec Shader-*-*

attribute vec4 mc_Entity;

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform float frameTimeCounter;
uniform vec3 sunPosition;
uniform vec3 cameraPosition;

varying float isPlant;
varying float isOre;
varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 cPos;//Chunked Position
varying vec3 wPos;//World Position
varying vec3 sunPos;//Sun Position
varying vec3 glnormal;
varying vec4 glcolor;

//*-*-Main-*-*
void main(){

isPlant=0.;
isOre=0.;

gl_Position=ftransform();

texcoord=(gl_TextureMatrix[0]*gl_MultiTexCoord0).xy;
lmcoord=(gl_TextureMatrix[1]*gl_MultiTexCoord1).xy;
glcolor=gl_Color;
glnormal=gl_Normal;

float e=mc_Entity.x;
if(e==141.||e==142.||e==59.||e==106.||e==127.||e==175.||e==83.||e==32.||e==37.||e==38.||e==31.||e==115.||e==6.||e==39.||e==40.||e==104.||e==105.)isPlant=1.;
if(e==56.||e==73.||e==129.||e==14.||e==15.||e==21.||e==79.)isOre=1.;

sunPos=(vec4(sunPosition,1.)*gl_ModelViewMatrix).xyz;
vec4 pos=gbufferModelViewInverse*gl_ModelViewMatrix*gl_Vertex;
cPos=pos.xyz+cameraPosition;

#ifdef WAVE
float wind=cos(frameTimeCounter*.3+cPos.x*.02+cPos.y*.04+cPos.z*.002);
if(isPlant>.5)pos.xz+=cos(frameTimeCounter*4.+dot(cPos,vec3(3.2,1.2,1.6)))*.02*wind*lmcoord.y;//Grasses, flowers, and other
if(e==18.||e==161.)pos.xz+=cos(frameTimeCounter*4.+dot(cPos,vec3(1.2,0.,.6)))*.02*wind*lmcoord.y;//Leaves
#endif

wPos=pos.xyz;

gl_Position=gl_ProjectionMatrix*gbufferModelView*pos;
}