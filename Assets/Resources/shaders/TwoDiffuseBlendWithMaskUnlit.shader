ÄShader "Griptonite/TwoDiffuseBlendWithMaskUnlit" {
Properties {
 _MainColor ("Main Color", Color) = (1,1,1,1)
 _SecondColor ("Second Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _SecondTex ("Second (RGB)", 2D) = "white" {}
 _BlendTex ("Mask (Alpha)", 2D) = "white" {}
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

varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;

attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord1.xy;
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _SecondTex;
uniform highp vec4 _SecondColor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainColor;
uniform highp float _ColorIntensity;
uniform sampler2D _BlendTex;
void main ()
{
  mediump vec4 c;
  mediump vec4 b;
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
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_BlendTex, xlv_TEXCOORD1);
  b = tmpvar_5;
  mediump float tmpvar_6;
  if ((b.w <= 0.0)) {
    tmpvar_6 = 0.0;
  } else {
    tmpvar_6 = max ((1.0 - ((1.0 - xlv_COLOR.w) / b.w)), 0.0);
  };
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((c1 * tmpvar_6) + (c2 * (1.0 - tmpvar_6)));
  c = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7.xyz * (xlv_COLOR.xyz * _ColorIntensity));
  c.xyz = tmpvar_8;
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