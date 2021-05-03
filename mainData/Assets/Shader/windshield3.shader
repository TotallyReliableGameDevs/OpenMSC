Shader "Windshield/windshield" {
Properties {
 _Color ("Color", Color) = (1,1,1,1)
 _MainTex ("Albedo (RGB)", 2D) = "white" { }
 _BumpMap ("Normal", 2D) = "white" { }
 _Glossiness ("Smoothness", Range(0,1)) = 0.5
 _Rain ("Rain", 2D) = "zeroRGBA" { }
 _RainOpacity ("Rain Opacity", Range(0,1)) = 0.5
 _Raining ("Raining (On/Off)", Range(0,1)) = 0
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask RGB
  GpuProgramID 13587
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * TANGENT.xyz));
  vec3 tmpvar_9;
  tmpvar_9 = (((tmpvar_6.yzx * tmpvar_8.zxy) - (tmpvar_6.zxy * tmpvar_8.yzx)) * TANGENT.w);
  vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_8.x;
  tmpvar_10.y = tmpvar_9.x;
  tmpvar_10.z = tmpvar_6.x;
  tmpvar_10.w = tmpvar_2.x;
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8.y;
  tmpvar_11.y = tmpvar_9.y;
  tmpvar_11.z = tmpvar_6.y;
  tmpvar_11.w = tmpvar_2.y;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_8.z;
  tmpvar_12.y = tmpvar_9.z;
  tmpvar_12.z = tmpvar_6.z;
  tmpvar_12.w = tmpvar_2.z;
  vec3 x2_13;
  vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_13.x = dot (unity_SHBr, tmpvar_14);
  x2_13.y = dot (unity_SHBg, tmpvar_14);
  x2_13.z = dot (unity_SHBb, tmpvar_14);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = (x2_13 + (unity_SHC.xyz * (
    (tmpvar_6.x * tmpvar_6.x)
   - 
    (tmpvar_6.y * tmpvar_6.y)
  )));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Rain;
uniform float _RainOpacity;
uniform float _Raining;
uniform float _Glossiness;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  float tmpvar_1;
  vec3 worldN_2;
  vec3 tmpvar_3;
  float tmpvar_4;
  float tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_6));
  vec3 tmpvar_8;
  vec3 tmpvar_9;
  float tmpvar_10;
  float tmpvar_11;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = tmpvar_3;
  tmpvar_10 = tmpvar_5;
  tmpvar_11 = 0.0;
  if ((_Raining > 0.0)) {
    vec4 tmpvar_12;
    tmpvar_12 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    vec4 tmpvar_13;
    tmpvar_13 = texture2D (_Rain, xlv_TEXCOORD0);
    tmpvar_8 = ((tmpvar_12.xyz * (1.0 - tmpvar_13.w)) + (tmpvar_13.x * tmpvar_13.w));
    vec3 normal_14;
    normal_14.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_14.z = sqrt((1.0 - clamp (
      dot (normal_14.xy, normal_14.xy)
    , 0.0, 1.0)));
    tmpvar_9 = normalize(((normal_14 * 
      (1.0 - tmpvar_13.w)
    ) + (vec3(0.0, 0.0, 1.0) * tmpvar_13.w)));
    tmpvar_10 = _Glossiness;
    tmpvar_11 = (tmpvar_12.w + (tmpvar_13.w * _RainOpacity));
  } else {
    vec4 tmpvar_15;
    tmpvar_15 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    tmpvar_8 = tmpvar_15.xyz;
    vec3 normal_16;
    normal_16.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_16.z = sqrt((1.0 - clamp (
      dot (normal_16.xy, normal_16.xy)
    , 0.0, 1.0)));
    tmpvar_9 = normal_16;
    tmpvar_10 = _Glossiness;
    tmpvar_11 = tmpvar_15.w;
  };
  tmpvar_5 = tmpvar_10;
  worldN_2.x = dot (xlv_TEXCOORD1.xyz, tmpvar_9);
  worldN_2.y = dot (xlv_TEXCOORD2.xyz, tmpvar_9);
  worldN_2.z = dot (xlv_TEXCOORD3.xyz, tmpvar_9);
  tmpvar_3 = worldN_2;
  tmpvar_1 = max (0.0, dot (worldN_2, _WorldSpaceLightPos0.xyz));
  vec3 tmpvar_17;
  vec3 tmpvar_18;
  tmpvar_18 = vec3(0.0, 0.0, 0.0);
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = worldN_2;
  vec3 x1_20;
  x1_20.x = dot (unity_SHAr, tmpvar_19);
  x1_20.y = dot (unity_SHAg, tmpvar_19);
  x1_20.z = dot (unity_SHAb, tmpvar_19);
  tmpvar_17 = (xlv_TEXCOORD4 + x1_20);
  vec3 tmpvar_21;
  vec3 I_22;
  I_22 = -(tmpvar_7);
  tmpvar_21 = (I_22 - (2.0 * (
    dot (worldN_2, I_22)
   * worldN_2)));
  vec3 worldNormal_23;
  worldNormal_23 = tmpvar_21;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_24;
    tmpvar_24 = normalize(tmpvar_21);
    vec3 tmpvar_25;
    tmpvar_25 = ((unity_SpecCube0_BoxMax.xyz - tmpvar_6) / tmpvar_24);
    vec3 tmpvar_26;
    tmpvar_26 = ((unity_SpecCube0_BoxMin.xyz - tmpvar_6) / tmpvar_24);
    bvec3 tmpvar_27;
    tmpvar_27 = greaterThan (tmpvar_24, vec3(0.0, 0.0, 0.0));
    float tmpvar_28;
    if (tmpvar_27.x) {
      tmpvar_28 = tmpvar_25.x;
    } else {
      tmpvar_28 = tmpvar_26.x;
    };
    float tmpvar_29;
    if (tmpvar_27.y) {
      tmpvar_29 = tmpvar_25.y;
    } else {
      tmpvar_29 = tmpvar_26.y;
    };
    float tmpvar_30;
    if (tmpvar_27.z) {
      tmpvar_30 = tmpvar_25.z;
    } else {
      tmpvar_30 = tmpvar_26.z;
    };
    vec3 tmpvar_31;
    tmpvar_31 = ((unity_SpecCube0_BoxMax.xyz + unity_SpecCube0_BoxMin.xyz) * 0.5);
    worldNormal_23 = (((
      (tmpvar_31 - unity_SpecCube0_ProbePosition.xyz)
     + tmpvar_6) + (tmpvar_24 * 
      min (min (tmpvar_28, tmpvar_29), tmpvar_30)
    )) - tmpvar_31);
  };
  vec4 tmpvar_32;
  tmpvar_32.xyz = worldNormal_23;
  tmpvar_32.w = (pow ((1.0 - tmpvar_10), 0.75) * 7.0);
  vec4 tmpvar_33;
  tmpvar_33 = textureCubeLod (unity_SpecCube0, worldNormal_23, tmpvar_32.w);
  vec3 tmpvar_34;
  tmpvar_34 = ((unity_SpecCube0_HDR.x * pow (tmpvar_33.w, unity_SpecCube0_HDR.y)) * tmpvar_33.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldNormal_35;
    worldNormal_35 = tmpvar_21;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_36;
      tmpvar_36 = normalize(tmpvar_21);
      vec3 tmpvar_37;
      tmpvar_37 = ((unity_SpecCube1_BoxMax.xyz - tmpvar_6) / tmpvar_36);
      vec3 tmpvar_38;
      tmpvar_38 = ((unity_SpecCube1_BoxMin.xyz - tmpvar_6) / tmpvar_36);
      bvec3 tmpvar_39;
      tmpvar_39 = greaterThan (tmpvar_36, vec3(0.0, 0.0, 0.0));
      float tmpvar_40;
      if (tmpvar_39.x) {
        tmpvar_40 = tmpvar_37.x;
      } else {
        tmpvar_40 = tmpvar_38.x;
      };
      float tmpvar_41;
      if (tmpvar_39.y) {
        tmpvar_41 = tmpvar_37.y;
      } else {
        tmpvar_41 = tmpvar_38.y;
      };
      float tmpvar_42;
      if (tmpvar_39.z) {
        tmpvar_42 = tmpvar_37.z;
      } else {
        tmpvar_42 = tmpvar_38.z;
      };
      vec3 tmpvar_43;
      tmpvar_43 = ((unity_SpecCube1_BoxMax.xyz + unity_SpecCube1_BoxMin.xyz) * 0.5);
      worldNormal_35 = (((
        (tmpvar_43 - unity_SpecCube1_ProbePosition.xyz)
       + tmpvar_6) + (tmpvar_36 * 
        min (min (tmpvar_40, tmpvar_41), tmpvar_42)
      )) - tmpvar_43);
    };
    vec4 tmpvar_44;
    tmpvar_44.xyz = worldNormal_35;
    tmpvar_44.w = (pow ((1.0 - tmpvar_10), 0.75) * 7.0);
    vec4 tmpvar_45;
    tmpvar_45 = textureCubeLod (unity_SpecCube1, worldNormal_35, tmpvar_44.w);
    tmpvar_18 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_45.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_45.xyz), tmpvar_34, unity_SpecCube0_BoxMin.www);
  } else {
    tmpvar_18 = tmpvar_34;
  };
  vec4 c_46;
  vec3 tmpvar_47;
  tmpvar_47 = normalize(worldN_2);
  vec3 tmpvar_48;
  tmpvar_48 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_8, vec3(tmpvar_4));
  float tmpvar_49;
  tmpvar_49 = (unity_ColorSpaceDielectricSpec.w - (tmpvar_4 * unity_ColorSpaceDielectricSpec.w));
  float tmpvar_50;
  tmpvar_50 = (1.0 - tmpvar_10);
  vec3 tmpvar_51;
  tmpvar_51 = normalize((_WorldSpaceLightPos0.xyz + tmpvar_7));
  float tmpvar_52;
  tmpvar_52 = max (0.0, dot (tmpvar_47, tmpvar_7));
  float tmpvar_53;
  tmpvar_53 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_51));
  float tmpvar_54;
  tmpvar_54 = ((tmpvar_50 * tmpvar_50) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_55;
  float tmpvar_56;
  tmpvar_56 = (10.0 / log2((
    ((1.0 - tmpvar_50) * 0.968)
   + 0.03)));
  tmpvar_55 = (tmpvar_56 * tmpvar_56);
  float x_57;
  x_57 = (1.0 - tmpvar_1);
  float x_58;
  x_58 = (1.0 - tmpvar_52);
  float tmpvar_59;
  tmpvar_59 = (0.5 + ((
    (2.0 * tmpvar_53)
   * tmpvar_53) * tmpvar_50));
  float x_60;
  x_60 = (1.0 - tmpvar_53);
  float x_61;
  x_61 = (1.0 - tmpvar_52);
  c_46.xyz = (((
    (tmpvar_8 * tmpvar_49)
   * 
    (tmpvar_17 + (_LightColor0.xyz * ((
      (1.0 + ((tmpvar_59 - 1.0) * ((
        ((x_57 * x_57) * x_57)
       * x_57) * x_57)))
     * 
      (1.0 + ((tmpvar_59 - 1.0) * ((
        ((x_58 * x_58) * x_58)
       * x_58) * x_58)))
    ) * tmpvar_1)))
  ) + (
    (max (0.0, ((
      ((1.0/(((
        ((tmpvar_1 * (1.0 - tmpvar_54)) + tmpvar_54)
       * 
        ((tmpvar_52 * (1.0 - tmpvar_54)) + tmpvar_54)
      ) + 0.0001))) * (pow (max (0.0, 
        dot (tmpvar_47, tmpvar_51)
      ), tmpvar_55) * ((tmpvar_55 + 1.0) * unity_LightGammaCorrectionConsts.y)))
     * tmpvar_1) * unity_LightGammaCorrectionConsts.x)) * _LightColor0.xyz)
   * 
    (tmpvar_48 + ((1.0 - tmpvar_48) * ((
      ((x_60 * x_60) * x_60)
     * x_60) * x_60)))
  )) + (tmpvar_18 * mix (tmpvar_48, vec3(
    clamp ((tmpvar_10 + (1.0 - tmpvar_49)), 0.0, 1.0)
  ), vec3(
    ((((x_61 * x_61) * x_61) * x_61) * x_61)
  ))));
  c_46.w = tmpvar_11;
  gl_FragData[0] = c_46;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 14 [_MainTex_ST]
Vector 12 [unity_SHBb]
Vector 11 [unity_SHBg]
Vector 10 [unity_SHBr]
Vector 13 [unity_SHC]
"vs_3_0
def c15, 0, 0, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord6 o6
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v3, c14, c14.zwzw
dp4 o2.w, c4, v0
dp4 o3.w, c5, v0
dp4 o4.w, c6, v0
mul r0, c8.xyzz, v2.y
mad r0, c7.xyzz, v2.x, r0
mad r0, c9.xyzz, v2.z, r0
dp3 r1.x, r0.xyww, r0.xyww
rsq r1.x, r1.x
mul r0, r0, r1.x
mul r1.x, r0.y, r0.y
mad r1.x, r0.x, r0.x, -r1.x
mul r2, r0.ywzx, r0
dp4 r3.x, c10, r2
dp4 r3.y, c11, r2
dp4 r3.z, c12, r2
mad o5.xyz, c13, r1.x, r3
dp3 r1.z, c4, v1
dp3 r1.x, c5, v1
dp3 r1.y, c6, v1
dp3 r0.z, r1, r1
rsq r0.z, r0.z
mul r1.xyz, r0.z, r1
mov o2.x, r1.z
mul r2.xyz, r0.wxyw, r1
mad r2.xyz, r0.ywxw, r1.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r0.x
mov o3.x, r1.x
mov o4.x, r1.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r0.y
mov o4.z, r0.w
mov o6, c15.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedkomagddpodgpojkcjlkkkijpmibkpobiabaaaaaanmaiaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoaagaaaaeaaaabaa
liabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
cnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
acaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
acaaaaaabbaaaaaadiaaaaaimcaabaaaaaaaaaaaagbabaaaacaaaaaaagiacaaa
acaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
acaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaa
acaaaaaabbaaaaaadiaaaaaimcaabaaaabaaaaaafgbfbaaaacaaaaaafgifcaaa
acaaaaaabcaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaa
bbaaaaaadiaaaaaimcaabaaaabaaaaaakgbkbaaaacaaaaaakgikcaaaacaaaaaa
bcaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegadbaaaaaaaaaaaegadbaaaaaaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaagaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaacaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaacaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaadganbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaangaebaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
eccabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaadaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaaadaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaa
abaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaadgaaaaaficcabaaa
adaaaaaabkaabaaaadaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaaadaaaaaa
dgaaaaafeccabaaaadaaaaaabkaabaaaaaaaaaaadgaaaaafcccabaaaadaaaaaa
bkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadgaaaaaf
eccabaaaaeaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaa
ngacbaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaaibcaabaaaacaaaaaaegiocaaa
abaaaaaacjaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaa
abaaaaaackaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaa
abaaaaaaclaaaaaaegaobaaaaaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaa
abaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadgaaaaaipccabaaa
agaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 v_3;
  v_3.x = _World2Object[0].x;
  v_3.y = _World2Object[1].x;
  v_3.z = _World2Object[2].x;
  v_3.w = _World2Object[3].x;
  vec4 v_4;
  v_4.x = _World2Object[0].y;
  v_4.y = _World2Object[1].y;
  v_4.z = _World2Object[2].y;
  v_4.w = _World2Object[3].y;
  vec4 v_5;
  v_5.x = _World2Object[0].z;
  v_5.y = _World2Object[1].z;
  v_5.z = _World2Object[2].z;
  v_5.w = _World2Object[3].z;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(((
    (v_3.xyz * gl_Normal.x)
   + 
    (v_4.xyz * gl_Normal.y)
  ) + (v_5.xyz * gl_Normal.z)));
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * TANGENT.xyz));
  vec3 tmpvar_9;
  tmpvar_9 = (((tmpvar_6.yzx * tmpvar_8.zxy) - (tmpvar_6.zxy * tmpvar_8.yzx)) * TANGENT.w);
  vec4 tmpvar_10;
  tmpvar_10.x = tmpvar_8.x;
  tmpvar_10.y = tmpvar_9.x;
  tmpvar_10.z = tmpvar_6.x;
  tmpvar_10.w = tmpvar_2.x;
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_8.y;
  tmpvar_11.y = tmpvar_9.y;
  tmpvar_11.z = tmpvar_6.y;
  tmpvar_11.w = tmpvar_2.y;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_8.z;
  tmpvar_12.y = tmpvar_9.z;
  tmpvar_12.z = tmpvar_6.z;
  tmpvar_12.w = tmpvar_2.z;
  vec3 x2_13;
  vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_13.x = dot (unity_SHBr, tmpvar_14);
  x2_13.y = dot (unity_SHBg, tmpvar_14);
  x2_13.z = dot (unity_SHBb, tmpvar_14);
  vec4 tmpvar_15;
  tmpvar_15 = (unity_4LightPosX0 - tmpvar_2.x);
  vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosY0 - tmpvar_2.y);
  vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosZ0 - tmpvar_2.z);
  vec4 tmpvar_18;
  tmpvar_18 = (((tmpvar_15 * tmpvar_15) + (tmpvar_16 * tmpvar_16)) + (tmpvar_17 * tmpvar_17));
  vec4 tmpvar_19;
  tmpvar_19 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_15 * tmpvar_6.x) + (tmpvar_16 * tmpvar_6.y)) + (tmpvar_17 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_18)
  )) * (1.0/((1.0 + 
    (tmpvar_18 * unity_4LightAtten0)
  ))));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = ((x2_13 + (unity_SHC.xyz * 
    ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y))
  )) + ((
    ((unity_LightColor[0].xyz * tmpvar_19.x) + (unity_LightColor[1].xyz * tmpvar_19.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_19.z)
  ) + (unity_LightColor[3].xyz * tmpvar_19.w)));
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Rain;
uniform float _RainOpacity;
uniform float _Raining;
uniform float _Glossiness;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  float tmpvar_1;
  vec3 worldN_2;
  vec3 tmpvar_3;
  float tmpvar_4;
  float tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD1.w;
  tmpvar_6.y = xlv_TEXCOORD2.w;
  tmpvar_6.z = xlv_TEXCOORD3.w;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_6));
  vec3 tmpvar_8;
  vec3 tmpvar_9;
  float tmpvar_10;
  float tmpvar_11;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = tmpvar_3;
  tmpvar_10 = tmpvar_5;
  tmpvar_11 = 0.0;
  if ((_Raining > 0.0)) {
    vec4 tmpvar_12;
    tmpvar_12 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    vec4 tmpvar_13;
    tmpvar_13 = texture2D (_Rain, xlv_TEXCOORD0);
    tmpvar_8 = ((tmpvar_12.xyz * (1.0 - tmpvar_13.w)) + (tmpvar_13.x * tmpvar_13.w));
    vec3 normal_14;
    normal_14.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_14.z = sqrt((1.0 - clamp (
      dot (normal_14.xy, normal_14.xy)
    , 0.0, 1.0)));
    tmpvar_9 = normalize(((normal_14 * 
      (1.0 - tmpvar_13.w)
    ) + (vec3(0.0, 0.0, 1.0) * tmpvar_13.w)));
    tmpvar_10 = _Glossiness;
    tmpvar_11 = (tmpvar_12.w + (tmpvar_13.w * _RainOpacity));
  } else {
    vec4 tmpvar_15;
    tmpvar_15 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    tmpvar_8 = tmpvar_15.xyz;
    vec3 normal_16;
    normal_16.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_16.z = sqrt((1.0 - clamp (
      dot (normal_16.xy, normal_16.xy)
    , 0.0, 1.0)));
    tmpvar_9 = normal_16;
    tmpvar_10 = _Glossiness;
    tmpvar_11 = tmpvar_15.w;
  };
  tmpvar_5 = tmpvar_10;
  worldN_2.x = dot (xlv_TEXCOORD1.xyz, tmpvar_9);
  worldN_2.y = dot (xlv_TEXCOORD2.xyz, tmpvar_9);
  worldN_2.z = dot (xlv_TEXCOORD3.xyz, tmpvar_9);
  tmpvar_3 = worldN_2;
  tmpvar_1 = max (0.0, dot (worldN_2, _WorldSpaceLightPos0.xyz));
  vec3 tmpvar_17;
  vec3 tmpvar_18;
  tmpvar_18 = vec3(0.0, 0.0, 0.0);
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = worldN_2;
  vec3 x1_20;
  x1_20.x = dot (unity_SHAr, tmpvar_19);
  x1_20.y = dot (unity_SHAg, tmpvar_19);
  x1_20.z = dot (unity_SHAb, tmpvar_19);
  tmpvar_17 = (xlv_TEXCOORD4 + x1_20);
  vec3 tmpvar_21;
  vec3 I_22;
  I_22 = -(tmpvar_7);
  tmpvar_21 = (I_22 - (2.0 * (
    dot (worldN_2, I_22)
   * worldN_2)));
  vec3 worldNormal_23;
  worldNormal_23 = tmpvar_21;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_24;
    tmpvar_24 = normalize(tmpvar_21);
    vec3 tmpvar_25;
    tmpvar_25 = ((unity_SpecCube0_BoxMax.xyz - tmpvar_6) / tmpvar_24);
    vec3 tmpvar_26;
    tmpvar_26 = ((unity_SpecCube0_BoxMin.xyz - tmpvar_6) / tmpvar_24);
    bvec3 tmpvar_27;
    tmpvar_27 = greaterThan (tmpvar_24, vec3(0.0, 0.0, 0.0));
    float tmpvar_28;
    if (tmpvar_27.x) {
      tmpvar_28 = tmpvar_25.x;
    } else {
      tmpvar_28 = tmpvar_26.x;
    };
    float tmpvar_29;
    if (tmpvar_27.y) {
      tmpvar_29 = tmpvar_25.y;
    } else {
      tmpvar_29 = tmpvar_26.y;
    };
    float tmpvar_30;
    if (tmpvar_27.z) {
      tmpvar_30 = tmpvar_25.z;
    } else {
      tmpvar_30 = tmpvar_26.z;
    };
    vec3 tmpvar_31;
    tmpvar_31 = ((unity_SpecCube0_BoxMax.xyz + unity_SpecCube0_BoxMin.xyz) * 0.5);
    worldNormal_23 = (((
      (tmpvar_31 - unity_SpecCube0_ProbePosition.xyz)
     + tmpvar_6) + (tmpvar_24 * 
      min (min (tmpvar_28, tmpvar_29), tmpvar_30)
    )) - tmpvar_31);
  };
  vec4 tmpvar_32;
  tmpvar_32.xyz = worldNormal_23;
  tmpvar_32.w = (pow ((1.0 - tmpvar_10), 0.75) * 7.0);
  vec4 tmpvar_33;
  tmpvar_33 = textureCubeLod (unity_SpecCube0, worldNormal_23, tmpvar_32.w);
  vec3 tmpvar_34;
  tmpvar_34 = ((unity_SpecCube0_HDR.x * pow (tmpvar_33.w, unity_SpecCube0_HDR.y)) * tmpvar_33.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldNormal_35;
    worldNormal_35 = tmpvar_21;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_36;
      tmpvar_36 = normalize(tmpvar_21);
      vec3 tmpvar_37;
      tmpvar_37 = ((unity_SpecCube1_BoxMax.xyz - tmpvar_6) / tmpvar_36);
      vec3 tmpvar_38;
      tmpvar_38 = ((unity_SpecCube1_BoxMin.xyz - tmpvar_6) / tmpvar_36);
      bvec3 tmpvar_39;
      tmpvar_39 = greaterThan (tmpvar_36, vec3(0.0, 0.0, 0.0));
      float tmpvar_40;
      if (tmpvar_39.x) {
        tmpvar_40 = tmpvar_37.x;
      } else {
        tmpvar_40 = tmpvar_38.x;
      };
      float tmpvar_41;
      if (tmpvar_39.y) {
        tmpvar_41 = tmpvar_37.y;
      } else {
        tmpvar_41 = tmpvar_38.y;
      };
      float tmpvar_42;
      if (tmpvar_39.z) {
        tmpvar_42 = tmpvar_37.z;
      } else {
        tmpvar_42 = tmpvar_38.z;
      };
      vec3 tmpvar_43;
      tmpvar_43 = ((unity_SpecCube1_BoxMax.xyz + unity_SpecCube1_BoxMin.xyz) * 0.5);
      worldNormal_35 = (((
        (tmpvar_43 - unity_SpecCube1_ProbePosition.xyz)
       + tmpvar_6) + (tmpvar_36 * 
        min (min (tmpvar_40, tmpvar_41), tmpvar_42)
      )) - tmpvar_43);
    };
    vec4 tmpvar_44;
    tmpvar_44.xyz = worldNormal_35;
    tmpvar_44.w = (pow ((1.0 - tmpvar_10), 0.75) * 7.0);
    vec4 tmpvar_45;
    tmpvar_45 = textureCubeLod (unity_SpecCube1, worldNormal_35, tmpvar_44.w);
    tmpvar_18 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_45.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_45.xyz), tmpvar_34, unity_SpecCube0_BoxMin.www);
  } else {
    tmpvar_18 = tmpvar_34;
  };
  vec4 c_46;
  vec3 tmpvar_47;
  tmpvar_47 = normalize(worldN_2);
  vec3 tmpvar_48;
  tmpvar_48 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_8, vec3(tmpvar_4));
  float tmpvar_49;
  tmpvar_49 = (unity_ColorSpaceDielectricSpec.w - (tmpvar_4 * unity_ColorSpaceDielectricSpec.w));
  float tmpvar_50;
  tmpvar_50 = (1.0 - tmpvar_10);
  vec3 tmpvar_51;
  tmpvar_51 = normalize((_WorldSpaceLightPos0.xyz + tmpvar_7));
  float tmpvar_52;
  tmpvar_52 = max (0.0, dot (tmpvar_47, tmpvar_7));
  float tmpvar_53;
  tmpvar_53 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_51));
  float tmpvar_54;
  tmpvar_54 = ((tmpvar_50 * tmpvar_50) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_55;
  float tmpvar_56;
  tmpvar_56 = (10.0 / log2((
    ((1.0 - tmpvar_50) * 0.968)
   + 0.03)));
  tmpvar_55 = (tmpvar_56 * tmpvar_56);
  float x_57;
  x_57 = (1.0 - tmpvar_1);
  float x_58;
  x_58 = (1.0 - tmpvar_52);
  float tmpvar_59;
  tmpvar_59 = (0.5 + ((
    (2.0 * tmpvar_53)
   * tmpvar_53) * tmpvar_50));
  float x_60;
  x_60 = (1.0 - tmpvar_53);
  float x_61;
  x_61 = (1.0 - tmpvar_52);
  c_46.xyz = (((
    (tmpvar_8 * tmpvar_49)
   * 
    (tmpvar_17 + (_LightColor0.xyz * ((
      (1.0 + ((tmpvar_59 - 1.0) * ((
        ((x_57 * x_57) * x_57)
       * x_57) * x_57)))
     * 
      (1.0 + ((tmpvar_59 - 1.0) * ((
        ((x_58 * x_58) * x_58)
       * x_58) * x_58)))
    ) * tmpvar_1)))
  ) + (
    (max (0.0, ((
      ((1.0/(((
        ((tmpvar_1 * (1.0 - tmpvar_54)) + tmpvar_54)
       * 
        ((tmpvar_52 * (1.0 - tmpvar_54)) + tmpvar_54)
      ) + 0.0001))) * (pow (max (0.0, 
        dot (tmpvar_47, tmpvar_51)
      ), tmpvar_55) * ((tmpvar_55 + 1.0) * unity_LightGammaCorrectionConsts.y)))
     * tmpvar_1) * unity_LightGammaCorrectionConsts.x)) * _LightColor0.xyz)
   * 
    (tmpvar_48 + ((1.0 - tmpvar_48) * ((
      ((x_60 * x_60) * x_60)
     * x_60) * x_60)))
  )) + (tmpvar_18 * mix (tmpvar_48, vec3(
    clamp ((tmpvar_10 + (1.0 - tmpvar_49)), 0.0, 1.0)
  ), vec3(
    ((((x_61 * x_61) * x_61) * x_61) * x_61)
  ))));
  c_46.w = tmpvar_11;
  gl_FragData[0] = c_46;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 22 [_MainTex_ST]
Vector 17 [unity_4LightAtten0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 20 [unity_SHBb]
Vector 19 [unity_SHBg]
Vector 18 [unity_SHBr]
Vector 21 [unity_SHC]
"vs_3_0
def c23, 0, 1, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord6 o6
dp4 o0.x, c4, v0
dp4 o0.y, c5, v0
dp4 o0.z, c6, v0
dp4 o0.w, c7, v0
mad o1.xy, v3, c22, c22.zwzw
dp4 r0.x, c10, v0
add r1, -r0.x, c16
mov o4.w, r0.x
dp4 r0.x, c8, v0
add r2, -r0.x, c14
mov o2.w, r0.x
dp4 r0.x, c9, v0
add r3, -r0.x, c15
mov o3.w, r0.x
mul r0, c12.xyzz, v2.y
mad r0, c11.xyzz, v2.x, r0
mad r0, c13.xyzz, v2.z, r0
dp3 r4.x, r0.xyww, r0.xyww
rsq r4.x, r4.x
mul r0, r0, r4.x
mul r4, r0.y, r3
mul r3, r3, r3
mad r3, r2, r2, r3
mad r2, r2, r0.x, r4
mad r2, r1, r0.w, r2
mad r1, r1, r1, r3
rsq r3.x, r1.x
rsq r3.y, r1.y
rsq r3.z, r1.z
rsq r3.w, r1.w
mov r4.y, c23.y
mad r1, r1, c17, r4.y
mul r2, r2, r3
max r2, r2, c23.x
rcp r3.x, r1.x
rcp r3.y, r1.y
rcp r3.z, r1.z
rcp r3.w, r1.w
mul r1, r2, r3
mul r2.xyz, r1.y, c1
mad r2.xyz, c0, r1.x, r2
mad r1.xyz, c2, r1.z, r2
mad r1.xyz, c3, r1.w, r1
mul r1.w, r0.y, r0.y
mad r1.w, r0.x, r0.x, -r1.w
mul r2, r0.ywzx, r0
dp4 r3.x, c18, r2
dp4 r3.y, c19, r2
dp4 r3.z, c20, r2
mad r2.xyz, c21, r1.w, r3
add o5.xyz, r1, r2
dp3 r1.z, c8, v1
dp3 r1.x, c9, v1
dp3 r1.y, c10, v1
dp3 r0.z, r1, r1
rsq r0.z, r0.z
mul r1.xyz, r0.z, r1
mov o2.x, r1.z
mul r2.xyz, r0.wxyw, r1
mad r2.xyz, r0.ywxw, r1.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r0.x
mov o3.x, r1.x
mov o4.x, r1.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r0.y
mov o4.z, r0.w
mov o6, c23.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedaahihegpdmhklkgoblolikjknfphaebmabaaaaaajealaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjiajaaaaeaaaabaa
ggacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
cnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaac
afaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaabaaaaaajgiecaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaajgiecaaaacaaaaaaamaaaaaa
agbabaaaabaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaajgiecaaa
acaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaa
bbaaaaaadiaaaaaimcaabaaaabaaaaaaagbabaaaacaaaaaaagiacaaaacaaaaaa
bcaaaaaadiaaaaaibcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaa
bbaaaaaadiaaaaaimcaabaaaacaaaaaafgbfbaaaacaaaaaafgifcaaaacaaaaaa
bcaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
diaaaaaibcaabaaaacaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaa
diaaaaaiccaabaaaacaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaa
diaaaaaimcaabaaaacaaaaaakgbkbaaaacaaaaaakgikcaaaacaaaaaabcaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaabaaaaaah
icaabaaaaaaaaaaaegadbaaaabaaaaaaegadbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaapgapbaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaadganbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaangaebaaaabaaaaaajgaebaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaf
iccabaaaacaaaaaaakaabaaaadaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaa
aaaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaaaaaaaaadgaaaaafeccabaaa
adaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadgaaaaaficcabaaaadaaaaaa
bkaabaaaadaaaaaadgaaaaafeccabaaaaeaaaaaadkaabaaaabaaaaaadgaaaaaf
iccabaaaaeaaaaaackaabaaaadaaaaaaaaaaaaajpcaabaaaaaaaaaaafgafbaia
ebaaaaaaadaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaaacaaaaaa
fgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaaaaaaaaaaaaaaaajpcaabaaaaeaaaaaaagaabaiaebaaaaaa
adaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaakgakbaia
ebaaaaaaadaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaacaaaaaa
egaobaaaaeaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaa
aaaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaaaaaaaaadcaaaaaj
pcaabaaaaaaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaegaobaaaaaaaaaaa
dcaaaaajpcaabaaaacaaaaaaegaobaaaadaaaaaapgapbaaaabaaaaaaegaobaaa
acaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaanpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaacaaaaaaegaobaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
fgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaangacbaaa
abaaaaaaegaobaaaabaaaaaabbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaa
cmaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaahhccabaaaafaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaipccabaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_5.xyz * gl_Normal.y)
  ) + (v_6.xyz * gl_Normal.z)));
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * TANGENT.xyz));
  vec3 tmpvar_10;
  tmpvar_10 = (((tmpvar_7.yzx * tmpvar_9.zxy) - (tmpvar_7.zxy * tmpvar_9.yzx)) * TANGENT.w);
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.y = tmpvar_10.x;
  tmpvar_11.z = tmpvar_7.x;
  tmpvar_11.w = tmpvar_3.x;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_9.y;
  tmpvar_12.y = tmpvar_10.y;
  tmpvar_12.z = tmpvar_7.y;
  tmpvar_12.w = tmpvar_3.y;
  vec4 tmpvar_13;
  tmpvar_13.x = tmpvar_9.z;
  tmpvar_13.y = tmpvar_10.z;
  tmpvar_13.z = tmpvar_7.z;
  tmpvar_13.w = tmpvar_3.z;
  vec3 x2_14;
  vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_14.x = dot (unity_SHBr, tmpvar_15);
  x2_14.y = dot (unity_SHBg, tmpvar_15);
  x2_14.z = dot (unity_SHBb, tmpvar_15);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = (x2_14 + (unity_SHC.xyz * (
    (tmpvar_7.x * tmpvar_7.x)
   - 
    (tmpvar_7.y * tmpvar_7.y)
  )));
  xlv_TEXCOORD5 = tmpvar_2.z;
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Rain;
uniform float _RainOpacity;
uniform float _Raining;
uniform float _Glossiness;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  float tmpvar_1;
  vec3 worldN_2;
  vec4 c_3;
  vec3 tmpvar_4;
  float tmpvar_5;
  float tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD1.w;
  tmpvar_7.y = xlv_TEXCOORD2.w;
  tmpvar_7.z = xlv_TEXCOORD3.w;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_7));
  vec3 tmpvar_9;
  vec3 tmpvar_10;
  float tmpvar_11;
  float tmpvar_12;
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = tmpvar_4;
  tmpvar_11 = tmpvar_6;
  tmpvar_12 = 0.0;
  if ((_Raining > 0.0)) {
    vec4 tmpvar_13;
    tmpvar_13 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    vec4 tmpvar_14;
    tmpvar_14 = texture2D (_Rain, xlv_TEXCOORD0);
    tmpvar_9 = ((tmpvar_13.xyz * (1.0 - tmpvar_14.w)) + (tmpvar_14.x * tmpvar_14.w));
    vec3 normal_15;
    normal_15.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_15.z = sqrt((1.0 - clamp (
      dot (normal_15.xy, normal_15.xy)
    , 0.0, 1.0)));
    tmpvar_10 = normalize(((normal_15 * 
      (1.0 - tmpvar_14.w)
    ) + (vec3(0.0, 0.0, 1.0) * tmpvar_14.w)));
    tmpvar_11 = _Glossiness;
    tmpvar_12 = (tmpvar_13.w + (tmpvar_14.w * _RainOpacity));
  } else {
    vec4 tmpvar_16;
    tmpvar_16 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    tmpvar_9 = tmpvar_16.xyz;
    vec3 normal_17;
    normal_17.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_17.z = sqrt((1.0 - clamp (
      dot (normal_17.xy, normal_17.xy)
    , 0.0, 1.0)));
    tmpvar_10 = normal_17;
    tmpvar_11 = _Glossiness;
    tmpvar_12 = tmpvar_16.w;
  };
  tmpvar_6 = tmpvar_11;
  c_3 = vec4(0.0, 0.0, 0.0, 0.0);
  worldN_2.x = dot (xlv_TEXCOORD1.xyz, tmpvar_10);
  worldN_2.y = dot (xlv_TEXCOORD2.xyz, tmpvar_10);
  worldN_2.z = dot (xlv_TEXCOORD3.xyz, tmpvar_10);
  tmpvar_4 = worldN_2;
  tmpvar_1 = max (0.0, dot (worldN_2, _WorldSpaceLightPos0.xyz));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  tmpvar_19 = vec3(0.0, 0.0, 0.0);
  vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = worldN_2;
  vec3 x1_21;
  x1_21.x = dot (unity_SHAr, tmpvar_20);
  x1_21.y = dot (unity_SHAg, tmpvar_20);
  x1_21.z = dot (unity_SHAb, tmpvar_20);
  tmpvar_18 = (xlv_TEXCOORD4 + x1_21);
  vec3 tmpvar_22;
  vec3 I_23;
  I_23 = -(tmpvar_8);
  tmpvar_22 = (I_23 - (2.0 * (
    dot (worldN_2, I_23)
   * worldN_2)));
  vec3 worldNormal_24;
  worldNormal_24 = tmpvar_22;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_25;
    tmpvar_25 = normalize(tmpvar_22);
    vec3 tmpvar_26;
    tmpvar_26 = ((unity_SpecCube0_BoxMax.xyz - tmpvar_7) / tmpvar_25);
    vec3 tmpvar_27;
    tmpvar_27 = ((unity_SpecCube0_BoxMin.xyz - tmpvar_7) / tmpvar_25);
    bvec3 tmpvar_28;
    tmpvar_28 = greaterThan (tmpvar_25, vec3(0.0, 0.0, 0.0));
    float tmpvar_29;
    if (tmpvar_28.x) {
      tmpvar_29 = tmpvar_26.x;
    } else {
      tmpvar_29 = tmpvar_27.x;
    };
    float tmpvar_30;
    if (tmpvar_28.y) {
      tmpvar_30 = tmpvar_26.y;
    } else {
      tmpvar_30 = tmpvar_27.y;
    };
    float tmpvar_31;
    if (tmpvar_28.z) {
      tmpvar_31 = tmpvar_26.z;
    } else {
      tmpvar_31 = tmpvar_27.z;
    };
    vec3 tmpvar_32;
    tmpvar_32 = ((unity_SpecCube0_BoxMax.xyz + unity_SpecCube0_BoxMin.xyz) * 0.5);
    worldNormal_24 = (((
      (tmpvar_32 - unity_SpecCube0_ProbePosition.xyz)
     + tmpvar_7) + (tmpvar_25 * 
      min (min (tmpvar_29, tmpvar_30), tmpvar_31)
    )) - tmpvar_32);
  };
  vec4 tmpvar_33;
  tmpvar_33.xyz = worldNormal_24;
  tmpvar_33.w = (pow ((1.0 - tmpvar_11), 0.75) * 7.0);
  vec4 tmpvar_34;
  tmpvar_34 = textureCubeLod (unity_SpecCube0, worldNormal_24, tmpvar_33.w);
  vec3 tmpvar_35;
  tmpvar_35 = ((unity_SpecCube0_HDR.x * pow (tmpvar_34.w, unity_SpecCube0_HDR.y)) * tmpvar_34.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldNormal_36;
    worldNormal_36 = tmpvar_22;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_37;
      tmpvar_37 = normalize(tmpvar_22);
      vec3 tmpvar_38;
      tmpvar_38 = ((unity_SpecCube1_BoxMax.xyz - tmpvar_7) / tmpvar_37);
      vec3 tmpvar_39;
      tmpvar_39 = ((unity_SpecCube1_BoxMin.xyz - tmpvar_7) / tmpvar_37);
      bvec3 tmpvar_40;
      tmpvar_40 = greaterThan (tmpvar_37, vec3(0.0, 0.0, 0.0));
      float tmpvar_41;
      if (tmpvar_40.x) {
        tmpvar_41 = tmpvar_38.x;
      } else {
        tmpvar_41 = tmpvar_39.x;
      };
      float tmpvar_42;
      if (tmpvar_40.y) {
        tmpvar_42 = tmpvar_38.y;
      } else {
        tmpvar_42 = tmpvar_39.y;
      };
      float tmpvar_43;
      if (tmpvar_40.z) {
        tmpvar_43 = tmpvar_38.z;
      } else {
        tmpvar_43 = tmpvar_39.z;
      };
      vec3 tmpvar_44;
      tmpvar_44 = ((unity_SpecCube1_BoxMax.xyz + unity_SpecCube1_BoxMin.xyz) * 0.5);
      worldNormal_36 = (((
        (tmpvar_44 - unity_SpecCube1_ProbePosition.xyz)
       + tmpvar_7) + (tmpvar_37 * 
        min (min (tmpvar_41, tmpvar_42), tmpvar_43)
      )) - tmpvar_44);
    };
    vec4 tmpvar_45;
    tmpvar_45.xyz = worldNormal_36;
    tmpvar_45.w = (pow ((1.0 - tmpvar_11), 0.75) * 7.0);
    vec4 tmpvar_46;
    tmpvar_46 = textureCubeLod (unity_SpecCube1, worldNormal_36, tmpvar_45.w);
    tmpvar_19 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_46.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_46.xyz), tmpvar_35, unity_SpecCube0_BoxMin.www);
  } else {
    tmpvar_19 = tmpvar_35;
  };
  vec4 c_47;
  vec3 tmpvar_48;
  tmpvar_48 = normalize(worldN_2);
  vec3 tmpvar_49;
  tmpvar_49 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_9, vec3(tmpvar_5));
  float tmpvar_50;
  tmpvar_50 = (unity_ColorSpaceDielectricSpec.w - (tmpvar_5 * unity_ColorSpaceDielectricSpec.w));
  float tmpvar_51;
  tmpvar_51 = (1.0 - tmpvar_11);
  vec3 tmpvar_52;
  tmpvar_52 = normalize((_WorldSpaceLightPos0.xyz + tmpvar_8));
  float tmpvar_53;
  tmpvar_53 = max (0.0, dot (tmpvar_48, tmpvar_8));
  float tmpvar_54;
  tmpvar_54 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_52));
  float tmpvar_55;
  tmpvar_55 = ((tmpvar_51 * tmpvar_51) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_56;
  float tmpvar_57;
  tmpvar_57 = (10.0 / log2((
    ((1.0 - tmpvar_51) * 0.968)
   + 0.03)));
  tmpvar_56 = (tmpvar_57 * tmpvar_57);
  float x_58;
  x_58 = (1.0 - tmpvar_1);
  float x_59;
  x_59 = (1.0 - tmpvar_53);
  float tmpvar_60;
  tmpvar_60 = (0.5 + ((
    (2.0 * tmpvar_54)
   * tmpvar_54) * tmpvar_51));
  float x_61;
  x_61 = (1.0 - tmpvar_54);
  float x_62;
  x_62 = (1.0 - tmpvar_53);
  vec3 tmpvar_63;
  tmpvar_63 = (((
    (tmpvar_9 * tmpvar_50)
   * 
    (tmpvar_18 + (_LightColor0.xyz * ((
      (1.0 + ((tmpvar_60 - 1.0) * ((
        ((x_58 * x_58) * x_58)
       * x_58) * x_58)))
     * 
      (1.0 + ((tmpvar_60 - 1.0) * ((
        ((x_59 * x_59) * x_59)
       * x_59) * x_59)))
    ) * tmpvar_1)))
  ) + (
    (max (0.0, ((
      ((1.0/(((
        ((tmpvar_1 * (1.0 - tmpvar_55)) + tmpvar_55)
       * 
        ((tmpvar_53 * (1.0 - tmpvar_55)) + tmpvar_55)
      ) + 0.0001))) * (pow (max (0.0, 
        dot (tmpvar_48, tmpvar_52)
      ), tmpvar_56) * ((tmpvar_56 + 1.0) * unity_LightGammaCorrectionConsts.y)))
     * tmpvar_1) * unity_LightGammaCorrectionConsts.x)) * _LightColor0.xyz)
   * 
    (tmpvar_49 + ((1.0 - tmpvar_49) * ((
      ((x_61 * x_61) * x_61)
     * x_61) * x_61)))
  )) + (tmpvar_19 * mix (tmpvar_49, vec3(
    clamp ((tmpvar_11 + (1.0 - tmpvar_50)), 0.0, 1.0)
  ), vec3(
    ((((x_62 * x_62) * x_62) * x_62) * x_62)
  ))));
  c_47.xyz = tmpvar_63;
  c_47.w = tmpvar_12;
  c_3.w = c_47.w;
  c_3.xyz = mix (unity_FogColor.xyz, tmpvar_63, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 14 [_MainTex_ST]
Vector 12 [unity_SHBb]
Vector 11 [unity_SHBg]
Vector 10 [unity_SHBr]
Vector 13 [unity_SHC]
"vs_3_0
def c15, 0, 0, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6.x
dcl_texcoord6 o7
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.w, c3, v0
mad o1.xy, v3, c14, c14.zwzw
dp4 o2.w, c4, v0
dp4 o3.w, c5, v0
dp4 o4.w, c6, v0
mul r0, c8.xyzz, v2.y
mad r0, c7.xyzz, v2.x, r0
mad r0, c9.xyzz, v2.z, r0
dp3 r1.x, r0.xyww, r0.xyww
rsq r1.x, r1.x
mul r0, r0, r1.x
mul r1.x, r0.y, r0.y
mad r1.x, r0.x, r0.x, -r1.x
mul r2, r0.ywzx, r0
dp4 r3.x, c10, r2
dp4 r3.y, c11, r2
dp4 r3.z, c12, r2
mad o5.xyz, c13, r1.x, r3
dp4 r0.z, c2, v0
mov o0.z, r0.z
mov o6.x, r0.z
dp3 r1.z, c4, v1
dp3 r1.x, c5, v1
dp3 r1.y, c6, v1
dp3 r0.z, r1, r1
rsq r0.z, r0.z
mul r1.xyz, r0.z, r1
mov o2.x, r1.z
mul r2.xyz, r0.wxyw, r1
mad r2.xyz, r0.ywxw, r1.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r0.x
mov o3.x, r1.x
mov o4.x, r1.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r0.y
mov o4.z, r0.w
mov o7, c15.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbaiclhhaoegiifjachmidgkppklpjlefabaaaaaaciajaaaaadaaaaaa
cmaaaaaaceabaaaaamacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcbeahaaaaeaaaabaamfabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaae
egiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafeccabaaaabaaaaaa
ckaabaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaimcaabaaaaaaaaaaa
agbabaaaacaaaaaaagiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaimcaabaaaabaaaaaa
fgbfbaaaacaaaaaafgifcaaaacaaaaaabcaaaaaaaaaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaimcaabaaaabaaaaaakgbkbaaa
acaaaaaakgikcaaaacaaaaaabcaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegadbaaaaaaaaaaa
egadbaaaaaaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaagaabaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaacaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaacaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
dganbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaangaebaaa
aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaa
akaabaaaacaaaaaadgaaaaafeccabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaai
hcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaadaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
adaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaadgaaaaaficcabaaaacaaaaaa
akaabaaaadaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
bccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaa
abaaaaaadgaaaaaficcabaaaadaaaaaabkaabaaaadaaaaaadgaaaaaficcabaaa
aeaaaaaackaabaaaadaaaaaadgaaaaafeccabaaaadaaaaaabkaabaaaaaaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadgaaaaafeccabaaaaeaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaa
abaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
diaaaaahpcaabaaaaaaaaaaangacbaaaaaaaaaaaegaobaaaaaaaaaaabbaaaaai
bcaabaaaacaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaaaaaaaaabbaaaaai
ccaabaaaacaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaaaaaaaaabbaaaaai
ecaabaaaacaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaaaaaaaaadcaaaaak
hccabaaaafaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadgaaaaaipccabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec4 v_4;
  v_4.x = _World2Object[0].x;
  v_4.y = _World2Object[1].x;
  v_4.z = _World2Object[2].x;
  v_4.w = _World2Object[3].x;
  vec4 v_5;
  v_5.x = _World2Object[0].y;
  v_5.y = _World2Object[1].y;
  v_5.z = _World2Object[2].y;
  v_5.w = _World2Object[3].y;
  vec4 v_6;
  v_6.x = _World2Object[0].z;
  v_6.y = _World2Object[1].z;
  v_6.z = _World2Object[2].z;
  v_6.w = _World2Object[3].z;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_5.xyz * gl_Normal.y)
  ) + (v_6.xyz * gl_Normal.z)));
  mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * TANGENT.xyz));
  vec3 tmpvar_10;
  tmpvar_10 = (((tmpvar_7.yzx * tmpvar_9.zxy) - (tmpvar_7.zxy * tmpvar_9.yzx)) * TANGENT.w);
  vec4 tmpvar_11;
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.y = tmpvar_10.x;
  tmpvar_11.z = tmpvar_7.x;
  tmpvar_11.w = tmpvar_3.x;
  vec4 tmpvar_12;
  tmpvar_12.x = tmpvar_9.y;
  tmpvar_12.y = tmpvar_10.y;
  tmpvar_12.z = tmpvar_7.y;
  tmpvar_12.w = tmpvar_3.y;
  vec4 tmpvar_13;
  tmpvar_13.x = tmpvar_9.z;
  tmpvar_13.y = tmpvar_10.z;
  tmpvar_13.z = tmpvar_7.z;
  tmpvar_13.w = tmpvar_3.z;
  vec3 x2_14;
  vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_14.x = dot (unity_SHBr, tmpvar_15);
  x2_14.y = dot (unity_SHBg, tmpvar_15);
  x2_14.z = dot (unity_SHBb, tmpvar_15);
  vec4 tmpvar_16;
  tmpvar_16 = (unity_4LightPosX0 - tmpvar_3.x);
  vec4 tmpvar_17;
  tmpvar_17 = (unity_4LightPosY0 - tmpvar_3.y);
  vec4 tmpvar_18;
  tmpvar_18 = (unity_4LightPosZ0 - tmpvar_3.z);
  vec4 tmpvar_19;
  tmpvar_19 = (((tmpvar_16 * tmpvar_16) + (tmpvar_17 * tmpvar_17)) + (tmpvar_18 * tmpvar_18));
  vec4 tmpvar_20;
  tmpvar_20 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_16 * tmpvar_7.x) + (tmpvar_17 * tmpvar_7.y)) + (tmpvar_18 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_19)
  )) * (1.0/((1.0 + 
    (tmpvar_19 * unity_4LightAtten0)
  ))));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = ((x2_14 + (unity_SHC.xyz * 
    ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))
  )) + ((
    ((unity_LightColor[0].xyz * tmpvar_20.x) + (unity_LightColor[1].xyz * tmpvar_20.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_20.z)
  ) + (unity_LightColor[3].xyz * tmpvar_20.w)));
  xlv_TEXCOORD5 = tmpvar_2.z;
  xlv_TEXCOORD6 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
uniform vec4 unity_SpecCube0_BoxMax;
uniform vec4 unity_SpecCube0_BoxMin;
uniform vec4 unity_SpecCube0_ProbePosition;
uniform vec4 unity_SpecCube0_HDR;
uniform vec4 unity_SpecCube1_BoxMax;
uniform vec4 unity_SpecCube1_BoxMin;
uniform vec4 unity_SpecCube1_ProbePosition;
uniform vec4 unity_SpecCube1_HDR;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Rain;
uniform float _RainOpacity;
uniform float _Raining;
uniform float _Glossiness;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  float tmpvar_1;
  vec3 worldN_2;
  vec4 c_3;
  vec3 tmpvar_4;
  float tmpvar_5;
  float tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD1.w;
  tmpvar_7.y = xlv_TEXCOORD2.w;
  tmpvar_7.z = xlv_TEXCOORD3.w;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_7));
  vec3 tmpvar_9;
  vec3 tmpvar_10;
  float tmpvar_11;
  float tmpvar_12;
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = tmpvar_4;
  tmpvar_11 = tmpvar_6;
  tmpvar_12 = 0.0;
  if ((_Raining > 0.0)) {
    vec4 tmpvar_13;
    tmpvar_13 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    vec4 tmpvar_14;
    tmpvar_14 = texture2D (_Rain, xlv_TEXCOORD0);
    tmpvar_9 = ((tmpvar_13.xyz * (1.0 - tmpvar_14.w)) + (tmpvar_14.x * tmpvar_14.w));
    vec3 normal_15;
    normal_15.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_15.z = sqrt((1.0 - clamp (
      dot (normal_15.xy, normal_15.xy)
    , 0.0, 1.0)));
    tmpvar_10 = normalize(((normal_15 * 
      (1.0 - tmpvar_14.w)
    ) + (vec3(0.0, 0.0, 1.0) * tmpvar_14.w)));
    tmpvar_11 = _Glossiness;
    tmpvar_12 = (tmpvar_13.w + (tmpvar_14.w * _RainOpacity));
  } else {
    vec4 tmpvar_16;
    tmpvar_16 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    tmpvar_9 = tmpvar_16.xyz;
    vec3 normal_17;
    normal_17.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_17.z = sqrt((1.0 - clamp (
      dot (normal_17.xy, normal_17.xy)
    , 0.0, 1.0)));
    tmpvar_10 = normal_17;
    tmpvar_11 = _Glossiness;
    tmpvar_12 = tmpvar_16.w;
  };
  tmpvar_6 = tmpvar_11;
  c_3 = vec4(0.0, 0.0, 0.0, 0.0);
  worldN_2.x = dot (xlv_TEXCOORD1.xyz, tmpvar_10);
  worldN_2.y = dot (xlv_TEXCOORD2.xyz, tmpvar_10);
  worldN_2.z = dot (xlv_TEXCOORD3.xyz, tmpvar_10);
  tmpvar_4 = worldN_2;
  tmpvar_1 = max (0.0, dot (worldN_2, _WorldSpaceLightPos0.xyz));
  vec3 tmpvar_18;
  vec3 tmpvar_19;
  tmpvar_19 = vec3(0.0, 0.0, 0.0);
  vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = worldN_2;
  vec3 x1_21;
  x1_21.x = dot (unity_SHAr, tmpvar_20);
  x1_21.y = dot (unity_SHAg, tmpvar_20);
  x1_21.z = dot (unity_SHAb, tmpvar_20);
  tmpvar_18 = (xlv_TEXCOORD4 + x1_21);
  vec3 tmpvar_22;
  vec3 I_23;
  I_23 = -(tmpvar_8);
  tmpvar_22 = (I_23 - (2.0 * (
    dot (worldN_2, I_23)
   * worldN_2)));
  vec3 worldNormal_24;
  worldNormal_24 = tmpvar_22;
  if ((unity_SpecCube0_ProbePosition.w > 0.0)) {
    vec3 tmpvar_25;
    tmpvar_25 = normalize(tmpvar_22);
    vec3 tmpvar_26;
    tmpvar_26 = ((unity_SpecCube0_BoxMax.xyz - tmpvar_7) / tmpvar_25);
    vec3 tmpvar_27;
    tmpvar_27 = ((unity_SpecCube0_BoxMin.xyz - tmpvar_7) / tmpvar_25);
    bvec3 tmpvar_28;
    tmpvar_28 = greaterThan (tmpvar_25, vec3(0.0, 0.0, 0.0));
    float tmpvar_29;
    if (tmpvar_28.x) {
      tmpvar_29 = tmpvar_26.x;
    } else {
      tmpvar_29 = tmpvar_27.x;
    };
    float tmpvar_30;
    if (tmpvar_28.y) {
      tmpvar_30 = tmpvar_26.y;
    } else {
      tmpvar_30 = tmpvar_27.y;
    };
    float tmpvar_31;
    if (tmpvar_28.z) {
      tmpvar_31 = tmpvar_26.z;
    } else {
      tmpvar_31 = tmpvar_27.z;
    };
    vec3 tmpvar_32;
    tmpvar_32 = ((unity_SpecCube0_BoxMax.xyz + unity_SpecCube0_BoxMin.xyz) * 0.5);
    worldNormal_24 = (((
      (tmpvar_32 - unity_SpecCube0_ProbePosition.xyz)
     + tmpvar_7) + (tmpvar_25 * 
      min (min (tmpvar_29, tmpvar_30), tmpvar_31)
    )) - tmpvar_32);
  };
  vec4 tmpvar_33;
  tmpvar_33.xyz = worldNormal_24;
  tmpvar_33.w = (pow ((1.0 - tmpvar_11), 0.75) * 7.0);
  vec4 tmpvar_34;
  tmpvar_34 = textureCubeLod (unity_SpecCube0, worldNormal_24, tmpvar_33.w);
  vec3 tmpvar_35;
  tmpvar_35 = ((unity_SpecCube0_HDR.x * pow (tmpvar_34.w, unity_SpecCube0_HDR.y)) * tmpvar_34.xyz);
  if ((unity_SpecCube0_BoxMin.w < 0.99999)) {
    vec3 worldNormal_36;
    worldNormal_36 = tmpvar_22;
    if ((unity_SpecCube1_ProbePosition.w > 0.0)) {
      vec3 tmpvar_37;
      tmpvar_37 = normalize(tmpvar_22);
      vec3 tmpvar_38;
      tmpvar_38 = ((unity_SpecCube1_BoxMax.xyz - tmpvar_7) / tmpvar_37);
      vec3 tmpvar_39;
      tmpvar_39 = ((unity_SpecCube1_BoxMin.xyz - tmpvar_7) / tmpvar_37);
      bvec3 tmpvar_40;
      tmpvar_40 = greaterThan (tmpvar_37, vec3(0.0, 0.0, 0.0));
      float tmpvar_41;
      if (tmpvar_40.x) {
        tmpvar_41 = tmpvar_38.x;
      } else {
        tmpvar_41 = tmpvar_39.x;
      };
      float tmpvar_42;
      if (tmpvar_40.y) {
        tmpvar_42 = tmpvar_38.y;
      } else {
        tmpvar_42 = tmpvar_39.y;
      };
      float tmpvar_43;
      if (tmpvar_40.z) {
        tmpvar_43 = tmpvar_38.z;
      } else {
        tmpvar_43 = tmpvar_39.z;
      };
      vec3 tmpvar_44;
      tmpvar_44 = ((unity_SpecCube1_BoxMax.xyz + unity_SpecCube1_BoxMin.xyz) * 0.5);
      worldNormal_36 = (((
        (tmpvar_44 - unity_SpecCube1_ProbePosition.xyz)
       + tmpvar_7) + (tmpvar_37 * 
        min (min (tmpvar_41, tmpvar_42), tmpvar_43)
      )) - tmpvar_44);
    };
    vec4 tmpvar_45;
    tmpvar_45.xyz = worldNormal_36;
    tmpvar_45.w = (pow ((1.0 - tmpvar_11), 0.75) * 7.0);
    vec4 tmpvar_46;
    tmpvar_46 = textureCubeLod (unity_SpecCube1, worldNormal_36, tmpvar_45.w);
    tmpvar_19 = mix (((unity_SpecCube1_HDR.x * 
      pow (tmpvar_46.w, unity_SpecCube1_HDR.y)
    ) * tmpvar_46.xyz), tmpvar_35, unity_SpecCube0_BoxMin.www);
  } else {
    tmpvar_19 = tmpvar_35;
  };
  vec4 c_47;
  vec3 tmpvar_48;
  tmpvar_48 = normalize(worldN_2);
  vec3 tmpvar_49;
  tmpvar_49 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_9, vec3(tmpvar_5));
  float tmpvar_50;
  tmpvar_50 = (unity_ColorSpaceDielectricSpec.w - (tmpvar_5 * unity_ColorSpaceDielectricSpec.w));
  float tmpvar_51;
  tmpvar_51 = (1.0 - tmpvar_11);
  vec3 tmpvar_52;
  tmpvar_52 = normalize((_WorldSpaceLightPos0.xyz + tmpvar_8));
  float tmpvar_53;
  tmpvar_53 = max (0.0, dot (tmpvar_48, tmpvar_8));
  float tmpvar_54;
  tmpvar_54 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_52));
  float tmpvar_55;
  tmpvar_55 = ((tmpvar_51 * tmpvar_51) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_56;
  float tmpvar_57;
  tmpvar_57 = (10.0 / log2((
    ((1.0 - tmpvar_51) * 0.968)
   + 0.03)));
  tmpvar_56 = (tmpvar_57 * tmpvar_57);
  float x_58;
  x_58 = (1.0 - tmpvar_1);
  float x_59;
  x_59 = (1.0 - tmpvar_53);
  float tmpvar_60;
  tmpvar_60 = (0.5 + ((
    (2.0 * tmpvar_54)
   * tmpvar_54) * tmpvar_51));
  float x_61;
  x_61 = (1.0 - tmpvar_54);
  float x_62;
  x_62 = (1.0 - tmpvar_53);
  vec3 tmpvar_63;
  tmpvar_63 = (((
    (tmpvar_9 * tmpvar_50)
   * 
    (tmpvar_18 + (_LightColor0.xyz * ((
      (1.0 + ((tmpvar_60 - 1.0) * ((
        ((x_58 * x_58) * x_58)
       * x_58) * x_58)))
     * 
      (1.0 + ((tmpvar_60 - 1.0) * ((
        ((x_59 * x_59) * x_59)
       * x_59) * x_59)))
    ) * tmpvar_1)))
  ) + (
    (max (0.0, ((
      ((1.0/(((
        ((tmpvar_1 * (1.0 - tmpvar_55)) + tmpvar_55)
       * 
        ((tmpvar_53 * (1.0 - tmpvar_55)) + tmpvar_55)
      ) + 0.0001))) * (pow (max (0.0, 
        dot (tmpvar_48, tmpvar_52)
      ), tmpvar_56) * ((tmpvar_56 + 1.0) * unity_LightGammaCorrectionConsts.y)))
     * tmpvar_1) * unity_LightGammaCorrectionConsts.x)) * _LightColor0.xyz)
   * 
    (tmpvar_49 + ((1.0 - tmpvar_49) * ((
      ((x_61 * x_61) * x_61)
     * x_61) * x_61)))
  )) + (tmpvar_19 * mix (tmpvar_49, vec3(
    clamp ((tmpvar_11 + (1.0 - tmpvar_50)), 0.0, 1.0)
  ), vec3(
    ((((x_62 * x_62) * x_62) * x_62) * x_62)
  ))));
  c_47.xyz = tmpvar_63;
  c_47.w = tmpvar_12;
  c_3.w = c_47.w;
  c_3.xyz = mix (unity_FogColor.xyz, tmpvar_63, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 22 [_MainTex_ST]
Vector 17 [unity_4LightAtten0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 20 [unity_SHBb]
Vector 19 [unity_SHBg]
Vector 18 [unity_SHBr]
Vector 21 [unity_SHC]
"vs_3_0
def c23, 0, 1, 0, 0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6.x
dcl_texcoord6 o7
dp4 o0.x, c4, v0
dp4 o0.y, c5, v0
dp4 o0.w, c7, v0
mad o1.xy, v3, c22, c22.zwzw
dp4 r0.x, c10, v0
add r1, -r0.x, c16
mov o4.w, r0.x
dp4 r0.x, c8, v0
add r2, -r0.x, c14
mov o2.w, r0.x
dp4 r0.x, c9, v0
add r3, -r0.x, c15
mov o3.w, r0.x
mul r0, c12.xyzz, v2.y
mad r0, c11.xyzz, v2.x, r0
mad r0, c13.xyzz, v2.z, r0
dp3 r4.x, r0.xyww, r0.xyww
rsq r4.x, r4.x
mul r0, r0, r4.x
mul r4, r0.y, r3
mul r3, r3, r3
mad r3, r2, r2, r3
mad r2, r2, r0.x, r4
mad r2, r1, r0.w, r2
mad r1, r1, r1, r3
rsq r3.x, r1.x
rsq r3.y, r1.y
rsq r3.z, r1.z
rsq r3.w, r1.w
mov r4.y, c23.y
mad r1, r1, c17, r4.y
mul r2, r2, r3
max r2, r2, c23.x
rcp r3.x, r1.x
rcp r3.y, r1.y
rcp r3.z, r1.z
rcp r3.w, r1.w
mul r1, r2, r3
mul r2.xyz, r1.y, c1
mad r2.xyz, c0, r1.x, r2
mad r1.xyz, c2, r1.z, r2
mad r1.xyz, c3, r1.w, r1
mul r1.w, r0.y, r0.y
mad r1.w, r0.x, r0.x, -r1.w
mul r2, r0.ywzx, r0
dp4 r3.x, c18, r2
dp4 r3.y, c19, r2
dp4 r3.z, c20, r2
mad r2.xyz, c21, r1.w, r3
add o5.xyz, r1, r2
dp4 r0.z, c6, v0
mov o0.z, r0.z
mov o6.x, r0.z
dp3 r1.z, c8, v1
dp3 r1.x, c9, v1
dp3 r1.y, c10, v1
dp3 r0.z, r1, r1
rsq r0.z, r0.z
mul r1.xyz, r0.z, r1
mov o2.x, r1.z
mul r2.xyz, r0.wxyw, r1
mad r2.xyz, r0.ywxw, r1.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r0.x
mov o3.x, r1.x
mov o4.x, r1.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r0.y
mov o4.z, r0.w
mov o7, c23.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedcdbhnnfmonelobefgeoghpphogpaefngabaaaaaaoaalaaaaadaaaaaa
cmaaaaaaceabaaaaamacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcmmajaaaaeaaaabaahdacaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaae
egiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafeccabaaaabaaaaaa
ckaabaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaabaaaaaajgiecaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgiecaaaacaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaajgiecaaaacaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaa
acaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaaakbabaaa
acaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaimcaabaaaabaaaaaaagbabaaa
acaaaaaaagiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaacaaaaaabkbabaaa
acaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaabkbabaaa
acaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaimcaabaaaacaaaaaafgbfbaaa
acaaaaaafgifcaaaacaaaaaabcaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaaacaaaaaa
ckiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaackbabaaaacaaaaaa
ckiacaaaacaaaaaabbaaaaaadiaaaaaimcaabaaaacaaaaaakgbkbaaaacaaaaaa
kgikcaaaacaaaaaabcaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegadbaaaabaaaaaaegadbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaadganbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaangaebaaa
abaaaaaajgaebaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaa
akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaaaaaaaaadgaaaaaf
eccabaaaacaaaaaaakaabaaaabaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaadaaaaaadgaaaaaficcabaaaacaaaaaaakaabaaaadaaaaaadgaaaaaf
bccabaaaadaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaa
aaaaaaaadgaaaaafeccabaaaadaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaa
adaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaa
dgaaaaaficcabaaaadaaaaaabkaabaaaadaaaaaadgaaaaafeccabaaaaeaaaaaa
dkaabaaaabaaaaaadgaaaaaficcabaaaaeaaaaaackaabaaaadaaaaaaaaaaaaaj
pcaabaaaaaaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaaabaaaaaaadaaaaaa
diaaaaahpcaabaaaacaaaaaafgafbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaajpcaabaaa
aeaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaaj
pcaabaaaadaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaaabaaaaaaaeaaaaaa
dcaaaaajpcaabaaaacaaaaaaegaobaaaaeaaaaaaagaabaaaabaaaaaaegaobaaa
acaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaa
egaobaaaaaaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaaadaaaaaaegaobaaa
adaaaaaaegaobaaaaaaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaadaaaaaa
pgapbaaaabaaaaaaegaobaaaacaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaa
aaaaaaaadcaaaaanpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaabaaaaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaaaaaaaaa
diaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadeaaaaak
pcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaa
diaaaaaihcaabaaaacaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaa
kgakbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaangacbaaaabaaaaaaegaobaaaabaaaaaabbaaaaaibcaabaaa
acaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
acaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaa
acaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaabaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaahhccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaai
pccabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Vector 19 [_Color]
Float 18 [_Glossiness]
Vector 14 [_LightColor0]
Float 16 [_RainOpacity]
Float 17 [_Raining]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 13 [unity_ColorSpaceDielectricSpec]
Vector 15 [unity_LightGammaCorrectionConsts]
Vector 4 [unity_SHAb]
Vector 3 [unity_SHAg]
Vector 2 [unity_SHAr]
Vector 5 [unity_SpecCube0_BoxMax]
Vector 6 [unity_SpecCube0_BoxMin]
Vector 8 [unity_SpecCube0_HDR]
Vector 7 [unity_SpecCube0_ProbePosition]
Vector 9 [unity_SpecCube1_BoxMax]
Vector 10 [unity_SpecCube1_BoxMin]
Vector 12 [unity_SpecCube1_HDR]
Vector 11 [unity_SpecCube1_ProbePosition]
SetTexture 0 [unity_SpecCube0] CUBE 0
SetTexture 1 [unity_SpecCube1] CUBE 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_BumpMap] 2D 3
SetTexture 4 [_Rain] 2D 4
"ps_3_0
def c20, 0.5, 0.75, 7, 0.999989986
def c21, 9.99999975e-005, 0.967999995, 0.0299999993, 10
def c22, 0, 2, -1, 1
dcl_texcoord v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4_pp v4.xyz
dcl_cube s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
mov r0.x, v1.w
mov r0.y, v2.w
mov r0.z, v3.w
add r1.xyz, -r0, c0
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, r1
mov r3.xw, c22
if_lt -c17.x, r3.x
texld r4, v0, s2
mul_pp r4, r4, c19
texld_pp r5, v0, s4
lrp_pp r6.xyz, r5.w, r5.x, r4
texld_pp r7, v0, s3
mad_pp r4.xy, r7.wyzw, c22.y, c22.z
dp2add_sat_pp r1.w, r4, r4, c22.x
add_pp r1.w, -r1.w, c22.w
rsq_pp r1.w, r1.w
rcp_pp r4.z, r1.w
lrp r7.xyz, r5.w, c22.xxww, r4
nrm_pp r4.xyz, r7
mad_pp oC0.w, r5.w, c16.x, r4.w
else
texld r5, v0, s2
mul_pp r6, r5, c19
texld_pp r5, v0, s3
mad_pp r4.xy, r5.wyzw, c22.y, c22.z
dp2add_sat_pp r1.w, r4, r4, c22.x
add_pp r1.w, -r1.w, c22.w
rsq_pp r1.w, r1.w
rcp_pp r4.z, r1.w
mov_pp oC0.w, r6.w
endif
dp3_pp r5.x, v1, r4
dp3_pp r5.y, v2, r4
dp3_pp r5.z, v3, r4
dp3_pp r1.w, r5, c1
max_pp r2.w, r1.w, c22.x
mov_pp r5.w, c22.w
dp4_pp r4.x, c2, r5
dp4_pp r4.y, c3, r5
dp4_pp r4.z, c4, r5
add_pp r4.xyz, r4, v4
dp3 r1.w, -r2, r5
add r1.w, r1.w, r1.w
mad_pp r7.xyz, r5, -r1.w, -r2
if_lt -c7.w, r3.x
nrm_pp r8.xyz, r7
add r9.xyz, -r0, c5
rcp r10.x, r8.x
rcp r10.y, r8.y
rcp r10.z, r8.z
mul_pp r9.xyz, r9, r10
add r11.xyz, -r0, c6
mul_pp r10.xyz, r10, r11
cmp_pp r9.xyz, -r8, r10, r9
min_pp r1.w, r9.y, r9.x
min_pp r3.y, r9.z, r1.w
mov r9.xyz, c6
add r9.xyz, r9, c5
mov r10.x, c20.x
mad r10.xyz, r9, r10.x, -c7
add r10.xyz, r0, r10
mad r8.xyz, r8, r3.y, r10
mad_pp r8.xyz, r9, -c20.x, r8
else
mov_pp r8.xyz, r7
endif
add_pp r1.w, r3.w, -c18.x
pow_pp r3.y, r1.w, c20.y
mul_pp r8.w, r3.y, c20.z
texldl_pp r9, r8, s0
pow_pp r3.y, r9.w, c8.y
mul_pp r3.y, r3.y, c8.x
mul_pp r10.xyz, r9, r3.y
mov r11.xw, c20
if_lt c6.w, r11.w
if_lt -c11.w, r3.x
nrm_pp r12.xyz, r7
add r11.yzw, -r0.xxyz, c9.xxyz
rcp r13.x, r12.x
rcp r13.y, r12.y
rcp r13.z, r12.z
mul_pp r11.yzw, r11, r13.xxyz
add r14.xyz, -r0, c10
mul_pp r13.xyz, r13, r14
cmp_pp r11.yzw, -r12.xxyz, r13.xxyz, r11
min_pp r3.x, r11.z, r11.y
min_pp r4.w, r11.w, r3.x
mov r13.xyz, c9
add r11.yzw, r13.xxyz, c10.xxyz
mad r13.xyz, r11.yzww, r11.x, -c11
add r0.xyz, r0, r13
mad r0.xyz, r12, r4.w, r0
mad_pp r8.xyz, r11.yzww, -c20.x, r0
else
mov_pp r8.xyz, r7
endif
texldl_pp r7, r8, s1
pow_pp r0.x, r7.w, c12.y
mul_pp r0.x, r0.x, c12.x
mul_pp r0.xyz, r7, r0.x
mad r3.xyz, r3.y, r9, -r0
mad_pp r10.xyz, c6.w, r3, r0
endif
nrm_pp r0.xyz, r5
mul_pp r3.xyz, r6, c13.w
mad_pp r1.xyz, r1, r0.w, c1
nrm_pp r5.xyz, r1
dp3_pp r0.w, r0, r5
max_pp r1.x, r0.w, c22.x
dp3_pp r0.x, r0, r2
max_pp r1.y, r0.x, c22.x
dp3_pp r0.x, c1, r5
max_pp r1.z, r0.x, c22.x
mul_pp r0.x, r1.w, r1.w
mul_pp r0.y, r0.x, c15.w
mad_pp r0.x, r0.x, -c15.w, r3.w
mad_pp r0.z, r2.w, r0.x, r0.y
mad_pp r0.x, r1.y, r0.x, r0.y
mad r0.x, r0.z, r0.x, c21.x
rcp_pp r0.x, r0.x
add_pp r0.y, -r1.w, c22.w
mad_pp r0.y, r0.y, c21.y, c21.z
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c21.w
mul_pp r0.z, r0.y, r0.y
mad_pp r0.y, r0.y, r0.y, c22.w
mul_pp r0.y, r0.y, c15.y
pow_pp r2.x, r1.x, r0.z
mul_pp r0.y, r0.y, r2.x
add_pp r0.z, -r2.w, c22.w
mul_pp r0.xw, r0.yyzz, r0.xyzz
mul_pp r0.w, r0.w, r0.w
mul_pp r0.z, r0.z, r0.w
add_pp r0.w, -r1.y, c22.w
mul_pp r1.x, r0.w, r0.w
mul_pp r1.x, r1.x, r1.x
mul_pp r0.w, r0.w, r1.x
mul_pp r1.x, r1.z, r1.z
dp2add_pp r1.x, r1.x, r1.w, -c20.x
mad_pp r0.z, r1.x, r0.z, c22.w
mad_pp r1.x, r1.x, r0.w, c22.w
mul_pp r0.z, r0.z, r1.x
mul_pp r0.xy, r2.w, r0.xzzw
mul_pp r0.x, r0.x, c15.x
mov r1.w, c13.w
add_pp r0.z, -r1.w, c18.x
add_sat_pp r0.z, r0.z, c22.w
mad_pp r1.xyw, c14.xyzz, r0.y, r4.xyzz
mul_pp r2.xyz, r0.x, c14
cmp_pp r2.xyz, r0.x, r2, c22.x
add_pp r0.x, -r1.z, c22.w
mul_pp r0.y, r0.x, r0.x
mul_pp r0.y, r0.y, r0.y
mul_pp r0.x, r0.x, r0.y
lrp_pp r4.xyz, r0.x, r3.w, c13
mul_pp r2.xyz, r2, r4
mad_pp r1.xyz, r3, r1.xyww, r2
lrp_pp r2.xyz, r0.w, r0.z, c13
mad_pp oC0.xyz, r10, r2, r1

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Rain] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [unity_SpecCube0] CUBE 0
SetTexture 4 [unity_SpecCube1] CUBE 1
ConstBuffer "$Globals" 192
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Float 144 [_RainOpacity]
Float 148 [_Raining]
Float 152 [_Glossiness]
Vector 160 [_Color]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
ConstBuffer "UnityReflectionProbes" 128
Vector 0 [unity_SpecCube0_BoxMax]
Vector 16 [unity_SpecCube0_BoxMin]
Vector 32 [unity_SpecCube0_ProbePosition]
Vector 48 [unity_SpecCube0_HDR]
Vector 64 [unity_SpecCube1_BoxMax]
Vector 80 [unity_SpecCube1_BoxMin]
Vector 96 [unity_SpecCube1_ProbePosition]
Vector 112 [unity_SpecCube1_HDR]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityReflectionProbes" 3
"ps_4_0
eefiecedikcglidkohcnagknjfddacnimbjacjdbabaaaaaacebhaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcombfaaaaeaaaaaaahlafaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaacjaaaaaafjaaaaaeegiocaaaadaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafidaaaaeaahabaaaadaaaaaaffffaaaafidaaaae
aahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacanaaaaaadgaaaaaf
bcaabaaaaaaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaa
adaaaaaadgaaaaafecaabaaaaaaaaaaadkbabaaaaeaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadbaaaaaiicaabaaaabaaaaaaabeaaaaaaaaaaaaabkiacaaa
aaaaaaaaajaaaaaabpaaaeaddkaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaipcaabaaa
adaaaaaaegaobaaaadaaaaaaegiocaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaa
aeaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaaaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaaeaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaacaaaaaadkaabaaaaeaaaaaaakaabaaaaeaaaaaadcaaaaajhcaabaaa
afaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaapgapbaaaacaaaaaaefaaaaaj
pcaabaaaagaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaa
dcaaaaapdcaabaaaadaaaaaahgapbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaacaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaa
dkaabaaaacaaaaaadiaaaaakhcaabaaaaeaaaaaapgapbaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
adaaaaaapgapbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
dcaaaaakiccabaaaaaaaaaaadkaabaaaaeaaaaaaakiacaaaaaaaaaaaajaaaaaa
dkaabaaaadaaaaaabcaaaaabefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaipcaabaaaafaaaaaaegaobaaa
aeaaaaaaegiocaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaa
hgapbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaa
adaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaafaaaaaabfaaaaabbaaaaaahbcaabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaa
adaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaa
egacbaaaadaaaaaabaaaaaaiicaabaaaabaaaaaaegacbaaaaeaaaaaaegiccaaa
acaaaaaaaaaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaaadgaaaaaficaabaaaaeaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
adaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaeaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaeaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaeaaaaaaaaaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaaacaaaaaa
egacbaiaebaaaaaaacaaaaaaegacbaaaaeaaaaaaaaaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaalhcaabaaaagaaaaaaegacbaaa
aeaaaaaapgapbaiaebaaaaaaacaaaaaaegacbaiaebaaaaaaacaaaaaadbaaaaai
icaabaaaacaaaaaaabeaaaaaaaaaaaaadkiacaaaadaaaaaaacaaaaaabpaaaead
dkaabaaaacaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaagaaaaaaegacbaaa
agaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaa
ahaaaaaapgapbaaaacaaaaaaegacbaaaagaaaaaaaaaaaaajhcaabaaaaiaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaaaaaaaaaaoaaaaahhcaabaaa
aiaaaaaaegacbaaaaiaaaaaaegacbaaaahaaaaaaaaaaaaajhcaabaaaajaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaabaaaaaaaoaaaaahhcaabaaa
ajaaaaaaegacbaaaajaaaaaaegacbaaaahaaaaaadbaaaaakhcaabaaaakaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaahaaaaaadhaaaaaj
hcaabaaaaiaaaaaaegacbaaaakaaaaaaegacbaaaaiaaaaaaegacbaaaajaaaaaa
ddaaaaahicaabaaaacaaaaaabkaabaaaaiaaaaaaakaabaaaaiaaaaaaddaaaaah
icaabaaaacaaaaaackaabaaaaiaaaaaadkaabaaaacaaaaaaaaaaaaajhcaabaaa
aiaaaaaaegiccaaaadaaaaaaaaaaaaaaegiccaaaadaaaaaaabaaaaaadcaaaaao
hcaabaaaajaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaegiccaiaebaaaaaaadaaaaaaacaaaaaaaaaaaaahhcaabaaaajaaaaaa
egacbaaaaaaaaaaaegacbaaaajaaaaaadcaaaaajhcaabaaaahaaaaaaegacbaaa
ahaaaaaapgapbaaaacaaaaaaegacbaaaajaaaaaadcaaaaanhcaabaaaahaaaaaa
egacbaiaebaaaaaaaiaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
egacbaaaahaaaaaabcaaaaabdgaaaaafhcaabaaaahaaaaaaegacbaaaagaaaaaa
bfaaaaabaaaaaaajicaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaa
abeaaaaaaaaaiadpcpaaaaaficaabaaaadaaaaaadkaabaaaacaaaaaadiaaaaah
icaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaeadpbjaaaaaficaabaaa
adaaaaaadkaabaaaadaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaa
abeaaaaaaaaaoaeaeiaaaaalpcaabaaaahaaaaaaegacbaaaahaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaadkaabaaaadaaaaaacpaaaaaficaabaaaaeaaaaaa
dkaabaaaahaaaaaadiaaaaaiicaabaaaaeaaaaaadkaabaaaaeaaaaaabkiacaaa
adaaaaaaadaaaaaabjaaaaaficaabaaaaeaaaaaadkaabaaaaeaaaaaadiaaaaai
icaabaaaaeaaaaaadkaabaaaaeaaaaaaakiacaaaadaaaaaaadaaaaaadiaaaaah
hcaabaaaaiaaaaaaegacbaaaahaaaaaapgapbaaaaeaaaaaadbaaaaaiicaabaaa
afaaaaaadkiacaaaadaaaaaaabaaaaaaabeaaaaafipphpdpbpaaaeaddkaabaaa
afaaaaaadbaaaaaiicaabaaaafaaaaaaabeaaaaaaaaaaaaadkiacaaaadaaaaaa
agaaaaaabpaaaeaddkaabaaaafaaaaaabaaaaaahicaabaaaafaaaaaaegacbaaa
agaaaaaaegacbaaaagaaaaaaeeaaaaaficaabaaaafaaaaaadkaabaaaafaaaaaa
diaaaaahhcaabaaaajaaaaaapgapbaaaafaaaaaaegacbaaaagaaaaaaaaaaaaaj
hcaabaaaakaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaaeaaaaaa
aoaaaaahhcaabaaaakaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaj
hcaabaaaalaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaafaaaaaa
aoaaaaahhcaabaaaalaaaaaaegacbaaaalaaaaaaegacbaaaajaaaaaadbaaaaak
hcaabaaaamaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaa
ajaaaaaadhaaaaajhcaabaaaakaaaaaaegacbaaaamaaaaaaegacbaaaakaaaaaa
egacbaaaalaaaaaaddaaaaahicaabaaaafaaaaaabkaabaaaakaaaaaaakaabaaa
akaaaaaaddaaaaahicaabaaaafaaaaaackaabaaaakaaaaaadkaabaaaafaaaaaa
aaaaaaajhcaabaaaakaaaaaaegiccaaaadaaaaaaaeaaaaaaegiccaaaadaaaaaa
afaaaaaadcaaaaaohcaabaaaalaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaaegiccaiaebaaaaaaadaaaaaaagaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaalaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaajaaaaaapgapbaaaafaaaaaaegacbaaaaaaaaaaadcaaaaan
hcaabaaaagaaaaaaegacbaiaebaaaaaaakaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaegacbaaaaaaaaaaabfaaaaabeiaaaaalpcaabaaaagaaaaaa
egacbaaaagaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadkaabaaaadaaaaaa
cpaaaaafbcaabaaaaaaaaaaadkaabaaaagaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaadaaaaaaahaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
adaaaaaaahaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaagaaaaaaagaabaaa
aaaaaaaadcaaaaakhcaabaaaagaaaaaapgapbaaaaeaaaaaaegacbaaaahaaaaaa
egacbaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaaiaaaaaapgipcaaaadaaaaaa
abaaaaaaegacbaaaagaaaaaaegacbaaaaaaaaaaabfaaaaabbaaaaaahbcaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaa
aeaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaaafaaaaaapgipcaaaaaaaaaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaaiccaabaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadeaaaaaklcaabaaaaaaaaaaaegambaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahecaabaaa
aaaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaaibcaabaaaabaaaaaa
ckaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadp
dcaaaaajccaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaa
aaaaaaaaabeaaaaabhlhnbdiaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaa
dkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaaaoaaaaahbcaabaaaabaaaaaaabeaaaaaaaaacaeb
akaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaa
aaaaaaaaaiaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaa
dkaabaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
ccaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaaapaaaaahccaabaaaabaaaaaafgafbaaaabaaaaaa
pgapbaaaacaaaaaaaaaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaalpdcaaaaajbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaiadpdcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaa
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaa
deaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaakbcaabaaa
abaaaaaadkiacaiaebaaaaaaaaaaaaaaacaaaaaackiacaaaaaaaaaaaajaaaaaa
aacaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaak
ocaabaaaabaaaaaaagijcaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaagajbaaa
adaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaa
agaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaamhcaabaaa
adaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadcaaaaakocaabaaaaaaaaaaaagajbaaaadaaaaaafgafbaaa
aaaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagajbaaaacaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaaeaaaaaa
fgaobaaaabaaaaaafgaobaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaagaabaaa
abaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaaiaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Vector 21 [_Color]
Float 20 [_Glossiness]
Vector 16 [_LightColor0]
Float 18 [_RainOpacity]
Float 19 [_Raining]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 15 [unity_ColorSpaceDielectricSpec]
Vector 5 [unity_FogColor]
Vector 6 [unity_FogParams]
Vector 17 [unity_LightGammaCorrectionConsts]
Vector 4 [unity_SHAb]
Vector 3 [unity_SHAg]
Vector 2 [unity_SHAr]
Vector 7 [unity_SpecCube0_BoxMax]
Vector 8 [unity_SpecCube0_BoxMin]
Vector 10 [unity_SpecCube0_HDR]
Vector 9 [unity_SpecCube0_ProbePosition]
Vector 11 [unity_SpecCube1_BoxMax]
Vector 12 [unity_SpecCube1_BoxMin]
Vector 14 [unity_SpecCube1_HDR]
Vector 13 [unity_SpecCube1_ProbePosition]
SetTexture 0 [unity_SpecCube0] CUBE 0
SetTexture 1 [unity_SpecCube1] CUBE 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_BumpMap] 2D 3
SetTexture 4 [_Rain] 2D 4
"ps_3_0
def c22, 0, 2, -1, 1
def c23, 0.5, 0.75, 7, 0.999989986
def c24, 9.99999975e-005, 0.967999995, 0.0299999993, 10
dcl_texcoord v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4_pp v4.xyz
dcl_texcoord5 v5.x
dcl_cube s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
mov r0.x, v1.w
mov r0.y, v2.w
mov r0.z, v3.w
add r1.xyz, -r0, c0
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, r1
mov r3.xw, c22
if_lt -c19.x, r3.x
texld r4, v0, s2
mul_pp r4, r4, c21
texld_pp r5, v0, s4
lrp_pp r6.xyz, r5.w, r5.x, r4
texld_pp r7, v0, s3
mad_pp r4.xy, r7.wyzw, c22.y, c22.z
dp2add_sat_pp r1.w, r4, r4, c22.x
add_pp r1.w, -r1.w, c22.w
rsq_pp r1.w, r1.w
rcp_pp r4.z, r1.w
lrp r7.xyz, r5.w, c22.xxww, r4
nrm_pp r4.xyz, r7
mad_pp oC0.w, r5.w, c18.x, r4.w
else
texld r5, v0, s2
mul_pp r6, r5, c21
texld_pp r5, v0, s3
mad_pp r4.xy, r5.wyzw, c22.y, c22.z
dp2add_sat_pp r1.w, r4, r4, c22.x
add_pp r1.w, -r1.w, c22.w
rsq_pp r1.w, r1.w
rcp_pp r4.z, r1.w
mov_pp oC0.w, r6.w
endif
dp3_pp r5.x, v1, r4
dp3_pp r5.y, v2, r4
dp3_pp r5.z, v3, r4
dp3_pp r1.w, r5, c1
max_pp r2.w, r1.w, c22.x
mov_pp r5.w, c22.w
dp4_pp r4.x, c2, r5
dp4_pp r4.y, c3, r5
dp4_pp r4.z, c4, r5
add_pp r4.xyz, r4, v4
dp3 r1.w, -r2, r5
add r1.w, r1.w, r1.w
mad_pp r7.xyz, r5, -r1.w, -r2
if_lt -c9.w, r3.x
nrm_pp r8.xyz, r7
add r9.xyz, -r0, c7
rcp r10.x, r8.x
rcp r10.y, r8.y
rcp r10.z, r8.z
mul_pp r9.xyz, r9, r10
add r11.xyz, -r0, c8
mul_pp r10.xyz, r10, r11
cmp_pp r9.xyz, -r8, r10, r9
min_pp r1.w, r9.y, r9.x
min_pp r3.y, r9.z, r1.w
mov r9.xyz, c8
add r9.xyz, r9, c7
mov r10.x, c23.x
mad r10.xyz, r9, r10.x, -c9
add r10.xyz, r0, r10
mad r8.xyz, r8, r3.y, r10
mad_pp r8.xyz, r9, -c23.x, r8
else
mov_pp r8.xyz, r7
endif
add_pp r1.w, r3.w, -c20.x
pow_pp r3.y, r1.w, c23.y
mul_pp r8.w, r3.y, c23.z
texldl_pp r9, r8, s0
pow_pp r3.y, r9.w, c10.y
mul_pp r3.y, r3.y, c10.x
mul_pp r10.xyz, r9, r3.y
mov r11.xw, c23
if_lt c8.w, r11.w
if_lt -c13.w, r3.x
nrm_pp r12.xyz, r7
add r11.yzw, -r0.xxyz, c11.xxyz
rcp r13.x, r12.x
rcp r13.y, r12.y
rcp r13.z, r12.z
mul_pp r11.yzw, r11, r13.xxyz
add r14.xyz, -r0, c12
mul_pp r13.xyz, r13, r14
cmp_pp r11.yzw, -r12.xxyz, r13.xxyz, r11
min_pp r3.x, r11.z, r11.y
min_pp r4.w, r11.w, r3.x
mov r13.xyz, c11
add r11.yzw, r13.xxyz, c12.xxyz
mad r13.xyz, r11.yzww, r11.x, -c13
add r0.xyz, r0, r13
mad r0.xyz, r12, r4.w, r0
mad_pp r8.xyz, r11.yzww, -c23.x, r0
else
mov_pp r8.xyz, r7
endif
texldl_pp r7, r8, s1
pow_pp r0.x, r7.w, c14.y
mul_pp r0.x, r0.x, c14.x
mul_pp r0.xyz, r7, r0.x
mad r3.xyz, r3.y, r9, -r0
mad_pp r10.xyz, c8.w, r3, r0
endif
nrm_pp r0.xyz, r5
mul_pp r3.xyz, r6, c15.w
mad_pp r1.xyz, r1, r0.w, c1
nrm_pp r5.xyz, r1
dp3_pp r0.w, r0, r5
max_pp r1.x, r0.w, c22.x
dp3_pp r0.x, r0, r2
max_pp r1.y, r0.x, c22.x
dp3_pp r0.x, c1, r5
max_pp r1.z, r0.x, c22.x
mul_pp r0.x, r1.w, r1.w
mul_pp r0.y, r0.x, c17.w
mad_pp r0.x, r0.x, -c17.w, r3.w
mad_pp r0.z, r2.w, r0.x, r0.y
mad_pp r0.x, r1.y, r0.x, r0.y
mad r0.x, r0.z, r0.x, c24.x
rcp_pp r0.x, r0.x
add_pp r0.y, -r1.w, c22.w
mad_pp r0.y, r0.y, c24.y, c24.z
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c24.w
mul_pp r0.z, r0.y, r0.y
mad_pp r0.y, r0.y, r0.y, c22.w
mul_pp r0.y, r0.y, c17.y
pow_pp r2.x, r1.x, r0.z
mul_pp r0.y, r0.y, r2.x
add_pp r0.z, -r2.w, c22.w
mul_pp r0.xw, r0.yyzz, r0.xyzz
mul_pp r0.w, r0.w, r0.w
mul_pp r0.z, r0.z, r0.w
add_pp r0.w, -r1.y, c22.w
mul_pp r1.x, r0.w, r0.w
mul_pp r1.x, r1.x, r1.x
mul_pp r0.w, r0.w, r1.x
mul_pp r1.x, r1.z, r1.z
dp2add_pp r1.x, r1.x, r1.w, -c23.x
mad_pp r0.z, r1.x, r0.z, c22.w
mad_pp r1.x, r1.x, r0.w, c22.w
mul_pp r0.z, r0.z, r1.x
mul_pp r0.xy, r2.w, r0.xzzw
mul_pp r0.x, r0.x, c17.x
mov r1.w, c15.w
add_pp r0.z, -r1.w, c20.x
add_sat_pp r0.z, r0.z, c22.w
mad_pp r1.xyw, c16.xyzz, r0.y, r4.xyzz
mul_pp r2.xyz, r0.x, c16
cmp_pp r2.xyz, r0.x, r2, c22.x
add_pp r0.x, -r1.z, c22.w
mul_pp r0.y, r0.x, r0.x
mul_pp r0.y, r0.y, r0.y
mul_pp r0.x, r0.x, r0.y
lrp_pp r4.xyz, r0.x, r3.w, c15
mul_pp r2.xyz, r2, r4
mad_pp r1.xyz, r3, r1.xyww, r2
lrp_pp r2.xyz, r0.w, r0.z, c15
mad_pp r0.xyz, r10, r2, r1
mul r0.w, c6.y, v5.x
exp_sat r0.w, -r0.w
add r0.xyz, r0, -c5
mad_pp oC0.xyz, r0.w, r0, c5

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Rain] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [unity_SpecCube0] CUBE 0
SetTexture 4 [unity_SpecCube1] CUBE 1
ConstBuffer "$Globals" 192
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Float 144 [_RainOpacity]
Float 148 [_Raining]
Float 152 [_Glossiness]
Vector 160 [_Color]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
ConstBuffer "UnityReflectionProbes" 128
Vector 0 [unity_SpecCube0_BoxMax]
Vector 16 [unity_SpecCube0_BoxMin]
Vector 32 [unity_SpecCube0_ProbePosition]
Vector 48 [unity_SpecCube0_HDR]
Vector 64 [unity_SpecCube1_BoxMax]
Vector 80 [unity_SpecCube1_BoxMin]
Vector 96 [unity_SpecCube1_ProbePosition]
Vector 112 [unity_SpecCube1_HDR]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityFog" 3
BindCB  "UnityReflectionProbes" 4
"ps_4_0
eefiecedcnjljdeachhdchkihmpffmopaolhafknabaaaaaapibhaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckibgaaaaeaaaaaaakkafaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaacjaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaafjaaaaaeegiocaaa
aeaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafidaaaaeaahabaaaadaaaaaa
ffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadecbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacanaaaaaadgaaaaafbcaabaaaaaaaaaaadkbabaaa
acaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaa
aaaaaaaadkbabaaaaeaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadbaaaaai
icaabaaaabaaaaaaabeaaaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaabpaaaead
dkaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaadiaaaaaipcaabaaaadaaaaaaegaobaaaadaaaaaa
egiocaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaeaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaia
ebaaaaaaaeaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaacaaaaaadkaabaaa
aeaaaaaaakaabaaaaeaaaaaadcaaaaajhcaabaaaafaaaaaaegacbaaaadaaaaaa
pgapbaaaabaaaaaapgapbaaaacaaaaaaefaaaaajpcaabaaaagaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaa
hgapbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaacaaaaaaegaabaaa
adaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaacaaaaaadiaaaaak
hcaabaaaaeaaaaaapgapbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadp
aaaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaa
egacbaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
adaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaadcaaaaakiccabaaaaaaaaaaa
dkaabaaaaeaaaaaaakiacaaaaaaaaaaaajaaaaaadkaabaaaadaaaaaabcaaaaab
efaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadiaaaaaipcaabaaaafaaaaaaegaobaaaaeaaaaaaegiocaaaaaaaaaaa
akaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaa
ddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaadaaaaaadkaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
afaaaaaabfaaaaabbaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaa
baaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaai
icaabaaaabaaaaaaegacbaaaaeaaaaaaegiccaaaacaaaaaaaaaaaaaadeaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadgaaaaaficaabaaa
aeaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaeaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaeaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaeaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
egbcbaaaafaaaaaabaaaaaaiicaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaa
egacbaaaaeaaaaaaaaaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaa
acaaaaaadcaaaaalhcaabaaaagaaaaaaegacbaaaaeaaaaaapgapbaiaebaaaaaa
acaaaaaaegacbaiaebaaaaaaacaaaaaadbaaaaaiicaabaaaacaaaaaaabeaaaaa
aaaaaaaadkiacaaaaeaaaaaaacaaaaaabpaaaeaddkaabaaaacaaaaaabaaaaaah
icaabaaaacaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaeeaaaaaficaabaaa
acaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaaahaaaaaapgapbaaaacaaaaaa
egacbaaaagaaaaaaaaaaaaajhcaabaaaaiaaaaaaegacbaiaebaaaaaaaaaaaaaa
egiccaaaaeaaaaaaaaaaaaaaaoaaaaahhcaabaaaaiaaaaaaegacbaaaaiaaaaaa
egacbaaaahaaaaaaaaaaaaajhcaabaaaajaaaaaaegacbaiaebaaaaaaaaaaaaaa
egiccaaaaeaaaaaaabaaaaaaaoaaaaahhcaabaaaajaaaaaaegacbaaaajaaaaaa
egacbaaaahaaaaaadbaaaaakhcaabaaaakaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaegacbaaaahaaaaaadhaaaaajhcaabaaaaiaaaaaaegacbaaa
akaaaaaaegacbaaaaiaaaaaaegacbaaaajaaaaaaddaaaaahicaabaaaacaaaaaa
bkaabaaaaiaaaaaaakaabaaaaiaaaaaaddaaaaahicaabaaaacaaaaaackaabaaa
aiaaaaaadkaabaaaacaaaaaaaaaaaaajhcaabaaaaiaaaaaaegiccaaaaeaaaaaa
aaaaaaaaegiccaaaaeaaaaaaabaaaaaadcaaaaaohcaabaaaajaaaaaaegacbaaa
aiaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegiccaiaebaaaaaa
aeaaaaaaacaaaaaaaaaaaaahhcaabaaaajaaaaaaegacbaaaaaaaaaaaegacbaaa
ajaaaaaadcaaaaajhcaabaaaahaaaaaaegacbaaaahaaaaaapgapbaaaacaaaaaa
egacbaaaajaaaaaadcaaaaanhcaabaaaahaaaaaaegacbaiaebaaaaaaaiaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaahaaaaaabcaaaaab
dgaaaaafhcaabaaaahaaaaaaegacbaaaagaaaaaabfaaaaabaaaaaaajicaabaaa
acaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaaabeaaaaaaaaaiadpcpaaaaaf
icaabaaaadaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaeadpbjaaaaaficaabaaaadaaaaaadkaabaaaadaaaaaa
diaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaoaeaeiaaaaal
pcaabaaaahaaaaaaegacbaaaahaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaa
dkaabaaaadaaaaaacpaaaaaficaabaaaaeaaaaaadkaabaaaahaaaaaadiaaaaai
icaabaaaaeaaaaaadkaabaaaaeaaaaaabkiacaaaaeaaaaaaadaaaaaabjaaaaaf
icaabaaaaeaaaaaadkaabaaaaeaaaaaadiaaaaaiicaabaaaaeaaaaaadkaabaaa
aeaaaaaaakiacaaaaeaaaaaaadaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaa
ahaaaaaapgapbaaaaeaaaaaadbaaaaaiicaabaaaafaaaaaadkiacaaaaeaaaaaa
abaaaaaaabeaaaaafipphpdpbpaaaeaddkaabaaaafaaaaaadbaaaaaiicaabaaa
afaaaaaaabeaaaaaaaaaaaaadkiacaaaaeaaaaaaagaaaaaabpaaaeaddkaabaaa
afaaaaaabaaaaaahicaabaaaafaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaa
eeaaaaaficaabaaaafaaaaaadkaabaaaafaaaaaadiaaaaahhcaabaaaajaaaaaa
pgapbaaaafaaaaaaegacbaaaagaaaaaaaaaaaaajhcaabaaaakaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaaeaaaaaaaeaaaaaaaoaaaaahhcaabaaaakaaaaaa
egacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaajhcaabaaaalaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaaeaaaaaaafaaaaaaaoaaaaahhcaabaaaalaaaaaa
egacbaaaalaaaaaaegacbaaaajaaaaaadbaaaaakhcaabaaaamaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaajaaaaaadhaaaaajhcaabaaa
akaaaaaaegacbaaaamaaaaaaegacbaaaakaaaaaaegacbaaaalaaaaaaddaaaaah
icaabaaaafaaaaaabkaabaaaakaaaaaaakaabaaaakaaaaaaddaaaaahicaabaaa
afaaaaaackaabaaaakaaaaaadkaabaaaafaaaaaaaaaaaaajhcaabaaaakaaaaaa
egiccaaaaeaaaaaaaeaaaaaaegiccaaaaeaaaaaaafaaaaaadcaaaaaohcaabaaa
alaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
egiccaiaebaaaaaaaeaaaaaaagaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaalaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaajaaaaaa
pgapbaaaafaaaaaaegacbaaaaaaaaaaadcaaaaanhcaabaaaagaaaaaaegacbaia
ebaaaaaaakaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaa
aaaaaaaabfaaaaabeiaaaaalpcaabaaaagaaaaaaegacbaaaagaaaaaaeghobaaa
aeaaaaaaaagabaaaabaaaaaadkaabaaaadaaaaaacpaaaaafbcaabaaaaaaaaaaa
dkaabaaaagaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaa
aeaaaaaaahaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaeaaaaaaahaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaagaaaaaaagaabaaaaaaaaaaadcaaaaakhcaabaaa
agaaaaaapgapbaaaaeaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaaaaaaaaaa
dcaaaaakhcaabaaaaiaaaaaapgipcaaaaeaaaaaaabaaaaaaegacbaaaagaaaaaa
egacbaaaaaaaaaaabfaaaaabbaaaaaahbcaabaaaaaaaaaaaegacbaaaaeaaaaaa
egacbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaaihcaabaaa
aeaaaaaaegacbaaaafaaaaaapgipcaaaaaaaaaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaabaaaaaaiccaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadeaaaaaklcaabaaaaaaaaaaaegambaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaaibcaabaaaabaaaaaackaabaaaaaaaaaaadkiacaaa
aaaaaaaaaiaaaaaadcaaaaalecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadpdcaaaaajccaabaaaabaaaaaa
dkaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaaj
ecaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaabhlhnbdi
aoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
ckaabaaaaaaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaaacaaaaaa
abeaaaaaaaaaiadpdcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
njmohhdpabeaaaaaipmcpfdmcpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
aoaaaaahbcaabaaaabaaaaaaabeaaaaaaaaacaebakaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaai
bcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaaaaaaaaaaaiaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaai
bcaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaah
ccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaabaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
apaaaaahccaabaaaabaaaaaafgafbaaaabaaaaaapgapbaaaacaaaaaaaaaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaalpdcaaaaajbcaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaaj
ccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaa
aaaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadeaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
abaaaaaaakaabaaaabaaaaaaaaaaaaakbcaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaacaaaaaackiacaaaaaaaaaaaajaaaaaaaacaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaakocaabaaaabaaaaaaagijcaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaagajbaaaadaaaaaadiaaaaaihcaabaaa
acaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaaaaaaaamhcaabaaaadaaaaaaegiccaiaebaaaaaa
aaaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaak
ocaabaaaaaaaaaaaagajbaaaadaaaaaafgafbaaaaaaaaaaaagijcaaaaaaaaaaa
acaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaacaaaaaa
dcaaaaajocaabaaaaaaaaaaaagajbaaaaeaaaaaafgaobaaaabaaaaaafgaobaaa
aaaaaaaaaaaaaaajhcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaiaebaaaaaa
aaaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
aiaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
ckbabaaaabaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaadaaaaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaadaaaaaaaaaaaaaadoaaaaab"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" }
  ZWrite Off
  Blend SrcAlpha One
  ColorMask RGB
  GpuProgramID 78861
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  vec3 tmpvar_4;
  tmpvar_4 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * TANGENT.xyz));
  vec3 tmpvar_7;
  tmpvar_7 = (((tmpvar_4.yzx * tmpvar_6.zxy) - (tmpvar_4.zxy * tmpvar_6.yzx)) * TANGENT.w);
  vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_6.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_4.x;
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_6.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_4.y;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_6.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_4.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Rain;
uniform float _RainOpacity;
uniform float _Raining;
uniform float _Glossiness;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 tmpvar_1;
  float tmpvar_2;
  vec3 worldN_3;
  vec3 tmpvar_4;
  float tmpvar_5;
  float tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_9;
  vec3 tmpvar_10;
  float tmpvar_11;
  float tmpvar_12;
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = tmpvar_4;
  tmpvar_11 = tmpvar_6;
  tmpvar_12 = 0.0;
  if ((_Raining > 0.0)) {
    vec4 tmpvar_13;
    tmpvar_13 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    vec4 tmpvar_14;
    tmpvar_14 = texture2D (_Rain, xlv_TEXCOORD0);
    tmpvar_9 = ((tmpvar_13.xyz * (1.0 - tmpvar_14.w)) + (tmpvar_14.x * tmpvar_14.w));
    vec3 normal_15;
    normal_15.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_15.z = sqrt((1.0 - clamp (
      dot (normal_15.xy, normal_15.xy)
    , 0.0, 1.0)));
    tmpvar_10 = normalize(((normal_15 * 
      (1.0 - tmpvar_14.w)
    ) + (vec3(0.0, 0.0, 1.0) * tmpvar_14.w)));
    tmpvar_11 = _Glossiness;
    tmpvar_12 = (tmpvar_13.w + (tmpvar_14.w * _RainOpacity));
  } else {
    vec4 tmpvar_16;
    tmpvar_16 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    tmpvar_9 = tmpvar_16.xyz;
    vec3 normal_17;
    normal_17.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_17.z = sqrt((1.0 - clamp (
      dot (normal_17.xy, normal_17.xy)
    , 0.0, 1.0)));
    tmpvar_10 = normal_17;
    tmpvar_11 = _Glossiness;
    tmpvar_12 = tmpvar_16.w;
  };
  tmpvar_6 = tmpvar_11;
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = xlv_TEXCOORD4;
  vec3 tmpvar_19;
  tmpvar_19 = (_LightMatrix0 * tmpvar_18).xyz;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_10);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_10);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_10);
  tmpvar_4 = worldN_3;
  tmpvar_2 = max (0.0, dot (worldN_3, tmpvar_7));
  tmpvar_1 = (_LightColor0.xyz * texture2D (_LightTexture0, vec2(dot (tmpvar_19, tmpvar_19))).w);
  vec4 c_20;
  vec3 tmpvar_21;
  tmpvar_21 = normalize(worldN_3);
  vec3 tmpvar_22;
  tmpvar_22 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_9, vec3(tmpvar_5));
  float tmpvar_23;
  tmpvar_23 = (1.0 - tmpvar_11);
  vec3 tmpvar_24;
  tmpvar_24 = normalize((tmpvar_7 + tmpvar_8));
  float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_21, tmpvar_8));
  float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_7, tmpvar_24));
  float tmpvar_27;
  tmpvar_27 = ((tmpvar_23 * tmpvar_23) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (10.0 / log2((
    ((1.0 - tmpvar_23) * 0.968)
   + 0.03)));
  tmpvar_28 = (tmpvar_29 * tmpvar_29);
  float x_30;
  x_30 = (1.0 - tmpvar_2);
  float x_31;
  x_31 = (1.0 - tmpvar_25);
  float tmpvar_32;
  tmpvar_32 = (0.5 + ((
    (2.0 * tmpvar_26)
   * tmpvar_26) * tmpvar_23));
  float x_33;
  x_33 = (1.0 - tmpvar_26);
  c_20.xyz = (((tmpvar_9 * 
    (unity_ColorSpaceDielectricSpec.w - (tmpvar_5 * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_1 * 
    (((1.0 + (
      (tmpvar_32 - 1.0)
     * 
      ((((x_30 * x_30) * x_30) * x_30) * x_30)
    )) * (1.0 + (
      (tmpvar_32 - 1.0)
     * 
      ((((x_31 * x_31) * x_31) * x_31) * x_31)
    ))) * tmpvar_2)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_2 * (1.0 - tmpvar_27))
       + tmpvar_27) * (
        (tmpvar_25 * (1.0 - tmpvar_27))
       + tmpvar_27)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_21, tmpvar_24)), tmpvar_28) * ((tmpvar_28 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_2) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_1) * (tmpvar_22 + 
    ((1.0 - tmpvar_22) * (((
      (x_33 * x_33)
     * x_33) * x_33) * x_33))
  )));
  c_20.w = tmpvar_12;
  gl_FragData[0] = c_20;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v3, c10, c10.zwzw
dp4 o5.x, c4, v0
dp4 o5.y, c5, v0
dp4 o5.z, c6, v0
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o2.x, r0.z
mul r1.xyz, c8.zxyw, v2.y
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r1.y
mov o3.x, r0.x
mov o4.x, r0.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r1.z
mov o4.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedjnkhicpgoahhoabngcoinldnhkdfghmeabaaaaaageahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaae
egiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  vec3 tmpvar_4;
  tmpvar_4 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * TANGENT.xyz));
  vec3 tmpvar_7;
  tmpvar_7 = (((tmpvar_4.yzx * tmpvar_6.zxy) - (tmpvar_4.zxy * tmpvar_6.yzx)) * TANGENT.w);
  vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_6.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_4.x;
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_6.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_4.y;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_6.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_4.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Rain;
uniform float _RainOpacity;
uniform float _Raining;
uniform float _Glossiness;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  float tmpvar_1;
  vec3 worldN_2;
  vec3 tmpvar_3;
  float tmpvar_4;
  float tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_7;
  vec3 tmpvar_8;
  float tmpvar_9;
  float tmpvar_10;
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_8 = tmpvar_3;
  tmpvar_9 = tmpvar_5;
  tmpvar_10 = 0.0;
  if ((_Raining > 0.0)) {
    vec4 tmpvar_11;
    tmpvar_11 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    vec4 tmpvar_12;
    tmpvar_12 = texture2D (_Rain, xlv_TEXCOORD0);
    tmpvar_7 = ((tmpvar_11.xyz * (1.0 - tmpvar_12.w)) + (tmpvar_12.x * tmpvar_12.w));
    vec3 normal_13;
    normal_13.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_13.z = sqrt((1.0 - clamp (
      dot (normal_13.xy, normal_13.xy)
    , 0.0, 1.0)));
    tmpvar_8 = normalize(((normal_13 * 
      (1.0 - tmpvar_12.w)
    ) + (vec3(0.0, 0.0, 1.0) * tmpvar_12.w)));
    tmpvar_9 = _Glossiness;
    tmpvar_10 = (tmpvar_11.w + (tmpvar_12.w * _RainOpacity));
  } else {
    vec4 tmpvar_14;
    tmpvar_14 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    tmpvar_7 = tmpvar_14.xyz;
    vec3 normal_15;
    normal_15.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_15.z = sqrt((1.0 - clamp (
      dot (normal_15.xy, normal_15.xy)
    , 0.0, 1.0)));
    tmpvar_8 = normal_15;
    tmpvar_9 = _Glossiness;
    tmpvar_10 = tmpvar_14.w;
  };
  tmpvar_5 = tmpvar_9;
  worldN_2.x = dot (xlv_TEXCOORD1, tmpvar_8);
  worldN_2.y = dot (xlv_TEXCOORD2, tmpvar_8);
  worldN_2.z = dot (xlv_TEXCOORD3, tmpvar_8);
  tmpvar_3 = worldN_2;
  tmpvar_1 = max (0.0, dot (worldN_2, _WorldSpaceLightPos0.xyz));
  vec4 c_16;
  vec3 tmpvar_17;
  tmpvar_17 = normalize(worldN_2);
  vec3 tmpvar_18;
  tmpvar_18 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_7, vec3(tmpvar_4));
  float tmpvar_19;
  tmpvar_19 = (1.0 - tmpvar_9);
  vec3 tmpvar_20;
  tmpvar_20 = normalize((_WorldSpaceLightPos0.xyz + tmpvar_6));
  float tmpvar_21;
  tmpvar_21 = max (0.0, dot (tmpvar_17, tmpvar_6));
  float tmpvar_22;
  tmpvar_22 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_20));
  float tmpvar_23;
  tmpvar_23 = ((tmpvar_19 * tmpvar_19) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_24;
  float tmpvar_25;
  tmpvar_25 = (10.0 / log2((
    ((1.0 - tmpvar_19) * 0.968)
   + 0.03)));
  tmpvar_24 = (tmpvar_25 * tmpvar_25);
  float x_26;
  x_26 = (1.0 - tmpvar_1);
  float x_27;
  x_27 = (1.0 - tmpvar_21);
  float tmpvar_28;
  tmpvar_28 = (0.5 + ((
    (2.0 * tmpvar_22)
   * tmpvar_22) * tmpvar_19));
  float x_29;
  x_29 = (1.0 - tmpvar_22);
  c_16.xyz = (((tmpvar_7 * 
    (unity_ColorSpaceDielectricSpec.w - (tmpvar_4 * unity_ColorSpaceDielectricSpec.w))
  ) * (_LightColor0.xyz * 
    (((1.0 + (
      (tmpvar_28 - 1.0)
     * 
      ((((x_26 * x_26) * x_26) * x_26) * x_26)
    )) * (1.0 + (
      (tmpvar_28 - 1.0)
     * 
      ((((x_27 * x_27) * x_27) * x_27) * x_27)
    ))) * tmpvar_1)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_1 * (1.0 - tmpvar_23))
       + tmpvar_23) * (
        (tmpvar_21 * (1.0 - tmpvar_23))
       + tmpvar_23)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_17, tmpvar_20)), tmpvar_24) * ((tmpvar_24 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_1) * unity_LightGammaCorrectionConsts.x))
   * _LightColor0.xyz) * (tmpvar_18 + 
    ((1.0 - tmpvar_18) * (((
      (x_29 * x_29)
     * x_29) * x_29) * x_29))
  )));
  c_16.w = tmpvar_10;
  gl_FragData[0] = c_16;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v3, c10, c10.zwzw
dp4 o5.x, c4, v0
dp4 o5.y, c5, v0
dp4 o5.z, c6, v0
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o2.x, r0.z
mul r1.xyz, c8.zxyw, v2.y
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r1.y
mov o3.x, r0.x
mov o4.x, r0.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r1.z
mov o4.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedjocpojgddkfionjbenbmemdijenhnamiabaaaaaageahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  vec3 tmpvar_4;
  tmpvar_4 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * TANGENT.xyz));
  vec3 tmpvar_7;
  tmpvar_7 = (((tmpvar_4.yzx * tmpvar_6.zxy) - (tmpvar_4.zxy * tmpvar_6.yzx)) * TANGENT.w);
  vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_6.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_4.x;
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_6.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_4.y;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_6.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_4.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Rain;
uniform float _RainOpacity;
uniform float _Raining;
uniform float _Glossiness;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 tmpvar_1;
  float tmpvar_2;
  vec3 worldN_3;
  vec3 tmpvar_4;
  float tmpvar_5;
  float tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_9;
  vec3 tmpvar_10;
  float tmpvar_11;
  float tmpvar_12;
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = tmpvar_4;
  tmpvar_11 = tmpvar_6;
  tmpvar_12 = 0.0;
  if ((_Raining > 0.0)) {
    vec4 tmpvar_13;
    tmpvar_13 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    vec4 tmpvar_14;
    tmpvar_14 = texture2D (_Rain, xlv_TEXCOORD0);
    tmpvar_9 = ((tmpvar_13.xyz * (1.0 - tmpvar_14.w)) + (tmpvar_14.x * tmpvar_14.w));
    vec3 normal_15;
    normal_15.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_15.z = sqrt((1.0 - clamp (
      dot (normal_15.xy, normal_15.xy)
    , 0.0, 1.0)));
    tmpvar_10 = normalize(((normal_15 * 
      (1.0 - tmpvar_14.w)
    ) + (vec3(0.0, 0.0, 1.0) * tmpvar_14.w)));
    tmpvar_11 = _Glossiness;
    tmpvar_12 = (tmpvar_13.w + (tmpvar_14.w * _RainOpacity));
  } else {
    vec4 tmpvar_16;
    tmpvar_16 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    tmpvar_9 = tmpvar_16.xyz;
    vec3 normal_17;
    normal_17.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_17.z = sqrt((1.0 - clamp (
      dot (normal_17.xy, normal_17.xy)
    , 0.0, 1.0)));
    tmpvar_10 = normal_17;
    tmpvar_11 = _Glossiness;
    tmpvar_12 = tmpvar_16.w;
  };
  tmpvar_6 = tmpvar_11;
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = xlv_TEXCOORD4;
  vec4 tmpvar_19;
  tmpvar_19 = (_LightMatrix0 * tmpvar_18);
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_10);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_10);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_10);
  tmpvar_4 = worldN_3;
  tmpvar_2 = max (0.0, dot (worldN_3, tmpvar_7));
  tmpvar_1 = (_LightColor0.xyz * ((
    float((tmpvar_19.z > 0.0))
   * texture2D (_LightTexture0, 
    ((tmpvar_19.xy / tmpvar_19.w) + 0.5)
  ).w) * texture2D (_LightTextureB0, vec2(dot (tmpvar_19.xyz, tmpvar_19.xyz))).w));
  vec4 c_20;
  vec3 tmpvar_21;
  tmpvar_21 = normalize(worldN_3);
  vec3 tmpvar_22;
  tmpvar_22 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_9, vec3(tmpvar_5));
  float tmpvar_23;
  tmpvar_23 = (1.0 - tmpvar_11);
  vec3 tmpvar_24;
  tmpvar_24 = normalize((tmpvar_7 + tmpvar_8));
  float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_21, tmpvar_8));
  float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_7, tmpvar_24));
  float tmpvar_27;
  tmpvar_27 = ((tmpvar_23 * tmpvar_23) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (10.0 / log2((
    ((1.0 - tmpvar_23) * 0.968)
   + 0.03)));
  tmpvar_28 = (tmpvar_29 * tmpvar_29);
  float x_30;
  x_30 = (1.0 - tmpvar_2);
  float x_31;
  x_31 = (1.0 - tmpvar_25);
  float tmpvar_32;
  tmpvar_32 = (0.5 + ((
    (2.0 * tmpvar_26)
   * tmpvar_26) * tmpvar_23));
  float x_33;
  x_33 = (1.0 - tmpvar_26);
  c_20.xyz = (((tmpvar_9 * 
    (unity_ColorSpaceDielectricSpec.w - (tmpvar_5 * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_1 * 
    (((1.0 + (
      (tmpvar_32 - 1.0)
     * 
      ((((x_30 * x_30) * x_30) * x_30) * x_30)
    )) * (1.0 + (
      (tmpvar_32 - 1.0)
     * 
      ((((x_31 * x_31) * x_31) * x_31) * x_31)
    ))) * tmpvar_2)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_2 * (1.0 - tmpvar_27))
       + tmpvar_27) * (
        (tmpvar_25 * (1.0 - tmpvar_27))
       + tmpvar_27)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_21, tmpvar_24)), tmpvar_28) * ((tmpvar_28 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_2) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_1) * (tmpvar_22 + 
    ((1.0 - tmpvar_22) * (((
      (x_33 * x_33)
     * x_33) * x_33) * x_33))
  )));
  c_20.w = tmpvar_12;
  gl_FragData[0] = c_20;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v3, c10, c10.zwzw
dp4 o5.x, c4, v0
dp4 o5.y, c5, v0
dp4 o5.z, c6, v0
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o2.x, r0.z
mul r1.xyz, c8.zxyw, v2.y
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r1.y
mov o3.x, r0.x
mov o4.x, r0.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r1.z
mov o4.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedjnkhicpgoahhoabngcoinldnhkdfghmeabaaaaaageahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaae
egiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  vec3 tmpvar_4;
  tmpvar_4 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * TANGENT.xyz));
  vec3 tmpvar_7;
  tmpvar_7 = (((tmpvar_4.yzx * tmpvar_6.zxy) - (tmpvar_4.zxy * tmpvar_6.yzx)) * TANGENT.w);
  vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_6.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_4.x;
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_6.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_4.y;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_6.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_4.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform samplerCube _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Rain;
uniform float _RainOpacity;
uniform float _Raining;
uniform float _Glossiness;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 tmpvar_1;
  float tmpvar_2;
  vec3 worldN_3;
  vec3 tmpvar_4;
  float tmpvar_5;
  float tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_9;
  vec3 tmpvar_10;
  float tmpvar_11;
  float tmpvar_12;
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = tmpvar_4;
  tmpvar_11 = tmpvar_6;
  tmpvar_12 = 0.0;
  if ((_Raining > 0.0)) {
    vec4 tmpvar_13;
    tmpvar_13 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    vec4 tmpvar_14;
    tmpvar_14 = texture2D (_Rain, xlv_TEXCOORD0);
    tmpvar_9 = ((tmpvar_13.xyz * (1.0 - tmpvar_14.w)) + (tmpvar_14.x * tmpvar_14.w));
    vec3 normal_15;
    normal_15.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_15.z = sqrt((1.0 - clamp (
      dot (normal_15.xy, normal_15.xy)
    , 0.0, 1.0)));
    tmpvar_10 = normalize(((normal_15 * 
      (1.0 - tmpvar_14.w)
    ) + (vec3(0.0, 0.0, 1.0) * tmpvar_14.w)));
    tmpvar_11 = _Glossiness;
    tmpvar_12 = (tmpvar_13.w + (tmpvar_14.w * _RainOpacity));
  } else {
    vec4 tmpvar_16;
    tmpvar_16 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    tmpvar_9 = tmpvar_16.xyz;
    vec3 normal_17;
    normal_17.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_17.z = sqrt((1.0 - clamp (
      dot (normal_17.xy, normal_17.xy)
    , 0.0, 1.0)));
    tmpvar_10 = normal_17;
    tmpvar_11 = _Glossiness;
    tmpvar_12 = tmpvar_16.w;
  };
  tmpvar_6 = tmpvar_11;
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = xlv_TEXCOORD4;
  vec3 tmpvar_19;
  tmpvar_19 = (_LightMatrix0 * tmpvar_18).xyz;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_10);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_10);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_10);
  tmpvar_4 = worldN_3;
  tmpvar_2 = max (0.0, dot (worldN_3, tmpvar_7));
  tmpvar_1 = (_LightColor0.xyz * (texture2D (_LightTextureB0, vec2(dot (tmpvar_19, tmpvar_19))).w * textureCube (_LightTexture0, tmpvar_19).w));
  vec4 c_20;
  vec3 tmpvar_21;
  tmpvar_21 = normalize(worldN_3);
  vec3 tmpvar_22;
  tmpvar_22 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_9, vec3(tmpvar_5));
  float tmpvar_23;
  tmpvar_23 = (1.0 - tmpvar_11);
  vec3 tmpvar_24;
  tmpvar_24 = normalize((tmpvar_7 + tmpvar_8));
  float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_21, tmpvar_8));
  float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_7, tmpvar_24));
  float tmpvar_27;
  tmpvar_27 = ((tmpvar_23 * tmpvar_23) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (10.0 / log2((
    ((1.0 - tmpvar_23) * 0.968)
   + 0.03)));
  tmpvar_28 = (tmpvar_29 * tmpvar_29);
  float x_30;
  x_30 = (1.0 - tmpvar_2);
  float x_31;
  x_31 = (1.0 - tmpvar_25);
  float tmpvar_32;
  tmpvar_32 = (0.5 + ((
    (2.0 * tmpvar_26)
   * tmpvar_26) * tmpvar_23));
  float x_33;
  x_33 = (1.0 - tmpvar_26);
  c_20.xyz = (((tmpvar_9 * 
    (unity_ColorSpaceDielectricSpec.w - (tmpvar_5 * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_1 * 
    (((1.0 + (
      (tmpvar_32 - 1.0)
     * 
      ((((x_30 * x_30) * x_30) * x_30) * x_30)
    )) * (1.0 + (
      (tmpvar_32 - 1.0)
     * 
      ((((x_31 * x_31) * x_31) * x_31) * x_31)
    ))) * tmpvar_2)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_2 * (1.0 - tmpvar_27))
       + tmpvar_27) * (
        (tmpvar_25 * (1.0 - tmpvar_27))
       + tmpvar_27)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_21, tmpvar_24)), tmpvar_28) * ((tmpvar_28 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_2) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_1) * (tmpvar_22 + 
    ((1.0 - tmpvar_22) * (((
      (x_33 * x_33)
     * x_33) * x_33) * x_33))
  )));
  c_20.w = tmpvar_12;
  gl_FragData[0] = c_20;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v3, c10, c10.zwzw
dp4 o5.x, c4, v0
dp4 o5.y, c5, v0
dp4 o5.z, c6, v0
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o2.x, r0.z
mul r1.xyz, c8.zxyw, v2.y
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r1.y
mov o3.x, r0.x
mov o4.x, r0.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r1.z
mov o4.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedjnkhicpgoahhoabngcoinldnhkdfghmeabaaaaaageahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaae
egiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 v_1;
  v_1.x = _World2Object[0].x;
  v_1.y = _World2Object[1].x;
  v_1.z = _World2Object[2].x;
  v_1.w = _World2Object[3].x;
  vec4 v_2;
  v_2.x = _World2Object[0].y;
  v_2.y = _World2Object[1].y;
  v_2.z = _World2Object[2].y;
  v_2.w = _World2Object[3].y;
  vec4 v_3;
  v_3.x = _World2Object[0].z;
  v_3.y = _World2Object[1].z;
  v_3.z = _World2Object[2].z;
  v_3.w = _World2Object[3].z;
  vec3 tmpvar_4;
  tmpvar_4 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * TANGENT.xyz));
  vec3 tmpvar_7;
  tmpvar_7 = (((tmpvar_4.yzx * tmpvar_6.zxy) - (tmpvar_4.zxy * tmpvar_6.yzx)) * TANGENT.w);
  vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_6.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_4.x;
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_6.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_4.y;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_6.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_4.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Rain;
uniform float _RainOpacity;
uniform float _Raining;
uniform float _Glossiness;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 tmpvar_1;
  float tmpvar_2;
  vec3 worldN_3;
  vec3 tmpvar_4;
  float tmpvar_5;
  float tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_8;
  vec3 tmpvar_9;
  float tmpvar_10;
  float tmpvar_11;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = tmpvar_4;
  tmpvar_10 = tmpvar_6;
  tmpvar_11 = 0.0;
  if ((_Raining > 0.0)) {
    vec4 tmpvar_12;
    tmpvar_12 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    vec4 tmpvar_13;
    tmpvar_13 = texture2D (_Rain, xlv_TEXCOORD0);
    tmpvar_8 = ((tmpvar_12.xyz * (1.0 - tmpvar_13.w)) + (tmpvar_13.x * tmpvar_13.w));
    vec3 normal_14;
    normal_14.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_14.z = sqrt((1.0 - clamp (
      dot (normal_14.xy, normal_14.xy)
    , 0.0, 1.0)));
    tmpvar_9 = normalize(((normal_14 * 
      (1.0 - tmpvar_13.w)
    ) + (vec3(0.0, 0.0, 1.0) * tmpvar_13.w)));
    tmpvar_10 = _Glossiness;
    tmpvar_11 = (tmpvar_12.w + (tmpvar_13.w * _RainOpacity));
  } else {
    vec4 tmpvar_15;
    tmpvar_15 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    tmpvar_8 = tmpvar_15.xyz;
    vec3 normal_16;
    normal_16.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_16.z = sqrt((1.0 - clamp (
      dot (normal_16.xy, normal_16.xy)
    , 0.0, 1.0)));
    tmpvar_9 = normal_16;
    tmpvar_10 = _Glossiness;
    tmpvar_11 = tmpvar_15.w;
  };
  tmpvar_6 = tmpvar_10;
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = xlv_TEXCOORD4;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_9);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_9);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_9);
  tmpvar_4 = worldN_3;
  tmpvar_2 = max (0.0, dot (worldN_3, _WorldSpaceLightPos0.xyz));
  tmpvar_1 = (_LightColor0.xyz * texture2D (_LightTexture0, (_LightMatrix0 * tmpvar_17).xy).w);
  vec4 c_18;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(worldN_3);
  vec3 tmpvar_20;
  tmpvar_20 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_8, vec3(tmpvar_5));
  float tmpvar_21;
  tmpvar_21 = (1.0 - tmpvar_10);
  vec3 tmpvar_22;
  tmpvar_22 = normalize((_WorldSpaceLightPos0.xyz + tmpvar_7));
  float tmpvar_23;
  tmpvar_23 = max (0.0, dot (tmpvar_19, tmpvar_7));
  float tmpvar_24;
  tmpvar_24 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_22));
  float tmpvar_25;
  tmpvar_25 = ((tmpvar_21 * tmpvar_21) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_26;
  float tmpvar_27;
  tmpvar_27 = (10.0 / log2((
    ((1.0 - tmpvar_21) * 0.968)
   + 0.03)));
  tmpvar_26 = (tmpvar_27 * tmpvar_27);
  float x_28;
  x_28 = (1.0 - tmpvar_2);
  float x_29;
  x_29 = (1.0 - tmpvar_23);
  float tmpvar_30;
  tmpvar_30 = (0.5 + ((
    (2.0 * tmpvar_24)
   * tmpvar_24) * tmpvar_21));
  float x_31;
  x_31 = (1.0 - tmpvar_24);
  c_18.xyz = (((tmpvar_8 * 
    (unity_ColorSpaceDielectricSpec.w - (tmpvar_5 * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_1 * 
    (((1.0 + (
      (tmpvar_30 - 1.0)
     * 
      ((((x_28 * x_28) * x_28) * x_28) * x_28)
    )) * (1.0 + (
      (tmpvar_30 - 1.0)
     * 
      ((((x_29 * x_29) * x_29) * x_29) * x_29)
    ))) * tmpvar_2)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_2 * (1.0 - tmpvar_25))
       + tmpvar_25) * (
        (tmpvar_23 * (1.0 - tmpvar_25))
       + tmpvar_25)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_19, tmpvar_22)), tmpvar_26) * ((tmpvar_26 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_2) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_1) * (tmpvar_20 + 
    ((1.0 - tmpvar_20) * (((
      (x_31 * x_31)
     * x_31) * x_31) * x_31))
  )));
  c_18.w = tmpvar_11;
  gl_FragData[0] = c_18;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v3, c10, c10.zwzw
dp4 o5.x, c4, v0
dp4 o5.y, c5, v0
dp4 o5.z, c6, v0
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o2.x, r0.z
mul r1.xyz, c8.zxyw, v2.y
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r1.y
mov o3.x, r0.x
mov o4.x, r0.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r1.z
mov o4.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedjnkhicpgoahhoabngcoinldnhkdfghmeabaaaaaageahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaae
egiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafeccabaaa
acaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaabaaaaaa
jgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaa
amaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
jgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaaaaaaaaaajgaebaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaaakaabaaaacaaaaaadgaaaaaf
bccabaaaacaaaaaackaabaaaabaaaaaadgaaaaafeccabaaaadaaaaaackaabaaa
aaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaaaaaaaaaadgaaaaafbccabaaa
adaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaaaeaaaaaabkaabaaaabaaaaaa
dgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaadgaaaaafcccabaaaaeaaaaaa
ckaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
  vec3 tmpvar_8;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * TANGENT.w);
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_5.x;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_7.y;
  tmpvar_10.y = tmpvar_8.y;
  tmpvar_10.z = tmpvar_5.y;
  vec3 tmpvar_11;
  tmpvar_11.x = tmpvar_7.z;
  tmpvar_11.y = tmpvar_8.z;
  tmpvar_11.z = tmpvar_5.z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD5 = tmpvar_1.z;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogParams;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Rain;
uniform float _RainOpacity;
uniform float _Raining;
uniform float _Glossiness;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  float tmpvar_2;
  vec3 worldN_3;
  vec4 c_4;
  vec3 tmpvar_5;
  float tmpvar_6;
  float tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  float tmpvar_12;
  float tmpvar_13;
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  tmpvar_11 = tmpvar_5;
  tmpvar_12 = tmpvar_7;
  tmpvar_13 = 0.0;
  if ((_Raining > 0.0)) {
    vec4 tmpvar_14;
    tmpvar_14 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    vec4 tmpvar_15;
    tmpvar_15 = texture2D (_Rain, xlv_TEXCOORD0);
    tmpvar_10 = ((tmpvar_14.xyz * (1.0 - tmpvar_15.w)) + (tmpvar_15.x * tmpvar_15.w));
    vec3 normal_16;
    normal_16.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_16.z = sqrt((1.0 - clamp (
      dot (normal_16.xy, normal_16.xy)
    , 0.0, 1.0)));
    tmpvar_11 = normalize(((normal_16 * 
      (1.0 - tmpvar_15.w)
    ) + (vec3(0.0, 0.0, 1.0) * tmpvar_15.w)));
    tmpvar_12 = _Glossiness;
    tmpvar_13 = (tmpvar_14.w + (tmpvar_15.w * _RainOpacity));
  } else {
    vec4 tmpvar_17;
    tmpvar_17 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    tmpvar_10 = tmpvar_17.xyz;
    vec3 normal_18;
    normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_18.z = sqrt((1.0 - clamp (
      dot (normal_18.xy, normal_18.xy)
    , 0.0, 1.0)));
    tmpvar_11 = normal_18;
    tmpvar_12 = _Glossiness;
    tmpvar_13 = tmpvar_17.w;
  };
  tmpvar_7 = tmpvar_12;
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = xlv_TEXCOORD4;
  vec3 tmpvar_20;
  tmpvar_20 = (_LightMatrix0 * tmpvar_19).xyz;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_11);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_11);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_11);
  tmpvar_5 = worldN_3;
  tmpvar_2 = max (0.0, dot (worldN_3, tmpvar_8));
  tmpvar_1 = (_LightColor0.xyz * texture2D (_LightTexture0, vec2(dot (tmpvar_20, tmpvar_20))).w);
  vec4 c_21;
  vec3 tmpvar_22;
  tmpvar_22 = normalize(worldN_3);
  vec3 tmpvar_23;
  tmpvar_23 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_10, vec3(tmpvar_6));
  float tmpvar_24;
  tmpvar_24 = (1.0 - tmpvar_12);
  vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_8 + tmpvar_9));
  float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_22, tmpvar_9));
  float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_8, tmpvar_25));
  float tmpvar_28;
  tmpvar_28 = ((tmpvar_24 * tmpvar_24) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_29;
  float tmpvar_30;
  tmpvar_30 = (10.0 / log2((
    ((1.0 - tmpvar_24) * 0.968)
   + 0.03)));
  tmpvar_29 = (tmpvar_30 * tmpvar_30);
  float x_31;
  x_31 = (1.0 - tmpvar_2);
  float x_32;
  x_32 = (1.0 - tmpvar_26);
  float tmpvar_33;
  tmpvar_33 = (0.5 + ((
    (2.0 * tmpvar_27)
   * tmpvar_27) * tmpvar_24));
  float x_34;
  x_34 = (1.0 - tmpvar_27);
  vec3 tmpvar_35;
  tmpvar_35 = (((tmpvar_10 * 
    (unity_ColorSpaceDielectricSpec.w - (tmpvar_6 * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_1 * 
    (((1.0 + (
      (tmpvar_33 - 1.0)
     * 
      ((((x_31 * x_31) * x_31) * x_31) * x_31)
    )) * (1.0 + (
      (tmpvar_33 - 1.0)
     * 
      ((((x_32 * x_32) * x_32) * x_32) * x_32)
    ))) * tmpvar_2)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_2 * (1.0 - tmpvar_28))
       + tmpvar_28) * (
        (tmpvar_26 * (1.0 - tmpvar_28))
       + tmpvar_28)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_22, tmpvar_25)), tmpvar_29) * ((tmpvar_29 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_2) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_1) * (tmpvar_23 + 
    ((1.0 - tmpvar_23) * (((
      (x_34 * x_34)
     * x_34) * x_34) * x_34))
  )));
  c_21.xyz = tmpvar_35;
  c_21.w = tmpvar_13;
  c_4.w = c_21.w;
  c_4.xyz = mix (vec3(0.0, 0.0, 0.0), tmpvar_35, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6.x
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.w, c3, v0
mad o1.xy, v3, c10, c10.zwzw
dp4 o5.x, c4, v0
dp4 o5.y, c5, v0
dp4 o5.z, c6, v0
dp4 r0.x, c2, v0
mov o0.z, r0.x
mov o6.x, r0.x
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o2.x, r0.z
mul r1.xyz, c8.zxyw, v2.y
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r1.y
mov o3.x, r0.x
mov o4.x, r0.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r1.z
mov o4.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedokcmbekcnmckbahmipagomhjokebcddcabaaaaaalaahaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcleafaaaaeaaaabaa
gnabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafeccabaaaabaaaaaackaabaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaa
akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
  vec3 tmpvar_8;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * TANGENT.w);
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_5.x;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_7.y;
  tmpvar_10.y = tmpvar_8.y;
  tmpvar_10.z = tmpvar_5.y;
  vec3 tmpvar_11;
  tmpvar_11.x = tmpvar_7.z;
  tmpvar_11.y = tmpvar_8.z;
  tmpvar_11.z = tmpvar_5.z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD5 = tmpvar_1.z;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogParams;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Rain;
uniform float _RainOpacity;
uniform float _Raining;
uniform float _Glossiness;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  float tmpvar_1;
  vec3 worldN_2;
  vec4 c_3;
  vec3 tmpvar_4;
  float tmpvar_5;
  float tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_8;
  vec3 tmpvar_9;
  float tmpvar_10;
  float tmpvar_11;
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = tmpvar_4;
  tmpvar_10 = tmpvar_6;
  tmpvar_11 = 0.0;
  if ((_Raining > 0.0)) {
    vec4 tmpvar_12;
    tmpvar_12 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    vec4 tmpvar_13;
    tmpvar_13 = texture2D (_Rain, xlv_TEXCOORD0);
    tmpvar_8 = ((tmpvar_12.xyz * (1.0 - tmpvar_13.w)) + (tmpvar_13.x * tmpvar_13.w));
    vec3 normal_14;
    normal_14.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_14.z = sqrt((1.0 - clamp (
      dot (normal_14.xy, normal_14.xy)
    , 0.0, 1.0)));
    tmpvar_9 = normalize(((normal_14 * 
      (1.0 - tmpvar_13.w)
    ) + (vec3(0.0, 0.0, 1.0) * tmpvar_13.w)));
    tmpvar_10 = _Glossiness;
    tmpvar_11 = (tmpvar_12.w + (tmpvar_13.w * _RainOpacity));
  } else {
    vec4 tmpvar_15;
    tmpvar_15 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    tmpvar_8 = tmpvar_15.xyz;
    vec3 normal_16;
    normal_16.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_16.z = sqrt((1.0 - clamp (
      dot (normal_16.xy, normal_16.xy)
    , 0.0, 1.0)));
    tmpvar_9 = normal_16;
    tmpvar_10 = _Glossiness;
    tmpvar_11 = tmpvar_15.w;
  };
  tmpvar_6 = tmpvar_10;
  worldN_2.x = dot (xlv_TEXCOORD1, tmpvar_9);
  worldN_2.y = dot (xlv_TEXCOORD2, tmpvar_9);
  worldN_2.z = dot (xlv_TEXCOORD3, tmpvar_9);
  tmpvar_4 = worldN_2;
  tmpvar_1 = max (0.0, dot (worldN_2, _WorldSpaceLightPos0.xyz));
  vec4 c_17;
  vec3 tmpvar_18;
  tmpvar_18 = normalize(worldN_2);
  vec3 tmpvar_19;
  tmpvar_19 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_8, vec3(tmpvar_5));
  float tmpvar_20;
  tmpvar_20 = (1.0 - tmpvar_10);
  vec3 tmpvar_21;
  tmpvar_21 = normalize((_WorldSpaceLightPos0.xyz + tmpvar_7));
  float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_18, tmpvar_7));
  float tmpvar_23;
  tmpvar_23 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_21));
  float tmpvar_24;
  tmpvar_24 = ((tmpvar_20 * tmpvar_20) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_25;
  float tmpvar_26;
  tmpvar_26 = (10.0 / log2((
    ((1.0 - tmpvar_20) * 0.968)
   + 0.03)));
  tmpvar_25 = (tmpvar_26 * tmpvar_26);
  float x_27;
  x_27 = (1.0 - tmpvar_1);
  float x_28;
  x_28 = (1.0 - tmpvar_22);
  float tmpvar_29;
  tmpvar_29 = (0.5 + ((
    (2.0 * tmpvar_23)
   * tmpvar_23) * tmpvar_20));
  float x_30;
  x_30 = (1.0 - tmpvar_23);
  vec3 tmpvar_31;
  tmpvar_31 = (((tmpvar_8 * 
    (unity_ColorSpaceDielectricSpec.w - (tmpvar_5 * unity_ColorSpaceDielectricSpec.w))
  ) * (_LightColor0.xyz * 
    (((1.0 + (
      (tmpvar_29 - 1.0)
     * 
      ((((x_27 * x_27) * x_27) * x_27) * x_27)
    )) * (1.0 + (
      (tmpvar_29 - 1.0)
     * 
      ((((x_28 * x_28) * x_28) * x_28) * x_28)
    ))) * tmpvar_1)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_1 * (1.0 - tmpvar_24))
       + tmpvar_24) * (
        (tmpvar_22 * (1.0 - tmpvar_24))
       + tmpvar_24)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_18, tmpvar_21)), tmpvar_25) * ((tmpvar_25 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_1) * unity_LightGammaCorrectionConsts.x))
   * _LightColor0.xyz) * (tmpvar_19 + 
    ((1.0 - tmpvar_19) * (((
      (x_30 * x_30)
     * x_30) * x_30) * x_30))
  )));
  c_17.xyz = tmpvar_31;
  c_17.w = tmpvar_11;
  c_3.w = c_17.w;
  c_3.xyz = mix (vec3(0.0, 0.0, 0.0), tmpvar_31, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6.x
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.w, c3, v0
mad o1.xy, v3, c10, c10.zwzw
dp4 o5.x, c4, v0
dp4 o5.y, c5, v0
dp4 o5.z, c6, v0
dp4 r0.x, c2, v0
mov o0.z, r0.x
mov o6.x, r0.x
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o2.x, r0.z
mul r1.xyz, c8.zxyw, v2.y
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r1.y
mov o3.x, r0.x
mov o4.x, r0.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r1.z
mov o4.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedjnoaiihkliplfhhemiflajjlonkdoikjabaaaaaalaahaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcleafaaaaeaaaabaa
gnabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafeccabaaaabaaaaaackaabaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaa
akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
  vec3 tmpvar_8;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * TANGENT.w);
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_5.x;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_7.y;
  tmpvar_10.y = tmpvar_8.y;
  tmpvar_10.z = tmpvar_5.y;
  vec3 tmpvar_11;
  tmpvar_11.x = tmpvar_7.z;
  tmpvar_11.y = tmpvar_8.z;
  tmpvar_11.z = tmpvar_5.z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD5 = tmpvar_1.z;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogParams;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Rain;
uniform float _RainOpacity;
uniform float _Raining;
uniform float _Glossiness;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  float tmpvar_2;
  vec3 worldN_3;
  vec4 c_4;
  vec3 tmpvar_5;
  float tmpvar_6;
  float tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  float tmpvar_12;
  float tmpvar_13;
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  tmpvar_11 = tmpvar_5;
  tmpvar_12 = tmpvar_7;
  tmpvar_13 = 0.0;
  if ((_Raining > 0.0)) {
    vec4 tmpvar_14;
    tmpvar_14 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    vec4 tmpvar_15;
    tmpvar_15 = texture2D (_Rain, xlv_TEXCOORD0);
    tmpvar_10 = ((tmpvar_14.xyz * (1.0 - tmpvar_15.w)) + (tmpvar_15.x * tmpvar_15.w));
    vec3 normal_16;
    normal_16.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_16.z = sqrt((1.0 - clamp (
      dot (normal_16.xy, normal_16.xy)
    , 0.0, 1.0)));
    tmpvar_11 = normalize(((normal_16 * 
      (1.0 - tmpvar_15.w)
    ) + (vec3(0.0, 0.0, 1.0) * tmpvar_15.w)));
    tmpvar_12 = _Glossiness;
    tmpvar_13 = (tmpvar_14.w + (tmpvar_15.w * _RainOpacity));
  } else {
    vec4 tmpvar_17;
    tmpvar_17 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    tmpvar_10 = tmpvar_17.xyz;
    vec3 normal_18;
    normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_18.z = sqrt((1.0 - clamp (
      dot (normal_18.xy, normal_18.xy)
    , 0.0, 1.0)));
    tmpvar_11 = normal_18;
    tmpvar_12 = _Glossiness;
    tmpvar_13 = tmpvar_17.w;
  };
  tmpvar_7 = tmpvar_12;
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = xlv_TEXCOORD4;
  vec4 tmpvar_20;
  tmpvar_20 = (_LightMatrix0 * tmpvar_19);
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_11);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_11);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_11);
  tmpvar_5 = worldN_3;
  tmpvar_2 = max (0.0, dot (worldN_3, tmpvar_8));
  tmpvar_1 = (_LightColor0.xyz * ((
    float((tmpvar_20.z > 0.0))
   * texture2D (_LightTexture0, 
    ((tmpvar_20.xy / tmpvar_20.w) + 0.5)
  ).w) * texture2D (_LightTextureB0, vec2(dot (tmpvar_20.xyz, tmpvar_20.xyz))).w));
  vec4 c_21;
  vec3 tmpvar_22;
  tmpvar_22 = normalize(worldN_3);
  vec3 tmpvar_23;
  tmpvar_23 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_10, vec3(tmpvar_6));
  float tmpvar_24;
  tmpvar_24 = (1.0 - tmpvar_12);
  vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_8 + tmpvar_9));
  float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_22, tmpvar_9));
  float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_8, tmpvar_25));
  float tmpvar_28;
  tmpvar_28 = ((tmpvar_24 * tmpvar_24) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_29;
  float tmpvar_30;
  tmpvar_30 = (10.0 / log2((
    ((1.0 - tmpvar_24) * 0.968)
   + 0.03)));
  tmpvar_29 = (tmpvar_30 * tmpvar_30);
  float x_31;
  x_31 = (1.0 - tmpvar_2);
  float x_32;
  x_32 = (1.0 - tmpvar_26);
  float tmpvar_33;
  tmpvar_33 = (0.5 + ((
    (2.0 * tmpvar_27)
   * tmpvar_27) * tmpvar_24));
  float x_34;
  x_34 = (1.0 - tmpvar_27);
  vec3 tmpvar_35;
  tmpvar_35 = (((tmpvar_10 * 
    (unity_ColorSpaceDielectricSpec.w - (tmpvar_6 * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_1 * 
    (((1.0 + (
      (tmpvar_33 - 1.0)
     * 
      ((((x_31 * x_31) * x_31) * x_31) * x_31)
    )) * (1.0 + (
      (tmpvar_33 - 1.0)
     * 
      ((((x_32 * x_32) * x_32) * x_32) * x_32)
    ))) * tmpvar_2)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_2 * (1.0 - tmpvar_28))
       + tmpvar_28) * (
        (tmpvar_26 * (1.0 - tmpvar_28))
       + tmpvar_28)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_22, tmpvar_25)), tmpvar_29) * ((tmpvar_29 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_2) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_1) * (tmpvar_23 + 
    ((1.0 - tmpvar_23) * (((
      (x_34 * x_34)
     * x_34) * x_34) * x_34))
  )));
  c_21.xyz = tmpvar_35;
  c_21.w = tmpvar_13;
  c_4.w = c_21.w;
  c_4.xyz = mix (vec3(0.0, 0.0, 0.0), tmpvar_35, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6.x
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.w, c3, v0
mad o1.xy, v3, c10, c10.zwzw
dp4 o5.x, c4, v0
dp4 o5.y, c5, v0
dp4 o5.z, c6, v0
dp4 r0.x, c2, v0
mov o0.z, r0.x
mov o6.x, r0.x
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o2.x, r0.z
mul r1.xyz, c8.zxyw, v2.y
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r1.y
mov o3.x, r0.x
mov o4.x, r0.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r1.z
mov o4.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedokcmbekcnmckbahmipagomhjokebcddcabaaaaaalaahaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcleafaaaaeaaaabaa
gnabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafeccabaaaabaaaaaackaabaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaa
akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
  vec3 tmpvar_8;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * TANGENT.w);
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_5.x;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_7.y;
  tmpvar_10.y = tmpvar_8.y;
  tmpvar_10.z = tmpvar_5.y;
  vec3 tmpvar_11;
  tmpvar_11.x = tmpvar_7.z;
  tmpvar_11.y = tmpvar_8.z;
  tmpvar_11.z = tmpvar_5.z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD5 = tmpvar_1.z;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogParams;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform samplerCube _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Rain;
uniform float _RainOpacity;
uniform float _Raining;
uniform float _Glossiness;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  float tmpvar_2;
  vec3 worldN_3;
  vec4 c_4;
  vec3 tmpvar_5;
  float tmpvar_6;
  float tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_10;
  vec3 tmpvar_11;
  float tmpvar_12;
  float tmpvar_13;
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  tmpvar_11 = tmpvar_5;
  tmpvar_12 = tmpvar_7;
  tmpvar_13 = 0.0;
  if ((_Raining > 0.0)) {
    vec4 tmpvar_14;
    tmpvar_14 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    vec4 tmpvar_15;
    tmpvar_15 = texture2D (_Rain, xlv_TEXCOORD0);
    tmpvar_10 = ((tmpvar_14.xyz * (1.0 - tmpvar_15.w)) + (tmpvar_15.x * tmpvar_15.w));
    vec3 normal_16;
    normal_16.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_16.z = sqrt((1.0 - clamp (
      dot (normal_16.xy, normal_16.xy)
    , 0.0, 1.0)));
    tmpvar_11 = normalize(((normal_16 * 
      (1.0 - tmpvar_15.w)
    ) + (vec3(0.0, 0.0, 1.0) * tmpvar_15.w)));
    tmpvar_12 = _Glossiness;
    tmpvar_13 = (tmpvar_14.w + (tmpvar_15.w * _RainOpacity));
  } else {
    vec4 tmpvar_17;
    tmpvar_17 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    tmpvar_10 = tmpvar_17.xyz;
    vec3 normal_18;
    normal_18.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_18.z = sqrt((1.0 - clamp (
      dot (normal_18.xy, normal_18.xy)
    , 0.0, 1.0)));
    tmpvar_11 = normal_18;
    tmpvar_12 = _Glossiness;
    tmpvar_13 = tmpvar_17.w;
  };
  tmpvar_7 = tmpvar_12;
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = xlv_TEXCOORD4;
  vec3 tmpvar_20;
  tmpvar_20 = (_LightMatrix0 * tmpvar_19).xyz;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_11);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_11);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_11);
  tmpvar_5 = worldN_3;
  tmpvar_2 = max (0.0, dot (worldN_3, tmpvar_8));
  tmpvar_1 = (_LightColor0.xyz * (texture2D (_LightTextureB0, vec2(dot (tmpvar_20, tmpvar_20))).w * textureCube (_LightTexture0, tmpvar_20).w));
  vec4 c_21;
  vec3 tmpvar_22;
  tmpvar_22 = normalize(worldN_3);
  vec3 tmpvar_23;
  tmpvar_23 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_10, vec3(tmpvar_6));
  float tmpvar_24;
  tmpvar_24 = (1.0 - tmpvar_12);
  vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_8 + tmpvar_9));
  float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_22, tmpvar_9));
  float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_8, tmpvar_25));
  float tmpvar_28;
  tmpvar_28 = ((tmpvar_24 * tmpvar_24) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_29;
  float tmpvar_30;
  tmpvar_30 = (10.0 / log2((
    ((1.0 - tmpvar_24) * 0.968)
   + 0.03)));
  tmpvar_29 = (tmpvar_30 * tmpvar_30);
  float x_31;
  x_31 = (1.0 - tmpvar_2);
  float x_32;
  x_32 = (1.0 - tmpvar_26);
  float tmpvar_33;
  tmpvar_33 = (0.5 + ((
    (2.0 * tmpvar_27)
   * tmpvar_27) * tmpvar_24));
  float x_34;
  x_34 = (1.0 - tmpvar_27);
  vec3 tmpvar_35;
  tmpvar_35 = (((tmpvar_10 * 
    (unity_ColorSpaceDielectricSpec.w - (tmpvar_6 * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_1 * 
    (((1.0 + (
      (tmpvar_33 - 1.0)
     * 
      ((((x_31 * x_31) * x_31) * x_31) * x_31)
    )) * (1.0 + (
      (tmpvar_33 - 1.0)
     * 
      ((((x_32 * x_32) * x_32) * x_32) * x_32)
    ))) * tmpvar_2)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_2 * (1.0 - tmpvar_28))
       + tmpvar_28) * (
        (tmpvar_26 * (1.0 - tmpvar_28))
       + tmpvar_28)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_22, tmpvar_25)), tmpvar_29) * ((tmpvar_29 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_2) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_1) * (tmpvar_23 + 
    ((1.0 - tmpvar_23) * (((
      (x_34 * x_34)
     * x_34) * x_34) * x_34))
  )));
  c_21.xyz = tmpvar_35;
  c_21.w = tmpvar_13;
  c_4.w = c_21.w;
  c_4.xyz = mix (vec3(0.0, 0.0, 0.0), tmpvar_35, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6.x
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.w, c3, v0
mad o1.xy, v3, c10, c10.zwzw
dp4 o5.x, c4, v0
dp4 o5.y, c5, v0
dp4 o5.z, c6, v0
dp4 r0.x, c2, v0
mov o0.z, r0.x
mov o6.x, r0.x
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o2.x, r0.z
mul r1.xyz, c8.zxyw, v2.y
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r1.y
mov o3.x, r0.x
mov o4.x, r0.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r1.z
mov o4.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedokcmbekcnmckbahmipagomhjokebcddcabaaaaaalaahaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcleafaaaaeaaaabaa
gnabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafeccabaaaabaaaaaackaabaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaa
akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
attribute vec4 TANGENT;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 v_2;
  v_2.x = _World2Object[0].x;
  v_2.y = _World2Object[1].x;
  v_2.z = _World2Object[2].x;
  v_2.w = _World2Object[3].x;
  vec4 v_3;
  v_3.x = _World2Object[0].y;
  v_3.y = _World2Object[1].y;
  v_3.z = _World2Object[2].y;
  v_3.w = _World2Object[3].y;
  vec4 v_4;
  v_4.x = _World2Object[0].z;
  v_4.y = _World2Object[1].z;
  v_4.z = _World2Object[2].z;
  v_4.w = _World2Object[3].z;
  vec3 tmpvar_5;
  tmpvar_5 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * TANGENT.xyz));
  vec3 tmpvar_8;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx)) * TANGENT.w);
  vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_5.x;
  vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_7.y;
  tmpvar_10.y = tmpvar_8.y;
  tmpvar_10.z = tmpvar_5.y;
  vec3 tmpvar_11;
  tmpvar_11.x = tmpvar_7.z;
  tmpvar_11.y = tmpvar_8.z;
  tmpvar_11.z = tmpvar_5.z;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_TEXCOORD4 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD5 = tmpvar_1.z;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogParams;
uniform vec4 unity_ColorSpaceDielectricSpec;
uniform vec4 _LightColor0;
uniform vec4 unity_LightGammaCorrectionConsts;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _Rain;
uniform float _RainOpacity;
uniform float _Raining;
uniform float _Glossiness;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec3 tmpvar_1;
  float tmpvar_2;
  vec3 worldN_3;
  vec4 c_4;
  vec3 tmpvar_5;
  float tmpvar_6;
  float tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_9;
  vec3 tmpvar_10;
  float tmpvar_11;
  float tmpvar_12;
  tmpvar_9 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = tmpvar_5;
  tmpvar_11 = tmpvar_7;
  tmpvar_12 = 0.0;
  if ((_Raining > 0.0)) {
    vec4 tmpvar_13;
    tmpvar_13 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    vec4 tmpvar_14;
    tmpvar_14 = texture2D (_Rain, xlv_TEXCOORD0);
    tmpvar_9 = ((tmpvar_13.xyz * (1.0 - tmpvar_14.w)) + (tmpvar_14.x * tmpvar_14.w));
    vec3 normal_15;
    normal_15.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_15.z = sqrt((1.0 - clamp (
      dot (normal_15.xy, normal_15.xy)
    , 0.0, 1.0)));
    tmpvar_10 = normalize(((normal_15 * 
      (1.0 - tmpvar_14.w)
    ) + (vec3(0.0, 0.0, 1.0) * tmpvar_14.w)));
    tmpvar_11 = _Glossiness;
    tmpvar_12 = (tmpvar_13.w + (tmpvar_14.w * _RainOpacity));
  } else {
    vec4 tmpvar_16;
    tmpvar_16 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
    tmpvar_9 = tmpvar_16.xyz;
    vec3 normal_17;
    normal_17.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
    normal_17.z = sqrt((1.0 - clamp (
      dot (normal_17.xy, normal_17.xy)
    , 0.0, 1.0)));
    tmpvar_10 = normal_17;
    tmpvar_11 = _Glossiness;
    tmpvar_12 = tmpvar_16.w;
  };
  tmpvar_7 = tmpvar_11;
  vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = xlv_TEXCOORD4;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_10);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_10);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_10);
  tmpvar_5 = worldN_3;
  tmpvar_2 = max (0.0, dot (worldN_3, _WorldSpaceLightPos0.xyz));
  tmpvar_1 = (_LightColor0.xyz * texture2D (_LightTexture0, (_LightMatrix0 * tmpvar_18).xy).w);
  vec4 c_19;
  vec3 tmpvar_20;
  tmpvar_20 = normalize(worldN_3);
  vec3 tmpvar_21;
  tmpvar_21 = mix (unity_ColorSpaceDielectricSpec.xyz, tmpvar_9, vec3(tmpvar_6));
  float tmpvar_22;
  tmpvar_22 = (1.0 - tmpvar_11);
  vec3 tmpvar_23;
  tmpvar_23 = normalize((_WorldSpaceLightPos0.xyz + tmpvar_8));
  float tmpvar_24;
  tmpvar_24 = max (0.0, dot (tmpvar_20, tmpvar_8));
  float tmpvar_25;
  tmpvar_25 = max (0.0, dot (_WorldSpaceLightPos0.xyz, tmpvar_23));
  float tmpvar_26;
  tmpvar_26 = ((tmpvar_22 * tmpvar_22) * unity_LightGammaCorrectionConsts.w);
  float tmpvar_27;
  float tmpvar_28;
  tmpvar_28 = (10.0 / log2((
    ((1.0 - tmpvar_22) * 0.968)
   + 0.03)));
  tmpvar_27 = (tmpvar_28 * tmpvar_28);
  float x_29;
  x_29 = (1.0 - tmpvar_2);
  float x_30;
  x_30 = (1.0 - tmpvar_24);
  float tmpvar_31;
  tmpvar_31 = (0.5 + ((
    (2.0 * tmpvar_25)
   * tmpvar_25) * tmpvar_22));
  float x_32;
  x_32 = (1.0 - tmpvar_25);
  vec3 tmpvar_33;
  tmpvar_33 = (((tmpvar_9 * 
    (unity_ColorSpaceDielectricSpec.w - (tmpvar_6 * unity_ColorSpaceDielectricSpec.w))
  ) * (tmpvar_1 * 
    (((1.0 + (
      (tmpvar_31 - 1.0)
     * 
      ((((x_29 * x_29) * x_29) * x_29) * x_29)
    )) * (1.0 + (
      (tmpvar_31 - 1.0)
     * 
      ((((x_30 * x_30) * x_30) * x_30) * x_30)
    ))) * tmpvar_2)
  )) + ((
    max (0.0, (((
      (1.0/((((
        (tmpvar_2 * (1.0 - tmpvar_26))
       + tmpvar_26) * (
        (tmpvar_24 * (1.0 - tmpvar_26))
       + tmpvar_26)) + 0.0001)))
     * 
      (pow (max (0.0, dot (tmpvar_20, tmpvar_23)), tmpvar_27) * ((tmpvar_27 + 1.0) * unity_LightGammaCorrectionConsts.y))
    ) * tmpvar_2) * unity_LightGammaCorrectionConsts.x))
   * tmpvar_1) * (tmpvar_21 + 
    ((1.0 - tmpvar_21) * (((
      (x_32 * x_32)
     * x_32) * x_32) * x_32))
  )));
  c_19.xyz = tmpvar_33;
  c_19.w = tmpvar_12;
  c_4.w = c_19.w;
  c_4.xyz = mix (vec3(0.0, 0.0, 0.0), tmpvar_33, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_tangent v1
dcl_normal v2
dcl_texcoord v3
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6.x
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.w, c3, v0
mad o1.xy, v3, c10, c10.zwzw
dp4 o5.x, c4, v0
dp4 o5.y, c5, v0
dp4 o5.z, c6, v0
dp4 r0.x, c2, v0
mov o0.z, r0.x
mov o6.x, r0.x
dp3 r0.z, c4, v1
dp3 r0.x, c5, v1
dp3 r0.y, c6, v1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mov o2.x, r0.z
mul r1.xyz, c8.zxyw, v2.y
mad r1.xyz, c7.zxyw, v2.x, r1
mad r1.xyz, c9.zxyw, v2.z, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r2.xyz, r0, r1
mad r2.xyz, r1.zxyw, r0.yzxw, -r2
mul r2.xyz, r2, v1.w
mov o2.y, r2.x
mov o2.z, r1.y
mov o3.x, r0.x
mov o4.x, r0.y
mov o3.y, r2.y
mov o4.y, r2.z
mov o3.z, r1.z
mov o4.z, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedokcmbekcnmckbahmipagomhjokebcddcabaaaaaalaahaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcleafaaaaeaaaabaa
gnabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafeccabaaaabaaaaaackaabaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafeccabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaabaaaaaajgiecaaaabaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaajgiecaaaabaaaaaaamaaaaaaagbabaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgiecaaaabaaaaaaaoaaaaaakgbkbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaacaaaaaacgajbaaa
aaaaaaaajgaebaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgbpbaaaabaaaaaadgaaaaafcccabaaaacaaaaaa
akaabaaaacaaaaaadgaaaaafbccabaaaacaaaaaackaabaaaabaaaaaadgaaaaaf
eccabaaaadaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaaeaaaaaaakaabaaa
aaaaaaaadgaaaaafbccabaaaadaaaaaaakaabaaaabaaaaaadgaaaaafbccabaaa
aeaaaaaabkaabaaaabaaaaaadgaaaaafcccabaaaadaaaaaabkaabaaaacaaaaaa
dgaaaaafcccabaaaaeaaaaaackaabaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Matrix 0 [_LightMatrix0] 3
Vector 11 [_Color]
Float 10 [_Glossiness]
Vector 6 [_LightColor0]
Float 8 [_RainOpacity]
Float 9 [_Raining]
Vector 3 [_WorldSpaceCameraPos]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_ColorSpaceDielectricSpec]
Vector 7 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_Rain] 2D 3
"ps_3_0
def c12, 9.99999975e-005, 0.967999995, 0.0299999993, 10
def c13, 0, 2, -1, 1
def c14, -0.5, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
add r0.xyz, c4, -v4
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
add r2.xyz, c3, -v4
nrm_pp r3.xyz, r2
mov r2.xw, c13
if_lt -c9.x, r2.x
texld r4, v0, s1
mul_pp r4, r4, c11
texld_pp r5, v0, s3
lrp_pp r6.xyz, r5.w, r5.x, r4
texld_pp r7, v0, s2
mad_pp r2.xy, r7.wyzw, c13.y, c13.z
dp2add_sat_pp r1.w, r2, r2, c13.x
add_pp r1.w, -r1.w, c13.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
lrp r4.xyz, r5.w, c13.xxww, r2
nrm_pp r2.xyz, r4
mad_pp oC0.w, r5.w, c8.x, r4.w
else
texld r4, v0, s1
mul_pp r6, r4, c11
texld_pp r4, v0, s2
mad_pp r2.xy, r4.wyzw, c13.y, c13.z
dp2add_sat_pp r1.w, r2, r2, c13.x
add_pp r1.w, -r1.w, c13.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
mov_pp oC0.w, r6.w
endif
mad r4, v4.xyzx, c13.wwwx, c13.xxxw
dp4 r5.x, c0, r4
dp4 r5.y, c1, r4
dp4 r5.z, c2, r4
dp3 r1.w, r5, r5
texld_pp r4, r1.w, s0
dp3_pp r5.x, v1, r2
dp3_pp r5.y, v2, r2
dp3_pp r5.z, v3, r2
dp3_pp r1.w, r5, r1
max_pp r2.x, r1.w, c13.x
mul_pp r4.xyz, r4.x, c6
nrm_pp r7.xyz, r5
mul_pp r5.xyz, r6, c5.w
add_pp r1.w, r2.w, -c10.x
mad_pp r0.xyz, r0, r0.w, r3
nrm_pp r6.xyz, r0
dp3_pp r0.x, r7, r6
max_pp r2.y, r0.x, c13.x
dp3_pp r0.x, r7, r3
max_pp r2.z, r0.x, c13.x
dp3_pp r0.x, r1, r6
max_pp r1.x, r0.x, c13.x
mul_pp r0.x, r1.w, r1.w
mul_pp r0.y, r0.x, c7.w
mad_pp r0.x, r0.x, -c7.w, r2.w
mad_pp r0.z, r2.x, r0.x, r0.y
mad_pp r0.x, r2.z, r0.x, r0.y
mad r0.x, r0.z, r0.x, c12.x
rcp_pp r0.x, r0.x
add_pp r0.y, -r1.w, c13.w
mad_pp r0.y, r0.y, c12.y, c12.z
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c12.w
mul_pp r0.z, r0.y, r0.y
mad_pp r0.y, r0.y, r0.y, c13.w
mul_pp r0.y, r0.y, c7.y
pow_pp r1.y, r2.y, r0.z
mul_pp r0.y, r0.y, r1.y
add_pp r0.z, -r2.x, c13.w
mul_pp r0.w, r0.z, r0.z
mul_pp r0.w, r0.w, r0.w
mul_pp r0.z, r0.z, r0.w
add_pp r0.w, -r2.z, c13.w
mul_pp r1.y, r0.w, r0.w
mul_pp r1.y, r1.y, r1.y
mul_pp r0.w, r0.w, r1.y
mul_pp r1.y, r1.x, r1.x
dp2add_pp r1.y, r1.y, r1.w, c14.x
mad_pp r0.z, r1.y, r0.z, c13.w
mad_pp r0.w, r1.y, r0.w, c13.w
mul_pp r0.xz, r0.yyww, r0
mul_pp r0.x, r2.x, r0.x
mul_pp r0.x, r0.x, c7.x
max_pp r1.y, r0.x, c13.x
mul_pp r0.x, r2.x, r0.z
mul_pp r0.xyz, r0.x, r4
mul_pp r1.yzw, r4.xxyz, r1.y
add_pp r0.w, -r1.x, c13.w
mul_pp r1.x, r0.w, r0.w
mul_pp r1.x, r1.x, r1.x
mul_pp r0.w, r0.w, r1.x
lrp_pp r3.xyz, r0.w, r2.w, c5
mul_pp r1.xyz, r1.yzww, r3
mad_pp oC0.xyz, r5, r0, r1

"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Rain] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Float 208 [_RainOpacity]
Float 212 [_Raining]
Float 216 [_Glossiness]
Vector 224 [_Color]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedgdkclkgonjioackkieanbijpfppmnapoabaaaaaaeeapaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcceaoaaaa
eaaaaaaaijadaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaiaebaaaaaaafaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadbaaaaaiicaabaaa
abaaaaaaabeaaaaaaaaaaaaabkiacaaaaaaaaaaaanaaaaaabpaaaeaddkaabaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaaipcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaa
aaaaaaaaaoaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
aeaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaacaaaaaadkaabaaaaeaaaaaa
akaabaaaaeaaaaaadcaaaaajhcaabaaaafaaaaaaegacbaaaadaaaaaapgapbaaa
abaaaaaapgapbaaaacaaaaaaefaaaaajpcaabaaaagaaaaaaegbabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaa
agaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaacaaaaaaegaabaaaadaaaaaa
egaabaaaadaaaaaaddaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaacaaaaaadiaaaaakhcaabaaa
aeaaaaaapgapbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaa
dcaaaaajhcaabaaaadaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaaegacbaaa
aeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaabaaaaaaegacbaaaadaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaa
aeaaaaaaakiacaaaaaaaaaaaanaaaaaadkaabaaaadaaaaaabcaaaaabefaaaaaj
pcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaaipcaabaaaafaaaaaaegaobaaaaeaaaaaaegiocaaaaaaaaaaaaoaaaaaa
efaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaaeaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
adaaaaaadkaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaafaaaaaa
bfaaaaabdiaaaaaihcaabaaaaeaaaaaafgbfbaaaafaaaaaaegiccaaaaaaaaaaa
akaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaa
afaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaaaaaaaaa
alaaaaaakgbkbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaihcaabaaaaeaaaaaa
egacbaaaaeaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaaeaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaapgapbaaa
abaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaabaaaaaahbcaabaaaagaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaagaaaaaaegbcbaaa
adaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaagaaaaaaegbcbaaaaeaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaa
diaaaaaihcaabaaaadaaaaaaagaabaaaaeaaaaaaegiccaaaaaaaaaaaagaaaaaa
baaaaaahicaabaaaacaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaeeaaaaaf
icaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaa
acaaaaaaegacbaaaagaaaaaadiaaaaaihcaabaaaafaaaaaaegacbaaaafaaaaaa
pgipcaaaaaaaaaaaacaaaaaaaaaaaaajicaabaaaacaaaaaackiacaiaebaaaaaa
aaaaaaaaanaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadeaaaaakjcaabaaaaaaaaaaaagambaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaaiecaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadp
dcaaaaajbcaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaa
aaaaaaaaabeaaaaabhlhnbdiaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaa
dkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaoaaaaahecaabaaaaaaaaaaaabeaaaaaaaaacaeb
ckaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
aaaaaaaaaiaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaai
bcaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaah
ccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaaapaaaaahccaabaaaabaaaaaafgafbaaaabaaaaaa
pgapbaaaacaaaaaaaaaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaalpdcaaaaajicaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahkcaabaaaaaaaaaaafganbaaaaaaaaaaapgadbaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaahocaabaaa
aaaaaaaaagajbaaaadaaaaaafgafbaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaabaaaaaaaaaaaaamhcaabaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaakhcaabaaa
acaaaaaaegacbaaaacaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaa
diaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 8 [_Color]
Float 7 [_Glossiness]
Vector 3 [_LightColor0]
Float 5 [_RainOpacity]
Float 6 [_Raining]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [unity_ColorSpaceDielectricSpec]
Vector 4 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Rain] 2D 2
"ps_3_0
def c9, 0, 2, -1, 1
def c10, 9.99999975e-005, 0.967999995, 0.0299999993, 10
def c11, -0.5, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
add r0.xyz, c0, -v4
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mov r2.xw, c9
if_lt -c6.x, r2.x
texld r3, v0, s0
mul_pp r3, r3, c8
texld_pp r4, v0, s2
lrp_pp r5.xyz, r4.w, r4.x, r3
texld_pp r6, v0, s1
mad_pp r2.xy, r6.wyzw, c9.y, c9.z
dp2add_sat_pp r1.w, r2, r2, c9.x
add_pp r1.w, -r1.w, c9.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
lrp r3.xyz, r4.w, c9.xxww, r2
nrm_pp r2.xyz, r3
mad_pp oC0.w, r4.w, c5.x, r3.w
else
texld r3, v0, s0
mul_pp r5, r3, c8
texld_pp r3, v0, s1
mad_pp r2.xy, r3.wyzw, c9.y, c9.z
dp2add_sat_pp r1.w, r2, r2, c9.x
add_pp r1.w, -r1.w, c9.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
mov_pp oC0.w, r5.w
endif
dp3_pp r3.x, v1, r2
dp3_pp r3.y, v2, r2
dp3_pp r3.z, v3, r2
dp3_pp r1.w, r3, c1
max_pp r2.x, r1.w, c9.x
nrm_pp r4.xyz, r3
mul_pp r3.xyz, r5, c2.w
add_pp r1.w, r2.w, -c7.x
mad_pp r0.xyz, r0, r0.w, c1
nrm_pp r5.xyz, r0
dp3_pp r0.x, r4, r5
max_pp r2.y, r0.x, c9.x
dp3_pp r0.x, r4, r1
max_pp r1.x, r0.x, c9.x
dp3_pp r0.x, c1, r5
max_pp r1.y, r0.x, c9.x
mul_pp r0.x, r1.w, r1.w
mul_pp r0.y, r0.x, c4.w
mad_pp r0.x, r0.x, -c4.w, r2.w
mad_pp r0.z, r2.x, r0.x, r0.y
mad_pp r0.x, r1.x, r0.x, r0.y
mad r0.x, r0.z, r0.x, c10.x
rcp_pp r0.x, r0.x
add_pp r0.y, -r1.w, c9.w
mad_pp r0.y, r0.y, c10.y, c10.z
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c10.w
mul_pp r0.z, r0.y, r0.y
mad_pp r0.y, r0.y, r0.y, c9.w
mul_pp r0.y, r0.y, c4.y
pow_pp r1.z, r2.y, r0.z
add_pp r0.z, -r2.x, c9.w
mul_pp r0.w, r0.z, r0.z
mul_pp r0.w, r0.w, r0.w
mul_pp r0.z, r0.z, r0.w
add_pp r0.w, -r1.x, c9.w
mul_pp r1.x, r0.w, r0.w
mul_pp r1.x, r1.x, r1.x
mul_pp r0.yw, r0, r1.xzzx
mul_pp r1.x, r1.y, r1.y
dp2add_pp r1.x, r1.x, r1.w, c11.x
mad_pp r0.z, r1.x, r0.z, c9.w
mad_pp r0.w, r1.x, r0.w, c9.w
mul_pp r0.xz, r0.yyww, r0
mul_pp r0.xy, r2.x, r0.xzzw
mul_pp r0.x, r0.x, c4.x
mul_pp r0.yzw, r0.y, c3.xxyz
mul_pp r1.xzw, r0.x, c3.xyyz
cmp_pp r1.xzw, r0.x, r1, c9.x
add_pp r0.x, -r1.y, c9.w
mul_pp r1.y, r0.x, r0.x
mul_pp r1.y, r1.y, r1.y
mul_pp r0.x, r0.x, r1.y
lrp_pp r4.xyz, r0.x, r2.w, c2
mul_pp r1.xyz, r1.xzww, r4
mad_pp oC0.xyz, r3, r0.yzww, r1

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Rain] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 192
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Float 144 [_RainOpacity]
Float 148 [_Raining]
Float 152 [_Glossiness]
Vector 160 [_Color]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedkbcfjabdlekdidmlehmhejhoppcepeijabaaaaaammanaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmamaaaa
eaaaaaaacladaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadbaaaaaiicaabaaaabaaaaaaabeaaaaaaaaaaaaa
bkiacaaaaaaaaaaaajaaaaaabpaaaeaddkaabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaakaaaaaaefaaaaaj
pcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaadaaaaaadkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaaj
hcaabaaaaeaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaaagaabaaaadaaaaaa
efaaaaajpcaabaaaafaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
abaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaafaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahbcaabaaaadaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
bcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaa
adaaaaaaakaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaaakaabaaaadaaaaaadiaaaaakhcaabaaaadaaaaaapgapbaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaacaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaadaaaaaaakiacaaaaaaaaaaa
ajaaaaaadkaabaaaacaaaaaabcaaaaabefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaaeaaaaaa
egaobaaaadaaaaaaegiocaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
acaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaeaaaaaabfaaaaabbaaaaaahbcaabaaa
adaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaadaaaaaa
egbcbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaadaaaaaaegbcbaaa
aeaaaaaaegacbaaaacaaaaaabaaaaaaiicaabaaaabaaaaaaegacbaaaadaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaah
hcaabaaaacaaaaaaagaabaaaacaaaaaaegacbaaaadaaaaaadiaaaaaihcaabaaa
adaaaaaaegacbaaaaeaaaaaapgipcaaaaaaaaaaaacaaaaaaaaaaaaajicaabaaa
acaaaaaackiacaiaebaaaaaaaaaaaaaaajaaaaaaabeaaaaaaaaaiadpdcaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaadeaaaaakjcaabaaaabaaaaaaagambaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabaaaaaaibcaabaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaaegacbaaaaaaaaaaadeaaaaakjcaabaaaaaaaaaaaagambaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaaiecaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadp
dcaaaaajccaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaa
aaaaaaaaabeaaaaabhlhnbdiaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaa
dkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaoaaaaahecaabaaaaaaaaaaaabeaaaaaaaaacaeb
ckaabaaaaaaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
aaaaaaaaaiaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaaaaaaaaai
bcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaah
ccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaaapaaaaahccaabaaaabaaaaaafgafbaaaabaaaaaa
pgapbaaaacaaaaaaaaaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaalpdcaaaaajicaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahkcaabaaaaaaaaaaafganbaaaaaaaaaaapgadbaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaai
ocaabaaaaaaaaaaafgafbaaaaaaaaaaaagijcaaaaaaaaaaaagaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaamhcaabaaaacaaaaaaegiccaia
ebaaaaaaaaaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
dcaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaaagaabaaaaaaaaaaaegiccaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Matrix 0 [_LightMatrix0]
Vector 12 [_Color]
Float 11 [_Glossiness]
Vector 7 [_LightColor0]
Float 9 [_RainOpacity]
Float 10 [_Raining]
Vector 4 [_WorldSpaceCameraPos]
Vector 5 [_WorldSpaceLightPos0]
Vector 6 [unity_ColorSpaceDielectricSpec]
Vector 8 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_BumpMap] 2D 3
SetTexture 4 [_Rain] 2D 4
"ps_3_0
def c13, 0.5, 9.99999975e-005, 0.967999995, 0.0299999993
def c14, 0, 2, -1, 1
def c15, 10, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
add r0.xyz, c5, -v4
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
add r2.xyz, c4, -v4
nrm_pp r3.xyz, r2
mov r2.xw, c14
if_lt -c10.x, r2.x
texld r4, v0, s2
mul_pp r4, r4, c12
texld_pp r5, v0, s4
lrp_pp r6.xyz, r5.w, r5.x, r4
texld_pp r7, v0, s3
mad_pp r2.xy, r7.wyzw, c14.y, c14.z
dp2add_sat_pp r1.w, r2, r2, c14.x
add_pp r1.w, -r1.w, c14.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
lrp r4.xyz, r5.w, c14.xxww, r2
nrm_pp r2.xyz, r4
mad_pp oC0.w, r5.w, c9.x, r4.w
else
texld r4, v0, s2
mul_pp r6, r4, c12
texld_pp r4, v0, s3
mad_pp r2.xy, r4.wyzw, c14.y, c14.z
dp2add_sat_pp r1.w, r2, r2, c14.x
add_pp r1.w, -r1.w, c14.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
mov_pp oC0.w, r6.w
endif
mad r4, v4.xyzx, c14.wwwx, c14.xxxw
dp4 r5.x, c0, r4
dp4 r5.y, c1, r4
dp4 r5.z, c2, r4
dp4 r1.w, c3, r4
rcp r1.w, r1.w
mad r4.xy, r5, r1.w, c13.x
texld_pp r4, r4, s0
dp3 r1.w, r5, r5
texld_pp r7, r1.w, s1
mul r1.w, r4.w, r7.x
dp3_pp r4.x, v1, r2
dp3_pp r4.y, v2, r2
dp3_pp r4.z, v3, r2
dp3_pp r2.x, r4, r1
max_pp r3.w, r2.x, c14.x
mul_pp r2.xyz, r1.w, c7
cmp_pp r2.xyz, -r5.z, c14.x, r2
nrm_pp r5.xyz, r4
mul_pp r4.xyz, r6, c6.w
add_pp r1.w, r2.w, -c11.x
mad_pp r0.xyz, r0, r0.w, r3
nrm_pp r6.xyz, r0
dp3_pp r0.x, r5, r6
max_pp r4.w, r0.x, c14.x
dp3_pp r0.x, r5, r3
max_pp r3.x, r0.x, c14.x
dp3_pp r0.x, r1, r6
max_pp r1.x, r0.x, c14.x
mul_pp r0.x, r1.w, r1.w
mul_pp r0.y, r0.x, c8.w
mad_pp r0.x, r0.x, -c8.w, r2.w
mad_pp r0.z, r3.w, r0.x, r0.y
mad_pp r0.x, r3.x, r0.x, r0.y
mad r0.x, r0.z, r0.x, c13.y
rcp_pp r0.x, r0.x
add_pp r0.y, -r1.w, c14.w
mad_pp r0.y, r0.y, c13.z, c13.w
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c15.x
mul_pp r0.z, r0.y, r0.y
mad_pp r0.y, r0.y, r0.y, c14.w
mul_pp r0.y, r0.y, c8.y
pow_pp r1.y, r4.w, r0.z
mul_pp r0.y, r0.y, r1.y
add_pp r0.z, -r3.w, c14.w
mul_pp r0.w, r0.z, r0.z
mul_pp r0.w, r0.w, r0.w
mul_pp r0.z, r0.z, r0.w
add_pp r0.w, -r3.x, c14.w
mul_pp r1.y, r0.w, r0.w
mul_pp r1.y, r1.y, r1.y
mul_pp r0.w, r0.w, r1.y
mul_pp r1.y, r1.x, r1.x
dp2add_pp r1.y, r1.y, r1.w, -c13.x
mad_pp r0.z, r1.y, r0.z, c14.w
mad_pp r0.w, r1.y, r0.w, c14.w
mul_pp r0.xz, r0.yyww, r0
mul_pp r0.x, r3.w, r0.x
mul_pp r0.x, r0.x, c8.x
max_pp r1.y, r0.x, c14.x
mul_pp r0.x, r3.w, r0.z
mul_pp r0.xyz, r0.x, r2
mul_pp r1.yzw, r2.xxyz, r1.y
add_pp r0.w, -r1.x, c14.w
mul_pp r1.x, r0.w, r0.w
mul_pp r1.x, r1.x, r1.x
mul_pp r0.w, r0.w, r1.x
lrp_pp r3.xyz, r0.w, r2.w, c6
mul_pp r1.xyz, r1.yzww, r3
mad_pp oC0.xyz, r4, r0, r1

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Rain] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Float 208 [_RainOpacity]
Float 212 [_Raining]
Float 216 [_Glossiness]
Vector 224 [_Color]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedljclnifgbfdkgdnnpafjoehabmnkomniabaaaaaacibaaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaiapaaaa
eaaaaaaamcadaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egbcbaiaebaaaaaaafaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadbaaaaaiicaabaaaabaaaaaa
abeaaaaaaaaaaaaabkiacaaaaaaaaaaaanaaaaaabpaaaeaddkaabaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadiaaaaaipcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaaaaaaaaa
aoaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaaeaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaeaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaacaaaaaadkaabaaaaeaaaaaaakaabaaa
aeaaaaaadcaaaaajhcaabaaaafaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaa
pgapbaaaacaaaaaaefaaaaajpcaabaaaagaaaaaaegbabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaagaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaacaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaacaaaaaadiaaaaakhcaabaaaaeaaaaaa
pgapbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaadcaaaaaj
hcaabaaaadaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaaegacbaaaaeaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaaeaaaaaa
akiacaaaaaaaaaaaanaaaaaadkaabaaaadaaaaaabcaaaaabefaaaaajpcaabaaa
aeaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaai
pcaabaaaafaaaaaaegaobaaaaeaaaaaaegiocaaaaaaaaaaaaoaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaa
dcaaaaapdcaabaaaadaaaaaahgapbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaa
dkaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaafaaaaaabfaaaaab
diaaaaaipcaabaaaaeaaaaaafgbfbaaaafaaaaaaegiocaaaaaaaaaaaakaaaaaa
dcaaaaakpcaabaaaaeaaaaaaegiocaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaaaaaaaaaalaaaaaa
kgbkbaaaafaaaaaaegaobaaaaeaaaaaaaaaaaaaipcaabaaaaeaaaaaaegaobaaa
aeaaaaaaegiocaaaaaaaaaaaamaaaaaadbaaaaahicaabaaaabaaaaaaabeaaaaa
aaaaaaaackaabaaaaeaaaaaaabaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaiadpaoaaaaahdcaabaaaagaaaaaaegaabaaaaeaaaaaapgapbaaa
aeaaaaaaaaaaaaakdcaabaaaagaaaaaaegaabaaaagaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaagaaaaaa
eghobaaaadaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaagaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaaeaaaaaa
egacbaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaapgapbaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
akaabaaaaeaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaa
baaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaah
icaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
adaaaaaapgapbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaabaaaaaaegacbaaa
aeaaaaaadiaaaaaihcaabaaaafaaaaaaegacbaaaafaaaaaapgipcaaaaaaaaaaa
acaaaaaaaaaaaaajicaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaa
abeaaaaaaaaaiadpdcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaacaaaaaa
egacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaakjcaabaaaacaaaaaaagambaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadeaaaaakjcaabaaaaaaaaaaa
agambaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaiecaabaaa
aaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaiadpdcaaaaajbcaabaaaabaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaabaaaaaa
bkaabaaaaaaaaaaaabeaaaaabhlhnbdiaoaaaaakccaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaahecaabaaaaaaaaaaaabeaaaaa
aaaacaebckaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
acaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaapaaaaahccaabaaaabaaaaaafgafbaaa
abaaaaaapgapbaaaabaaaaaaaaaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaaalpdcaaaaajicaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaaabaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahgcaabaaaaaaaaaaapgapbaaaacaaaaaafgahbaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaah
ocaabaaaaaaaaaaaagajbaaaadaaaaaafgafbaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
abaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkaabaaaabaaaaaaaaaaaaamhcaabaaaacaaaaaaegiccaiaebaaaaaa
aaaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaak
hcaabaaaacaaaaaaegacbaaaacaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Matrix 0 [_LightMatrix0] 3
Vector 11 [_Color]
Float 10 [_Glossiness]
Vector 6 [_LightColor0]
Float 8 [_RainOpacity]
Float 9 [_Raining]
Vector 3 [_WorldSpaceCameraPos]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_ColorSpaceDielectricSpec]
Vector 7 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_BumpMap] 2D 3
SetTexture 4 [_Rain] 2D 4
"ps_3_0
def c12, 9.99999975e-005, 0.967999995, 0.0299999993, 10
def c13, 0, 2, -1, 1
def c14, -0.5, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_cube s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
add r0.xyz, c4, -v4
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
add r2.xyz, c3, -v4
nrm_pp r3.xyz, r2
mov r2.xw, c13
if_lt -c9.x, r2.x
texld r4, v0, s2
mul_pp r4, r4, c11
texld_pp r5, v0, s4
lrp_pp r6.xyz, r5.w, r5.x, r4
texld_pp r7, v0, s3
mad_pp r2.xy, r7.wyzw, c13.y, c13.z
dp2add_sat_pp r1.w, r2, r2, c13.x
add_pp r1.w, -r1.w, c13.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
lrp r4.xyz, r5.w, c13.xxww, r2
nrm_pp r2.xyz, r4
mad_pp oC0.w, r5.w, c8.x, r4.w
else
texld r4, v0, s2
mul_pp r6, r4, c11
texld_pp r4, v0, s3
mad_pp r2.xy, r4.wyzw, c13.y, c13.z
dp2add_sat_pp r1.w, r2, r2, c13.x
add_pp r1.w, -r1.w, c13.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
mov_pp oC0.w, r6.w
endif
mad r4, v4.xyzx, c13.wwwx, c13.xxxw
dp4 r5.x, c0, r4
dp4 r5.y, c1, r4
dp4 r5.z, c2, r4
dp3 r1.w, r5, r5
texld r4, r1.w, s1
texld r5, r5, s0
mul_pp r1.w, r4.x, r5.w
dp3_pp r4.x, v1, r2
dp3_pp r4.y, v2, r2
dp3_pp r4.z, v3, r2
dp3_pp r2.x, r4, r1
max_pp r3.w, r2.x, c13.x
mul_pp r2.xyz, r1.w, c6
nrm_pp r5.xyz, r4
mul_pp r4.xyz, r6, c5.w
add_pp r1.w, r2.w, -c10.x
mad_pp r0.xyz, r0, r0.w, r3
nrm_pp r6.xyz, r0
dp3_pp r0.x, r5, r6
max_pp r4.w, r0.x, c13.x
dp3_pp r0.x, r5, r3
max_pp r3.x, r0.x, c13.x
dp3_pp r0.x, r1, r6
max_pp r1.x, r0.x, c13.x
mul_pp r0.x, r1.w, r1.w
mul_pp r0.y, r0.x, c7.w
mad_pp r0.x, r0.x, -c7.w, r2.w
mad_pp r0.z, r3.w, r0.x, r0.y
mad_pp r0.x, r3.x, r0.x, r0.y
mad r0.x, r0.z, r0.x, c12.x
rcp_pp r0.x, r0.x
add_pp r0.y, -r1.w, c13.w
mad_pp r0.y, r0.y, c12.y, c12.z
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c12.w
mul_pp r0.z, r0.y, r0.y
mad_pp r0.y, r0.y, r0.y, c13.w
mul_pp r0.y, r0.y, c7.y
pow_pp r1.y, r4.w, r0.z
mul_pp r0.y, r0.y, r1.y
add_pp r0.z, -r3.w, c13.w
mul_pp r0.w, r0.z, r0.z
mul_pp r0.w, r0.w, r0.w
mul_pp r0.z, r0.z, r0.w
add_pp r0.w, -r3.x, c13.w
mul_pp r1.y, r0.w, r0.w
mul_pp r1.y, r1.y, r1.y
mul_pp r0.w, r0.w, r1.y
mul_pp r1.y, r1.x, r1.x
dp2add_pp r1.y, r1.y, r1.w, c14.x
mad_pp r0.z, r1.y, r0.z, c13.w
mad_pp r0.w, r1.y, r0.w, c13.w
mul_pp r0.xz, r0.yyww, r0
mul_pp r0.x, r3.w, r0.x
mul_pp r0.x, r0.x, c7.x
max_pp r1.y, r0.x, c13.x
mul_pp r0.x, r3.w, r0.z
mul_pp r0.xyz, r0.x, r2
mul_pp r1.yzw, r2.xxyz, r1.y
add_pp r0.w, -r1.x, c13.w
mul_pp r1.x, r0.w, r0.w
mul_pp r1.x, r1.x, r1.x
mul_pp r0.w, r0.w, r1.x
lrp_pp r3.xyz, r0.w, r2.w, c5
mul_pp r1.xyz, r1.yzww, r3
mad_pp oC0.xyz, r4, r0, r1

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Rain] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Float 208 [_RainOpacity]
Float 212 [_Raining]
Float 216 [_Glossiness]
Vector 224 [_Color]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedemabbcnoenajgiimlfoonbeecembglhkabaaaaaajaapaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchaaoaaaa
eaaaaaaajmadaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egbcbaiaebaaaaaaafaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadbaaaaaiicaabaaaabaaaaaa
abeaaaaaaaaaaaaabkiacaaaaaaaaaaaanaaaaaabpaaaeaddkaabaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadiaaaaaipcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaaaaaaaaa
aoaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaaeaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaeaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaacaaaaaadkaabaaaaeaaaaaaakaabaaa
aeaaaaaadcaaaaajhcaabaaaafaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaa
pgapbaaaacaaaaaaefaaaaajpcaabaaaagaaaaaaegbabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaagaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaacaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaacaaaaaadiaaaaakhcaabaaaaeaaaaaa
pgapbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaadcaaaaaj
hcaabaaaadaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaaegacbaaaaeaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaaeaaaaaa
akiacaaaaaaaaaaaanaaaaaadkaabaaaadaaaaaabcaaaaabefaaaaajpcaabaaa
aeaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaai
pcaabaaaafaaaaaaegaobaaaaeaaaaaaegiocaaaaaaaaaaaaoaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaa
dcaaaaapdcaabaaaadaaaaaahgapbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaa
dkaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaafaaaaaabfaaaaab
diaaaaaihcaabaaaaeaaaaaafgbfbaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaa
dcaaaaakhcaabaaaaeaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaa
egacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaaaaaaaaaalaaaaaa
kgbkbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaihcaabaaaaeaaaaaaegacbaaa
aeaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
aeaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaagaaaaaapgapbaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegacbaaa
aeaaaaaaeghobaaaaeaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaaeaaaaaaakaabaaaagaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaa
acaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaa
egacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaa
adaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaadaaaaaapgapbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaa
abaaaaaaegacbaaaaeaaaaaadiaaaaaihcaabaaaafaaaaaaegacbaaaafaaaaaa
pgipcaaaaaaaaaaaacaaaaaaaaaaaaajicaabaaaabaaaaaackiacaiaebaaaaaa
aaaaaaaaanaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaakjcaabaaa
acaaaaaaagambaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadeaaaaak
jcaabaaaaaaaaaaaagambaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaaiecaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaa
dcaaaaalccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaa
aiaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaaabaaaaaadkaabaaaacaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
acaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaabhlhnbdiaoaaaaakccaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanjmohhdpabeaaaaa
ipmcpfdmcpaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaacaebckaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaa
abeaaaaaaaaaiadpdiaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaapaaaaahccaabaaa
abaaaaaafgafbaaaabaaaaaapgapbaaaabaaaaaaaaaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaaaaaaaalpdcaaaaajicaabaaaaaaaaaaabkaabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahgcaabaaaaaaaaaaapgapbaaa
acaaaaaafgahbaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
adaaaaaadiaaaaahocaabaaaaaaaaaaaagajbaaaadaaaaaafgafbaaaaaaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahicaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaamhcaabaaaacaaaaaa
egiccaiaebaaaaaaaaaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Matrix 0 [_LightMatrix0] 2
Vector 10 [_Color]
Float 9 [_Glossiness]
Vector 5 [_LightColor0]
Float 7 [_RainOpacity]
Float 8 [_Raining]
Vector 2 [_WorldSpaceCameraPos]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [unity_ColorSpaceDielectricSpec]
Vector 6 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_Rain] 2D 3
"ps_3_0
def c11, 9.99999975e-005, 0.967999995, 0.0299999993, 10
def c12, 0, 2, -1, 1
def c13, -0.5, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
add r0.xyz, c2, -v4
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mov r2.xw, c12
if_lt -c8.x, r2.x
texld r3, v0, s1
mul_pp r3, r3, c10
texld_pp r4, v0, s3
lrp_pp r5.xyz, r4.w, r4.x, r3
texld_pp r6, v0, s2
mad_pp r2.xy, r6.wyzw, c12.y, c12.z
dp2add_sat_pp r1.w, r2, r2, c12.x
add_pp r1.w, -r1.w, c12.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
lrp r3.xyz, r4.w, c12.xxww, r2
nrm_pp r2.xyz, r3
mad_pp oC0.w, r4.w, c7.x, r3.w
else
texld r3, v0, s1
mul_pp r5, r3, c10
texld_pp r3, v0, s2
mad_pp r2.xy, r3.wyzw, c12.y, c12.z
dp2add_sat_pp r1.w, r2, r2, c12.x
add_pp r1.w, -r1.w, c12.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
mov_pp oC0.w, r5.w
endif
mad r3, v4.xyzx, c12.wwwx, c12.xxxw
dp4 r4.x, c0, r3
dp4 r4.y, c1, r3
texld_pp r3, r4, s0
dp3_pp r3.x, v1, r2
dp3_pp r3.y, v2, r2
dp3_pp r3.z, v3, r2
dp3_pp r1.w, r3, c3
max_pp r2.x, r1.w, c12.x
mul_pp r4.xyz, r3.w, c5
nrm_pp r6.xyz, r3
mul_pp r3.xyz, r5, c4.w
add_pp r1.w, r2.w, -c9.x
mad_pp r0.xyz, r0, r0.w, c3
nrm_pp r5.xyz, r0
dp3_pp r0.x, r6, r5
max_pp r2.y, r0.x, c12.x
dp3_pp r0.x, r6, r1
max_pp r1.x, r0.x, c12.x
dp3_pp r0.x, c3, r5
max_pp r1.y, r0.x, c12.x
mul_pp r0.x, r1.w, r1.w
mul_pp r0.y, r0.x, c6.w
mad_pp r0.x, r0.x, -c6.w, r2.w
mad_pp r0.z, r2.x, r0.x, r0.y
mad_pp r0.x, r1.x, r0.x, r0.y
mad r0.x, r0.z, r0.x, c11.x
rcp_pp r0.x, r0.x
add_pp r0.y, -r1.w, c12.w
mad_pp r0.y, r0.y, c11.y, c11.z
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c11.w
mul_pp r0.z, r0.y, r0.y
mad_pp r0.y, r0.y, r0.y, c12.w
mul_pp r0.y, r0.y, c6.y
pow_pp r1.z, r2.y, r0.z
add_pp r0.z, -r2.x, c12.w
mul_pp r0.w, r0.z, r0.z
mul_pp r0.w, r0.w, r0.w
mul_pp r0.z, r0.z, r0.w
add_pp r0.w, -r1.x, c12.w
mul_pp r1.x, r0.w, r0.w
mul_pp r1.x, r1.x, r1.x
mul_pp r0.yw, r0, r1.xzzx
mul_pp r1.x, r1.y, r1.y
dp2add_pp r1.x, r1.x, r1.w, c13.x
mad_pp r0.z, r1.x, r0.z, c12.w
mad_pp r0.w, r1.x, r0.w, c12.w
mul_pp r0.xz, r0.yyww, r0
mul_pp r0.x, r2.x, r0.x
mul_pp r0.x, r0.x, c6.x
max_pp r1.x, r0.x, c12.x
mul_pp r0.x, r2.x, r0.z
mul_pp r0.xyz, r0.x, r4
mul_pp r1.xzw, r4.xyyz, r1.x
add_pp r0.w, -r1.y, c12.w
mul_pp r1.y, r0.w, r0.w
mul_pp r1.y, r1.y, r1.y
mul_pp r0.w, r0.w, r1.y
lrp_pp r4.xyz, r0.w, r2.w, c4
mul_pp r1.xyz, r1.xzww, r4
mad_pp oC0.xyz, r3, r0, r1

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Rain] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Float 208 [_RainOpacity]
Float 212 [_Raining]
Float 216 [_Glossiness]
Vector 224 [_Color]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefieceddenlnoikpidngenpgjjchefakiibnbfdabaaaaaaleaoaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjeanaaaa
eaaaaaaagfadaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadbaaaaaiicaabaaaabaaaaaaabeaaaaaaaaaaaaabkiacaaa
aaaaaaaaanaaaaaabpaaaeaddkaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaaipcaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaaoaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaadaaaaaadkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajhcaabaaa
aeaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaaagaabaaaadaaaaaaefaaaaaj
pcaabaaaafaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
dcaaaaapdcaabaaaacaaaaaahgapbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
bcaabaaaadaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaadaaaaaa
akaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaa
akaabaaaadaaaaaadiaaaaakhcaabaaaadaaaaaapgapbaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakiccabaaaaaaaaaaadkaabaaaadaaaaaaakiacaaaaaaaaaaaanaaaaaa
dkaabaaaacaaaaaabcaaaaabefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaaipcaabaaaaeaaaaaaegaobaaa
adaaaaaaegiocaaaaaaaaaaaaoaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaacaaaaaa
hgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaa
acaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaeaaaaaabfaaaaabdiaaaaaidcaabaaaadaaaaaa
fgbfbaaaafaaaaaaegiacaaaaaaaaaaaakaaaaaadcaaaaakdcaabaaaadaaaaaa
egiacaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegaabaaaadaaaaaadcaaaaak
dcaabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaaegaabaaa
adaaaaaaaaaaaaaidcaabaaaadaaaaaaegaabaaaadaaaaaaegiacaaaaaaaaaaa
amaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaadaaaaaa
aagabaaaaaaaaaaabaaaaaahbcaabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaabaaaaaahccaabaaaadaaaaaaegbcbaaaadaaaaaaegacbaaaacaaaaaa
baaaaaahecaabaaaadaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaai
icaabaaaabaaaaaaegacbaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaapgapbaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaah
icaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaa
acaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaacaaaaaa
egacbaaaadaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaaaeaaaaaapgipcaaa
aaaaaaaaacaaaaaaaaaaaaajicaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaa
anaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadeaaaaakjcaabaaa
abaaaaaaagambaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
baaaaaaibcaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaegacbaaaaaaaaaaa
deaaaaakjcaabaaaaaaaaaaaagambaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaaiecaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaa
aiaaaaaadcaaaaalccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadkiacaaa
aaaaaaaaaiaaaaaaabeaaaaaaaaaiadpdcaaaaajccaabaaaabaaaaaadkaabaaa
abaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaabaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaabkaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaabhlhnbdiaoaaaaak
ccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
aaaaaaaaaaaaaaaiecaabaaaaaaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaanjmohhdp
abeaaaaaipmcpfdmcpaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaah
ecaabaaaaaaaaaaaabeaaaaaaaaacaebckaabaaaaaaaaaaadiaaaaahccaabaaa
abaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiecaabaaa
aaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaa
abaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaapaaaaah
ccaabaaaabaaaaaafgafbaaaabaaaaaapgapbaaaacaaaaaaaaaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaalpdcaaaaajicaabaaaaaaaaaaa
bkaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaah
ccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahkcaabaaa
aaaaaaaafganbaaaaaaaaaaapgadbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadeaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaa
abaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaamhcaabaaa
acaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaajgahbaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaeaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" "FOG_EXP" }
Matrix 0 [_LightMatrix0] 3
Vector 12 [_Color]
Float 11 [_Glossiness]
Vector 7 [_LightColor0]
Float 9 [_RainOpacity]
Float 10 [_Raining]
Vector 3 [_WorldSpaceCameraPos]
Vector 4 [_WorldSpaceLightPos0]
Vector 6 [unity_ColorSpaceDielectricSpec]
Vector 5 [unity_FogParams]
Vector 8 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_Rain] 2D 3
"ps_3_0
def c13, 0, 2, -1, 1
def c14, 9.99999975e-005, 0.967999995, 0.0299999993, 10
def c15, -0.5, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
add r0.xyz, c4, -v4
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
add r2.xyz, c3, -v4
nrm_pp r3.xyz, r2
mov r2.xw, c13
if_lt -c10.x, r2.x
texld r4, v0, s1
mul_pp r4, r4, c12
texld_pp r5, v0, s3
lrp_pp r6.xyz, r5.w, r5.x, r4
texld_pp r7, v0, s2
mad_pp r2.xy, r7.wyzw, c13.y, c13.z
dp2add_sat_pp r1.w, r2, r2, c13.x
add_pp r1.w, -r1.w, c13.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
lrp r4.xyz, r5.w, c13.xxww, r2
nrm_pp r2.xyz, r4
mad_pp oC0.w, r5.w, c9.x, r4.w
else
texld r4, v0, s1
mul_pp r6, r4, c12
texld_pp r4, v0, s2
mad_pp r2.xy, r4.wyzw, c13.y, c13.z
dp2add_sat_pp r1.w, r2, r2, c13.x
add_pp r1.w, -r1.w, c13.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
mov_pp oC0.w, r6.w
endif
mad r4, v4.xyzx, c13.wwwx, c13.xxxw
dp4 r5.x, c0, r4
dp4 r5.y, c1, r4
dp4 r5.z, c2, r4
dp3 r1.w, r5, r5
texld_pp r4, r1.w, s0
dp3_pp r5.x, v1, r2
dp3_pp r5.y, v2, r2
dp3_pp r5.z, v3, r2
dp3_pp r1.w, r5, r1
max_pp r2.x, r1.w, c13.x
mul_pp r4.xyz, r4.x, c7
nrm_pp r7.xyz, r5
mul_pp r5.xyz, r6, c6.w
add_pp r1.w, r2.w, -c11.x
mad_pp r0.xyz, r0, r0.w, r3
nrm_pp r6.xyz, r0
dp3_pp r0.x, r7, r6
max_pp r2.y, r0.x, c13.x
dp3_pp r0.x, r7, r3
max_pp r2.z, r0.x, c13.x
dp3_pp r0.x, r1, r6
max_pp r1.x, r0.x, c13.x
mul_pp r0.x, r1.w, r1.w
mul_pp r0.y, r0.x, c8.w
mad_pp r0.x, r0.x, -c8.w, r2.w
mad_pp r0.z, r2.x, r0.x, r0.y
mad_pp r0.x, r2.z, r0.x, r0.y
mad r0.x, r0.z, r0.x, c14.x
rcp_pp r0.x, r0.x
add_pp r0.y, -r1.w, c13.w
mad_pp r0.y, r0.y, c14.y, c14.z
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c14.w
mul_pp r0.z, r0.y, r0.y
mad_pp r0.y, r0.y, r0.y, c13.w
mul_pp r0.y, r0.y, c8.y
pow_pp r1.y, r2.y, r0.z
mul_pp r0.y, r0.y, r1.y
add_pp r0.z, -r2.x, c13.w
mul_pp r0.w, r0.z, r0.z
mul_pp r0.w, r0.w, r0.w
mul_pp r0.z, r0.z, r0.w
add_pp r0.w, -r2.z, c13.w
mul_pp r1.y, r0.w, r0.w
mul_pp r1.y, r1.y, r1.y
mul_pp r0.w, r0.w, r1.y
mul_pp r1.y, r1.x, r1.x
dp2add_pp r1.y, r1.y, r1.w, c15.x
mad_pp r0.z, r1.y, r0.z, c13.w
mad_pp r0.w, r1.y, r0.w, c13.w
mul_pp r0.xz, r0.yyww, r0
mul_pp r0.x, r2.x, r0.x
mul_pp r0.x, r0.x, c8.x
max_pp r1.y, r0.x, c13.x
mul_pp r0.x, r2.x, r0.z
mul_pp r0.xyz, r0.x, r4
mul_pp r1.yzw, r4.xxyz, r1.y
add_pp r0.w, -r1.x, c13.w
mul_pp r1.x, r0.w, r0.w
mul_pp r1.x, r1.x, r1.x
mul_pp r0.w, r0.w, r1.x
lrp_pp r3.xyz, r0.w, r2.w, c6
mul_pp r1.xyz, r1.yzww, r3
mad_pp r0.xyz, r5, r0, r1
mul r0.w, c5.y, v5.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w

"
}
SubProgram "d3d11 " {
Keywords { "POINT" "SHADOWS_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Rain] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Float 208 [_RainOpacity]
Float 212 [_Raining]
Float 216 [_Glossiness]
Vector 224 [_Color]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityFog" 3
"ps_4_0
eefiecedjohkbpkhbmidgldjiokodhdndmgjondiabaaaaaaoiapaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclaaoaaaaeaaaaaaakmadaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
ecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacahaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaiaebaaaaaa
afaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaacaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
abaaaaaaegacbaaaacaaaaaadbaaaaaiicaabaaaabaaaaaaabeaaaaaaaaaaaaa
bkiacaaaaaaaaaaaanaaaaaabpaaaeaddkaabaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaai
pcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaaaaaaaaaaoaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaeaaaaaaabeaaaaaaaaaiadp
diaaaaahicaabaaaacaaaaaadkaabaaaaeaaaaaaakaabaaaaeaaaaaadcaaaaaj
hcaabaaaafaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaapgapbaaaacaaaaaa
efaaaaajpcaabaaaagaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaagaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaacaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
acaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
adaaaaaadkaabaaaacaaaaaadiaaaaakhcaabaaaaeaaaaaapgapbaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaadcaaaaajhcaabaaaadaaaaaa
egacbaaaadaaaaaapgapbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaa
adaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaaeaaaaaaakiacaaaaaaaaaaa
anaaaaaadkaabaaaadaaaaaabcaaaaabefaaaaajpcaabaaaaeaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaaipcaabaaaafaaaaaa
egaobaaaaeaaaaaaegiocaaaaaaaaaaaaoaaaaaaefaaaaajpcaabaaaaeaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaafaaaaaabfaaaaabdiaaaaaihcaabaaa
aeaaaaaafgbfbaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
aeaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegacbaaaaeaaaaaa
dcaaaaakhcaabaaaaeaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaa
egacbaaaaeaaaaaaaaaaaaaihcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaa
aaaaaaaaamaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaa
aeaaaaaaefaaaaajpcaabaaaaeaaaaaapgapbaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaaaaaaaaabaaaaaahbcaabaaaagaaaaaaegbcbaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahccaabaaaagaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaa
baaaaaahecaabaaaagaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaadaaaaaa
agaabaaaaeaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaacaaaaaa
egacbaaaagaaaaaaegacbaaaagaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaacaaaaaaegacbaaaagaaaaaa
diaaaaaihcaabaaaafaaaaaaegacbaaaafaaaaaapgipcaaaaaaaaaaaacaaaaaa
aaaaaaajicaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaa
aaaaiadpdcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaadeaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
abeaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaadeaaaaakjcaabaaaaaaaaaaaagambaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaaiecaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaa
aaaaaaaaaiaaaaaadcaaaaalccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaaabaaaaaa
dkaabaaaabaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaaakaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaabhlhnbdi
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaadkaabaiaebaaaaaaacaaaaaa
abeaaaaaaaaaiadpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
njmohhdpabeaaaaaipmcpfdmcpaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
aoaaaaahecaabaaaaaaaaaaaabeaaaaaaaaacaebckaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaia
ebaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
apaaaaahccaabaaaabaaaaaafgafbaaaabaaaaaapgapbaaaacaaaaaaaaaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaalpdcaaaaajicaabaaa
aaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
kcaabaaaaaaaaaaafganbaaaaaaaaaaapgadbaaaabaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaakgakbaaa
aaaaaaaaegacbaaaadaaaaaadiaaaaahocaabaaaaaaaaaaaagajbaaaadaaaaaa
fgafbaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaam
hcaabaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgahbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
afaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
ckbabaaaabaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "FOG_EXP" }
Vector 9 [_Color]
Float 8 [_Glossiness]
Vector 4 [_LightColor0]
Float 6 [_RainOpacity]
Float 7 [_Raining]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 3 [unity_ColorSpaceDielectricSpec]
Vector 2 [unity_FogParams]
Vector 5 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Rain] 2D 2
"ps_3_0
def c10, 0, 2, -1, 1
def c11, 9.99999975e-005, 0.967999995, 0.0299999993, 10
def c12, -0.5, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
add r0.xyz, c0, -v4
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mov r2.xw, c10
if_lt -c7.x, r2.x
texld r3, v0, s0
mul_pp r3, r3, c9
texld_pp r4, v0, s2
lrp_pp r5.xyz, r4.w, r4.x, r3
texld_pp r6, v0, s1
mad_pp r2.xy, r6.wyzw, c10.y, c10.z
dp2add_sat_pp r1.w, r2, r2, c10.x
add_pp r1.w, -r1.w, c10.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
lrp r3.xyz, r4.w, c10.xxww, r2
nrm_pp r2.xyz, r3
mad_pp oC0.w, r4.w, c6.x, r3.w
else
texld r3, v0, s0
mul_pp r5, r3, c9
texld_pp r3, v0, s1
mad_pp r2.xy, r3.wyzw, c10.y, c10.z
dp2add_sat_pp r1.w, r2, r2, c10.x
add_pp r1.w, -r1.w, c10.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
mov_pp oC0.w, r5.w
endif
dp3_pp r3.x, v1, r2
dp3_pp r3.y, v2, r2
dp3_pp r3.z, v3, r2
dp3_pp r1.w, r3, c1
max_pp r2.x, r1.w, c10.x
nrm_pp r4.xyz, r3
mul_pp r3.xyz, r5, c3.w
add_pp r1.w, r2.w, -c8.x
mad_pp r0.xyz, r0, r0.w, c1
nrm_pp r5.xyz, r0
dp3_pp r0.x, r4, r5
max_pp r2.y, r0.x, c10.x
dp3_pp r0.x, r4, r1
max_pp r1.x, r0.x, c10.x
dp3_pp r0.x, c1, r5
max_pp r1.y, r0.x, c10.x
mul_pp r0.x, r1.w, r1.w
mul_pp r0.y, r0.x, c5.w
mad_pp r0.x, r0.x, -c5.w, r2.w
mad_pp r0.z, r2.x, r0.x, r0.y
mad_pp r0.x, r1.x, r0.x, r0.y
mad r0.x, r0.z, r0.x, c11.x
rcp_pp r0.x, r0.x
add_pp r0.y, -r1.w, c10.w
mad_pp r0.y, r0.y, c11.y, c11.z
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c11.w
mul_pp r0.z, r0.y, r0.y
mad_pp r0.y, r0.y, r0.y, c10.w
mul_pp r0.y, r0.y, c5.y
pow_pp r1.z, r2.y, r0.z
add_pp r0.z, -r2.x, c10.w
mul_pp r0.w, r0.z, r0.z
mul_pp r0.w, r0.w, r0.w
mul_pp r0.z, r0.z, r0.w
add_pp r0.w, -r1.x, c10.w
mul_pp r1.x, r0.w, r0.w
mul_pp r1.x, r1.x, r1.x
mul_pp r0.yw, r0, r1.xzzx
mul_pp r1.x, r1.y, r1.y
dp2add_pp r1.x, r1.x, r1.w, c12.x
mad_pp r0.z, r1.x, r0.z, c10.w
mad_pp r0.w, r1.x, r0.w, c10.w
mul_pp r0.xz, r0.yyww, r0
mul_pp r0.xy, r2.x, r0.xzzw
mul_pp r0.x, r0.x, c5.x
mul_pp r0.yzw, r0.y, c4.xxyz
mul_pp r1.xzw, r0.x, c4.xyyz
cmp_pp r1.xzw, r0.x, r1, c10.x
add_pp r0.x, -r1.y, c10.w
mul_pp r1.y, r0.x, r0.x
mul_pp r1.y, r1.y, r1.y
mul_pp r0.x, r0.x, r1.y
lrp_pp r4.xyz, r0.x, r2.w, c3
mul_pp r1.xyz, r1.xzww, r4
mad_pp r0.xyz, r3, r0.yzww, r1
mul r0.w, c2.y, v5.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Rain] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 192
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Float 144 [_RainOpacity]
Float 148 [_Raining]
Float 152 [_Glossiness]
Vector 160 [_Color]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityFog" 3
"ps_4_0
eefiecedcgimbmgemedjbaopoeifcmmiodjhmlbkabaaaaaahaaoaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdianaaaaeaaaaaaaeoadaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacagaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaia
ebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dbaaaaaiicaabaaaabaaaaaaabeaaaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaa
bpaaaeaddkaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegiocaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaadaaaaaa
dkaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaa
acaaaaaapgapbaaaabaaaaaaagaabaaaadaaaaaaefaaaaajpcaabaaaafaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
acaaaaaahgapbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaadaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahbcaabaaaadaaaaaaakaabaaa
adaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaadaaaaaaakaabaiaebaaaaaa
adaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaaakaabaaaadaaaaaa
diaaaaakhcaabaaaadaaaaaapgapbaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaiadpaaaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakiccabaaa
aaaaaaaadkaabaaaadaaaaaaakiacaaaaaaaaaaaajaaaaaadkaabaaaacaaaaaa
bcaaaaabefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaaipcaabaaaaeaaaaaaegaobaaaadaaaaaaegiocaaa
aaaaaaaaakaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaa
acaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaeaaaaaabfaaaaabbaaaaaahbcaabaaaadaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaabaaaaaahccaabaaaadaaaaaaegbcbaaaadaaaaaaegacbaaa
acaaaaaabaaaaaahecaabaaaadaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaa
baaaaaaiicaabaaaabaaaaaaegacbaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
bcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaa
acaaaaaaegacbaaaadaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaaeaaaaaa
pgipcaaaaaaaaaaaacaaaaaaaaaaaaajicaabaaaacaaaaaackiacaiaebaaaaaa
aaaaaaaaajaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadeaaaaak
jcaabaaaabaaaaaaagambaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaabaaaaaaibcaabaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaegacbaaa
aaaaaaaadeaaaaakjcaabaaaaaaaaaaaagambaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaaiecaabaaaaaaaaaaabkaabaaaaaaaaaaadkiacaaa
aaaaaaaaaiaaaaaadcaaaaalccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadpdcaaaaajccaabaaaabaaaaaa
dkaabaaaabaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaaakaabaaaabaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaabhlhnbdi
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaadkaabaiaebaaaaaaacaaaaaa
abeaaaaaaaaaiadpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
njmohhdpabeaaaaaipmcpfdmcpaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
aoaaaaahecaabaaaaaaaaaaaabeaaaaaaaaacaebckaabaaaaaaaaaaadiaaaaah
ccaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaah
ccaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
apaaaaahccaabaaaabaaaaaafgafbaaaabaaaaaapgapbaaaacaaaaaaaaaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaalpdcaaaaajicaabaaa
aaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaj
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
kcaabaaaaaaaaaaafganbaaaaaaaaaaapgadbaaaabaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaakgakbaaa
aaaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaaiocaabaaaaaaaaaaafgafbaaa
aaaaaaaaagijcaaaaaaaaaaaagaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
abaaaaaaaaaaaaamhcaabaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaakhcaabaaaacaaaaaa
egacbaaaacaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaah
hcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaackbabaaaabaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaag
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" "FOG_EXP" }
Matrix 0 [_LightMatrix0]
Vector 13 [_Color]
Float 12 [_Glossiness]
Vector 8 [_LightColor0]
Float 10 [_RainOpacity]
Float 11 [_Raining]
Vector 4 [_WorldSpaceCameraPos]
Vector 5 [_WorldSpaceLightPos0]
Vector 7 [unity_ColorSpaceDielectricSpec]
Vector 6 [unity_FogParams]
Vector 9 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_BumpMap] 2D 3
SetTexture 4 [_Rain] 2D 4
"ps_3_0
def c14, 0.5, 9.99999975e-005, 0.967999995, 0.0299999993
def c15, 0, 2, -1, 1
def c16, 10, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
add r0.xyz, c5, -v4
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
add r2.xyz, c4, -v4
nrm_pp r3.xyz, r2
mov r2.xw, c15
if_lt -c11.x, r2.x
texld r4, v0, s2
mul_pp r4, r4, c13
texld_pp r5, v0, s4
lrp_pp r6.xyz, r5.w, r5.x, r4
texld_pp r7, v0, s3
mad_pp r2.xy, r7.wyzw, c15.y, c15.z
dp2add_sat_pp r1.w, r2, r2, c15.x
add_pp r1.w, -r1.w, c15.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
lrp r4.xyz, r5.w, c15.xxww, r2
nrm_pp r2.xyz, r4
mad_pp oC0.w, r5.w, c10.x, r4.w
else
texld r4, v0, s2
mul_pp r6, r4, c13
texld_pp r4, v0, s3
mad_pp r2.xy, r4.wyzw, c15.y, c15.z
dp2add_sat_pp r1.w, r2, r2, c15.x
add_pp r1.w, -r1.w, c15.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
mov_pp oC0.w, r6.w
endif
mad r4, v4.xyzx, c15.wwwx, c15.xxxw
dp4 r5.x, c0, r4
dp4 r5.y, c1, r4
dp4 r5.z, c2, r4
dp4 r1.w, c3, r4
rcp r1.w, r1.w
mad r4.xy, r5, r1.w, c14.x
texld_pp r4, r4, s0
dp3 r1.w, r5, r5
texld_pp r7, r1.w, s1
mul r1.w, r4.w, r7.x
dp3_pp r4.x, v1, r2
dp3_pp r4.y, v2, r2
dp3_pp r4.z, v3, r2
dp3_pp r2.x, r4, r1
max_pp r3.w, r2.x, c15.x
mul_pp r2.xyz, r1.w, c8
cmp_pp r2.xyz, -r5.z, c15.x, r2
nrm_pp r5.xyz, r4
mul_pp r4.xyz, r6, c7.w
add_pp r1.w, r2.w, -c12.x
mad_pp r0.xyz, r0, r0.w, r3
nrm_pp r6.xyz, r0
dp3_pp r0.x, r5, r6
max_pp r4.w, r0.x, c15.x
dp3_pp r0.x, r5, r3
max_pp r3.x, r0.x, c15.x
dp3_pp r0.x, r1, r6
max_pp r1.x, r0.x, c15.x
mul_pp r0.x, r1.w, r1.w
mul_pp r0.y, r0.x, c9.w
mad_pp r0.x, r0.x, -c9.w, r2.w
mad_pp r0.z, r3.w, r0.x, r0.y
mad_pp r0.x, r3.x, r0.x, r0.y
mad r0.x, r0.z, r0.x, c14.y
rcp_pp r0.x, r0.x
add_pp r0.y, -r1.w, c15.w
mad_pp r0.y, r0.y, c14.z, c14.w
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c16.x
mul_pp r0.z, r0.y, r0.y
mad_pp r0.y, r0.y, r0.y, c15.w
mul_pp r0.y, r0.y, c9.y
pow_pp r1.y, r4.w, r0.z
mul_pp r0.y, r0.y, r1.y
add_pp r0.z, -r3.w, c15.w
mul_pp r0.w, r0.z, r0.z
mul_pp r0.w, r0.w, r0.w
mul_pp r0.z, r0.z, r0.w
add_pp r0.w, -r3.x, c15.w
mul_pp r1.y, r0.w, r0.w
mul_pp r1.y, r1.y, r1.y
mul_pp r0.w, r0.w, r1.y
mul_pp r1.y, r1.x, r1.x
dp2add_pp r1.y, r1.y, r1.w, -c14.x
mad_pp r0.z, r1.y, r0.z, c15.w
mad_pp r0.w, r1.y, r0.w, c15.w
mul_pp r0.xz, r0.yyww, r0
mul_pp r0.x, r3.w, r0.x
mul_pp r0.x, r0.x, c9.x
max_pp r1.y, r0.x, c15.x
mul_pp r0.x, r3.w, r0.z
mul_pp r0.xyz, r0.x, r2
mul_pp r1.yzw, r2.xxyz, r1.y
add_pp r0.w, -r1.x, c15.w
mul_pp r1.x, r0.w, r0.w
mul_pp r1.x, r1.x, r1.x
mul_pp r0.w, r0.w, r1.x
lrp_pp r3.xyz, r0.w, r2.w, c7
mul_pp r1.xyz, r1.yzww, r3
mad_pp r0.xyz, r4, r0, r1
mul r0.w, c6.y, v5.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "SHADOWS_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Rain] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Float 208 [_RainOpacity]
Float 212 [_Raining]
Float 216 [_Glossiness]
Vector 224 [_Color]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityFog" 3
"ps_4_0
eefiecedpaahblllcgalpmodibmegbnaiokgnpeeabaaaaaammbaaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjeapaaaaeaaaaaaaofadaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacahaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
acaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaadbaaaaaiicaabaaaabaaaaaaabeaaaaaaaaaaaaabkiacaaa
aaaaaaaaanaaaaaabpaaaeaddkaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaipcaabaaa
adaaaaaaegaobaaaadaaaaaaegiocaaaaaaaaaaaaoaaaaaaefaaaaajpcaabaaa
aeaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaaaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaaeaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaacaaaaaadkaabaaaaeaaaaaaakaabaaaaeaaaaaadcaaaaajhcaabaaa
afaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaapgapbaaaacaaaaaaefaaaaaj
pcaabaaaagaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaa
dcaaaaapdcaabaaaadaaaaaahgapbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaacaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaa
dkaabaaaacaaaaaadiaaaaakhcaabaaaaeaaaaaapgapbaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
adaaaaaapgapbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
dcaaaaakiccabaaaaaaaaaaadkaabaaaaeaaaaaaakiacaaaaaaaaaaaanaaaaaa
dkaabaaaadaaaaaabcaaaaabefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaipcaabaaaafaaaaaaegaobaaa
aeaaaaaaegiocaaaaaaaaaaaaoaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaa
hgapbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaa
adaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaafaaaaaabfaaaaabdiaaaaaipcaabaaaaeaaaaaa
fgbfbaaaafaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaakpcaabaaaaeaaaaaa
egiocaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaaeaaaaaaegiocaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaaegaobaaa
aeaaaaaaaaaaaaaipcaabaaaaeaaaaaaegaobaaaaeaaaaaaegiocaaaaaaaaaaa
amaaaaaadbaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaeaaaaaa
abaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaoaaaaah
dcaabaaaagaaaaaaegaabaaaaeaaaaaapgapbaaaaeaaaaaaaaaaaaakdcaabaaa
agaaaaaaegaabaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaagaaaaaaegaabaaaagaaaaaaeghobaaaadaaaaaaaagabaaa
aaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaagaaaaaa
baaaaaahicaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaefaaaaaj
pcaabaaaaeaaaaaapgapbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaaeaaaaaabaaaaaah
bcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaa
aeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaa
egbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaa
aeaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaadaaaaaapgapbaaaabaaaaaa
egiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaa
egacbaaaaeaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaaeaaaaaapgapbaaaabaaaaaaegacbaaaaeaaaaaadiaaaaaihcaabaaa
afaaaaaaegacbaaaafaaaaaapgipcaaaaaaaaaaaacaaaaaaaaaaaaajicaabaaa
abaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadpdcaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaa
egacbaaaaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaa
acaaaaaadeaaaaakjcaabaaaacaaaaaaagambaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadeaaaaakjcaabaaaaaaaaaaaagambaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaaiecaabaaaaaaaaaaabkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaiaaaaaadcaaaaalccaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaa
abaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajccaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaa
bhlhnbdiaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaadkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaoaaaaahecaabaaaaaaaaaaaabeaaaaaaaaacaebckaabaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaa
akaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaaapaaaaahccaabaaaabaaaaaafgafbaaaabaaaaaapgapbaaaabaaaaaa
aaaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaalpdcaaaaaj
icaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
dcaaaaajbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
diaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
gcaabaaaaaaaaaaapgapbaaaacaaaaaafgahbaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaahocaabaaaaaaaaaaaagajbaaa
adaaaaaafgafbaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
aaaaaaamhcaabaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaa
acaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
aaaaaaaajgahbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaafaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaackbabaaaabaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaagicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" "FOG_EXP" }
Matrix 0 [_LightMatrix0] 3
Vector 12 [_Color]
Float 11 [_Glossiness]
Vector 7 [_LightColor0]
Float 9 [_RainOpacity]
Float 10 [_Raining]
Vector 3 [_WorldSpaceCameraPos]
Vector 4 [_WorldSpaceLightPos0]
Vector 6 [unity_ColorSpaceDielectricSpec]
Vector 5 [unity_FogParams]
Vector 8 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_BumpMap] 2D 3
SetTexture 4 [_Rain] 2D 4
"ps_3_0
def c13, 0, 2, -1, 1
def c14, 9.99999975e-005, 0.967999995, 0.0299999993, 10
def c15, -0.5, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.x
dcl_cube s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
add r0.xyz, c4, -v4
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
add r2.xyz, c3, -v4
nrm_pp r3.xyz, r2
mov r2.xw, c13
if_lt -c10.x, r2.x
texld r4, v0, s2
mul_pp r4, r4, c12
texld_pp r5, v0, s4
lrp_pp r6.xyz, r5.w, r5.x, r4
texld_pp r7, v0, s3
mad_pp r2.xy, r7.wyzw, c13.y, c13.z
dp2add_sat_pp r1.w, r2, r2, c13.x
add_pp r1.w, -r1.w, c13.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
lrp r4.xyz, r5.w, c13.xxww, r2
nrm_pp r2.xyz, r4
mad_pp oC0.w, r5.w, c9.x, r4.w
else
texld r4, v0, s2
mul_pp r6, r4, c12
texld_pp r4, v0, s3
mad_pp r2.xy, r4.wyzw, c13.y, c13.z
dp2add_sat_pp r1.w, r2, r2, c13.x
add_pp r1.w, -r1.w, c13.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
mov_pp oC0.w, r6.w
endif
mad r4, v4.xyzx, c13.wwwx, c13.xxxw
dp4 r5.x, c0, r4
dp4 r5.y, c1, r4
dp4 r5.z, c2, r4
dp3 r1.w, r5, r5
texld r4, r1.w, s1
texld r5, r5, s0
mul_pp r1.w, r4.x, r5.w
dp3_pp r4.x, v1, r2
dp3_pp r4.y, v2, r2
dp3_pp r4.z, v3, r2
dp3_pp r2.x, r4, r1
max_pp r3.w, r2.x, c13.x
mul_pp r2.xyz, r1.w, c7
nrm_pp r5.xyz, r4
mul_pp r4.xyz, r6, c6.w
add_pp r1.w, r2.w, -c11.x
mad_pp r0.xyz, r0, r0.w, r3
nrm_pp r6.xyz, r0
dp3_pp r0.x, r5, r6
max_pp r4.w, r0.x, c13.x
dp3_pp r0.x, r5, r3
max_pp r3.x, r0.x, c13.x
dp3_pp r0.x, r1, r6
max_pp r1.x, r0.x, c13.x
mul_pp r0.x, r1.w, r1.w
mul_pp r0.y, r0.x, c8.w
mad_pp r0.x, r0.x, -c8.w, r2.w
mad_pp r0.z, r3.w, r0.x, r0.y
mad_pp r0.x, r3.x, r0.x, r0.y
mad r0.x, r0.z, r0.x, c14.x
rcp_pp r0.x, r0.x
add_pp r0.y, -r1.w, c13.w
mad_pp r0.y, r0.y, c14.y, c14.z
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c14.w
mul_pp r0.z, r0.y, r0.y
mad_pp r0.y, r0.y, r0.y, c13.w
mul_pp r0.y, r0.y, c8.y
pow_pp r1.y, r4.w, r0.z
mul_pp r0.y, r0.y, r1.y
add_pp r0.z, -r3.w, c13.w
mul_pp r0.w, r0.z, r0.z
mul_pp r0.w, r0.w, r0.w
mul_pp r0.z, r0.z, r0.w
add_pp r0.w, -r3.x, c13.w
mul_pp r1.y, r0.w, r0.w
mul_pp r1.y, r1.y, r1.y
mul_pp r0.w, r0.w, r1.y
mul_pp r1.y, r1.x, r1.x
dp2add_pp r1.y, r1.y, r1.w, c15.x
mad_pp r0.z, r1.y, r0.z, c13.w
mad_pp r0.w, r1.y, r0.w, c13.w
mul_pp r0.xz, r0.yyww, r0
mul_pp r0.x, r3.w, r0.x
mul_pp r0.x, r0.x, c8.x
max_pp r1.y, r0.x, c13.x
mul_pp r0.x, r3.w, r0.z
mul_pp r0.xyz, r0.x, r2
mul_pp r1.yzw, r2.xxyz, r1.y
add_pp r0.w, -r1.x, c13.w
mul_pp r1.x, r0.w, r0.w
mul_pp r1.x, r1.x, r1.x
mul_pp r0.w, r0.w, r1.x
lrp_pp r3.xyz, r0.w, r2.w, c6
mul_pp r1.xyz, r1.yzww, r3
mad_pp r0.xyz, r4, r0, r1
mul r0.w, c5.y, v5.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_Rain] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Float 208 [_RainOpacity]
Float 212 [_Raining]
Float 216 [_Glossiness]
Vector 224 [_Color]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityFog" 3
"ps_4_0
eefiecedmiofdkpbohgmmjmfmijmpnehmeobmeeoabaaaaaadebaaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpmaoaaaaeaaaaaaalpadaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaae
aahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacahaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaiaebaaaaaaafaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
acaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaadbaaaaaiicaabaaaabaaaaaaabeaaaaaaaaaaaaabkiacaaa
aaaaaaaaanaaaaaabpaaaeaddkaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaipcaabaaa
adaaaaaaegaobaaaadaaaaaaegiocaaaaaaaaaaaaoaaaaaaefaaaaajpcaabaaa
aeaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaaaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaaeaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaacaaaaaadkaabaaaaeaaaaaaakaabaaaaeaaaaaadcaaaaajhcaabaaa
afaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaapgapbaaaacaaaaaaefaaaaaj
pcaabaaaagaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaa
dcaaaaapdcaabaaaadaaaaaahgapbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaacaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaa
dkaabaaaacaaaaaadiaaaaakhcaabaaaaeaaaaaapgapbaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
adaaaaaapgapbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
dcaaaaakiccabaaaaaaaaaaadkaabaaaaeaaaaaaakiacaaaaaaaaaaaanaaaaaa
dkaabaaaadaaaaaabcaaaaabefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaipcaabaaaafaaaaaaegaobaaa
aeaaaaaaegiocaaaaaaaaaaaaoaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaa
hgapbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaa
adaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaafaaaaaabfaaaaabdiaaaaaihcaabaaaaeaaaaaa
fgbfbaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaaeaaaaaa
egiccaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegacbaaaaeaaaaaadcaaaaak
hcaabaaaaeaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaaegacbaaa
aeaaaaaaaaaaaaaihcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaa
amaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
efaaaaajpcaabaaaagaaaaaapgapbaaaabaaaaaaeghobaaaadaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaaegacbaaaaeaaaaaaeghobaaaaeaaaaaa
aagabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaaeaaaaaaakaabaaa
agaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaa
baaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaah
ecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaadaaaaaa
pgapbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaabaaaaaaegacbaaaaeaaaaaa
diaaaaaihcaabaaaafaaaaaaegacbaaaafaaaaaapgipcaaaaaaaaaaaacaaaaaa
aaaaaaajicaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaa
aaaaiadpdcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaadeaaaaakjcaabaaaacaaaaaaagambaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadeaaaaakjcaabaaaaaaaaaaaagambaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaiecaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalccaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaiadp
dcaaaaajbcaabaaaabaaaaaadkaabaaaacaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaa
aaaaaaaaabeaaaaabhlhnbdiaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaa
dkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaoaaaaahecaabaaaaaaaaaaaabeaaaaaaaaacaeb
ckaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
aaaaaaaaaiaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaacaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaai
bcaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaah
ccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaaapaaaaahccaabaaaabaaaaaafgafbaaaabaaaaaa
pgapbaaaabaaaaaaaaaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaalpdcaaaaajicaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahgcaabaaaaaaaaaaapgapbaaaacaaaaaafgahbaaaaaaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaa
deaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaahocaabaaa
aaaaaaaaagajbaaaadaaaaaafgafbaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaabaaaaaaaaaaaaamhcaabaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaakhcaabaaa
acaaaaaaegacbaaaacaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaa
diaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaackbabaaaabaaaaaabkiacaaaadaaaaaaabaaaaaa
bjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" "FOG_EXP" }
Matrix 0 [_LightMatrix0] 2
Vector 11 [_Color]
Float 10 [_Glossiness]
Vector 6 [_LightColor0]
Float 8 [_RainOpacity]
Float 9 [_Raining]
Vector 2 [_WorldSpaceCameraPos]
Vector 3 [_WorldSpaceLightPos0]
Vector 5 [unity_ColorSpaceDielectricSpec]
Vector 4 [unity_FogParams]
Vector 7 [unity_LightGammaCorrectionConsts]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_Rain] 2D 3
"ps_3_0
def c12, 0, 2, -1, 1
def c13, 9.99999975e-005, 0.967999995, 0.0299999993, 10
def c14, -0.5, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
add r0.xyz, c2, -v4
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul_pp r1.xyz, r0.w, r0
mov r2.xw, c12
if_lt -c9.x, r2.x
texld r3, v0, s1
mul_pp r3, r3, c11
texld_pp r4, v0, s3
lrp_pp r5.xyz, r4.w, r4.x, r3
texld_pp r6, v0, s2
mad_pp r2.xy, r6.wyzw, c12.y, c12.z
dp2add_sat_pp r1.w, r2, r2, c12.x
add_pp r1.w, -r1.w, c12.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
lrp r3.xyz, r4.w, c12.xxww, r2
nrm_pp r2.xyz, r3
mad_pp oC0.w, r4.w, c8.x, r3.w
else
texld r3, v0, s1
mul_pp r5, r3, c11
texld_pp r3, v0, s2
mad_pp r2.xy, r3.wyzw, c12.y, c12.z
dp2add_sat_pp r1.w, r2, r2, c12.x
add_pp r1.w, -r1.w, c12.w
rsq_pp r1.w, r1.w
rcp_pp r2.z, r1.w
mov_pp oC0.w, r5.w
endif
mad r3, v4.xyzx, c12.wwwx, c12.xxxw
dp4 r4.x, c0, r3
dp4 r4.y, c1, r3
texld_pp r3, r4, s0
dp3_pp r3.x, v1, r2
dp3_pp r3.y, v2, r2
dp3_pp r3.z, v3, r2
dp3_pp r1.w, r3, c3
max_pp r2.x, r1.w, c12.x
mul_pp r4.xyz, r3.w, c6
nrm_pp r6.xyz, r3
mul_pp r3.xyz, r5, c5.w
add_pp r1.w, r2.w, -c10.x
mad_pp r0.xyz, r0, r0.w, c3
nrm_pp r5.xyz, r0
dp3_pp r0.x, r6, r5
max_pp r2.y, r0.x, c12.x
dp3_pp r0.x, r6, r1
max_pp r1.x, r0.x, c12.x
dp3_pp r0.x, c3, r5
max_pp r1.y, r0.x, c12.x
mul_pp r0.x, r1.w, r1.w
mul_pp r0.y, r0.x, c7.w
mad_pp r0.x, r0.x, -c7.w, r2.w
mad_pp r0.z, r2.x, r0.x, r0.y
mad_pp r0.x, r1.x, r0.x, r0.y
mad r0.x, r0.z, r0.x, c13.x
rcp_pp r0.x, r0.x
add_pp r0.y, -r1.w, c12.w
mad_pp r0.y, r0.y, c13.y, c13.z
log_pp r0.y, r0.y
rcp r0.y, r0.y
mul_pp r0.y, r0.y, c13.w
mul_pp r0.z, r0.y, r0.y
mad_pp r0.y, r0.y, r0.y, c12.w
mul_pp r0.y, r0.y, c7.y
pow_pp r1.z, r2.y, r0.z
add_pp r0.z, -r2.x, c12.w
mul_pp r0.w, r0.z, r0.z
mul_pp r0.w, r0.w, r0.w
mul_pp r0.z, r0.z, r0.w
add_pp r0.w, -r1.x, c12.w
mul_pp r1.x, r0.w, r0.w
mul_pp r1.x, r1.x, r1.x
mul_pp r0.yw, r0, r1.xzzx
mul_pp r1.x, r1.y, r1.y
dp2add_pp r1.x, r1.x, r1.w, c14.x
mad_pp r0.z, r1.x, r0.z, c12.w
mad_pp r0.w, r1.x, r0.w, c12.w
mul_pp r0.xz, r0.yyww, r0
mul_pp r0.x, r2.x, r0.x
mul_pp r0.x, r0.x, c7.x
max_pp r1.x, r0.x, c12.x
mul_pp r0.x, r2.x, r0.z
mul_pp r0.xyz, r0.x, r4
mul_pp r1.xzw, r4.xyyz, r1.x
add_pp r0.w, -r1.y, c12.w
mul_pp r1.y, r0.w, r0.w
mul_pp r1.y, r1.y, r1.y
mul_pp r0.w, r0.w, r1.y
lrp_pp r4.xyz, r0.w, r2.w, c5
mul_pp r1.xyz, r1.xzww, r4
mad_pp r0.xyz, r3, r0, r1
mul r0.w, c4.y, v5.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Rain] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 32 [unity_ColorSpaceDielectricSpec]
Vector 96 [_LightColor0]
Vector 128 [unity_LightGammaCorrectionConsts]
Float 208 [_RainOpacity]
Float 212 [_Raining]
Float 216 [_Glossiness]
Vector 224 [_Color]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityFog" 3
"ps_4_0
eefiecedkdaahcodofoobfjfgkggcibpaehdffocabaaaaaafiapaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccaaoaaaaeaaaaaaaiiadaaaa
fjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
ecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacagaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaiaebaaaaaa
afaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadbaaaaai
icaabaaaabaaaaaaabeaaaaaaaaaaaaabkiacaaaaaaaaaaaanaaaaaabpaaaead
dkaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaa
egiocaaaaaaaaaaaaoaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaia
ebaaaaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaadaaaaaadkaabaaa
adaaaaaaakaabaaaadaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaaacaaaaaa
pgapbaaaabaaaaaaagaabaaaadaaaaaaefaaaaajpcaabaaaafaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaacaaaaaa
hgapbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaadaaaaaaegaabaaa
acaaaaaaegaabaaaacaaaaaaddaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaiadpaaaaaaaibcaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaak
hcaabaaaadaaaaaapgapbaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadp
aaaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaa
dkaabaaaadaaaaaaakiacaaaaaaaaaaaanaaaaaadkaabaaaacaaaaaabcaaaaab
efaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaaipcaabaaaaeaaaaaaegaobaaaadaaaaaaegiocaaaaaaaaaaa
aoaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaadaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaa
ddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaacaaaaaadkaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aeaaaaaabfaaaaabdiaaaaaidcaabaaaadaaaaaafgbfbaaaafaaaaaaegiacaaa
aaaaaaaaakaaaaaadcaaaaakdcaabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaa
agbabaaaafaaaaaaegaabaaaadaaaaaadcaaaaakdcaabaaaadaaaaaaegiacaaa
aaaaaaaaalaaaaaakgbkbaaaafaaaaaaegaabaaaadaaaaaaaaaaaaaidcaabaaa
adaaaaaaegaabaaaadaaaaaaegiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaadaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaabaaaaaah
bcaabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaa
adaaaaaaegbcbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaadaaaaaa
egbcbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaaiicaabaaaabaaaaaaegacbaaa
adaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaa
adaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaacaaaaaaegacbaaaadaaaaaadiaaaaai
hcaabaaaaeaaaaaaegacbaaaaeaaaaaapgipcaaaaaaaaaaaacaaaaaaaaaaaaaj
icaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaaanaaaaaaabeaaaaaaaaaiadp
dcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaabaaaaaadeaaaaakjcaabaaaabaaaaaaagambaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabaaaaaaibcaabaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaaegacbaaaaaaaaaaadeaaaaakjcaabaaaaaaaaaaa
agambaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaaiecaabaaa
aaaaaaaabkaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaalccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaiadpdcaaaaajccaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaaaaaaaaaabeaaaaabhlhnbdiaoaaaaakccaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaanjmohhdpabeaaaaaipmcpfdmcpaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaahecaabaaaaaaaaaaaabeaaaaa
aaaacaebckaabaaaaaaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaapaaaaahccaabaaaabaaaaaafgafbaaa
abaaaaaapgapbaaaacaaaaaaaaaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaaalpdcaaaaajicaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdcaaaaajbcaabaaaabaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahkcaabaaaaaaaaaaafganbaaaaaaaaaaa
pgadbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaaiaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaah
ocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
abaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkaabaaaabaaaaaaaaaaaaamhcaabaaaacaaaaaaegiccaiaebaaaaaa
aaaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaak
hcaabaaaacaaaaaaegacbaaaacaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaackbabaaaabaaaaaabkiacaaaadaaaaaa
abaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadoaaaaab"
}
}
 }
}
Fallback "Diffuse"
}