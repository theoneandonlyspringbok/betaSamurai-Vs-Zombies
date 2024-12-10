öShader "Griptonite/TextureCutoffWithUVOffset" {
Properties {
 _Intensity ("Intensity", Float) = 0.1
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _OffsetTex ("Offset (IA)", 2D) = "white" {}
 _Cutoff ("Alpha Cutoff", Range(0,0.9)) = 0.5
}
SubShader { 
 Tags { "QUEUE"="AlphaTest" "RenderType"="TransparentCutout" }
 Pass {
  Tags { "QUEUE"="AlphaTest" "RenderType"="TransparentCutout" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;

uniform highp vec4 _OffsetTex_ST;
uniform highp vec4 _MainTex_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * _OffsetTex_ST.xy) + _OffsetTex_ST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _OffsetTex;
uniform sampler2D _MainTex;
uniform highp float _Intensity;
uniform highp float _Cutoff;
void main ()
{
  mediump vec4 c;
  mediump vec2 texOffset;
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_OffsetTex, xlv_TEXCOORD1);
  highp vec2 tmpvar_2;
  tmpvar_2 = (tmpvar_1.wz * _Intensity);
  texOffset = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, (xlv_TEXCOORD0 + texOffset));
  c = tmpvar_3;
  float x;
  x = (c.w - _Cutoff);
  if ((x < 0.0)) {
    discard;
  };
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