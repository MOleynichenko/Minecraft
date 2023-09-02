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

#ifdef LIGHT
if(length(diffuse.a)>.5)diffuse.rgb+=lightColor*max(lmcoord.x-.6,0.);
#endif

gl_FragData[0]=diffuse;
}