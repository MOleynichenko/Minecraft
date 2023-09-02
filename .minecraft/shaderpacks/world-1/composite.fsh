#version 120
#include "/settings/lib.h"

//*-*-Skylec Shader-*-*

uniform sampler2D gcolor;
uniform int isEyeInWater;
uniform float frameTimeCounter;

varying vec2 texcoord;

//*-*-Main-*-*
void main(){
#ifdef UNDERWATER
vec3 diffuse=texture2D(gcolor,texcoord+mix(vec2(0.),vec2(snoise(texcoord*4+4.*4.+frameTimeCounter*.5)*.003),saturate(float(isEyeInWater)))).rgb;
#else
vec3 diffuse=texture2D(gcolor,texcoord).rgb;
#endif

gl_FragData[0]=vec4(diffuse,1.);
}