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

//*-*-Data Base-*-*
float indoor=smoothstep(.95,1.,lmcoord.y);
float cave=smoothstep(.7,1.,lmcoord.y);
float day=saturate(skyColor.r*2.);
float dusk=saturate((fogColor.r-.1)-fogColor.b);
float mainShadow=smoothstep(.95,.96,lmcoord.y);
float sideShadow=smoothstep(.64,.68,glcolor.g);

#ifdef TONEMAP
vec3 color=mix(mix(caveColor,mix(mix(mix(nightColor,dayColor,day),duskColor,dusk),rainColor,rainStrength),cave),diffuse.rgb*underWaterColor,float(isEyeInWater==1));
diffuse.rgb=toneMap(diffuse.rgb,color);
#endif

#ifdef RAIN
vec3 nWPos=normalize(wPos);
float rain=mix(0.,mix(0.,mix(0.,saturate(abs(length(nWPos.xz*.27/nWPos.y)))*.28,saturate(glnormal.y)),indoor),rainStrength);
diffuse.rgb+=rain;
#endif

#ifdef SHADOWS
float shadowDepth=mix(mix(1.,.73,day),1.,lmcoord.x*1.2);
diffuse.rgb*=mix(shadowDepth,1.,mainShadow);
diffuse.rgb*=mix(1.,mix(shadowDepth,1.,saturate(dot(sunPos,glnormal))),mainShadow);
#endif

#ifdef UNDERWATER
if(isEyeInWater==1){
vec3 p=cPos;p.xz*=vec2(1.,.5);
float wave=snoise(p.xz+frameTimeCounter*.3)+snoise(vec2(p.x+frameTimeCounter*.4,(p.z+frameTimeCounter*1.5)*.5));
diffuse.rgb+=mix(vec3(0.),vec3(.1),pow(saturate(1.-abs(wave)),1.4));
}
#endif

#ifdef LIGHT
if(length(diffuse.a)>.5)diffuse.rgb+=mix(vec3(0.),lightColor*max(lmcoord.x-.6,0.),saturate(1.-(day)+(1.-cave)+rainStrength*.5));
#endif

#ifdef FOG
vec3 fog=mix(mix(mix(mix(nightFogColor,dayFogColor,day),duskFogColor,dusk),rainFogColor,rainStrength),underwaterFogColor,float(isEyeInWater==1));
diffuse.rgb=mix(diffuse.rgb,fog,smoothstep(0.,far,length(wPos.zx)));
#endif

gl_FragData[0]=diffuse;
}