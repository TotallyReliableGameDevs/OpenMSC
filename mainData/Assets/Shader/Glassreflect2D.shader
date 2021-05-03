Shader "Car/GlassReflect2DNew" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
 _MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" { }
 _Cube ("Reflection Cubemap", CUBE) = "_Skybox" { }
 _BumpMap ("Bumpmap (RGB Trans)", 2D) = "bump" { }
 _2DReflection ("Reflection (RGB)", CUBE) = "grey" { }
 _FresnelPower ("_FresnelPower", Range(0.05,5)) = 0.75
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" }
  ZWrite Off
  Blend One OneMinusSrcAlpha
  ColorMask RGB
  GpuProgramID 56732
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
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
uniform vec4 _Color;
uniform vec4 _ReflectColor;
uniform float _FresnelPower;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - tmpvar_3));
  vec3 tmpvar_5;
  tmpvar_5 = -(tmpvar_4);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8 = ((textureCube (_Cube, (tmpvar_5 - 
    (2.0 * (dot (tmpvar_7, tmpvar_5) * tmpvar_7))
  )).xyz * _ReflectColor.xyz) + (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz);
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = worldN_1;
  vec3 x1_10;
  x1_10.x = dot (unity_SHAr, tmpvar_9);
  x1_10.y = dot (unity_SHAg, tmpvar_9);
  x1_10.z = dot (unity_SHAb, tmpvar_9);
  vec4 c_11;
  vec4 c_12;
  c_12.xyz = ((tmpvar_8 * _LightColor0.xyz) * max (0.0, dot (worldN_1, _WorldSpaceLightPos0.xyz)));
  c_12.w = max ((0.20373 + (0.79627 * 
    pow (clamp ((1.0 - max (
      dot (normalize(((
        (xlv_TEXCOORD1.xyz * tmpvar_4.x)
       + 
        (xlv_TEXCOORD2.xyz * tmpvar_4.y)
      ) + (xlv_TEXCOORD3.xyz * tmpvar_4.z))), normalize(normal_6))
    , 0.0)), 0.0, 1.0), _FresnelPower)
  )), 0.0);
  c_11.w = c_12.w;
  c_11.xyz = (c_12.xyz + (tmpvar_8 * (xlv_TEXCOORD4 + x1_10)));
  c_2.w = c_11.w;
  c_2.xyz = (c_11.xyz + (tmpvar_8 * 0.25));
  gl_FragData[0] = c_2;
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
ConstBuffer "$Globals" 272
Vector 256 [_MainTex_ST]
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
eefieceddbblbcihckhhnhccihadeaflmioebnmfabaaaaaanmaiaaaaadaaaaaa
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
liabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaa
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
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaabaaaaaaaogikcaaa
aaaaaaaabaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaa
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
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
uniform vec4 _Color;
uniform vec4 _ReflectColor;
uniform float _FresnelPower;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - tmpvar_3));
  vec3 tmpvar_5;
  tmpvar_5 = -(tmpvar_4);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8 = ((textureCube (_Cube, (tmpvar_5 - 
    (2.0 * (dot (tmpvar_7, tmpvar_5) * tmpvar_7))
  )).xyz * _ReflectColor.xyz) + (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz);
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = worldN_1;
  vec3 x1_10;
  x1_10.x = dot (unity_SHAr, tmpvar_9);
  x1_10.y = dot (unity_SHAg, tmpvar_9);
  x1_10.z = dot (unity_SHAb, tmpvar_9);
  vec4 c_11;
  vec4 c_12;
  c_12.xyz = ((tmpvar_8 * _LightColor0.xyz) * max (0.0, dot (worldN_1, _WorldSpaceLightPos0.xyz)));
  c_12.w = max ((0.20373 + (0.79627 * 
    pow (clamp ((1.0 - max (
      dot (normalize(((
        (xlv_TEXCOORD1.xyz * tmpvar_4.x)
       + 
        (xlv_TEXCOORD2.xyz * tmpvar_4.y)
      ) + (xlv_TEXCOORD3.xyz * tmpvar_4.z))), normalize(normal_6))
    , 0.0)), 0.0, 1.0), _FresnelPower)
  )), 0.0);
  c_11.w = c_12.w;
  c_11.xyz = (c_12.xyz + (tmpvar_8 * (xlv_TEXCOORD4 + x1_10)));
  c_2.w = c_11.w;
  c_2.xyz = (c_11.xyz + (tmpvar_8 * 0.25));
  gl_FragData[0] = c_2;
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
ConstBuffer "$Globals" 272
Vector 256 [_MainTex_ST]
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
eefiecedicjfgnjdijkkpjmljgbkbpfbophomjkiabaaaaaajealaaaaadaaaaaa
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
ggacaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaa
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
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaabaaaaaaaogikcaaa
aaaaaaaabaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaabaaaaaajgiecaaa
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
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
uniform vec4 _Color;
uniform vec4 _ReflectColor;
uniform float _FresnelPower;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - tmpvar_3));
  vec3 tmpvar_5;
  tmpvar_5 = -(tmpvar_4);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8 = ((textureCube (_Cube, (tmpvar_5 - 
    (2.0 * (dot (tmpvar_7, tmpvar_5) * tmpvar_7))
  )).xyz * _ReflectColor.xyz) + (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz);
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = worldN_1;
  vec3 x1_10;
  x1_10.x = dot (unity_SHAr, tmpvar_9);
  x1_10.y = dot (unity_SHAg, tmpvar_9);
  x1_10.z = dot (unity_SHAb, tmpvar_9);
  vec4 c_11;
  vec4 c_12;
  c_12.xyz = ((tmpvar_8 * _LightColor0.xyz) * max (0.0, dot (worldN_1, _WorldSpaceLightPos0.xyz)));
  c_12.w = max ((0.20373 + (0.79627 * 
    pow (clamp ((1.0 - max (
      dot (normalize(((
        (xlv_TEXCOORD1.xyz * tmpvar_4.x)
       + 
        (xlv_TEXCOORD2.xyz * tmpvar_4.y)
      ) + (xlv_TEXCOORD3.xyz * tmpvar_4.z))), normalize(normal_6))
    , 0.0)), 0.0, 1.0), _FresnelPower)
  )), 0.0);
  c_11.w = c_12.w;
  c_11.xyz = (c_12.xyz + (tmpvar_8 * (xlv_TEXCOORD4 + x1_10)));
  c_2.w = c_11.w;
  c_2.xyz = (c_11.xyz + (tmpvar_8 * 0.25));
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = c_2;
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
ConstBuffer "$Globals" 272
Vector 256 [_MainTex_ST]
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
eefiecedchlabikfbenndafnpnigkdhhjlfcgignabaaaaaaciajaaaaadaaaaaa
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
egiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaae
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
aaaaaaaabaaaaaaaogikcaaaaaaaaaaabaaaaaaadiaaaaaibcaabaaaaaaaaaaa
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
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
uniform vec4 _Color;
uniform vec4 _ReflectColor;
uniform float _FresnelPower;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec3 tmpvar_4;
  tmpvar_4 = normalize((_WorldSpaceCameraPos - tmpvar_3));
  vec3 tmpvar_5;
  tmpvar_5 = -(tmpvar_4);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8 = ((textureCube (_Cube, (tmpvar_5 - 
    (2.0 * (dot (tmpvar_7, tmpvar_5) * tmpvar_7))
  )).xyz * _ReflectColor.xyz) + (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz);
  worldN_1.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  worldN_1.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  worldN_1.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = worldN_1;
  vec3 x1_10;
  x1_10.x = dot (unity_SHAr, tmpvar_9);
  x1_10.y = dot (unity_SHAg, tmpvar_9);
  x1_10.z = dot (unity_SHAb, tmpvar_9);
  vec4 c_11;
  vec4 c_12;
  c_12.xyz = ((tmpvar_8 * _LightColor0.xyz) * max (0.0, dot (worldN_1, _WorldSpaceLightPos0.xyz)));
  c_12.w = max ((0.20373 + (0.79627 * 
    pow (clamp ((1.0 - max (
      dot (normalize(((
        (xlv_TEXCOORD1.xyz * tmpvar_4.x)
       + 
        (xlv_TEXCOORD2.xyz * tmpvar_4.y)
      ) + (xlv_TEXCOORD3.xyz * tmpvar_4.z))), normalize(normal_6))
    , 0.0)), 0.0, 1.0), _FresnelPower)
  )), 0.0);
  c_11.w = c_12.w;
  c_11.xyz = (c_12.xyz + (tmpvar_8 * (xlv_TEXCOORD4 + x1_10)));
  c_2.w = c_11.w;
  c_2.xyz = (c_11.xyz + (tmpvar_8 * 0.25));
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = c_2;
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
ConstBuffer "$Globals" 272
Vector 256 [_MainTex_ST]
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
eefiecedepgmgkjjhnfpegijhdilgkpobgchennfabaaaaaaoaalaaaaadaaaaaa
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
egiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaae
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
aaaaaaaabaaaaaaaogikcaaaaaaaaaaabaaaaaaadiaaaaaihcaabaaaaaaaaaaa
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
Vector 6 [_Color]
Float 8 [_FresnelPower]
Vector 5 [_LightColor0]
Vector 7 [_ReflectColor]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 4 [unity_SHAb]
Vector 3 [unity_SHAg]
Vector 2 [unity_SHAr]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
"ps_3_0
def c9, 2, -1, 0, 1
def c10, 0.796270013, 0.203730002, 0.25, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4_pp v4.xyz
dcl_2d s0
dcl_2d s1
dcl_cube s2
mov r0.x, v1.w
mov r0.y, v2.w
mov r0.z, v3.w
add r0.xyz, -r0, c0
nrm_pp r1.xyz, r0
mul r0.xyz, r1.y, v2
mad r0.xyz, v1, r1.x, r0
mad_pp r0.xyz, v3, r1.z, r0
nrm r2.xyz, r0
texld_pp r0, v0, s1
mad_pp r0.xy, r0.wyzw, c9.x, c9.y
dp2add_sat_pp r0.w, r0, r0, c9.z
add_pp r0.w, -r0.w, c9.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
nrm r3.xyz, r0
dp3 r0.w, r2, r3
add r1.w, -r0.w, c9.w
cmp r0.w, r0.w, r1.w, c9.w
max r1.w, r0.w, c9.z
pow r0.w, r1.w, c8.x
mad_pp oC0.w, r0.w, c10.x, c10.y
dp3 r2.x, v1, r0
dp3 r2.y, v2, r0
dp3 r2.z, v3, r0
mov r2.w, c9.w
dp4_pp r0.x, c2, r2
dp4_pp r0.y, c3, r2
dp4_pp r0.z, c4, r2
add_pp r0.xyz, r0, v4
dp3 r0.w, -r1, r2
add r0.w, r0.w, r0.w
mad_pp r1.xyz, r2, -r0.w, -r1
dp3_pp r0.w, r2, c1
max_pp r1.w, r0.w, c9.z
texld_pp r2, r1, s2
texld_pp r3, v0, s0
mul_pp r1.xyz, r3, c6
mad_pp r1.xyz, r2, c7, r1
mul_pp r0.xyz, r0, r1
mul_pp r2.xyz, r1, c5
mad_pp r0.xyz, r2, r1.w, r0
mad_pp oC0.xyz, r1, c10.z, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
ConstBuffer "$Globals" 272
Vector 96 [_LightColor0]
Vector 208 [_Color]
Vector 224 [_ReflectColor]
Float 240 [_FresnelPower]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedflbilfbpchleiijfbabpbhklcmjnafhlabaaaaaabeaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmagaaaaeaaaaaaalhabaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaacjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadgaaaaafbcaabaaa
abaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaabaaaaaadkbabaaaadaaaaaa
dgaaaaafecaabaaaabaaaaaadkbabaaaaeaaaaaaaaaaaaajhcaabaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaa
ddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaacaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaadaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaadaaaaaaegbcbaaaadaaaaaa
egacbaaaacaaaaaabaaaaaahecaabaaaadaaaaaaegbcbaaaaeaaaaaaegacbaaa
acaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
adaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaalhcaabaaaaeaaaaaaegacbaaaadaaaaaapgapbaiaebaaaaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegacbaaaaeaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaa
aeaaaaaaegiccaaaaaaaaaaaaoaaaaaaegacbaaaaaaaaaaadgaaaaaficaabaaa
adaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaadaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaaaadaaaaaa
egiccaaaacaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaaeaaaaaaegbcbaaa
afaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaa
diaaaaaihcaabaaaaeaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
dcaaaaajhcaabaaaadaaaaaaegacbaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaa
adaaaaaadcaaaaamhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiado
aaaaiadoaaaaiadoaaaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaafgafbaaaabaaaaaaegbcbaaaadaaaaaadcaaaaaj
lcaabaaaabaaaaaaegbibaaaacaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaa
dcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaakgakbaaaabaaaaaaegadbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaapaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajiccabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaafknieldpabeaaaaajjjofadodoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Vector 8 [_Color]
Float 10 [_FresnelPower]
Vector 7 [_LightColor0]
Vector 9 [_ReflectColor]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 5 [unity_FogColor]
Vector 6 [unity_FogParams]
Vector 4 [unity_SHAb]
Vector 3 [unity_SHAg]
Vector 2 [unity_SHAr]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
"ps_3_0
def c11, 2, -1, 0, 1
def c12, 0.796270013, 0.203730002, 0.25, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4_pp v4.xyz
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_cube s2
mov r0.x, v1.w
mov r0.y, v2.w
mov r0.z, v3.w
add r0.xyz, -r0, c0
nrm_pp r1.xyz, r0
mul r0.xyz, r1.y, v2
mad r0.xyz, v1, r1.x, r0
mad_pp r0.xyz, v3, r1.z, r0
nrm r2.xyz, r0
texld_pp r0, v0, s1
mad_pp r0.xy, r0.wyzw, c11.x, c11.y
dp2add_sat_pp r0.w, r0, r0, c11.z
add_pp r0.w, -r0.w, c11.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
nrm r3.xyz, r0
dp3 r0.w, r2, r3
add r1.w, -r0.w, c11.w
cmp r0.w, r0.w, r1.w, c11.w
max r1.w, r0.w, c11.z
pow r0.w, r1.w, c10.x
mad_pp oC0.w, r0.w, c12.x, c12.y
dp3 r2.x, v1, r0
dp3 r2.y, v2, r0
dp3 r2.z, v3, r0
mov r2.w, c11.w
dp4_pp r0.x, c2, r2
dp4_pp r0.y, c3, r2
dp4_pp r0.z, c4, r2
add_pp r0.xyz, r0, v4
dp3 r0.w, -r1, r2
add r0.w, r0.w, r0.w
mad_pp r1.xyz, r2, -r0.w, -r1
dp3_pp r0.w, r2, c1
max_pp r1.w, r0.w, c11.z
texld_pp r2, r1, s2
texld_pp r3, v0, s0
mul_pp r1.xyz, r3, c8
mad_pp r1.xyz, r2, c9, r1
mul_pp r0.xyz, r0, r1
mul_pp r2.xyz, r1, c7
mad_pp r0.xyz, r2, r1.w, r0
mad_pp r0.xyz, r1, c12.z, r0
add r0.xyz, r0, -c5
mul r0.w, c6.y, v5.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c5

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
ConstBuffer "$Globals" 272
Vector 96 [_LightColor0]
Vector 208 [_Color]
Vector 224 [_ReflectColor]
Float 240 [_FresnelPower]
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
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityFog" 3
"ps_4_0
eefiecedfhjphlhnhiffkekgacgmlijbgphpgjnpabaaaaaaoiaiaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcjiahaaaaeaaaaaaaogabaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaacjaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaanaaaaaadgaaaaafbcaabaaaabaaaaaadkbabaaaacaaaaaa
dgaaaaafccaabaaaabaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
dkbabaaaaeaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaa
baaaaaahccaabaaaadaaaaaaegbcbaaaadaaaaaaegacbaaaacaaaaaabaaaaaah
ecaabaaaadaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaaiicaabaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaadaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaalhcaabaaaaeaaaaaa
egacbaaaadaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaaegacbaaaaeaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaa
aoaaaaaaegacbaaaaaaaaaaadgaaaaaficaabaaaadaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaadaaaaaa
bbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaadaaaaaa
bbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaadaaaaaa
baaaaaaiicaabaaaaaaaaaaaegacbaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
hcaabaaaadaaaaaaegacbaaaaeaaaaaaegbcbaaaafaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaaihcaabaaaaeaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaadcaaaaajhcaabaaaadaaaaaa
egacbaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaaaaa
egacbaaaadaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaadaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaackbabaaaabaaaaaa
bkiacaaaadaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
dcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
adaaaaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
fgafbaaaabaaaaaaegbcbaaaadaaaaaadcaaaaajlcaabaaaabaaaaaaegbibaaa
acaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egbcbaaaaeaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaapaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajiccabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaafknieldpabeaaaaa
jjjofadodoaaaaab"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent" }
  ZWrite Off
  Blend One One
  ColorMask RGB
  GpuProgramID 73757
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" }
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
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
uniform vec4 _Color;
uniform vec4 _ReflectColor;
uniform float _FresnelPower;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 worldN_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_3;
  tmpvar_3 = -(tmpvar_2);
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5.x = dot (xlv_TEXCOORD1, normal_4);
  tmpvar_5.y = dot (xlv_TEXCOORD2, normal_4);
  tmpvar_5.z = dot (xlv_TEXCOORD3, normal_4);
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD4;
  vec3 tmpvar_7;
  tmpvar_7 = (_LightMatrix0 * tmpvar_6).xyz;
  worldN_1.x = dot (xlv_TEXCOORD1, normal_4);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_4);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_4);
  vec4 c_8;
  vec4 c_9;
  c_9.xyz = (((
    (textureCube (_Cube, (tmpvar_3 - (2.0 * (
      dot (tmpvar_5, tmpvar_3)
     * tmpvar_5)))).xyz * _ReflectColor.xyz)
   + 
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz) * (_LightColor0.xyz * texture2D (_LightTexture0, vec2(
    dot (tmpvar_7, tmpvar_7)
  )).w)) * max (0.0, dot (worldN_1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4))
  )));
  c_9.w = max ((0.20373 + (0.79627 * 
    pow (clamp ((1.0 - max (
      dot (normalize(((
        (xlv_TEXCOORD1 * tmpvar_2.x)
       + 
        (xlv_TEXCOORD2 * tmpvar_2.y)
      ) + (xlv_TEXCOORD3 * tmpvar_2.z))), normalize(normal_4))
    , 0.0)), 0.0, 1.0), _FresnelPower)
  )), 0.0);
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
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
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 336
Vector 320 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedbeocldbnplgjfedphbcnoabeeamjlhljabaaaaaageahaaaaadaaaaaa
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
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaae
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
aaaaaaaabeaaaaaaogikcaaaaaaaaaaabeaaaaaadiaaaaaiccaabaaaaaaaaaaa
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
Keywords { "DIRECTIONAL" }
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
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
uniform vec4 _Color;
uniform vec4 _ReflectColor;
uniform float _FresnelPower;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 worldN_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_3;
  tmpvar_3 = -(tmpvar_2);
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5.x = dot (xlv_TEXCOORD1, normal_4);
  tmpvar_5.y = dot (xlv_TEXCOORD2, normal_4);
  tmpvar_5.z = dot (xlv_TEXCOORD3, normal_4);
  worldN_1.x = dot (xlv_TEXCOORD1, normal_4);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_4);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_4);
  vec4 c_6;
  vec4 c_7;
  c_7.xyz = (((
    (textureCube (_Cube, (tmpvar_3 - (2.0 * (
      dot (tmpvar_5, tmpvar_3)
     * tmpvar_5)))).xyz * _ReflectColor.xyz)
   + 
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz) * _LightColor0.xyz) * max (0.0, dot (worldN_1, _WorldSpaceLightPos0.xyz)));
  c_7.w = max ((0.20373 + (0.79627 * 
    pow (clamp ((1.0 - max (
      dot (normalize(((
        (xlv_TEXCOORD1 * tmpvar_2.x)
       + 
        (xlv_TEXCOORD2 * tmpvar_2.y)
      ) + (xlv_TEXCOORD3 * tmpvar_2.z))), normalize(normal_4))
    , 0.0)), 0.0, 1.0), _FresnelPower)
  )), 0.0);
  c_6.w = c_7.w;
  c_6.xyz = c_7.xyz;
  gl_FragData[0] = c_6;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
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
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 272
Vector 256 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednanlefkpciegiligeibadhigbclabcmfabaaaaaageahaaaaadaaaaaa
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
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaae
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
aaaaaaaabaaaaaaaogikcaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
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
Keywords { "SPOT" }
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
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
uniform vec4 _Color;
uniform vec4 _ReflectColor;
uniform float _FresnelPower;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 worldN_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_3;
  tmpvar_3 = -(tmpvar_2);
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5.x = dot (xlv_TEXCOORD1, normal_4);
  tmpvar_5.y = dot (xlv_TEXCOORD2, normal_4);
  tmpvar_5.z = dot (xlv_TEXCOORD3, normal_4);
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD4;
  vec4 tmpvar_7;
  tmpvar_7 = (_LightMatrix0 * tmpvar_6);
  worldN_1.x = dot (xlv_TEXCOORD1, normal_4);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_4);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_4);
  vec4 c_8;
  vec4 c_9;
  c_9.xyz = (((
    (textureCube (_Cube, (tmpvar_3 - (2.0 * (
      dot (tmpvar_5, tmpvar_3)
     * tmpvar_5)))).xyz * _ReflectColor.xyz)
   + 
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz) * (_LightColor0.xyz * 
    ((float((tmpvar_7.z > 0.0)) * texture2D (_LightTexture0, ((tmpvar_7.xy / tmpvar_7.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (tmpvar_7.xyz, tmpvar_7.xyz))).w)
  )) * max (0.0, dot (worldN_1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4))
  )));
  c_9.w = max ((0.20373 + (0.79627 * 
    pow (clamp ((1.0 - max (
      dot (normalize(((
        (xlv_TEXCOORD1 * tmpvar_2.x)
       + 
        (xlv_TEXCOORD2 * tmpvar_2.y)
      ) + (xlv_TEXCOORD3 * tmpvar_2.z))), normalize(normal_4))
    , 0.0)), 0.0, 1.0), _FresnelPower)
  )), 0.0);
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
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
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 336
Vector 320 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedbeocldbnplgjfedphbcnoabeeamjlhljabaaaaaageahaaaaadaaaaaa
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
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaae
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
aaaaaaaabeaaaaaaogikcaaaaaaaaaaabeaaaaaadiaaaaaiccaabaaaaaaaaaaa
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
Keywords { "POINT_COOKIE" }
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
uniform vec4 _LightColor0;
uniform samplerCube _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
uniform vec4 _Color;
uniform vec4 _ReflectColor;
uniform float _FresnelPower;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 worldN_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_3;
  tmpvar_3 = -(tmpvar_2);
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5.x = dot (xlv_TEXCOORD1, normal_4);
  tmpvar_5.y = dot (xlv_TEXCOORD2, normal_4);
  tmpvar_5.z = dot (xlv_TEXCOORD3, normal_4);
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD4;
  vec3 tmpvar_7;
  tmpvar_7 = (_LightMatrix0 * tmpvar_6).xyz;
  worldN_1.x = dot (xlv_TEXCOORD1, normal_4);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_4);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_4);
  vec4 c_8;
  vec4 c_9;
  c_9.xyz = (((
    (textureCube (_Cube, (tmpvar_3 - (2.0 * (
      dot (tmpvar_5, tmpvar_3)
     * tmpvar_5)))).xyz * _ReflectColor.xyz)
   + 
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz) * (_LightColor0.xyz * 
    (texture2D (_LightTextureB0, vec2(dot (tmpvar_7, tmpvar_7))).w * textureCube (_LightTexture0, tmpvar_7).w)
  )) * max (0.0, dot (worldN_1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4))
  )));
  c_9.w = max ((0.20373 + (0.79627 * 
    pow (clamp ((1.0 - max (
      dot (normalize(((
        (xlv_TEXCOORD1 * tmpvar_2.x)
       + 
        (xlv_TEXCOORD2 * tmpvar_2.y)
      ) + (xlv_TEXCOORD3 * tmpvar_2.z))), normalize(normal_4))
    , 0.0)), 0.0, 1.0), _FresnelPower)
  )), 0.0);
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  gl_FragData[0] = c_8;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
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
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 336
Vector 320 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedbeocldbnplgjfedphbcnoabeeamjlhljabaaaaaageahaaaaadaaaaaa
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
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaae
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
aaaaaaaabeaaaaaaogikcaaaaaaaaaaabeaaaaaadiaaaaaiccaabaaaaaaaaaaa
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
Keywords { "DIRECTIONAL_COOKIE" }
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
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
uniform vec4 _Color;
uniform vec4 _ReflectColor;
uniform float _FresnelPower;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec3 worldN_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_3;
  tmpvar_3 = -(tmpvar_2);
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5.x = dot (xlv_TEXCOORD1, normal_4);
  tmpvar_5.y = dot (xlv_TEXCOORD2, normal_4);
  tmpvar_5.z = dot (xlv_TEXCOORD3, normal_4);
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD4;
  worldN_1.x = dot (xlv_TEXCOORD1, normal_4);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_4);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_4);
  vec4 c_7;
  vec4 c_8;
  c_8.xyz = (((
    (textureCube (_Cube, (tmpvar_3 - (2.0 * (
      dot (tmpvar_5, tmpvar_3)
     * tmpvar_5)))).xyz * _ReflectColor.xyz)
   + 
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz) * (_LightColor0.xyz * texture2D (_LightTexture0, 
    (_LightMatrix0 * tmpvar_6)
  .xy).w)) * max (0.0, dot (worldN_1, _WorldSpaceLightPos0.xyz)));
  c_8.w = max ((0.20373 + (0.79627 * 
    pow (clamp ((1.0 - max (
      dot (normalize(((
        (xlv_TEXCOORD1 * tmpvar_2.x)
       + 
        (xlv_TEXCOORD2 * tmpvar_2.y)
      ) + (xlv_TEXCOORD3 * tmpvar_2.z))), normalize(normal_4))
    , 0.0)), 0.0, 1.0), _FresnelPower)
  )), 0.0);
  c_7.w = c_8.w;
  c_7.xyz = c_8.xyz;
  gl_FragData[0] = c_7;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
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
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 336
Vector 320 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedbeocldbnplgjfedphbcnoabeeamjlhljabaaaaaageahaaaaadaaaaaa
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
iaafaaaaeaaaabaagaabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaae
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
aaaaaaaabeaaaaaaogikcaaaaaaaaaaabeaaaaaadiaaaaaiccaabaaaaaaaaaaa
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
Keywords { "POINT" "FOG_EXP" }
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
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
uniform vec4 _Color;
uniform vec4 _ReflectColor;
uniform float _FresnelPower;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_4;
  tmpvar_4 = -(tmpvar_3);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_6;
  tmpvar_6.x = dot (xlv_TEXCOORD1, normal_5);
  tmpvar_6.y = dot (xlv_TEXCOORD2, normal_5);
  tmpvar_6.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = xlv_TEXCOORD4;
  vec3 tmpvar_8;
  tmpvar_8 = (_LightMatrix0 * tmpvar_7).xyz;
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_9;
  vec4 c_10;
  c_10.xyz = (((
    (textureCube (_Cube, (tmpvar_4 - (2.0 * (
      dot (tmpvar_6, tmpvar_4)
     * tmpvar_6)))).xyz * _ReflectColor.xyz)
   + 
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz) * (_LightColor0.xyz * texture2D (_LightTexture0, vec2(
    dot (tmpvar_8, tmpvar_8)
  )).w)) * max (0.0, dot (worldN_1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4))
  )));
  c_10.w = max ((0.20373 + (0.79627 * 
    pow (clamp ((1.0 - max (
      dot (normalize(((
        (xlv_TEXCOORD1 * tmpvar_3.x)
       + 
        (xlv_TEXCOORD2 * tmpvar_3.y)
      ) + (xlv_TEXCOORD3 * tmpvar_3.z))), normalize(normal_5))
    , 0.0)), 0.0, 1.0), _FresnelPower)
  )), 0.0);
  c_9.w = c_10.w;
  c_9.xyz = c_10.xyz;
  c_2.w = c_9.w;
  c_2.xyz = mix (vec3(0.0, 0.0, 0.0), c_10.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "FOG_EXP" }
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
Keywords { "POINT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 336
Vector 320 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmoihnccgnfbbomapleahgjgjpnglengnabaaaaaalaahaaaaadaaaaaa
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
gnabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaaeegiocaaaabaaaaaa
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
egbabaaaadaaaaaaegiacaaaaaaaaaaabeaaaaaaogikcaaaaaaaaaaabeaaaaaa
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
Keywords { "DIRECTIONAL" "FOG_EXP" }
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
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
uniform vec4 _Color;
uniform vec4 _ReflectColor;
uniform float _FresnelPower;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_4;
  tmpvar_4 = -(tmpvar_3);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_6;
  tmpvar_6.x = dot (xlv_TEXCOORD1, normal_5);
  tmpvar_6.y = dot (xlv_TEXCOORD2, normal_5);
  tmpvar_6.z = dot (xlv_TEXCOORD3, normal_5);
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_7;
  vec4 c_8;
  c_8.xyz = (((
    (textureCube (_Cube, (tmpvar_4 - (2.0 * (
      dot (tmpvar_6, tmpvar_4)
     * tmpvar_6)))).xyz * _ReflectColor.xyz)
   + 
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz) * _LightColor0.xyz) * max (0.0, dot (worldN_1, _WorldSpaceLightPos0.xyz)));
  c_8.w = max ((0.20373 + (0.79627 * 
    pow (clamp ((1.0 - max (
      dot (normalize(((
        (xlv_TEXCOORD1 * tmpvar_3.x)
       + 
        (xlv_TEXCOORD2 * tmpvar_3.y)
      ) + (xlv_TEXCOORD3 * tmpvar_3.z))), normalize(normal_5))
    , 0.0)), 0.0, 1.0), _FresnelPower)
  )), 0.0);
  c_7.w = c_8.w;
  c_7.xyz = c_8.xyz;
  c_2.w = c_7.w;
  c_2.xyz = mix (vec3(0.0, 0.0, 0.0), c_8.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
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
Keywords { "DIRECTIONAL" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 272
Vector 256 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedjfahemfjfpgfhhffjbkkpjmhmnjckgojabaaaaaalaahaaaaadaaaaaa
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
gnabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaa
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
egbabaaaadaaaaaaegiacaaaaaaaaaaabaaaaaaaogikcaaaaaaaaaaabaaaaaaa
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
Keywords { "SPOT" "FOG_EXP" }
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
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
uniform vec4 _Color;
uniform vec4 _ReflectColor;
uniform float _FresnelPower;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_4;
  tmpvar_4 = -(tmpvar_3);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_6;
  tmpvar_6.x = dot (xlv_TEXCOORD1, normal_5);
  tmpvar_6.y = dot (xlv_TEXCOORD2, normal_5);
  tmpvar_6.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = xlv_TEXCOORD4;
  vec4 tmpvar_8;
  tmpvar_8 = (_LightMatrix0 * tmpvar_7);
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_9;
  vec4 c_10;
  c_10.xyz = (((
    (textureCube (_Cube, (tmpvar_4 - (2.0 * (
      dot (tmpvar_6, tmpvar_4)
     * tmpvar_6)))).xyz * _ReflectColor.xyz)
   + 
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz) * (_LightColor0.xyz * 
    ((float((tmpvar_8.z > 0.0)) * texture2D (_LightTexture0, ((tmpvar_8.xy / tmpvar_8.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (tmpvar_8.xyz, tmpvar_8.xyz))).w)
  )) * max (0.0, dot (worldN_1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4))
  )));
  c_10.w = max ((0.20373 + (0.79627 * 
    pow (clamp ((1.0 - max (
      dot (normalize(((
        (xlv_TEXCOORD1 * tmpvar_3.x)
       + 
        (xlv_TEXCOORD2 * tmpvar_3.y)
      ) + (xlv_TEXCOORD3 * tmpvar_3.z))), normalize(normal_5))
    , 0.0)), 0.0, 1.0), _FresnelPower)
  )), 0.0);
  c_9.w = c_10.w;
  c_9.xyz = c_10.xyz;
  c_2.w = c_9.w;
  c_2.xyz = mix (vec3(0.0, 0.0, 0.0), c_10.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "FOG_EXP" }
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
Keywords { "SPOT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 336
Vector 320 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmoihnccgnfbbomapleahgjgjpnglengnabaaaaaalaahaaaaadaaaaaa
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
gnabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaaeegiocaaaabaaaaaa
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
egbabaaaadaaaaaaegiacaaaaaaaaaaabeaaaaaaogikcaaaaaaaaaaabeaaaaaa
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
Keywords { "POINT_COOKIE" "FOG_EXP" }
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
uniform vec4 _LightColor0;
uniform samplerCube _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
uniform vec4 _Color;
uniform vec4 _ReflectColor;
uniform float _FresnelPower;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_4;
  tmpvar_4 = -(tmpvar_3);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_6;
  tmpvar_6.x = dot (xlv_TEXCOORD1, normal_5);
  tmpvar_6.y = dot (xlv_TEXCOORD2, normal_5);
  tmpvar_6.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = xlv_TEXCOORD4;
  vec3 tmpvar_8;
  tmpvar_8 = (_LightMatrix0 * tmpvar_7).xyz;
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_9;
  vec4 c_10;
  c_10.xyz = (((
    (textureCube (_Cube, (tmpvar_4 - (2.0 * (
      dot (tmpvar_6, tmpvar_4)
     * tmpvar_6)))).xyz * _ReflectColor.xyz)
   + 
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz) * (_LightColor0.xyz * 
    (texture2D (_LightTextureB0, vec2(dot (tmpvar_8, tmpvar_8))).w * textureCube (_LightTexture0, tmpvar_8).w)
  )) * max (0.0, dot (worldN_1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4))
  )));
  c_10.w = max ((0.20373 + (0.79627 * 
    pow (clamp ((1.0 - max (
      dot (normalize(((
        (xlv_TEXCOORD1 * tmpvar_3.x)
       + 
        (xlv_TEXCOORD2 * tmpvar_3.y)
      ) + (xlv_TEXCOORD3 * tmpvar_3.z))), normalize(normal_5))
    , 0.0)), 0.0, 1.0), _FresnelPower)
  )), 0.0);
  c_9.w = c_10.w;
  c_9.xyz = c_10.xyz;
  c_2.w = c_9.w;
  c_2.xyz = mix (vec3(0.0, 0.0, 0.0), c_10.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
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
Keywords { "POINT_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 336
Vector 320 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmoihnccgnfbbomapleahgjgjpnglengnabaaaaaalaahaaaaadaaaaaa
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
gnabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaaeegiocaaaabaaaaaa
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
egbabaaaadaaaaaaegiacaaaaaaaaaaabeaaaaaaogikcaaaaaaaaaaabeaaaaaa
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
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
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
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform samplerCube _Cube;
uniform vec4 _Color;
uniform vec4 _ReflectColor;
uniform float _FresnelPower;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec3 worldN_1;
  vec4 c_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  vec3 tmpvar_4;
  tmpvar_4 = -(tmpvar_3);
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_6;
  tmpvar_6.x = dot (xlv_TEXCOORD1, normal_5);
  tmpvar_6.y = dot (xlv_TEXCOORD2, normal_5);
  tmpvar_6.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = xlv_TEXCOORD4;
  worldN_1.x = dot (xlv_TEXCOORD1, normal_5);
  worldN_1.y = dot (xlv_TEXCOORD2, normal_5);
  worldN_1.z = dot (xlv_TEXCOORD3, normal_5);
  vec4 c_8;
  vec4 c_9;
  c_9.xyz = (((
    (textureCube (_Cube, (tmpvar_4 - (2.0 * (
      dot (tmpvar_6, tmpvar_4)
     * tmpvar_6)))).xyz * _ReflectColor.xyz)
   + 
    (texture2D (_MainTex, xlv_TEXCOORD0) * _Color)
  .xyz) * (_LightColor0.xyz * texture2D (_LightTexture0, 
    (_LightMatrix0 * tmpvar_7)
  .xy).w)) * max (0.0, dot (worldN_1, _WorldSpaceLightPos0.xyz)));
  c_9.w = max ((0.20373 + (0.79627 * 
    pow (clamp ((1.0 - max (
      dot (normalize(((
        (xlv_TEXCOORD1 * tmpvar_3.x)
       + 
        (xlv_TEXCOORD2 * tmpvar_3.y)
      ) + (xlv_TEXCOORD3 * tmpvar_3.z))), normalize(normal_5))
    , 0.0)), 0.0, 1.0), _FresnelPower)
  )), 0.0);
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  c_2.w = c_8.w;
  c_2.xyz = mix (vec3(0.0, 0.0, 0.0), c_9.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
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
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord4
ConstBuffer "$Globals" 336
Vector 320 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmoihnccgnfbbomapleahgjgjpnglengnabaaaaaalaahaaaaadaaaaaa
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
gnabaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafjaaaaaeegiocaaaabaaaaaa
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
egbabaaaadaaaaaaegiacaaaaaaaaaaabeaaaaaaogikcaaaaaaaaaaabeaaaaaa
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
Keywords { "POINT" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Matrix 0 [_LightMatrix0] 3
Vector 6 [_Color]
Float 8 [_FresnelPower]
Vector 5 [_LightColor0]
Vector 7 [_ReflectColor]
Vector 3 [_WorldSpaceCameraPos]
Vector 4 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_Cube] CUBE 3
"ps_3_0
def c9, 2, -1, 0, 1
def c10, 0.796270013, 0.203730002, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
add r0.xyz, c3, -v4
nrm_pp r1.xyz, r0
mul_pp r0.xyz, r1.y, v2
mad_pp r0.xyz, v1, r1.x, r0
mad_pp r0.xyz, v3, r1.z, r0
nrm r2.xyz, r0
texld_pp r0, v0, s2
mad_pp r0.xy, r0.wyzw, c9.x, c9.y
dp2add_sat_pp r0.w, r0, r0, c9.z
add_pp r0.w, -r0.w, c9.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
nrm r3.xyz, r0
dp3 r0.w, r2, r3
add r1.w, -r0.w, c9.w
cmp r0.w, r0.w, r1.w, c9.w
max r1.w, r0.w, c9.z
pow r0.w, r1.w, c8.x
mad_pp oC0.w, r0.w, c10.x, c10.y
dp3 r2.x, v1, r0
dp3 r2.y, v2, r0
dp3 r2.z, v3, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad_pp r0.xyz, r2, -r0.x, -r1
texld_pp r0, r0, s3
texld_pp r1, v0, s1
mul_pp r1.xyz, r1, c6
mad_pp r0.xyz, r0, c7, r1
mad r1, v4.xyzx, c9.wwwz, c9.zzzw
dp4 r3.x, c0, r1
dp4 r3.y, c1, r1
dp4 r3.z, c2, r1
dp3 r0.w, r3, r3
texld_pp r1, r0.w, s0
mul_pp r1.xyz, r1.x, c5
mul_pp r0.xyz, r0, r1
add r1.xyz, c4, -v4
nrm_pp r3.xyz, r1
dp3_pp r0.w, r2, r3
max_pp r1.x, r0.w, c9.z
mul_pp oC0.xyz, r0, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_Cube] CUBE 3
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 336
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 272 [_Color]
Vector 288 [_ReflectColor]
Float 304 [_FresnelPower]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedlipjkljdoefodpfdlodfemaolkfnkjfmabaaaaaafaaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdaahaaaa
eaaaaaaammabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaamaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaaeghobaaaadaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaabbaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaiaebaaaaaa
afaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaefaaaaaj
pcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
dcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
adaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaa
baaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaai
icaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaaeaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaalhcaabaaa
afaaaaaaegacbaaaaeaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaaefaaaaajpcaabaaaafaaaaaaegacbaaaafaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaafaaaaaaegiccaaa
aaaaaaaabcaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaa
afaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaadiaaaaah
hcaabaaaabaaaaaafgafbaaaacaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaa
abaaaaaaegbcbaaaacaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaaj
hcaabaaaabaaaaaaegbcbaaaaeaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaabdaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajiccabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
fknieldpabeaaaaajjjofadodoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 3 [_Color]
Float 5 [_FresnelPower]
Vector 2 [_LightColor0]
Vector 4 [_ReflectColor]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
"ps_3_0
def c6, 2, -1, 0, 1
def c7, 0.796270013, 0.203730002, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_2d s0
dcl_2d s1
dcl_cube s2
add r0.xyz, c0, -v4
nrm_pp r1.xyz, r0
mul_pp r0.xyz, r1.y, v2
mad_pp r0.xyz, v1, r1.x, r0
mad_pp r0.xyz, v3, r1.z, r0
nrm r2.xyz, r0
texld_pp r0, v0, s1
mad_pp r0.xy, r0.wyzw, c6.x, c6.y
dp2add_sat_pp r0.w, r0, r0, c6.z
add_pp r0.w, -r0.w, c6.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
nrm r3.xyz, r0
dp3 r0.w, r2, r3
add r1.w, -r0.w, c6.w
cmp r0.w, r0.w, r1.w, c6.w
max r1.w, r0.w, c6.z
pow r0.w, r1.w, c5.x
mad_pp oC0.w, r0.w, c7.x, c7.y
dp3 r2.x, v1, r0
dp3 r2.y, v2, r0
dp3 r2.z, v3, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad_pp r0.xyz, r2, -r0.x, -r1
dp3_pp r0.w, r2, c1
max_pp r1.x, r0.w, c6.z
texld_pp r0, r0, s2
texld_pp r2, v0, s0
mul_pp r1.yzw, r2.xxyz, c3.xxyz
mad_pp r0.xyz, r0, c4, r1.yzww
mul_pp r0.xyz, r0, c2
mul_pp oC0.xyz, r1.x, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
ConstBuffer "$Globals" 272
Vector 96 [_LightColor0]
Vector 208 [_Color]
Vector 224 [_ReflectColor]
Float 240 [_FresnelPower]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedckmdehjimeffccjenghhlhhffiookainabaaaaaanmagaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclmafaaaa
eaaaaaaagpabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaacaaaaaa
hgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaa
acaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaaaaaaaaabaaaaaah
bcaabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaa
adaaaaaaegbcbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaadaaaaaa
egbcbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaaegacbaaaadaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaalhcaabaaaaeaaaaaaegacbaaaadaaaaaa
pgapbaiaebaaaaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaabaaaaaaiicaabaaa
aaaaaaaaegacbaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
egacbaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaaaoaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaahhcaabaaaacaaaaaafgafbaaaabaaaaaaegbcbaaa
adaaaaaadcaaaaajlcaabaaaabaaaaaaegbibaaaacaaaaaaagaabaaaabaaaaaa
egaibaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaakgakbaaa
abaaaaaaegadbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaapaaaaaa
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajiccabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaafknieldpabeaaaaajjjofadodoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Matrix 0 [_LightMatrix0]
Vector 7 [_Color]
Float 9 [_FresnelPower]
Vector 6 [_LightColor0]
Vector 8 [_ReflectColor]
Vector 4 [_WorldSpaceCameraPos]
Vector 5 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_BumpMap] 2D 3
SetTexture 4 [_Cube] CUBE 4
"ps_3_0
def c10, 2, -1, 0, 1
def c11, 0.796270013, 0.203730002, 0.5, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
add r0.xyz, c4, -v4
nrm_pp r1.xyz, r0
mul_pp r0.xyz, r1.y, v2
mad_pp r0.xyz, v1, r1.x, r0
mad_pp r0.xyz, v3, r1.z, r0
nrm r2.xyz, r0
texld_pp r0, v0, s3
mad_pp r0.xy, r0.wyzw, c10.x, c10.y
dp2add_sat_pp r0.w, r0, r0, c10.z
add_pp r0.w, -r0.w, c10.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
nrm r3.xyz, r0
dp3 r0.w, r2, r3
add r1.w, -r0.w, c10.w
cmp r0.w, r0.w, r1.w, c10.w
max r1.w, r0.w, c10.z
pow r0.w, r1.w, c9.x
mad_pp oC0.w, r0.w, c11.x, c11.y
dp3 r2.x, v1, r0
dp3 r2.y, v2, r0
dp3 r2.z, v3, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad_pp r0.xyz, r2, -r0.x, -r1
texld_pp r0, r0, s4
texld_pp r1, v0, s2
mul_pp r1.xyz, r1, c7
mad_pp r0.xyz, r0, c8, r1
mad r1, v4.xyzx, c10.wwwz, c10.zzzw
dp4 r0.w, c3, r1
rcp r0.w, r0.w
dp4 r3.x, c0, r1
dp4 r3.y, c1, r1
dp4 r3.z, c2, r1
mad r1.xy, r3, r0.w, c11.z
dp3 r0.w, r3, r3
texld_pp r4, r0.w, s1
texld_pp r1, r1, s0
mul r0.w, r4.x, r1.w
mul_pp r1.xyz, r0.w, c6
cmp_pp r1.xyz, -r3.z, c10.z, r1
mul_pp r0.xyz, r0, r1
add r1.xyz, c5, -v4
nrm_pp r3.xyz, r1
dp3_pp r0.w, r2, r3
max_pp r1.x, r0.w, c10.z
mul_pp oC0.xyz, r0, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_Cube] CUBE 4
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 336
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 272 [_Color]
Vector 288 [_ReflectColor]
Float 304 [_FresnelPower]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefieceddifinnanellhikndjokdllfhcbnjkpmcabaaaaaaeeajaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcceaiaaaa
eaaaaaaaajacaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaafaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaaegaobaaa
aaaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
amaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaa
aaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaagaabaaaaaaaaaaaeghobaaaaeaaaaaa
aagabaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaabbaaaaaa
aaaaaaajhcaabaaaacaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaa
hgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaa
adaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaah
bcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaa
aeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaa
egbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaaaaeaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaalhcaabaaaafaaaaaaegacbaaaaeaaaaaa
pgapbaiaebaaaaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaefaaaaajpcaabaaa
afaaaaaaegacbaaaafaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaaegacbaaaafaaaaaaegiccaaaaaaaaaaabcaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaacaaaaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaa
acaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaacaaaaaa
agaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaa
aeaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaabdaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
iccabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaafknieldpabeaaaaajjjofado
doaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Matrix 0 [_LightMatrix0] 3
Vector 6 [_Color]
Float 8 [_FresnelPower]
Vector 5 [_LightColor0]
Vector 7 [_ReflectColor]
Vector 3 [_WorldSpaceCameraPos]
Vector 4 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_BumpMap] 2D 3
SetTexture 4 [_Cube] CUBE 4
"ps_3_0
def c9, 2, -1, 0, 1
def c10, 0.796270013, 0.203730002, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_cube s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
add r0.xyz, c3, -v4
nrm_pp r1.xyz, r0
mul_pp r0.xyz, r1.y, v2
mad_pp r0.xyz, v1, r1.x, r0
mad_pp r0.xyz, v3, r1.z, r0
nrm r2.xyz, r0
texld_pp r0, v0, s3
mad_pp r0.xy, r0.wyzw, c9.x, c9.y
dp2add_sat_pp r0.w, r0, r0, c9.z
add_pp r0.w, -r0.w, c9.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
nrm r3.xyz, r0
dp3 r0.w, r2, r3
add r1.w, -r0.w, c9.w
cmp r0.w, r0.w, r1.w, c9.w
max r1.w, r0.w, c9.z
pow r0.w, r1.w, c8.x
mad_pp oC0.w, r0.w, c10.x, c10.y
dp3 r2.x, v1, r0
dp3 r2.y, v2, r0
dp3 r2.z, v3, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad_pp r0.xyz, r2, -r0.x, -r1
texld_pp r0, r0, s4
texld_pp r1, v0, s2
mul_pp r1.xyz, r1, c6
mad_pp r0.xyz, r0, c7, r1
mad r1, v4.xyzx, c9.wwwz, c9.zzzw
dp4 r3.x, c0, r1
dp4 r3.y, c1, r1
dp4 r3.z, c2, r1
dp3 r0.w, r3, r3
texld r1, r3, s0
texld r3, r0.w, s1
mul_pp r0.w, r1.w, r3.x
mul_pp r1.xyz, r0.w, c5
mul_pp r0.xyz, r0, r1
add r1.xyz, c4, -v4
nrm_pp r3.xyz, r1
dp3_pp r0.w, r2, r3
max_pp r1.x, r0.w, c9.z
mul_pp oC0.xyz, r0, r1.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_Cube] CUBE 4
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 336
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 272 [_Color]
Vector 288 [_ReflectColor]
Float 304 [_FresnelPower]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedpdfeplibepnnlpkfhkiefgfpkadpajlmabaaaaaakmaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcimahaaaa
eaaaaaaaodabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaafaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaaegacbaaa
aaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
amaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegacbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaapgapbaaaaaaaaaaaeghobaaaadaaaaaa
aagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
agaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaabbaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaiaebaaaaaaafaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaap
dcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaa
baaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaah
ecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaaiicaabaaa
aaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaaeaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaalhcaabaaaafaaaaaa
egacbaaaaeaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
efaaaaajpcaabaaaafaaaaaaegacbaaaafaaaaaaeghobaaaacaaaaaaaagabaaa
aeaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaafaaaaaaegiccaaaaaaaaaaa
bcaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaa
abaaaaaafgafbaaaacaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaa
egbcbaaaacaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaa
abaaaaaaegbcbaaaaeaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaabdaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajiccabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaafknieldp
abeaaaaajjjofadodoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Matrix 0 [_LightMatrix0] 2
Vector 5 [_Color]
Float 7 [_FresnelPower]
Vector 4 [_LightColor0]
Vector 6 [_ReflectColor]
Vector 2 [_WorldSpaceCameraPos]
Vector 3 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_Cube] CUBE 3
"ps_3_0
def c8, 2, -1, 0, 1
def c9, 0.796270013, 0.203730002, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
add r0.xyz, c2, -v4
nrm_pp r1.xyz, r0
mul_pp r0.xyz, r1.y, v2
mad_pp r0.xyz, v1, r1.x, r0
mad_pp r0.xyz, v3, r1.z, r0
nrm r2.xyz, r0
texld_pp r0, v0, s2
mad_pp r0.xy, r0.wyzw, c8.x, c8.y
dp2add_sat_pp r0.w, r0, r0, c8.z
add_pp r0.w, -r0.w, c8.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
nrm r3.xyz, r0
dp3 r0.w, r2, r3
add r1.w, -r0.w, c8.w
cmp r0.w, r0.w, r1.w, c8.w
max r1.w, r0.w, c8.z
pow r0.w, r1.w, c7.x
mad_pp oC0.w, r0.w, c9.x, c9.y
dp3 r2.x, v1, r0
dp3 r2.y, v2, r0
dp3 r2.z, v3, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad_pp r0.xyz, r2, -r0.x, -r1
dp3_pp r0.w, r2, c3
max_pp r1.x, r0.w, c8.z
texld_pp r0, r0, s3
texld_pp r2, v0, s1
mul_pp r1.yzw, r2.xxyz, c5.xxyz
mad_pp r0.xyz, r0, c6, r1.yzww
mad r2, v4.xyzx, c8.wwwz, c8.zzzw
dp4 r3.x, c0, r2
dp4 r3.y, c1, r2
texld_pp r2, r3, s0
mul_pp r1.yzw, r2.w, c4.xxyz
mul_pp r0.xyz, r0, r1.yzww
mul_pp oC0.xyz, r1.x, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_Cube] CUBE 3
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 336
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 272 [_Color]
Vector 288 [_ReflectColor]
Float 304 [_FresnelPower]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedcidmbojdlgcjkhiikbgcmnmbbbfhhoodabaaaaaamiahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckiagaaaa
eaaaaaaakkabaaaafjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaadiaaaaaidcaabaaa
aaaaaaaafgbfbaaaafaaaaaaegiacaaaaaaaaaaaakaaaaaadcaaaaakdcaabaaa
aaaaaaaaegiacaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaaegaabaaaaaaaaaaa
dcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaa
egaabaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaa
aaaaaaaaamaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaabbaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaia
ebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
adaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaa
egacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaa
adaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaaadaaaaaa
baaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaaeaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaal
hcaabaaaafaaaaaaegacbaaaaeaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaaaaeaaaaaaegiccaaa
acaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaefaaaaajpcaabaaaaeaaaaaaegacbaaaafaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaaeaaaaaaegiccaaa
aaaaaaaabcaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaabaaaaaa
fgafbaaaacaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaa
acaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaabaaaaaa
egbcbaaaaeaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaabdaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajiccabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaafknieldpabeaaaaa
jjjofadodoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT" "FOG_EXP" }
Matrix 0 [_LightMatrix0] 3
Vector 7 [_Color]
Float 9 [_FresnelPower]
Vector 6 [_LightColor0]
Vector 8 [_ReflectColor]
Vector 3 [_WorldSpaceCameraPos]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_FogParams]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_Cube] CUBE 3
"ps_3_0
def c10, 2, -1, 0, 1
def c11, 0.796270013, 0.203730002, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
add r0.xyz, c3, -v4
nrm_pp r1.xyz, r0
mul_pp r0.xyz, r1.y, v2
mad_pp r0.xyz, v1, r1.x, r0
mad_pp r0.xyz, v3, r1.z, r0
nrm r2.xyz, r0
texld_pp r0, v0, s2
mad_pp r0.xy, r0.wyzw, c10.x, c10.y
dp2add_sat_pp r0.w, r0, r0, c10.z
add_pp r0.w, -r0.w, c10.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
nrm r3.xyz, r0
dp3 r0.w, r2, r3
add r1.w, -r0.w, c10.w
cmp r0.w, r0.w, r1.w, c10.w
max r1.w, r0.w, c10.z
pow r0.w, r1.w, c9.x
mad_pp oC0.w, r0.w, c11.x, c11.y
dp3 r2.x, v1, r0
dp3 r2.y, v2, r0
dp3 r2.z, v3, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad_pp r0.xyz, r2, -r0.x, -r1
texld_pp r0, r0, s3
texld_pp r1, v0, s1
mul_pp r1.xyz, r1, c7
mad_pp r0.xyz, r0, c8, r1
mad r1, v4.xyzx, c10.wwwz, c10.zzzw
dp4 r3.x, c0, r1
dp4 r3.y, c1, r1
dp4 r3.z, c2, r1
dp3 r0.w, r3, r3
texld_pp r1, r0.w, s0
mul_pp r1.xyz, r1.x, c6
mul_pp r0.xyz, r0, r1
add r1.xyz, c4, -v4
nrm_pp r3.xyz, r1
dp3_pp r0.w, r2, r3
max_pp r1.x, r0.w, c10.z
mul_pp r0.xyz, r0, r1.x
mul r0.w, c5.y, v5.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w

"
}
SubProgram "d3d11 " {
Keywords { "POINT" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_Cube] CUBE 3
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 336
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 272 [_Color]
Vector 288 [_ReflectColor]
Float 304 [_FresnelPower]
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
eefiecedegkhjaghbakkajncngbbiaagmkmofkgbabaaaaaapeaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclmahaaaaeaaaaaaaopabaaaa
fjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
ecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacagaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaafaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
ajaaaaaaagbabaaaafaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaalaaaaaakgbkbaaaafaaaaaaegacbaaaaaaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaagaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaabbaaaaaa
aaaaaaajhcaabaaaacaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaa
hgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaa
adaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaah
bcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaa
aeaaaaaaegbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaa
egbcbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaaaaeaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaalhcaabaaaafaaaaaaegacbaaaaeaaaaaa
pgapbaiaebaaaaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaefaaaaajpcaabaaa
afaaaaaaegacbaaaafaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaak
hcaabaaaabaaaaaaegacbaaaafaaaaaaegiccaaaaaaaaaaabcaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaacaaaaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaackbabaaaabaaaaaabkiacaaaadaaaaaa
abaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaa
diaaaaahhcaabaaaabaaaaaafgafbaaaacaaaaaaegbcbaaaadaaaaaadcaaaaaj
hcaabaaaabaaaaaaegbcbaaaacaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaakgakbaaaacaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaabdaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajiccabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaafknieldpabeaaaaajjjofadodoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
Vector 4 [_Color]
Float 6 [_FresnelPower]
Vector 3 [_LightColor0]
Vector 5 [_ReflectColor]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [unity_FogParams]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
"ps_3_0
def c7, 2, -1, 0, 1
def c8, 0.796270013, 0.203730002, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_cube s2
add r0.xyz, c0, -v4
nrm_pp r1.xyz, r0
mul_pp r0.xyz, r1.y, v2
mad_pp r0.xyz, v1, r1.x, r0
mad_pp r0.xyz, v3, r1.z, r0
nrm r2.xyz, r0
texld_pp r0, v0, s1
mad_pp r0.xy, r0.wyzw, c7.x, c7.y
dp2add_sat_pp r0.w, r0, r0, c7.z
add_pp r0.w, -r0.w, c7.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
nrm r3.xyz, r0
dp3 r0.w, r2, r3
add r1.w, -r0.w, c7.w
cmp r0.w, r0.w, r1.w, c7.w
max r1.w, r0.w, c7.z
pow r0.w, r1.w, c6.x
mad_pp oC0.w, r0.w, c8.x, c8.y
dp3 r2.x, v1, r0
dp3 r2.y, v2, r0
dp3 r2.z, v3, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad_pp r0.xyz, r2, -r0.x, -r1
dp3_pp r0.w, r2, c1
max_pp r1.x, r0.w, c7.z
texld_pp r0, r0, s2
texld_pp r2, v0, s0
mul_pp r1.yzw, r2.xxyz, c4.xxyz
mad_pp r0.xyz, r0, c5, r1.yzww
mul_pp r0.xyz, r0, c3
mul_pp r0.xyz, r1.x, r0
mul r0.w, c2.y, v5.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
ConstBuffer "$Globals" 272
Vector 96 [_LightColor0]
Vector 208 [_Color]
Vector 224 [_ReflectColor]
Float 240 [_FresnelPower]
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
eefiecedofpiimdfadfblenenlhgdlbndbhofbceabaaaaaaiaahaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceiagaaaaeaaaaaaajcabaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaadiaaaaaibcaabaaaaaaaaaaackbabaaa
abaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaagbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaa
aaaaaaaaanaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
abaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaa
abaaaaaabaaaaaahbcaabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaa
baaaaaahccaabaaaadaaaaaaegbcbaaaadaaaaaaegacbaaaacaaaaaabaaaaaah
ecaabaaaadaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaaiicaabaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaadaaaaaaaaaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaalhcaabaaaaeaaaaaa
egacbaaaadaaaaaapgapbaiaebaaaaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
baaaaaaiicaabaaaabaaaaaaegacbaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaa
deaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaegacbaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
dcaaaaakocaabaaaaaaaaaaaagajbaaaadaaaaaaagijcaaaaaaaaaaaaoaaaaaa
fgaobaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaa
aaaaaaaaagaaaaaadiaaaaahocaabaaaaaaaaaaapgapbaaaabaaaaaafgaobaaa
aaaaaaaadiaaaaahhccabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaacaaaaaafgafbaaaabaaaaaa
egbcbaaaadaaaaaadcaaaaajlcaabaaaabaaaaaaegbibaaaacaaaaaaagaabaaa
abaaaaaaegaibaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaa
kgakbaaaabaaaaaaegadbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
apaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajiccabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaafknieldpabeaaaaajjjofadodoaaaaab
"
}
SubProgram "opengl " {
Keywords { "SPOT" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "FOG_EXP" }
Matrix 0 [_LightMatrix0]
Vector 8 [_Color]
Float 10 [_FresnelPower]
Vector 7 [_LightColor0]
Vector 9 [_ReflectColor]
Vector 4 [_WorldSpaceCameraPos]
Vector 5 [_WorldSpaceLightPos0]
Vector 6 [unity_FogParams]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_BumpMap] 2D 3
SetTexture 4 [_Cube] CUBE 4
"ps_3_0
def c11, 2, -1, 0, 1
def c12, 0.796270013, 0.203730002, 0.5, 0
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
dcl_cube s4
add r0.xyz, c4, -v4
nrm_pp r1.xyz, r0
mul_pp r0.xyz, r1.y, v2
mad_pp r0.xyz, v1, r1.x, r0
mad_pp r0.xyz, v3, r1.z, r0
nrm r2.xyz, r0
texld_pp r0, v0, s3
mad_pp r0.xy, r0.wyzw, c11.x, c11.y
dp2add_sat_pp r0.w, r0, r0, c11.z
add_pp r0.w, -r0.w, c11.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
nrm r3.xyz, r0
dp3 r0.w, r2, r3
add r1.w, -r0.w, c11.w
cmp r0.w, r0.w, r1.w, c11.w
max r1.w, r0.w, c11.z
pow r0.w, r1.w, c10.x
mad_pp oC0.w, r0.w, c12.x, c12.y
dp3 r2.x, v1, r0
dp3 r2.y, v2, r0
dp3 r2.z, v3, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad_pp r0.xyz, r2, -r0.x, -r1
texld_pp r0, r0, s4
texld_pp r1, v0, s2
mul_pp r1.xyz, r1, c8
mad_pp r0.xyz, r0, c9, r1
mad r1, v4.xyzx, c11.wwwz, c11.zzzw
dp4 r0.w, c3, r1
rcp r0.w, r0.w
dp4 r3.x, c0, r1
dp4 r3.y, c1, r1
dp4 r3.z, c2, r1
mad r1.xy, r3, r0.w, c12.z
dp3 r0.w, r3, r3
texld_pp r4, r0.w, s1
texld_pp r1, r1, s0
mul r0.w, r4.x, r1.w
mul_pp r1.xyz, r0.w, c7
cmp_pp r1.xyz, -r3.z, c11.z, r1
mul_pp r0.xyz, r0, r1
add r1.xyz, c5, -v4
nrm_pp r3.xyz, r1
dp3_pp r0.w, r2, r3
max_pp r1.x, r0.w, c11.z
mul_pp r0.xyz, r0, r1.x
mul r0.w, c6.y, v5.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_Cube] CUBE 4
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 336
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 272 [_Color]
Vector 288 [_ReflectColor]
Float 304 [_FresnelPower]
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
eefiecedbbfkiikjbklnlpagdlhcgamdclbaakmhabaaaaaaoiajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclaaiaaaaeaaaaaaacmacaaaa
fjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaafaaaaaaegiocaaa
aaaaaaaaakaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaajaaaaaa
agbabaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaalaaaaaakgbkbaaaafaaaaaaegaobaaaaaaaaaaaaaaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaamaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaaaaaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaagaabaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaaabaaaaah
bcaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaa
aaaaaaaadkaabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaabbaaaaaaaaaaaaajhcaabaaaacaaaaaa
egbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaa
ddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaa
acaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaa
egacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaaegacbaaa
adaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
aeaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaalhcaabaaaafaaaaaaegacbaaaaeaaaaaapgapbaiaebaaaaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaaefaaaaajpcaabaaaafaaaaaaegacbaaaafaaaaaa
eghobaaaacaaaaaaaagabaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaa
afaaaaaaegiccaaaaaaaaaaabcaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaiaebaaaaaaafaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaackbabaaaabaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaagicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaabaaaaaa
fgafbaaaacaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaa
acaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaabaaaaaa
egbcbaaaaeaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaabdaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajiccabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaafknieldpabeaaaaa
jjjofadodoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
Matrix 0 [_LightMatrix0] 3
Vector 7 [_Color]
Float 9 [_FresnelPower]
Vector 6 [_LightColor0]
Vector 8 [_ReflectColor]
Vector 3 [_WorldSpaceCameraPos]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_FogParams]
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_BumpMap] 2D 3
SetTexture 4 [_Cube] CUBE 4
"ps_3_0
def c10, 2, -1, 0, 1
def c11, 0.796270013, 0.203730002, 0, 0
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
dcl_cube s4
add r0.xyz, c3, -v4
nrm_pp r1.xyz, r0
mul_pp r0.xyz, r1.y, v2
mad_pp r0.xyz, v1, r1.x, r0
mad_pp r0.xyz, v3, r1.z, r0
nrm r2.xyz, r0
texld_pp r0, v0, s3
mad_pp r0.xy, r0.wyzw, c10.x, c10.y
dp2add_sat_pp r0.w, r0, r0, c10.z
add_pp r0.w, -r0.w, c10.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
nrm r3.xyz, r0
dp3 r0.w, r2, r3
add r1.w, -r0.w, c10.w
cmp r0.w, r0.w, r1.w, c10.w
max r1.w, r0.w, c10.z
pow r0.w, r1.w, c9.x
mad_pp oC0.w, r0.w, c11.x, c11.y
dp3 r2.x, v1, r0
dp3 r2.y, v2, r0
dp3 r2.z, v3, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad_pp r0.xyz, r2, -r0.x, -r1
texld_pp r0, r0, s4
texld_pp r1, v0, s2
mul_pp r1.xyz, r1, c7
mad_pp r0.xyz, r0, c8, r1
mad r1, v4.xyzx, c10.wwwz, c10.zzzw
dp4 r3.x, c0, r1
dp4 r3.y, c1, r1
dp4 r3.z, c2, r1
dp3 r0.w, r3, r3
texld r1, r3, s0
texld r3, r0.w, s1
mul_pp r0.w, r1.w, r3.x
mul_pp r1.xyz, r0.w, c6
mul_pp r0.xyz, r0, r1
add r1.xyz, c4, -v4
nrm_pp r3.xyz, r1
dp3_pp r0.w, r2, r3
max_pp r1.x, r0.w, c10.z
mul_pp r0.xyz, r0, r1.x
mul r0.w, c5.y, v5.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_Cube] CUBE 4
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 336
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 272 [_Color]
Vector 288 [_ReflectColor]
Float 304 [_FresnelPower]
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
eefiecedknimloogeeakaaagfeholjhjnmibebjjabaaaaaafaajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbiaiaaaaeaaaaaaaagacaaaa
fjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaae
aahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacagaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaafaaaaaaegiccaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaa
agbabaaaafaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaalaaaaaakgbkbaaaafaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egacbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaapgapbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadiaaaaah
bcaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaabbaaaaaaaaaaaaaj
hcaabaaaacaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaa
adaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaadaaaaaa
egaabaaaadaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaa
egbcbaaaadaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaa
aeaaaaaaegacbaaaadaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaaaaeaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaalhcaabaaaafaaaaaaegacbaaaaeaaaaaapgapbaia
ebaaaaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaefaaaaajpcaabaaaafaaaaaa
egacbaaaafaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaadcaaaaakhcaabaaa
abaaaaaaegacbaaaafaaaaaaegiccaaaaaaaaaaabcaaaaaaegacbaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaacaaaaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaa
egacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaackbabaaaabaaaaaabkiacaaaadaaaaaaabaaaaaa
bjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaadiaaaaah
hcaabaaaabaaaaaafgafbaaaacaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaa
abaaaaaaegbcbaaaacaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaaj
hcaabaaaabaaaaaaegbcbaaaaeaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaabdaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajiccabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
fknieldpabeaaaaajjjofadodoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
Matrix 0 [_LightMatrix0] 2
Vector 6 [_Color]
Float 8 [_FresnelPower]
Vector 5 [_LightColor0]
Vector 7 [_ReflectColor]
Vector 2 [_WorldSpaceCameraPos]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [unity_FogParams]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_Cube] CUBE 3
"ps_3_0
def c9, 2, -1, 0, 1
def c10, 0.796270013, 0.203730002, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3_pp v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
add r0.xyz, c2, -v4
nrm_pp r1.xyz, r0
mul_pp r0.xyz, r1.y, v2
mad_pp r0.xyz, v1, r1.x, r0
mad_pp r0.xyz, v3, r1.z, r0
nrm r2.xyz, r0
texld_pp r0, v0, s2
mad_pp r0.xy, r0.wyzw, c9.x, c9.y
dp2add_sat_pp r0.w, r0, r0, c9.z
add_pp r0.w, -r0.w, c9.w
rsq_pp r0.w, r0.w
rcp_pp r0.z, r0.w
nrm r3.xyz, r0
dp3 r0.w, r2, r3
add r1.w, -r0.w, c9.w
cmp r0.w, r0.w, r1.w, c9.w
max r1.w, r0.w, c9.z
pow r0.w, r1.w, c8.x
mad_pp oC0.w, r0.w, c10.x, c10.y
dp3 r2.x, v1, r0
dp3 r2.y, v2, r0
dp3 r2.z, v3, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad_pp r0.xyz, r2, -r0.x, -r1
dp3_pp r0.w, r2, c3
max_pp r1.x, r0.w, c9.z
texld_pp r0, r0, s3
texld_pp r2, v0, s1
mul_pp r1.yzw, r2.xxyz, c6.xxyz
mad_pp r0.xyz, r0, c7, r1.yzww
mad r2, v4.xyzx, c9.wwwz, c9.zzzw
dp4 r3.x, c0, r2
dp4 r3.y, c1, r2
texld_pp r2, r3, s0
mul_pp r1.yzw, r2.w, c5.xxyz
mul_pp r0.xyz, r0, r1.yzww
mul_pp r0.xyz, r1.x, r0
mul r0.w, c4.y, v5.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_Cube] CUBE 3
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 336
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 272 [_Color]
Vector 288 [_ReflectColor]
Float 304 [_FresnelPower]
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
eefiecedclcelngkeeacifgecijbhpafmeagdmaiabaaaaaagmaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeahaaaaeaaaaaaamnabaaaa
fjaaaaaeegiocaaaaaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
ecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacagaaaaaadiaaaaaibcaabaaaaaaaaaaackbabaaaabaaaaaa
bkiacaaaadaaaaaaabaaaaaabjaaaaagbcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaaigcaabaaaaaaaaaaafgbfbaaaafaaaaaaagibcaaaaaaaaaaaakaaaaaa
dcaaaaakgcaabaaaaaaaaaaaagibcaaaaaaaaaaaajaaaaaaagbabaaaafaaaaaa
fgagbaaaaaaaaaaadcaaaaakgcaabaaaaaaaaaaaagibcaaaaaaaaaaaalaaaaaa
kgbkbaaaafaaaaaafgagbaaaaaaaaaaaaaaaaaaigcaabaaaaaaaaaaafgagbaaa
aaaaaaaaagibcaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaa
aaaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaa
pgapbaaaabaaaaaaagijcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaabbaaaaaaaaaaaaajhcaabaaa
acaaaaaaegbcbaiaebaaaaaaafaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaabaaaaaahbcaabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaa
adaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaa
egacbaaaadaaaaaabaaaaaaiicaabaaaabaaaaaaegacbaiaebaaaaaaacaaaaaa
egacbaaaaeaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaa
abaaaaaadcaaaaalhcaabaaaafaaaaaaegacbaaaaeaaaaaapgapbaiaebaaaaaa
abaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaaiicaabaaaabaaaaaaegacbaaa
aeaaaaaaegiccaaaacaaaaaaaaaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegacbaaaafaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaa
aeaaaaaaegiccaaaaaaaaaaabcaaaaaaegacbaaaabaaaaaadiaaaaahocaabaaa
aaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahocaabaaaaaaaaaaa
pgapbaaaabaaaaaafgaobaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaajgahbaaa
aaaaaaaaagaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaa
abaaaaaafgafbaaaacaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaa
egbcbaaaacaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaa
abaaaaaaegbcbaaaaeaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaabdaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajiccabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaafknieldp
abeaaaaajjjofadodoaaaaab"
}
}
 }
}
Fallback "Reflective/VertexLit"
}