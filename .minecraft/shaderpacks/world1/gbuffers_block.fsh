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

#ifdef UNDERWATER
if(isEyeInWater==1){
vec3 p=cPos;p.xz*=vec2(1.,.5);
float wave=snoise(p.xz+frameTimeCounter*.3)+snoise(vec2(p.x+frameTimeCounter*.4,(p.z+frameTimeCounter*1.5)*.5));
diffuse.rgb+=mix(vec3(0.),vec3(.1),pow(saturate(1.-abs(wave)),1.4));
}
#endif

#ifdef LIGHT
if(length(diffuse.a)>.5)diffuse.rgb+=lightColor*max(lmcoord.x-.6,0.);
#endif

#ifdef FOG
diffuse.rgb=mix(diffuse.rgb,fogColor,smoothstep(0.,far,length(wPos.zx)));
#endif

gl_FragData[0]=diffuse;
}