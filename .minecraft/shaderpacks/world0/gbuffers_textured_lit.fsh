#version 120
#include "/settings/lib.h"

//*-*-Skylec Shader-*-*

uniform sampler2D lightmap;
uniform sampler2D texture;
uniform int isEyeInWater;
uniform float rainStrength;
uniform vec3 fogColor;
uniform vec3 skyColor;

varying vec2 lmcoord;
varying vec2 texcoord;
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

#ifdef LIGHT
if(length(diffuse.a)>.5)diffuse.rgb+=mix(vec3(0.),lightColor*max(lmcoord.x-.6,0.),saturate(1.-(day)+(1.-cave)));
#endif

#ifdef TONEMAP
vec3 color=mix(mix(caveColor,mix(mix(mix(nightColor,dayColor,day),duskColor,dusk),rainColor,rainStrength),cave),diffuse.rgb*underWaterColor,float(isEyeInWater==1));
diffuse.rgb=toneMap(diffuse.rgb,color);
#endif

gl_FragData[0]=diffuse;
}