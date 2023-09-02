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
varying vec3 sunPos;//Sun Position
varying vec3 glnormal;
varying vec4 glcolor;

//*-*-Main-*-*
void main(){
vec4 diffuse=texture2D(texture,texcoord)*glcolor;
diffuse*=texture2D(lightmap,lmcoord);

//*-*-Data Base-*-*
float indoor=smoothstep(.95,1.,lmcoord.y);
float cave=smoothstep(.7,1.,lmcoord.y);
float day=saturate(skyColor.r*2.);
float dusk=saturate((fogColor.r-.1)-fogColor.b);

#ifdef TONEMAP
vec3 color=mix(mix(caveColor,mix(mix(mix(nightColor,dayColor,day),duskColor,dusk),rainColor,rainStrength),cave),diffuse.rgb*underWaterColor,float(isEyeInWater==1));
diffuse.rgb=toneMap(diffuse.rgb,color);
#endif

#ifdef WATER
if(isWater>.5&&isEyeInWater==0){
vec3 p=cPos;p.xz*=vec2(1.2,.5);
vec3 nWPos=normalize(wPos);
float wave=snoise(p.xz+frameTimeCounter*.3)+snoise(vec2(p.x+frameTimeCounter*.4,(p.z+frameTimeCounter*1.5)*.5));
float cloudRef=saturate(snoise((wPos.xz+wave*2.*wPos.xz/max(length(wPos.xz),.5))*.2));
float moonRef=saturate((1.-length(nWPos.z*3.)));
vec3 cc=mix(vec3(.7),mix(mix(mix(vec3(.7,.7,.9),vec3(1.5),day),vec3(2.,1.5,.8),dusk),vec3(.2),rainStrength),cave);
float wLen=saturate(length(nWPos.xz*.5/nWPos.y));
vec3 waterColor=mix(mix(mix(nightWaterColor,dayWaterColor,day),duskWaterColor,dusk),rainWaterColor,rainStrength);
diffuse.rgb=toneMap(diffuse.rgb,waterColor);
diffuse.rgb*=mix(vec3(.7,.9,.98),vec3(1.),wave);
diffuse.rgb=mix(diffuse.rgb,mix(cc,diffuse.rgb,rainStrength),(cloudRef*.3*wLen+moonRef*mix(mix(.4,.3,day),.6,dusk)*pow(abs(wave),2.)*wLen)*lmcoord.y);
}
#endif

#ifdef UNDERWATER
if(isEyeInWater==1){
vec3 p=cPos;p.xz*=vec2(1.,.5);
float wave=snoise(p.xz+frameTimeCounter*.3)+snoise(vec2(p.x+frameTimeCounter*.4,(p.z+frameTimeCounter*1.5)*.5));
diffuse.rgb+=mix(vec3(0.),vec3(.13),pow(saturate(1.-abs(wave)),1.4));
}
#endif

#ifdef FOG
vec3 fog=mix(mix(mix(mix(nightFogColor,dayFogColor,day),duskFogColor,dusk),rainFogColor,rainStrength),underwaterFogColor,float(isEyeInWater==1));
diffuse.rgb=mix(diffuse.rgb,fog,smoothstep(0.,far,length(wPos.zx)));
#endif

gl_FragData[0]=diffuse;
}