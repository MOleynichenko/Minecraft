#version 120
#include "/settings/lib.h"

//*-*-Skylec Shader-*-*

uniform sampler2D texture;

varying vec2 texcoord;
varying vec4 glcolor;

//*-*-Main-*-*
void main(){

#ifdef VANILLACLOUDS
vec4 diffuse=texture2D(texture,texcoord)*glcolor;
gl_FragData[0]=diffuse;
#else
discard;
#endif

}