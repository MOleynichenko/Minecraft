#version 120
#include "/settings/lib.h"

//*-*-Skylec Shader-*-*

uniform sampler2D lightmap;
uniform sampler2D texture;
uniform int isEyeInWater;
uniform float far;
uniform float frameTimeCounter;
uniform float rainStrength;
uniform vec3 skyColor;
uniform vec3 fogColor;
uniform vec4 entityColor;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 cPos;//Chunked Position
varying vec3 wPos;//World Position
varying vec3 sunPos;//Sun Position
varying vec3 glnormal;
varying vec4 glcolor;

//*-*-Main-*-*
void main(){
vec4 diffuse=texture2D(texture,texcoord)*glcolor;
diffuse.rgb=mix(diffuse.rgb,entityColor.rgb,entityColor.a);

#ifdef UNDERWATER
float lmy=1.;
if(isEyeInWater!=1)lmy=lmcoord.y;
diffuse*=texture2D(lightmap,vec2(lmcoord.x,lmy));
#else
diffuse*=texture2D(lightmap,lmcoord);
#endif

#ifdef TONEMAP
diffuse.rgb=toneMap(diffuse.rgb,vec3(1.));
#endif

#ifdef LIGHT
if(length(diffuse.a)>.5)diffuse.rgb+=lightColor*max(lmcoord.x-.6,0.);
#endif

gl_FragData[0]=diffuse;
}