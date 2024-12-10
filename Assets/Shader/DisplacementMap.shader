ÊShader "Billboard/Displacement Map Shader" {
Properties {
 _Background ("Background", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
 _BumpAmt ("Distortion", Range(0,0.1)) = 0.02
 _BlendAmt ("Blend Amount", Range(0,1)) = 0.5
}
SubShader { 
 Tags { "IGNOREPROJECTOR"="True" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="True" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;
#define gl_TextureMatrix0 glstate_matrix_texture0
uniform mat4 glstate_matrix_texture0;

varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;


attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec4 pos;
  highp vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * _glesVertex);
  pos = tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.x = _glesMultiTexCoord0.x;
  tmpvar_4.y = _glesMultiTexCoord0.y;
  tmpvar_3 = (gl_TextureMatrix0 * tmpvar_4).xy;
  tmpvar_1 = tmpvar_3;
  gl_Position = pos;
  xlv_TEXCOORD0 = (((pos.xy / pos.w) * 0.5) + 0.5);
  xlv_TEXCOORD1 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
uniform sampler2D _BumpMap;
uniform lowp float _BumpAmt;
uniform lowp float _BlendAmt;
uniform sampler2D _Background;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = texture2D (_Background, (xlv_TEXCOORD0 + ((texture2D (_BumpMap, xlv_TEXCOORD1).xy - 0.501961) * _BumpAmt))).xyz;
  tmpvar_1.w = _BlendAmt;
  gl_FragData[0] = tmpvar_1;
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
Fallback Off
}