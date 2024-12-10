®Shader "Griptonite/TwoDiffuseBlendUnlit" {
Properties {
 _MainColor ("Main Color", Color) = (1,1,1,1)
 _SecondColor ("Second Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _SecondTex ("Second (RGB)", 2D) = "white" {}
 _ColorIntensity ("Color Intensity", Range(0,4)) = 1
}
SubShader { 
 Pass {
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;

uniform highp vec4 _MainTex_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform sampler2D _SecondTex;
uniform highp vec4 _SecondColor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainColor;
uniform highp float _ColorIntensity;
void main ()
{
  mediump vec4 c;
  mediump vec4 c2;
  mediump vec4 c1;
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2 = (tmpvar_1 * _MainColor);
  c1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_SecondTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _SecondColor);
  c2 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((c1 * xlv_COLOR.w) + (c2 * (1.0 - xlv_COLOR.w)));
  c = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5.xyz * (xlv_COLOR.xyz * _ColorIntensity));
  c.xyz = tmpvar_6;
  gl_FragData[0] = c;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
}
 }
}
}