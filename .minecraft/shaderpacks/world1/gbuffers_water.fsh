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

varying float isWater;
varying vec2 lmcoord;
varying vec2 texcoord;
varying vec3 cPos;//Chunked Position
varying vec3 wPos;//World Position
varying vec3 glnormal;
varying vec4 glcolor;

//*-*-Main-*-*
void main(){
vec4 diffuse=texture2D(texture,texcoord)*glcolor;
diffuse*=texture2D(lightmap,lmcoord);

#ifdef TONEMAP
diffuse.rgb=toneMap(diffuse.rgb,vec3(1.));
#endif

#ifdef FOG
diffuse.rgb=mix(diffuse.rgb,fogColor,smoothstep(0.,far,length(wPos.zx)));
#endif

gl_FragData[0]=diffuse;
}