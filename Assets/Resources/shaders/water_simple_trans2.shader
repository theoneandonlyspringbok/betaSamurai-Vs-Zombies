Ð Shader "FX/Water (trans)" {
Properties {
 _horizonColor ("Horizon color", Color) = (0.172,0.463,0.435,0)
 _WaveScale ("Wave scale", Range(0.02,0.15)) = 0.07
 _ColorControl ("Reflective color (RGB) fresnel (A) ", 2D) = "" {}
 _ColorControlCube ("Reflective color cube (RGB) fresnel (A) ", CUBE) = "" { TexGen CubeReflect }
 _BumpMap ("Waves Normalmap ", 2D) = "" {}
 WaveSpeed ("Wave speed (map1 x,y; map2 x,y)", Vector) = (19,9,-16,-7)
 _MainTex ("Fallback texture", 2D) = "" {}
 _Opacity ("Opacity", Range(0,1)) = 1
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 _World2Object;
uniform highp float _WaveScale;
uniform highp vec4 _WaveOffset;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 temp;
  vec2 tmpvar_1[2];
  temp = (((_glesVertex.xzxz * _WaveScale) / unity_Scale.w) + _WaveOffset);
  tmpvar_1[0] = (temp.xy * vec2(0.4, 0.45));
  tmpvar_1[1] = temp.wz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1[0];
  xlv_TEXCOORD0_1 = tmpvar_1[1];
  xlv_TEXCOORD2 = normalize ((((_World2Object * tmpvar_2).xyz * unity_Scale.w) - _glesVertex.xyz)).xzy;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _horizonColor;
uniform highp float _Opacity;
uniform sampler2D _ColorControl;
uniform sampler2D _BumpMap;
void main ()
{
  vec2 tmpvar_1[2];
  tmpvar_1[0] = xlv_TEXCOORD0;
  tmpvar_1[1] = xlv_TEXCOORD0_1;
  mediump vec4 col;
  mediump vec4 water;
  mediump float fresnel;
  mediump vec3 bump2;
  mediump vec3 bump1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = ((texture2D (_BumpMap, tmpvar_1[0]).xyz * 2.0) - 1.0);
  bump1 = tmpvar_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_BumpMap, tmpvar_1[1]).xyz * 2.0) - 1.0);
  bump2 = tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = ((bump1 + bump2) * 0.5);
  highp float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD2, tmpvar_4);
  fresnel = tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6.x = fresnel;
  tmpvar_6.y = fresnel;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ColorControl, tmpvar_6);
  water = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = water.www;
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (water.xyz, _horizonColor.xyz, tmpvar_8);
  col.xyz = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_horizonColor.w * _Opacity);
  col.w = tmpvar_10;
  gl_FragData[0] = col;
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
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  Color (0.5,0.5,0.5,0.5)
  Blend SrcAlpha OneMinusSrcAlpha
  SetTexture [_MainTex] { Matrix [_WaveMatrix] combine texture * primary }
  SetTexture [_MainTex] { Matrix [_WaveMatrix2] combine texture * primary + previous }
  SetTexture [_ColorControlCube] { Matrix [_Reflection] combine texture +- previous, primary alpha }
 }
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  Color (0.5,0.5,0.5,0.5)
  Blend SrcAlpha OneMinusSrcAlpha
  SetTexture [_MainTex] { Matrix [_WaveMatrix] combine texture }
  SetTexture [_ColorControlCube] { Matrix [_Reflection] combine texture +- previous, primary alpha }
 }
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  Color (0.5,0.5,0.5,0)
  Blend SrcAlpha OneMinusSrcAlpha
  SetTexture [_MainTex] { Matrix [_WaveMatrix] combine texture, primary alpha }
 }
}
}