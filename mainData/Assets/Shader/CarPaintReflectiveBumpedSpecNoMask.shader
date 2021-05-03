Shader "Car Paint Reflective Bumped Specular (Paint only, no mask)" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _Tint ("Tint Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.03,1)) = 0.078125
 _Reflection ("Reflection", Range(0.03,1)) = 0.25
 _ReflectColor ("Reflection Color (RGB)", Color) = (1,1,1,0.5)
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
 _Skybox ("Reflection Cubemap", CUBE) = "_Skybox" { }
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  GpuProgramID 20779
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD7;
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
  vec3 I_7;
  I_7 = (tmpvar_2 - _WorldSpaceCameraPos);
  vec3 x2_8;
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_8.x = dot (unity_SHBr, tmpvar_9);
  x2_8.y = dot (unity_SHBg, tmpvar_9);
  x2_8.z = dot (unity_SHBb, tmpvar_9);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (I_7 - (2.0 * (
    dot (tmpvar_6, I_7)
   * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (x2_8 + (unity_SHC.xyz * (
    (tmpvar_6.x * tmpvar_6.x)
   - 
    (tmpvar_6.y * tmpvar_6.y)
  )));
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform samplerCube _Skybox;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform vec4 _ReflectColor;
uniform float _Shininess;
uniform float _Reflection;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * _Color) * _Tint);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD2;
  vec3 x1_6;
  x1_6.x = dot (unity_SHAr, tmpvar_5);
  x1_6.y = dot (unity_SHAg, tmpvar_5);
  x1_6.z = dot (unity_SHAb, tmpvar_5);
  vec4 c_7;
  vec4 c_8;
  c_8.xyz = (((tmpvar_4.xyz * _LightColor0.xyz) * max (0.0, 
    dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)
  )) + ((_LightColor0.xyz * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD2, normalize(
      (_WorldSpaceLightPos0.xyz + tmpvar_2)
    ))), (_Shininess * 128.0))
   * tmpvar_3.w)));
  c_8.w = 1.0;
  c_7.w = c_8.w;
  c_7.xyz = (c_8.xyz + (tmpvar_4.xyz * (xlv_TEXCOORD4 + x1_6)));
  c_1.xyz = (c_7.xyz + ((textureCube (_Skybox, xlv_TEXCOORD1) * 
    (_Reflection * (1.0 - dot (normalize(tmpvar_2), xlv_TEXCOORD2)))
  ).xyz * _ReflectColor.xyz));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 15 [_MainTex_ST]
Vector 10 [_WorldSpaceCameraPos]
Vector 13 [unity_SHBb]
Vector 12 [unity_SHBg]
Vector 11 [unity_SHBr]
Vector 14 [unity_SHC]
"vs_3_0
def c16, 0, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord7 o6
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c15, c15.zwzw
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, -r0, c10
mov o4.xyz, r0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r2.xyz, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad o2.xyz, r2, -r0.x, -r1
mul r0.x, r2.y, r2.y
mad r0.x, r2.x, r2.x, -r0.x
mul r1, r2.yzzx, r2.xyzz
mov o3.xyz, r2
dp4 r2.x, c11, r1
dp4 r2.y, c12, r1
dp4 r2.z, c13, r1
mad o5.xyz, c14, r0.x, r2
mov o6, c16.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
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
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedcgfajijaiajinfhljfpnidbpkgfhpdinabaaaaaaiiahaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaalmaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcimafaaaaeaaaabaa
gdabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
giaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaa
ogikcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaabaaaaaaaeaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaaabaaaaaa
baaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaal
hccabaaaacaaaaaaegacbaaaaaaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaaaaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaaaaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaabaaaaaabbaaaaai
ecaabaaaaaaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaabaaaaaadcaaaaak
hccabaaaafaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaipccabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD7;
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
  vec3 I_8;
  I_8 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 x2_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_9.x = dot (unity_SHBr, tmpvar_10);
  x2_9.y = dot (unity_SHBg, tmpvar_10);
  x2_9.z = dot (unity_SHBb, tmpvar_10);
  vec4 o_11;
  vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_2 * 0.5);
  vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (I_8 - (2.0 * (
    dot (tmpvar_7, I_8)
   * tmpvar_7)));
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (x2_9 + (unity_SHC.xyz * (
    (tmpvar_7.x * tmpvar_7.x)
   - 
    (tmpvar_7.y * tmpvar_7.y)
  )));
  xlv_TEXCOORD5 = o_11;
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform samplerCube _Skybox;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform vec4 _ReflectColor;
uniform float _Shininess;
uniform float _Reflection;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * _Color) * _Tint);
  vec3 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD2;
  vec3 x1_7;
  x1_7.x = dot (unity_SHAr, tmpvar_6);
  x1_7.y = dot (unity_SHAg, tmpvar_6);
  x1_7.z = dot (unity_SHAb, tmpvar_6);
  tmpvar_5 = (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x);
  vec4 c_8;
  vec4 c_9;
  c_9.xyz = (((tmpvar_4.xyz * tmpvar_5) * max (0.0, 
    dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)
  )) + ((tmpvar_5 * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD2, normalize(
      (_WorldSpaceLightPos0.xyz + tmpvar_2)
    ))), (_Shininess * 128.0))
   * tmpvar_3.w)));
  c_9.w = 1.0;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_4.xyz * (xlv_TEXCOORD4 + x1_7)));
  c_1.xyz = (c_8.xyz + ((textureCube (_Skybox, xlv_TEXCOORD1) * 
    (_Reflection * (1.0 - dot (normalize(tmpvar_2), xlv_TEXCOORD2)))
  ).xyz * _ReflectColor.xyz));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 17 [_MainTex_ST]
Vector 11 [_ProjectionParams]
Vector 12 [_ScreenParams]
Vector 10 [_WorldSpaceCameraPos]
Vector 15 [unity_SHBb]
Vector 14 [unity_SHBg]
Vector 13 [unity_SHBr]
Vector 16 [unity_SHC]
"vs_3_0
def c18, 0.5, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6
dcl_texcoord7 o7
mad o1.xy, v2, c17, c17.zwzw
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, -r0, c10
mov o4.xyz, r0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r2.xyz, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad o2.xyz, r2, -r0.x, -r1
mul r0.x, r2.y, r2.y
mad r0.x, r2.x, r2.x, -r0.x
mul r1, r2.yzzx, r2.xyzz
mov o3.xyz, r2
dp4 r2.x, c13, r1
dp4 r2.y, c14, r1
dp4 r2.z, c15, r1
mad o5.xyz, c16, r0.x, r2
dp4 r0.y, c1, v0
mul r1.x, r0.y, c11.x
mul r1.w, r1.x, c18.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c18.x
mad o6.xy, r1.z, c12.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov o0, r0
mov o6.zw, r0
mov o7, c18.y

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
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
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedakpcjohnjophechjmoijbfepkmegjeopabaaaaaadiaiaaaaadaaaaaa
cmaaaaaaceabaaaaamacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcceagaaaaeaaaabaaijabaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaa
ahaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaa
anaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
bcaaaaaadiaaaaaibcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaibcaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaajhcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaaabaaaaaa
aeaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaaacaaaaaabaaaaaaiicaabaaa
abaaaaaaegacbaiaebaaaaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaalhccabaaaacaaaaaa
egacbaaaabaaaaaapgapbaiaebaaaaaaabaaaaaaegacbaiaebaaaaaaadaaaaaa
dgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
bkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaabaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaabaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaabaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
agaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
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
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD7;
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
  vec3 I_7;
  I_7 = (tmpvar_2 - _WorldSpaceCameraPos);
  vec3 x2_8;
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_8.x = dot (unity_SHBr, tmpvar_9);
  x2_8.y = dot (unity_SHBg, tmpvar_9);
  x2_8.z = dot (unity_SHBb, tmpvar_9);
  vec4 tmpvar_10;
  tmpvar_10 = (unity_4LightPosX0 - tmpvar_2.x);
  vec4 tmpvar_11;
  tmpvar_11 = (unity_4LightPosY0 - tmpvar_2.y);
  vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosZ0 - tmpvar_2.z);
  vec4 tmpvar_13;
  tmpvar_13 = (((tmpvar_10 * tmpvar_10) + (tmpvar_11 * tmpvar_11)) + (tmpvar_12 * tmpvar_12));
  vec4 tmpvar_14;
  tmpvar_14 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_10 * tmpvar_6.x) + (tmpvar_11 * tmpvar_6.y)) + (tmpvar_12 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_13)
  )) * (1.0/((1.0 + 
    (tmpvar_13 * unity_4LightAtten0)
  ))));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (I_7 - (2.0 * (
    dot (tmpvar_6, I_7)
   * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = ((x2_8 + (unity_SHC.xyz * 
    ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y))
  )) + ((
    ((unity_LightColor[0].xyz * tmpvar_14.x) + (unity_LightColor[1].xyz * tmpvar_14.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_14.z)
  ) + (unity_LightColor[3].xyz * tmpvar_14.w)));
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform samplerCube _Skybox;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform vec4 _ReflectColor;
uniform float _Shininess;
uniform float _Reflection;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * _Color) * _Tint);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD2;
  vec3 x1_6;
  x1_6.x = dot (unity_SHAr, tmpvar_5);
  x1_6.y = dot (unity_SHAg, tmpvar_5);
  x1_6.z = dot (unity_SHAb, tmpvar_5);
  vec4 c_7;
  vec4 c_8;
  c_8.xyz = (((tmpvar_4.xyz * _LightColor0.xyz) * max (0.0, 
    dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)
  )) + ((_LightColor0.xyz * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD2, normalize(
      (_WorldSpaceLightPos0.xyz + tmpvar_2)
    ))), (_Shininess * 128.0))
   * tmpvar_3.w)));
  c_8.w = 1.0;
  c_7.w = c_8.w;
  c_7.xyz = (c_8.xyz + (tmpvar_4.xyz * (xlv_TEXCOORD4 + x1_6)));
  c_1.xyz = (c_7.xyz + ((textureCube (_Skybox, xlv_TEXCOORD1) * 
    (_Reflection * (1.0 - dot (normalize(tmpvar_2), xlv_TEXCOORD2)))
  ).xyz * _ReflectColor.xyz));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 23 [_MainTex_ST]
Vector 14 [_WorldSpaceCameraPos]
Vector 18 [unity_4LightAtten0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 21 [unity_SHBb]
Vector 20 [unity_SHBg]
Vector 19 [unity_SHBr]
Vector 22 [unity_SHC]
"vs_3_0
def c24, 0, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord7 o6
dp4 o0.x, c4, v0
dp4 o0.y, c5, v0
dp4 o0.z, c6, v0
dp4 o0.w, c7, v0
mad o1.xy, v2, c23, c23.zwzw
dp4 r0.x, c8, v0
dp4 r0.y, c9, v0
dp4 r0.z, c10, v0
add r1.xyz, -r0, c14
mul r2.xyz, c12, v1.y
mad r2.xyz, c11, v1.x, r2
mad r2.xyz, c13, v1.z, r2
nrm r3.xyz, r2
dp3 r0.w, -r1, r3
add r0.w, r0.w, r0.w
mad o2.xyz, r3, -r0.w, -r1
add r1, -r0.x, c15
mov o4.xyz, r0
add r2, -r0.y, c16
add r0, -r0.z, c17
mul r4, r3.y, r2
mul r2, r2, r2
mad r2, r1, r1, r2
mad r1, r1, r3.x, r4
mad r1, r0, r3.z, r1
mad r0, r0, r0, r2
rsq r2.x, r0.x
rsq r2.y, r0.y
rsq r2.z, r0.z
rsq r2.w, r0.w
mov r4.y, c24.y
mad r0, r0, c18, r4.y
mul r1, r1, r2
max r1, r1, c24.x
rcp r2.x, r0.x
rcp r2.y, r0.y
rcp r2.z, r0.z
rcp r2.w, r0.w
mul r0, r1, r2
mul r1.xyz, r0.y, c1
mad r1.xyz, c0, r0.x, r1
mad r0.xyz, c2, r0.z, r1
mad r0.xyz, c3, r0.w, r0
mul r0.w, r3.y, r3.y
mad r0.w, r3.x, r3.x, -r0.w
mul r1, r3.yzzx, r3.xyzz
mov o3.xyz, r3
dp4 r2.x, c19, r1
dp4 r2.y, c20, r1
dp4 r2.z, c21, r1
mad r1.xyz, c22, r0.w, r2
add o5.xyz, r0, r1
mov o6, c24.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
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
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedbogogoamoamnjckocajnmfdpiebhkgooabaaaaaaeaakaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaalmaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefceeaiaaaaeaaaabaa
bbacaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaa
ogikcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
adaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaalhccabaaaacaaaaaaegacbaaaaaaaaaaapgapbaia
ebaaaaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadgaaaaafhccabaaaadaaaaaa
egacbaaaaaaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaj
pcaabaaaacaaaaaafgafbaiaebaaaaaaabaaaaaaegiocaaaacaaaaaaadaaaaaa
diaaaaahpcaabaaaadaaaaaafgafbaaaaaaaaaaaegaobaaaacaaaaaadiaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaaaaaaaajpcaabaaa
aeaaaaaaagaabaiaebaaaaaaabaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaaj
pcaabaaaabaaaaaakgakbaiaebaaaaaaabaaaaaaegiocaaaacaaaaaaaeaaaaaa
dcaaaaajpcaabaaaadaaaaaaegaobaaaaeaaaaaaagaabaaaaaaaaaaaegaobaaa
adaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaa
kgakbaaaaaaaaaaaegaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaa
acaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaacaaaaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadeaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaa
kgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
aaaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
aaaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
aaaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaai
pccabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
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
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD7;
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
  vec3 I_8;
  I_8 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 x2_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_9.x = dot (unity_SHBr, tmpvar_10);
  x2_9.y = dot (unity_SHBg, tmpvar_10);
  x2_9.z = dot (unity_SHBb, tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = (unity_4LightPosX0 - tmpvar_3.x);
  vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosY0 - tmpvar_3.y);
  vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosZ0 - tmpvar_3.z);
  vec4 tmpvar_14;
  tmpvar_14 = (((tmpvar_11 * tmpvar_11) + (tmpvar_12 * tmpvar_12)) + (tmpvar_13 * tmpvar_13));
  vec4 tmpvar_15;
  tmpvar_15 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_11 * tmpvar_7.x) + (tmpvar_12 * tmpvar_7.y)) + (tmpvar_13 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_14)
  )) * (1.0/((1.0 + 
    (tmpvar_14 * unity_4LightAtten0)
  ))));
  vec4 o_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_2 * 0.5);
  vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (I_8 - (2.0 * (
    dot (tmpvar_7, I_8)
   * tmpvar_7)));
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = ((x2_9 + (unity_SHC.xyz * 
    ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))
  )) + ((
    ((unity_LightColor[0].xyz * tmpvar_15.x) + (unity_LightColor[1].xyz * tmpvar_15.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_15.z)
  ) + (unity_LightColor[3].xyz * tmpvar_15.w)));
  xlv_TEXCOORD5 = o_16;
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform samplerCube _Skybox;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform vec4 _ReflectColor;
uniform float _Shininess;
uniform float _Reflection;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * _Color) * _Tint);
  vec3 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD2;
  vec3 x1_7;
  x1_7.x = dot (unity_SHAr, tmpvar_6);
  x1_7.y = dot (unity_SHAg, tmpvar_6);
  x1_7.z = dot (unity_SHAb, tmpvar_6);
  tmpvar_5 = (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x);
  vec4 c_8;
  vec4 c_9;
  c_9.xyz = (((tmpvar_4.xyz * tmpvar_5) * max (0.0, 
    dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)
  )) + ((tmpvar_5 * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD2, normalize(
      (_WorldSpaceLightPos0.xyz + tmpvar_2)
    ))), (_Shininess * 128.0))
   * tmpvar_3.w)));
  c_9.w = 1.0;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_4.xyz * (xlv_TEXCOORD4 + x1_7)));
  c_1.xyz = (c_8.xyz + ((textureCube (_Skybox, xlv_TEXCOORD1) * 
    (_Reflection * (1.0 - dot (normalize(tmpvar_2), xlv_TEXCOORD2)))
  ).xyz * _ReflectColor.xyz));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 25 [_MainTex_ST]
Vector 15 [_ProjectionParams]
Vector 16 [_ScreenParams]
Vector 14 [_WorldSpaceCameraPos]
Vector 20 [unity_4LightAtten0]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 23 [unity_SHBb]
Vector 22 [unity_SHBg]
Vector 21 [unity_SHBr]
Vector 24 [unity_SHC]
"vs_3_0
def c26, 0, 1, 0.5, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6
dcl_texcoord7 o7
mad o1.xy, v2, c25, c25.zwzw
dp4 r0.x, c8, v0
dp4 r0.y, c9, v0
dp4 r0.z, c10, v0
add r1.xyz, -r0, c14
mul r2.xyz, c12, v1.y
mad r2.xyz, c11, v1.x, r2
mad r2.xyz, c13, v1.z, r2
nrm r3.xyz, r2
dp3 r0.w, -r1, r3
add r0.w, r0.w, r0.w
mad o2.xyz, r3, -r0.w, -r1
add r1, -r0.x, c17
mov o4.xyz, r0
add r2, -r0.y, c18
add r0, -r0.z, c19
mul r4, r3.y, r2
mul r2, r2, r2
mad r2, r1, r1, r2
mad r1, r1, r3.x, r4
mad r1, r0, r3.z, r1
mad r0, r0, r0, r2
rsq r2.x, r0.x
rsq r2.y, r0.y
rsq r2.z, r0.z
rsq r2.w, r0.w
mov r4.y, c26.y
mad r0, r0, c20, r4.y
mul r1, r1, r2
max r1, r1, c26.x
rcp r2.x, r0.x
rcp r2.y, r0.y
rcp r2.z, r0.z
rcp r2.w, r0.w
mul r0, r1, r2
mul r1.xyz, r0.y, c1
mad r1.xyz, c0, r0.x, r1
mad r0.xyz, c2, r0.z, r1
mad r0.xyz, c3, r0.w, r0
mul r0.w, r3.y, r3.y
mad r0.w, r3.x, r3.x, -r0.w
mul r1, r3.yzzx, r3.xyzz
mov o3.xyz, r3
dp4 r2.x, c21, r1
dp4 r2.y, c22, r1
dp4 r2.z, c23, r1
mad r1.xyz, c24, r0.w, r2
add o5.xyz, r0, r1
dp4 r0.y, c5, v0
mul r1.x, r0.y, c15.x
mul r1.w, r1.x, c26.z
dp4 r0.x, c4, v0
dp4 r0.w, c7, v0
mul r1.xz, r0.xyww, c26.z
mad o6.xy, r1.z, c16.zwzw, r1.xwzw
dp4 r0.z, c6, v0
mov o0, r0
mov o6.zw, r0
mov o7, c26.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
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
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedbanhklomoammlldpgjgcoajmdoalofeiabaaaaaapaakaaaaadaaaaaa
cmaaaaaaceabaaaaamacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcnmaiaaaaeaaaabaadhacaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaa
ahaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaa
anaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaa
bcaaaaaadiaaaaaibcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaibcaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaajhcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaaiicaabaaaabaaaaaaegacbaiaebaaaaaaadaaaaaaegacbaaa
abaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaalhccabaaaacaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaabaaaaaa
egacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaa
fgafbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaa
aeaaaaaafgafbaaaabaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaia
ebaaaaaaacaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaa
kgakbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaa
aeaaaaaaegaobaaaafaaaaaaagaabaaaabaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaa
dcaaaaajpcaabaaaadaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaakgakbaaaabaaaaaa
egaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaadaaaaaadcaaaaan
pcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaadaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaaacaaaaaa
egaobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaacaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaacaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaacaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaacaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaajaaaaaa
pgapbaaaacaaaaaaegacbaaaacaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaadaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaabaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaa
afaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaagaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaaahaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
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
  vec3 I_8;
  I_8 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 x2_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_9.x = dot (unity_SHBr, tmpvar_10);
  x2_9.y = dot (unity_SHBg, tmpvar_10);
  x2_9.z = dot (unity_SHBb, tmpvar_10);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (I_8 - (2.0 * (
    dot (tmpvar_7, I_8)
   * tmpvar_7)));
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (x2_9 + (unity_SHC.xyz * (
    (tmpvar_7.x * tmpvar_7.x)
   - 
    (tmpvar_7.y * tmpvar_7.y)
  )));
  xlv_TEXCOORD6 = tmpvar_2.z;
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform samplerCube _Skybox;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform vec4 _ReflectColor;
uniform float _Shininess;
uniform float _Reflection;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * _Color) * _Tint);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD2;
  vec3 x1_6;
  x1_6.x = dot (unity_SHAr, tmpvar_5);
  x1_6.y = dot (unity_SHAg, tmpvar_5);
  x1_6.z = dot (unity_SHAb, tmpvar_5);
  vec4 c_7;
  vec4 c_8;
  c_8.xyz = (((tmpvar_4.xyz * _LightColor0.xyz) * max (0.0, 
    dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)
  )) + ((_LightColor0.xyz * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD2, normalize(
      (_WorldSpaceLightPos0.xyz + tmpvar_2)
    ))), (_Shininess * 128.0))
   * tmpvar_3.w)));
  c_8.w = 1.0;
  c_7.w = c_8.w;
  c_7.xyz = (c_8.xyz + (tmpvar_4.xyz * (xlv_TEXCOORD4 + x1_6)));
  c_1.w = c_7.w;
  c_1.xyz = (c_7.xyz + ((textureCube (_Skybox, xlv_TEXCOORD1) * 
    (_Reflection * (1.0 - dot (normalize(tmpvar_2), xlv_TEXCOORD2)))
  ).xyz * _ReflectColor.xyz));
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD6))
  ), 0.0, 1.0)));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 15 [_MainTex_ST]
Vector 10 [_WorldSpaceCameraPos]
Vector 13 [unity_SHBb]
Vector 12 [unity_SHBg]
Vector 11 [unity_SHBr]
Vector 14 [unity_SHC]
"vs_3_0
def c16, 0, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord6 o6.x
dcl_texcoord7 o7
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c15, c15.zwzw
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, -r0, c10
mov o4.xyz, r0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r2.xyz, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad o2.xyz, r2, -r0.x, -r1
mul r0.x, r2.y, r2.y
mad r0.x, r2.x, r2.x, -r0.x
mul r1, r2.yzzx, r2.xyzz
mov o3.xyz, r2
dp4 r2.x, c11, r1
dp4 r2.y, c12, r1
dp4 r2.z, c13, r1
mad o5.xyz, c14, r0.x, r2
dp4 r0.x, c2, v0
mov o0.z, r0.x
mov o6.x, r0.x
mov o7, c16.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
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
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedbhajoplohgmpfplhmeenplilpocakllcabaaaaaaneahaaaaadaaaaaa
cmaaaaaaceabaaaaamacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcmaafaaaaeaaaabaahaabaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
eccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaa
agaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafeccabaaa
abaaaaaackaabaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaadgaaaaafhccabaaa
aeaaaaaaegacbaaaabaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaalhccabaaaacaaaaaaegacbaaaaaaaaaaapgapbaia
ebaaaaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadgaaaaafhccabaaaadaaaaaa
egacbaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaaaaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaabaaaaaabbaaaaaiccaabaaaaaaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaabaaaaaabbaaaaaiecaabaaaaaaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaacaaaaaacmaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaipccabaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
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
  vec3 I_8;
  I_8 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 x2_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_9.x = dot (unity_SHBr, tmpvar_10);
  x2_9.y = dot (unity_SHBg, tmpvar_10);
  x2_9.z = dot (unity_SHBb, tmpvar_10);
  vec4 o_11;
  vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_2 * 0.5);
  vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (I_8 - (2.0 * (
    dot (tmpvar_7, I_8)
   * tmpvar_7)));
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (x2_9 + (unity_SHC.xyz * (
    (tmpvar_7.x * tmpvar_7.x)
   - 
    (tmpvar_7.y * tmpvar_7.y)
  )));
  xlv_TEXCOORD5 = o_11;
  xlv_TEXCOORD6 = tmpvar_2.z;
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform samplerCube _Skybox;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform vec4 _ReflectColor;
uniform float _Shininess;
uniform float _Reflection;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * _Color) * _Tint);
  vec3 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD2;
  vec3 x1_7;
  x1_7.x = dot (unity_SHAr, tmpvar_6);
  x1_7.y = dot (unity_SHAg, tmpvar_6);
  x1_7.z = dot (unity_SHAb, tmpvar_6);
  tmpvar_5 = (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x);
  vec4 c_8;
  vec4 c_9;
  c_9.xyz = (((tmpvar_4.xyz * tmpvar_5) * max (0.0, 
    dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)
  )) + ((tmpvar_5 * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD2, normalize(
      (_WorldSpaceLightPos0.xyz + tmpvar_2)
    ))), (_Shininess * 128.0))
   * tmpvar_3.w)));
  c_9.w = 1.0;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_4.xyz * (xlv_TEXCOORD4 + x1_7)));
  c_1.w = c_8.w;
  c_1.xyz = (c_8.xyz + ((textureCube (_Skybox, xlv_TEXCOORD1) * 
    (_Reflection * (1.0 - dot (normalize(tmpvar_2), xlv_TEXCOORD2)))
  ).xyz * _ReflectColor.xyz));
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD6))
  ), 0.0, 1.0)));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 17 [_MainTex_ST]
Vector 11 [_ProjectionParams]
Vector 12 [_ScreenParams]
Vector 10 [_WorldSpaceCameraPos]
Vector 15 [unity_SHBb]
Vector 14 [unity_SHBg]
Vector 13 [unity_SHBr]
Vector 16 [unity_SHC]
"vs_3_0
def c18, 0.5, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6
dcl_texcoord6 o7.x
dcl_texcoord7 o8
mad o1.xy, v2, c17, c17.zwzw
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, -r0, c10
mov o4.xyz, r0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r2.xyz, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad o2.xyz, r2, -r0.x, -r1
mul r0.x, r2.y, r2.y
mad r0.x, r2.x, r2.x, -r0.x
mul r1, r2.yzzx, r2.xyzz
mov o3.xyz, r2
dp4 r2.x, c13, r1
dp4 r2.y, c14, r1
dp4 r2.z, c15, r1
mad o5.xyz, c16, r0.x, r2
dp4 r0.y, c1, v0
mul r1.x, r0.y, c11.x
mul r1.w, r1.x, c18.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c18.x
mad o6.xy, r1.z, c12.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov o0, r0
mov o6.zw, r0
mov o7.x, r0.z
mov o8, c18.y

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
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
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedlfijimopchnodhmhjjlobkhgehiacameabaaaaaaimaiaaaaadaaaaaa
cmaaaaaaceabaaaaceacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaomaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaomaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcgaagaaaaeaaaabaajiabaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaad
pccabaaaahaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
eccabaaaabaaaaaackaabaaaaaaaaaaadgaaaaafmccabaaaagaaaaaakgaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
anaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaa
acaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaaakbabaaa
acaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaaakbabaaa
acaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaacaaaaaabkbabaaa
acaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaabkbabaaa
acaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaabkbabaaa
acaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaaacaaaaaa
ckiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaackbabaaaacaaaaaa
ckiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaackbabaaaacaaaaaa
ckiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaacaaaaaaaaaaaaajhcaabaaaadaaaaaaegacbaiaebaaaaaa
acaaaaaaegiccaaaabaaaaaaaeaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaa
acaaaaaabaaaaaaiecaabaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaaegacbaaa
abaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaalhccabaaaacaaaaaaegacbaaaabaaaaaakgakbaiaebaaaaaaaaaaaaaa
egacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaa
diaaaaahecaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaak
ecaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaackaabaiaebaaaaaa
aaaaaaaadiaaaaahpcaabaaaabaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaa
bbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaabaaaaaa
dcaaaaakhccabaaaafaaaaaaegiccaaaacaaaaaacmaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakfcaabaaaaaaaaaaaagadbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaadpaaaaaaahdccabaaaagaaaaaakgakbaaaaaaaaaaa
mgaabaaaaaaaaaaadgaaaaaipccabaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
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
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
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
  vec3 I_8;
  I_8 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 x2_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_9.x = dot (unity_SHBr, tmpvar_10);
  x2_9.y = dot (unity_SHBg, tmpvar_10);
  x2_9.z = dot (unity_SHBb, tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = (unity_4LightPosX0 - tmpvar_3.x);
  vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosY0 - tmpvar_3.y);
  vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosZ0 - tmpvar_3.z);
  vec4 tmpvar_14;
  tmpvar_14 = (((tmpvar_11 * tmpvar_11) + (tmpvar_12 * tmpvar_12)) + (tmpvar_13 * tmpvar_13));
  vec4 tmpvar_15;
  tmpvar_15 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_11 * tmpvar_7.x) + (tmpvar_12 * tmpvar_7.y)) + (tmpvar_13 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_14)
  )) * (1.0/((1.0 + 
    (tmpvar_14 * unity_4LightAtten0)
  ))));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (I_8 - (2.0 * (
    dot (tmpvar_7, I_8)
   * tmpvar_7)));
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = ((x2_9 + (unity_SHC.xyz * 
    ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))
  )) + ((
    ((unity_LightColor[0].xyz * tmpvar_15.x) + (unity_LightColor[1].xyz * tmpvar_15.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_15.z)
  ) + (unity_LightColor[3].xyz * tmpvar_15.w)));
  xlv_TEXCOORD6 = tmpvar_2.z;
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform samplerCube _Skybox;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform vec4 _ReflectColor;
uniform float _Shininess;
uniform float _Reflection;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD6;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * _Color) * _Tint);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD2;
  vec3 x1_6;
  x1_6.x = dot (unity_SHAr, tmpvar_5);
  x1_6.y = dot (unity_SHAg, tmpvar_5);
  x1_6.z = dot (unity_SHAb, tmpvar_5);
  vec4 c_7;
  vec4 c_8;
  c_8.xyz = (((tmpvar_4.xyz * _LightColor0.xyz) * max (0.0, 
    dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)
  )) + ((_LightColor0.xyz * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD2, normalize(
      (_WorldSpaceLightPos0.xyz + tmpvar_2)
    ))), (_Shininess * 128.0))
   * tmpvar_3.w)));
  c_8.w = 1.0;
  c_7.w = c_8.w;
  c_7.xyz = (c_8.xyz + (tmpvar_4.xyz * (xlv_TEXCOORD4 + x1_6)));
  c_1.w = c_7.w;
  c_1.xyz = (c_7.xyz + ((textureCube (_Skybox, xlv_TEXCOORD1) * 
    (_Reflection * (1.0 - dot (normalize(tmpvar_2), xlv_TEXCOORD2)))
  ).xyz * _ReflectColor.xyz));
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD6))
  ), 0.0, 1.0)));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 23 [_MainTex_ST]
Vector 14 [_WorldSpaceCameraPos]
Vector 18 [unity_4LightAtten0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 21 [unity_SHBb]
Vector 20 [unity_SHBg]
Vector 19 [unity_SHBr]
Vector 22 [unity_SHC]
"vs_3_0
def c24, 0, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord6 o6.x
dcl_texcoord7 o7
dp4 o0.x, c4, v0
dp4 o0.y, c5, v0
dp4 o0.w, c7, v0
mad o1.xy, v2, c23, c23.zwzw
dp4 r0.x, c8, v0
dp4 r0.y, c9, v0
dp4 r0.z, c10, v0
add r1.xyz, -r0, c14
mul r2.xyz, c12, v1.y
mad r2.xyz, c11, v1.x, r2
mad r2.xyz, c13, v1.z, r2
nrm r3.xyz, r2
dp3 r0.w, -r1, r3
add r0.w, r0.w, r0.w
mad o2.xyz, r3, -r0.w, -r1
add r1, -r0.x, c15
mov o4.xyz, r0
add r2, -r0.y, c16
add r0, -r0.z, c17
mul r4, r3.y, r2
mul r2, r2, r2
mad r2, r1, r1, r2
mad r1, r1, r3.x, r4
mad r1, r0, r3.z, r1
mad r0, r0, r0, r2
rsq r2.x, r0.x
rsq r2.y, r0.y
rsq r2.z, r0.z
rsq r2.w, r0.w
mov r4.y, c24.y
mad r0, r0, c18, r4.y
mul r1, r1, r2
max r1, r1, c24.x
rcp r2.x, r0.x
rcp r2.y, r0.y
rcp r2.z, r0.z
rcp r2.w, r0.w
mul r0, r1, r2
mul r1.xyz, r0.y, c1
mad r1.xyz, c0, r0.x, r1
mad r0.xyz, c2, r0.z, r1
mad r0.xyz, c3, r0.w, r0
mul r0.w, r3.y, r3.y
mad r0.w, r3.x, r3.x, -r0.w
mul r1, r3.yzzx, r3.xyzz
mov o3.xyz, r3
dp4 r2.x, c19, r1
dp4 r2.y, c20, r1
dp4 r2.z, c21, r1
mad r1.xyz, c22, r0.w, r2
add o5.xyz, r0, r1
dp4 r0.x, c6, v0
mov o0.z, r0.x
mov o6.x, r0.x
mov o7, c24.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
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
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedlmdjojlmakdngimgfkebdljdpneikfgiabaaaaaaimakaaaaadaaaaaa
cmaaaaaaceabaaaaamacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaneaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefchiaiaaaaeaaaabaaboacaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
eccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaa
agaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafeccabaaa
abaaaaaackaabaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaaiicaabaaa
aaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaalhccabaaaacaaaaaa
egacbaaaaaaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
dgaaaaafhccabaaaadaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaaeaaaaaa
egacbaaaabaaaaaaaaaaaaajpcaabaaaacaaaaaafgafbaiaebaaaaaaabaaaaaa
egiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaadaaaaaafgafbaaaaaaaaaaa
egaobaaaacaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
acaaaaaaaaaaaaajpcaabaaaaeaaaaaaagaabaiaebaaaaaaabaaaaaaegiocaaa
acaaaaaaacaaaaaaaaaaaaajpcaabaaaabaaaaaakgakbaiaebaaaaaaabaaaaaa
egiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaaeaaaaaa
agaabaaaaaaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaa
aeaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaaegaobaaaabaaaaaakgakbaaaaaaaaaaaegaobaaaadaaaaaaeeaaaaaf
pcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaa
acaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaa
egiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
agaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaaaaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaaaaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaaaaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaipccabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
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
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
varying vec4 xlv_TEXCOORD7;
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
  vec3 I_8;
  I_8 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec3 x2_9;
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_9.x = dot (unity_SHBr, tmpvar_10);
  x2_9.y = dot (unity_SHBg, tmpvar_10);
  x2_9.z = dot (unity_SHBb, tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = (unity_4LightPosX0 - tmpvar_3.x);
  vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosY0 - tmpvar_3.y);
  vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosZ0 - tmpvar_3.z);
  vec4 tmpvar_14;
  tmpvar_14 = (((tmpvar_11 * tmpvar_11) + (tmpvar_12 * tmpvar_12)) + (tmpvar_13 * tmpvar_13));
  vec4 tmpvar_15;
  tmpvar_15 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_11 * tmpvar_7.x) + (tmpvar_12 * tmpvar_7.y)) + (tmpvar_13 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_14)
  )) * (1.0/((1.0 + 
    (tmpvar_14 * unity_4LightAtten0)
  ))));
  vec4 o_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_2 * 0.5);
  vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (I_8 - (2.0 * (
    dot (tmpvar_7, I_8)
   * tmpvar_7)));
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = ((x2_9 + (unity_SHC.xyz * 
    ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))
  )) + ((
    ((unity_LightColor[0].xyz * tmpvar_15.x) + (unity_LightColor[1].xyz * tmpvar_15.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_15.z)
  ) + (unity_LightColor[3].xyz * tmpvar_15.w)));
  xlv_TEXCOORD5 = o_16;
  xlv_TEXCOORD6 = tmpvar_2.z;
  xlv_TEXCOORD7 = tmpvar_1;
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
uniform vec4 _SpecColor;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform samplerCube _Skybox;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform vec4 _ReflectColor;
uniform float _Shininess;
uniform float _Reflection;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying float xlv_TEXCOORD6;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * _Color) * _Tint);
  vec3 tmpvar_5;
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = xlv_TEXCOORD2;
  vec3 x1_7;
  x1_7.x = dot (unity_SHAr, tmpvar_6);
  x1_7.y = dot (unity_SHAg, tmpvar_6);
  x1_7.z = dot (unity_SHAb, tmpvar_6);
  tmpvar_5 = (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5).x);
  vec4 c_8;
  vec4 c_9;
  c_9.xyz = (((tmpvar_4.xyz * tmpvar_5) * max (0.0, 
    dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)
  )) + ((tmpvar_5 * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD2, normalize(
      (_WorldSpaceLightPos0.xyz + tmpvar_2)
    ))), (_Shininess * 128.0))
   * tmpvar_3.w)));
  c_9.w = 1.0;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_4.xyz * (xlv_TEXCOORD4 + x1_7)));
  c_1.w = c_8.w;
  c_1.xyz = (c_8.xyz + ((textureCube (_Skybox, xlv_TEXCOORD1) * 
    (_Reflection * (1.0 - dot (normalize(tmpvar_2), xlv_TEXCOORD2)))
  ).xyz * _ReflectColor.xyz));
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD6))
  ), 0.0, 1.0)));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 25 [_MainTex_ST]
Vector 15 [_ProjectionParams]
Vector 16 [_ScreenParams]
Vector 14 [_WorldSpaceCameraPos]
Vector 20 [unity_4LightAtten0]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 23 [unity_SHBb]
Vector 22 [unity_SHBg]
Vector 21 [unity_SHBr]
Vector 24 [unity_SHC]
"vs_3_0
def c26, 0, 1, 0.5, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6
dcl_texcoord6 o7.x
dcl_texcoord7 o8
mad o1.xy, v2, c25, c25.zwzw
dp4 r0.x, c8, v0
dp4 r0.y, c9, v0
dp4 r0.z, c10, v0
add r1.xyz, -r0, c14
mul r2.xyz, c12, v1.y
mad r2.xyz, c11, v1.x, r2
mad r2.xyz, c13, v1.z, r2
nrm r3.xyz, r2
dp3 r0.w, -r1, r3
add r0.w, r0.w, r0.w
mad o2.xyz, r3, -r0.w, -r1
add r1, -r0.x, c17
mov o4.xyz, r0
add r2, -r0.y, c18
add r0, -r0.z, c19
mul r4, r3.y, r2
mul r2, r2, r2
mad r2, r1, r1, r2
mad r1, r1, r3.x, r4
mad r1, r0, r3.z, r1
mad r0, r0, r0, r2
rsq r2.x, r0.x
rsq r2.y, r0.y
rsq r2.z, r0.z
rsq r2.w, r0.w
mov r4.y, c26.y
mad r0, r0, c20, r4.y
mul r1, r1, r2
max r1, r1, c26.x
rcp r2.x, r0.x
rcp r2.y, r0.y
rcp r2.z, r0.z
rcp r2.w, r0.w
mul r0, r1, r2
mul r1.xyz, r0.y, c1
mad r1.xyz, c0, r0.x, r1
mad r0.xyz, c2, r0.z, r1
mad r0.xyz, c3, r0.w, r0
mul r0.w, r3.y, r3.y
mad r0.w, r3.x, r3.x, -r0.w
mul r1, r3.yzzx, r3.xyzz
mov o3.xyz, r3
dp4 r2.x, c21, r1
dp4 r2.y, c22, r1
dp4 r2.z, c23, r1
mad r1.xyz, c24, r0.w, r2
add o5.xyz, r0, r1
dp4 r0.y, c5, v0
mul r1.x, r0.y, c15.x
mul r1.w, r1.x, c26.z
dp4 r0.x, c4, v0
dp4 r0.w, c7, v0
mul r1.xz, r0.xyww, c26.z
mad o6.xy, r1.z, c16.zwzw, r1.xwzw
dp4 r0.z, c6, v0
mov o0, r0
mov o6.zw, r0
mov o7.x, r0.z
mov o8, c26.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
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
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedmebgbdpopmmoaolgbeihkgogjmknkmbgabaaaaaaeealaaaaadaaaaaa
cmaaaaaaceabaaaaceacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaomaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaomaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcbiajaaaaeaaaabaaegacaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaad
pccabaaaahaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
eccabaaaabaaaaaackaabaaaaaaaaaaadgaaaaafmccabaaaagaaaaaakgaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
anaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaa
acaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaaakbabaaa
acaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaaakbabaaa
acaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaacaaaaaabkbabaaa
acaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaabkbabaaa
acaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaabkbabaaa
acaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaaacaaaaaa
ckiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaackbabaaaacaaaaaa
ckiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaackbabaaaacaaaaaa
ckiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaacaaaaaaaaaaaaajhcaabaaaadaaaaaaegacbaiaebaaaaaa
acaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaaiecaabaaaaaaaaaaaegacbaia
ebaaaaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaalhccabaaaacaaaaaaegacbaaaabaaaaaa
kgakbaiaebaaaaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaa
adaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaaacaaaaaa
aaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaa
adaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaabaaaaaaegaobaaaadaaaaaa
diaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaaj
pcaabaaaafaaaaaaagaabaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaacaaaaaa
aaaaaaajpcaabaaaacaaaaaakgakbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaa
aeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaaabaaaaaa
egaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaa
afaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaa
acaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaa
egaobaaaadaaaaaadcaaaaanpcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaa
acaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaak
pcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaa
adaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
deaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaa
acaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaaacaaaaaa
ahaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaa
acaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
aiaaaaaakgakbaaaacaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaacaaaaaaajaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakecaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaabaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaacmaaaaaakgakbaaaaaaaaaaaegacbaaa
adaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakfcaabaaaaaaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaadpaaaaaaahdccabaaaagaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaa
dgaaaaaipccabaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
doaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Vector 7 [_Color]
Vector 5 [_LightColor0]
Vector 9 [_ReflectColor]
Float 11 [_Reflection]
Float 10 [_Shininess]
Vector 6 [_SpecColor]
Vector 8 [_Tint]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 4 [unity_SHAb]
Vector 3 [unity_SHAg]
Vector 2 [unity_SHAr]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
"ps_3_0
def c12, 1, 0, 128, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4_pp v4.xyz
dcl_2d s0
dcl_cube s1
mad_pp r0, v2.xyzx, c12.xxxy, c12.yyyx
dp4_pp r1.x, c2, r0
dp4_pp r1.y, c3, r0
dp4_pp r1.z, c4, r0
add_pp r0.xyz, r1, v4
add r1.xyz, c0, -v3
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mad_pp r2.xyz, r1, r0.w, c1
mul_pp r1.xyz, r0.w, r1
dp3 r0.w, r1, v2
add_pp r0.w, -r0.w, c12.x
mul r0.w, r0.w, c11.x
nrm_pp r1.xyz, r2
dp3_pp r1.x, v2, r1
max r2.x, r1.x, c12.y
mov r1.z, c12.z
mul r1.x, r1.z, c10.x
pow r3.x, r2.x, r1.x
texld_pp r1, v0, s0
mul r1.w, r1.w, r3.x
mul r1.xyz, r1, c7
mul_pp r1.xyz, r1, c8
mov r2.xyz, c5
mul r2.xyz, r2, c6
mul r2.xyz, r1.w, r2
dp3_pp r1.w, v2, c1
max_pp r2.w, r1.w, c12.y
mul_pp r3.xyz, r1, c5
mad_pp r2.xyz, r3, r2.w, r2
mad_pp r0.xyz, r1, r0, r2
texld_pp r1, v1, s1
mul_pp r1.xyz, r0.w, r1
mad_pp oC0.xyz, r1, c9, r0
mov_pp oC0.w, c12.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Vector 144 [_Color]
Vector 160 [_Tint]
Vector 176 [_ReflectColor]
Float 192 [_Shininess]
Float 196 [_Reflection]
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
eefieceddbdmcopeaegongbbcpompninfeklkhnkabaaaaaafmagaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcceafaaaaeaaaaaaaejabaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaacjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadgaaaaafhcaabaaa
aaaaaaaaegbcbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaafaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegbcbaiaebaaaaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegbcbaaaadaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaa
abeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaaiocaabaaa
abaaaaaaagajbaaaacaaaaaaagijcaaaaaaaaaaaajaaaaaadiaaaaaiocaabaaa
abaaaaaafgaobaaaabaaaaaaagijcaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaa
acaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaah
hcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaa
abaaaaaaegbcbaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaadeaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaadaaaaaa
jgahbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaadaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
aaaaaaaajgahbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbcbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Vector 7 [_Color]
Vector 5 [_LightColor0]
Vector 9 [_ReflectColor]
Float 11 [_Reflection]
Float 10 [_Shininess]
Vector 6 [_SpecColor]
Vector 8 [_Tint]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 4 [unity_SHAb]
Vector 3 [unity_SHAg]
Vector 2 [unity_SHAr]
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Skybox] CUBE 2
"ps_3_0
def c12, 1, 0, 128, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4_pp v4.xyz
dcl_texcoord5 v5
dcl_2d s0
dcl_2d s1
dcl_cube s2
mad_pp r0, v2.xyzx, c12.xxxy, c12.yyyx
dp4_pp r1.x, c2, r0
dp4_pp r1.y, c3, r0
dp4_pp r1.z, c4, r0
add_pp r0.xyz, r1, v4
add r1.xyz, c0, -v3
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mad_pp r2.xyz, r1, r0.w, c1
mul_pp r1.xyz, r0.w, r1
dp3 r0.w, r1, v2
add_pp r0.w, -r0.w, c12.x
mul r0.w, r0.w, c11.x
nrm_pp r1.xyz, r2
dp3_pp r1.x, v2, r1
max r2.x, r1.x, c12.y
mov r1.z, c12.z
mul r1.x, r1.z, c10.x
pow r3.x, r2.x, r1.x
texld_pp r1, v0, s1
mul r1.w, r1.w, r3.x
mul r1.xyz, r1, c7
mul_pp r1.xyz, r1, c8
texldp_pp r2, v5, s0
mul_pp r2.xyz, r2.x, c5
mul r3.xyz, r2, c6
mul_pp r2.xyz, r1, r2
mul r3.xyz, r1.w, r3
dp3_pp r1.w, v2, c1
max_pp r2.w, r1.w, c12.y
mad_pp r2.xyz, r2, r2.w, r3
mad_pp r0.xyz, r1, r0, r2
texld_pp r1, v1, s2
mul_pp r1.xyz, r0.w, r1
mad_pp oC0.xyz, r1, c9, r0
mov_pp oC0.w, c12.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Skybox] CUBE 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Vector 144 [_Color]
Vector 160 [_Tint]
Vector 176 [_ReflectColor]
Float 192 [_Shininess]
Float 196 [_Reflection]
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
eefiecedpikfpcahodmkdonnnnjkkapkjjmlhmbaabaaaaaapeagaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckeafaaaaeaaaaaaagjabaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaacjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadlcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadgaaaaafhcaabaaa
aaaaaaaaegbcbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaafaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegbcbaiaebaaaaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegbcbaaaadaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaa
abeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaaiocaabaaa
abaaaaaaagajbaaaacaaaaaaagijcaaaaaaaaaaaajaaaaaadiaaaaaiocaabaaa
abaaaaaafgaobaaaabaaaaaaagijcaaaaaaaaaaaakaaaaaaaoaaaaahdcaabaaa
acaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaaagaabaaaacaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaa
adaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaa
acaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaa
agaabaaaabaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaabaaaaaaegbcbaaa
adaaaaaaegiccaaaacaaaaaaaaaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaacaaaaaa
agaabaaaabaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaa
abaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
egbcbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaaaaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Vector 9 [_Color]
Vector 7 [_LightColor0]
Vector 11 [_ReflectColor]
Float 13 [_Reflection]
Float 12 [_Shininess]
Vector 8 [_SpecColor]
Vector 10 [_Tint]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 5 [unity_FogColor]
Vector 6 [unity_FogParams]
Vector 4 [unity_SHAb]
Vector 3 [unity_SHAg]
Vector 2 [unity_SHAr]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
"ps_3_0
def c14, 1, 0, 128, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4_pp v4.xyz
dcl_texcoord6 v5.x
dcl_2d s0
dcl_cube s1
mad_pp r0, v2.xyzx, c14.xxxy, c14.yyyx
dp4_pp r1.x, c2, r0
dp4_pp r1.y, c3, r0
dp4_pp r1.z, c4, r0
add_pp r0.xyz, r1, v4
add r1.xyz, c0, -v3
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mad_pp r2.xyz, r1, r0.w, c1
mul_pp r1.xyz, r0.w, r1
dp3 r0.w, r1, v2
add_pp r0.w, -r0.w, c14.x
mul r0.w, r0.w, c13.x
nrm_pp r1.xyz, r2
dp3_pp r1.x, v2, r1
max r2.x, r1.x, c14.y
mov r1.z, c14.z
mul r1.x, r1.z, c12.x
pow r3.x, r2.x, r1.x
texld_pp r1, v0, s0
mul r1.w, r1.w, r3.x
mul r1.xyz, r1, c9
mul_pp r1.xyz, r1, c10
mov r2.xyz, c7
mul r2.xyz, r2, c8
mul r2.xyz, r1.w, r2
dp3_pp r1.w, v2, c1
max_pp r2.w, r1.w, c14.y
mul_pp r3.xyz, r1, c7
mad_pp r2.xyz, r3, r2.w, r2
mad_pp r0.xyz, r1, r0, r2
texld_pp r1, v1, s1
mul_pp r1.xyz, r0.w, r1
mad_pp r0.xyz, r1, c11, r0
add r0.xyz, r0, -c5
mul r0.w, c6.y, v5.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c5
mov_pp oC0.w, c14.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Vector 144 [_Color]
Vector 160 [_Tint]
Vector 176 [_ReflectColor]
Float 192 [_Shininess]
Float 196 [_Reflection]
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
eefiecedogdhkgaaljkmpjejepeoljeiikpoillbabaaaaaadaahaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaahaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcoaafaaaaeaaaaaaahiabaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaacjaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fidaaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
ecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadgaaaaafhcaabaaaaaaaaaaaegbcbaaaadaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaabaaaaaaegbcbaaaafaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaia
ebaaaaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaa
adaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaa
amaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
adaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaaaacaaaaaadiaaaaaiocaabaaaabaaaaaaagajbaaaacaaaaaa
agijcaaaaaaaaaaaajaaaaaadiaaaaaiocaabaaaabaaaaaafgaobaaaabaaaaaa
agijcaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaa
agaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaabaaaaaaegbcbaaaadaaaaaa
egiccaaaacaaaaaaaaaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaadiaaaaaihcaabaaaadaaaaaajgahbaaaabaaaaaaegiccaaa
aaaaaaaaagaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaadaaaaaaagaabaaa
abaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaabaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegbcbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaalaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaackbabaaaabaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaag
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaadaaaaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Vector 9 [_Color]
Vector 7 [_LightColor0]
Vector 11 [_ReflectColor]
Float 13 [_Reflection]
Float 12 [_Shininess]
Vector 8 [_SpecColor]
Vector 10 [_Tint]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 5 [unity_FogColor]
Vector 6 [unity_FogParams]
Vector 4 [unity_SHAb]
Vector 3 [unity_SHAg]
Vector 2 [unity_SHAr]
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_Skybox] CUBE 2
"ps_3_0
def c14, 1, 0, 128, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4_pp v4.xyz
dcl_texcoord5 v5
dcl_texcoord6 v6.x
dcl_2d s0
dcl_2d s1
dcl_cube s2
mad_pp r0, v2.xyzx, c14.xxxy, c14.yyyx
dp4_pp r1.x, c2, r0
dp4_pp r1.y, c3, r0
dp4_pp r1.z, c4, r0
add_pp r0.xyz, r1, v4
add r1.xyz, c0, -v3
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mad_pp r2.xyz, r1, r0.w, c1
mul_pp r1.xyz, r0.w, r1
dp3 r0.w, r1, v2
add_pp r0.w, -r0.w, c14.x
mul r0.w, r0.w, c13.x
nrm_pp r1.xyz, r2
dp3_pp r1.x, v2, r1
max r2.x, r1.x, c14.y
mov r1.z, c14.z
mul r1.x, r1.z, c12.x
pow r3.x, r2.x, r1.x
texld_pp r1, v0, s1
mul r1.w, r1.w, r3.x
mul r1.xyz, r1, c9
mul_pp r1.xyz, r1, c10
texldp_pp r2, v5, s0
mul_pp r2.xyz, r2.x, c7
mul r3.xyz, r2, c8
mul_pp r2.xyz, r1, r2
mul r3.xyz, r1.w, r3
dp3_pp r1.w, v2, c1
max_pp r2.w, r1.w, c14.y
mad_pp r2.xyz, r2, r2.w, r3
mad_pp r0.xyz, r1, r0, r2
texld_pp r1, v1, s2
mul_pp r1.xyz, r0.w, r1
mad_pp r0.xyz, r1, c11, r0
add r0.xyz, r0, -c5
mul r0.w, c6.y, v6.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c5
mov_pp oC0.w, c14.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Skybox] CUBE 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Vector 144 [_Color]
Vector 160 [_Tint]
Vector 176 [_ReflectColor]
Float 192 [_Shininess]
Float 196 [_Reflection]
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
eefiecedigdcflbhecpbikhkdbloaonndnhopkjmabaaaaaamiahaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapalaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgaagaaaaeaaaaaaajiabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaacjaaaaaa
fjaaaaaeegiocaaaadaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafidaaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadlcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaadgaaaaafhcaabaaaaaaaaaaaegbcbaaaadaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaabaaaaaaegbcbaaaafaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaia
ebaaaaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaa
adaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaa
amaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
adaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaaaacaaaaaadiaaaaaiocaabaaaabaaaaaaagajbaaaacaaaaaa
agijcaaaaaaaaaaaajaaaaaadiaaaaaiocaabaaaabaaaaaafgaobaaaabaaaaaa
agijcaaaaaaaaaaaakaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaagaaaaaa
pgbpbaaaagaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaaagaabaaaacaaaaaa
egiccaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaacaaaaaajgahbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaaagaabaaaabaaaaaaegacbaaa
adaaaaaabaaaaaaibcaabaaaabaaaaaaegbcbaaaadaaaaaaegiccaaaacaaaaaa
aaaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaacaaaaaaagaabaaaabaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaabaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegbcbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaalaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaadaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
ckbabaaaabaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaadaaaaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Blend One One
  GpuProgramID 89707
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
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
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec4 c_3;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_6;
  tmpvar_6 = (_LightMatrix0 * tmpvar_5).xyz;
  tmpvar_2 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  tmpvar_1 = (_LightColor0.xyz * texture2D (_LightTexture0, vec2(dot (tmpvar_6, tmpvar_6))).w);
  vec4 c_7;
  vec4 c_8;
  c_8.xyz = (((
    ((tmpvar_4 * _Color) * _Tint)
  .xyz * tmpvar_1) * max (0.0, 
    dot (xlv_TEXCOORD1, tmpvar_2)
  )) + ((tmpvar_1 * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD1, normalize(
      (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2)))
    ))), (_Shininess * 128.0))
   * tmpvar_4.w)));
  c_8.w = 1.0;
  c_7.w = c_8.w;
  c_7.xyz = c_8.xyz;
  c_3.xyz = c_7.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgmcdldcfpcdocafdimlapgfmnhmdefjbabaaaaaaeaafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcimadaaaaeaaaabaaodaaaaaafjaaaaae
egiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
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
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = (((
    ((tmpvar_2 * _Color) * _Tint)
  .xyz * _LightColor0.xyz) * max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  )) + ((_LightColor0.xyz * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD1, normalize(
      (_WorldSpaceLightPos0.xyz + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2)))
    ))), (_Shininess * 128.0))
   * tmpvar_2.w)));
  c_4.w = 1.0;
  c_3.w = c_4.w;
  c_3.xyz = c_4.xyz;
  c_1.xyz = c_3.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedocckgjbcaclpbehmkdieonmjpmblnameabaaaaaaeaafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcimadaaaaeaaaabaaodaaaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
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
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec4 c_3;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD2;
  vec4 tmpvar_6;
  tmpvar_6 = (_LightMatrix0 * tmpvar_5);
  tmpvar_2 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  tmpvar_1 = (_LightColor0.xyz * ((
    float((tmpvar_6.z > 0.0))
   * texture2D (_LightTexture0, 
    ((tmpvar_6.xy / tmpvar_6.w) + 0.5)
  ).w) * texture2D (_LightTextureB0, vec2(dot (tmpvar_6.xyz, tmpvar_6.xyz))).w));
  vec4 c_7;
  vec4 c_8;
  c_8.xyz = (((
    ((tmpvar_4 * _Color) * _Tint)
  .xyz * tmpvar_1) * max (0.0, 
    dot (xlv_TEXCOORD1, tmpvar_2)
  )) + ((tmpvar_1 * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD1, normalize(
      (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2)))
    ))), (_Shininess * 128.0))
   * tmpvar_4.w)));
  c_8.w = 1.0;
  c_7.w = c_8.w;
  c_7.xyz = c_8.xyz;
  c_3.xyz = c_7.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgmcdldcfpcdocafdimlapgfmnhmdefjbabaaaaaaeaafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcimadaaaaeaaaabaaodaaaaaafjaaaaae
egiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
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
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform samplerCube _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec4 c_3;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_6;
  tmpvar_6 = (_LightMatrix0 * tmpvar_5).xyz;
  tmpvar_2 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  tmpvar_1 = (_LightColor0.xyz * (texture2D (_LightTextureB0, vec2(dot (tmpvar_6, tmpvar_6))).w * textureCube (_LightTexture0, tmpvar_6).w));
  vec4 c_7;
  vec4 c_8;
  c_8.xyz = (((
    ((tmpvar_4 * _Color) * _Tint)
  .xyz * tmpvar_1) * max (0.0, 
    dot (xlv_TEXCOORD1, tmpvar_2)
  )) + ((tmpvar_1 * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD1, normalize(
      (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2)))
    ))), (_Shininess * 128.0))
   * tmpvar_4.w)));
  c_8.w = 1.0;
  c_7.w = c_8.w;
  c_7.xyz = c_8.xyz;
  c_3.xyz = c_7.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgmcdldcfpcdocafdimlapgfmnhmdefjbabaaaaaaeaafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcimadaaaaeaaaabaaodaaaaaafjaaaaae
egiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
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
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  vec4 c_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = xlv_TEXCOORD2;
  tmpvar_1 = (_LightColor0.xyz * texture2D (_LightTexture0, (_LightMatrix0 * tmpvar_4).xy).w);
  vec4 c_5;
  vec4 c_6;
  c_6.xyz = (((
    ((tmpvar_3 * _Color) * _Tint)
  .xyz * tmpvar_1) * max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  )) + ((tmpvar_1 * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD1, normalize(
      (_WorldSpaceLightPos0.xyz + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2)))
    ))), (_Shininess * 128.0))
   * tmpvar_3.w)));
  c_6.w = 1.0;
  c_5.w = c_6.w;
  c_5.xyz = c_6.xyz;
  c_2.xyz = c_5.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgmcdldcfpcdocafdimlapgfmnhmdefjbabaaaaaaeaafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcimadaaaaeaaaabaaodaaaaaafjaaaaae
egiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaabbaaaaaaogikcaaaaaaaaaaabbaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "POINT" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1.z;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogParams;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec4 c_3;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_6;
  tmpvar_6 = (_LightMatrix0 * tmpvar_5).xyz;
  tmpvar_2 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  tmpvar_1 = (_LightColor0.xyz * texture2D (_LightTexture0, vec2(dot (tmpvar_6, tmpvar_6))).w);
  vec4 c_7;
  c_7.xyz = (((
    ((tmpvar_4 * _Color) * _Tint)
  .xyz * tmpvar_1) * max (0.0, 
    dot (xlv_TEXCOORD1, tmpvar_2)
  )) + ((tmpvar_1 * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD1, normalize(
      (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2)))
    ))), (_Shininess * 128.0))
   * tmpvar_4.w)));
  c_7.w = 1.0;
  c_3.xyz = mix (vec3(0.0, 0.0, 0.0), c_7.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD4))
  ), 0.0, 1.0)));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord4 o4.x
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0
dp4 r0.x, c2, v0
mov o0.z, r0.x
mov o4.x, r0.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednficaoenaomggojpcggbnfbbfpflnioiabaaaaaaimafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcmaadaaaaeaaaabaapaaaaaaafjaaaaaeegiocaaaaaaaaaaa
bcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafeccabaaaabaaaaaackaabaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaabbaaaaaa
ogikcaaaaaaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1.z;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogParams;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 c_3;
  c_3.xyz = (((
    ((tmpvar_2 * _Color) * _Tint)
  .xyz * _LightColor0.xyz) * max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  )) + ((_LightColor0.xyz * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD1, normalize(
      (_WorldSpaceLightPos0.xyz + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2)))
    ))), (_Shininess * 128.0))
   * tmpvar_2.w)));
  c_3.w = 1.0;
  c_1.xyz = mix (vec3(0.0, 0.0, 0.0), c_3.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD4))
  ), 0.0, 1.0)));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord4 o4.x
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0
dp4 r0.x, c2, v0
mov o0.z, r0.x
mov o4.x, r0.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 224
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhljahcbkjnbkgihbbpldklbhffdmakngabaaaaaaimafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcmaadaaaaeaaaabaapaaaaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafeccabaaaabaaaaaackaabaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaa
ogikcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1.z;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogParams;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec4 c_3;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD2;
  vec4 tmpvar_6;
  tmpvar_6 = (_LightMatrix0 * tmpvar_5);
  tmpvar_2 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  tmpvar_1 = (_LightColor0.xyz * ((
    float((tmpvar_6.z > 0.0))
   * texture2D (_LightTexture0, 
    ((tmpvar_6.xy / tmpvar_6.w) + 0.5)
  ).w) * texture2D (_LightTextureB0, vec2(dot (tmpvar_6.xyz, tmpvar_6.xyz))).w));
  vec4 c_7;
  c_7.xyz = (((
    ((tmpvar_4 * _Color) * _Tint)
  .xyz * tmpvar_1) * max (0.0, 
    dot (xlv_TEXCOORD1, tmpvar_2)
  )) + ((tmpvar_1 * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD1, normalize(
      (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2)))
    ))), (_Shininess * 128.0))
   * tmpvar_4.w)));
  c_7.w = 1.0;
  c_3.xyz = mix (vec3(0.0, 0.0, 0.0), c_7.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD4))
  ), 0.0, 1.0)));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord4 o4.x
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0
dp4 r0.x, c2, v0
mov o0.z, r0.x
mov o4.x, r0.x

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednficaoenaomggojpcggbnfbbfpflnioiabaaaaaaimafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcmaadaaaaeaaaabaapaaaaaaafjaaaaaeegiocaaaaaaaaaaa
bcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafeccabaaaabaaaaaackaabaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaabbaaaaaa
ogikcaaaaaaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1.z;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogParams;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform samplerCube _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec3 tmpvar_1;
  vec3 tmpvar_2;
  vec4 c_3;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_6;
  tmpvar_6 = (_LightMatrix0 * tmpvar_5).xyz;
  tmpvar_2 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  tmpvar_1 = (_LightColor0.xyz * (texture2D (_LightTextureB0, vec2(dot (tmpvar_6, tmpvar_6))).w * textureCube (_LightTexture0, tmpvar_6).w));
  vec4 c_7;
  c_7.xyz = (((
    ((tmpvar_4 * _Color) * _Tint)
  .xyz * tmpvar_1) * max (0.0, 
    dot (xlv_TEXCOORD1, tmpvar_2)
  )) + ((tmpvar_1 * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD1, normalize(
      (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2)))
    ))), (_Shininess * 128.0))
   * tmpvar_4.w)));
  c_7.w = 1.0;
  c_3.xyz = mix (vec3(0.0, 0.0, 0.0), c_7.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD4))
  ), 0.0, 1.0)));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord4 o4.x
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0
dp4 r0.x, c2, v0
mov o0.z, r0.x
mov o4.x, r0.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednficaoenaomggojpcggbnfbbfpflnioiabaaaaaaimafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcmaadaaaaeaaaabaapaaaaaaafjaaaaaeegiocaaaaaaaaaaa
bcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafeccabaaaabaaaaaackaabaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaabbaaaaaa
ogikcaaaaaaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = normalize(((
    (v_2.xyz * gl_Normal.x)
   + 
    (v_3.xyz * gl_Normal.y)
  ) + (v_4.xyz * gl_Normal.z)));
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1.z;
}


#endif
#ifdef FRAGMENT
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogParams;
uniform vec4 _LightColor0;
uniform vec4 _SpecColor;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform float _Shininess;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec3 tmpvar_1;
  vec4 c_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = xlv_TEXCOORD2;
  tmpvar_1 = (_LightColor0.xyz * texture2D (_LightTexture0, (_LightMatrix0 * tmpvar_4).xy).w);
  vec4 c_5;
  c_5.xyz = (((
    ((tmpvar_3 * _Color) * _Tint)
  .xyz * tmpvar_1) * max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  )) + ((tmpvar_1 * _SpecColor.xyz) * (
    pow (max (0.0, dot (xlv_TEXCOORD1, normalize(
      (_WorldSpaceLightPos0.xyz + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2)))
    ))), (_Shininess * 128.0))
   * tmpvar_3.w)));
  c_5.w = 1.0;
  c_2.xyz = mix (vec3(0.0, 0.0, 0.0), c_5.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD4))
  ), 0.0, 1.0)));
  c_2.w = 1.0;
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
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord4 o4.x
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0
dp4 r0.x, c2, v0
mov o0.z, r0.x
mov o4.x, r0.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 288
Vector 272 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednficaoenaomggojpcggbnfbbfpflnioiabaaaaaaimafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcmaadaaaaeaaaabaapaaaaaaafjaaaaaeegiocaaaaaaaaaaa
bcaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafeccabaaaabaaaaaackaabaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaabbaaaaaa
ogikcaaaaaaaaaaabbaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
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
Vector 7 [_Color]
Vector 5 [_LightColor0]
Float 9 [_Shininess]
Vector 6 [_SpecColor]
Vector 8 [_Tint]
Vector 3 [_WorldSpaceCameraPos]
Vector 4 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
def c10, 1, 0, 128, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2 v2.xyz
dcl_2d s0
dcl_2d s1
add r0.xyz, c3, -v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
add r1.xyz, c4, -v2
nrm_pp r2.xyz, r1
mad_pp r0.xyz, r0, r0.w, r2
dp3_pp r0.w, v1, r2
max_pp r1.x, r0.w, c10.y
nrm_pp r2.xyz, r0
dp3_pp r0.x, v1, r2
max r1.y, r0.x, c10.y
mov r0.z, c10.z
mul r0.x, r0.z, c9.x
pow r2.x, r1.y, r0.x
texld_pp r0, v0, s1
mul r0.w, r0.w, r2.x
mul r0.xyz, r0, c7
mul_pp r0.xyz, r0, c8
mad r2, v2.xyzx, c10.xxxy, c10.yyyx
dp4 r3.x, c0, r2
dp4 r3.y, c1, r2
dp4 r3.z, c2, r2
dp3 r1.y, r3, r3
texld_pp r2, r1.y, s0
mul_pp r1.yzw, r2.x, c5.xxyz
mul r2.xyz, r1.yzww, c6
mul_pp r0.xyz, r0, r1.yzww
mul r1.yzw, r0.w, r2.xxyz
mad_pp oC0.xyz, r0, r1.x, r1.yzww
mov_pp oC0.w, c10.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Vector 208 [_Color]
Vector 224 [_Tint]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedaapjnfohikakaiplnlpbhfilcheoiehaabaaaaaajeafaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckeaeaaaaeaaaaaaacjabaaaafjaaaaaeegiocaaa
aaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaa
egiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaa
agajbaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaajgahbaaa
aaaaaaaadeaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaacpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaed
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaanaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaaoaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaa
adaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
aaaaaaaaajaaaaaaagbabaaaadaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegacbaaaacaaaaaa
aaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaamaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaakgakbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
diaaaaaihcaabaaaacaaaaaaagaabaaaacaaaaaaegiccaaaaaaaaaaaagaaaaaa
diaaaaaihcaabaaaadaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaahaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaah
ocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 4 [_Color]
Vector 2 [_LightColor0]
Float 6 [_Shininess]
Vector 3 [_SpecColor]
Vector 5 [_Tint]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
def c7, 0, 128, 1, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2 v2.xyz
dcl_2d s0
add r0.xyz, c0, -v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mad_pp r0.xyz, r0, r0.w, c1
nrm_pp r1.xyz, r0
dp3_pp r0.x, v1, r1
max r1.x, r0.x, c7.x
mov r0.y, c7.y
mul r0.x, r0.y, c6.x
pow r2.x, r1.x, r0.x
texld_pp r0, v0, s0
mul r0.w, r0.w, r2.x
mul r0.xyz, r0, c4
mul_pp r0.xyz, r0, c5
mul_pp r0.xyz, r0, c2
mov r1.xyz, c2
mul r1.xyz, r1, c3
mul r1.xyz, r0.w, r1
dp3_pp r0.w, v1, c1
max_pp r1.w, r0.w, c7.x
mad_pp oC0.xyz, r0, r1.w, r1
mov_pp oC0.w, c7.z

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Vector 144 [_Color]
Vector 160 [_Tint]
Float 192 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecednjcollilkdmjiknlhkahhgpffbpdobmbabaaaaaadiaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefceiadaaaaeaaaaaaancaaaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaaakiacaaa
aaaaaaaaamaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaajaaaaaa
diaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaaaaaaaaaaakaaaaaa
diaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaaaaaaaaaaagaaaaaa
diaaaaajhcaabaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaa
ahaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaaibcaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaacaaaaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaaj
hccabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Matrix 0 [_LightMatrix0]
Vector 8 [_Color]
Vector 6 [_LightColor0]
Float 10 [_Shininess]
Vector 7 [_SpecColor]
Vector 9 [_Tint]
Vector 4 [_WorldSpaceCameraPos]
Vector 5 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
def c11, 1, 0, 0.5, 128
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2 v2.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
mad r0, v2.xyzx, c11.xxxy, c11.yyyx
dp4 r1.x, c3, r0
rcp r1.x, r1.x
dp4 r2.x, c0, r0
dp4 r2.y, c1, r0
dp4 r2.z, c2, r0
mad r0.xy, r2, r1.x, c11.z
dp3 r0.z, r2, r2
texld_pp r1, r0.z, s1
texld_pp r0, r0, s0
mul r0.x, r1.x, r0.w
mul_pp r0.xyz, r0.x, c6
cmp_pp r0.xyz, -r2.z, c11.y, r0
mul r1.xyz, r0, c7
add r2.xyz, c4, -v2
dp3 r0.w, r2, r2
rsq r0.w, r0.w
add r3.xyz, c5, -v2
nrm_pp r4.xyz, r3
mad_pp r2.xyz, r2, r0.w, r4
dp3_pp r0.w, v1, r4
max_pp r1.w, r0.w, c11.y
nrm_pp r3.xyz, r2
dp3_pp r0.w, v1, r3
max r2.x, r0.w, c11.y
mov r0.w, c11.w
mul r0.w, r0.w, c10.x
pow r3.x, r2.x, r0.w
texld_pp r2, v0, s2
mul r0.w, r2.w, r3.x
mul r2.xyz, r2, c8
mul_pp r2.xyz, r2, c9
mul_pp r0.xyz, r0, r2
mul r1.xyz, r0.w, r1
mad_pp oC0.xyz, r0, r1.w, r1
mov_pp oC0.w, c11.x

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Vector 208 [_Color]
Vector 224 [_Tint]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecednhgdhnoohlolaidmongfnjlgaohodkfmabaaaaaajiagaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckiafaaaaeaaaaaaagkabaaaafjaaaaaeegiocaaa
aaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaadaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaajaaaaaaagbabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegaobaaa
aaaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
amaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaa
aaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaagaabaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaaaaaaaaaj
hcaabaaaacaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaaaaaaaajhcaabaaaadaaaaaaegbcbaiaebaaaaaa
adaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaajhcaabaaaadaaaaaaegacbaaaadaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaibcaabaaaacaaaaaa
akiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaabjaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
anaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
aoaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Matrix 0 [_LightMatrix0] 3
Vector 7 [_Color]
Vector 5 [_LightColor0]
Float 9 [_Shininess]
Vector 6 [_SpecColor]
Vector 8 [_Tint]
Vector 3 [_WorldSpaceCameraPos]
Vector 4 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
def c10, 1, 0, 128, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2 v2.xyz
dcl_cube s0
dcl_2d s1
dcl_2d s2
mad r0, v2.xyzx, c10.xxxy, c10.yyyx
dp4 r1.x, c0, r0
dp4 r1.y, c1, r0
dp4 r1.z, c2, r0
dp3 r0.x, r1, r1
texld r1, r1, s0
texld r0, r0.x, s1
mul_pp r0.x, r1.w, r0.x
mul_pp r0.xyz, r0.x, c5
mul r1.xyz, r0, c6
add r2.xyz, c3, -v2
dp3 r0.w, r2, r2
rsq r0.w, r0.w
add r3.xyz, c4, -v2
nrm_pp r4.xyz, r3
mad_pp r2.xyz, r2, r0.w, r4
dp3_pp r0.w, v1, r4
max_pp r1.w, r0.w, c10.y
nrm_pp r3.xyz, r2
dp3_pp r0.w, v1, r3
max r2.x, r0.w, c10.y
mov r2.z, c10.z
mul r0.w, r2.z, c9.x
pow r3.x, r2.x, r0.w
texld_pp r2, v0, s2
mul r0.w, r2.w, r3.x
mul r2.xyz, r2, c7
mul_pp r2.xyz, r2, c8
mul_pp r0.xyz, r0, r2
mul r1.xyz, r0.w, r1
mad_pp oC0.xyz, r0, r1.w, r1
mov_pp oC0.w, c10.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Vector 208 [_Color]
Vector 224 [_Tint]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedaalbpkgkfnhhhendpcnmbfmcflehbnngabaaaaaapaafaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaaafaaaaeaaaaaaaeaabaaaafjaaaaaeegiocaaa
aaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egbcbaiaebaaaaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaa
abaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaajgahbaaaaaaaaaaa
deaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaacpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
ecaabaaaaaaaaaaaakiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaeddiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaanaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaaoaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaadaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaa
ajaaaaaaagbabaaaadaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegacbaaaacaaaaaaaaaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegacbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaakgakbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahecaabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaai
hcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaai
hcaabaaaadaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagajbaaaadaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Matrix 0 [_LightMatrix0] 2
Vector 6 [_Color]
Vector 4 [_LightColor0]
Float 8 [_Shininess]
Vector 5 [_SpecColor]
Vector 7 [_Tint]
Vector 2 [_WorldSpaceCameraPos]
Vector 3 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
def c9, 1, 0, 128, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2 v2.xyz
dcl_2d s0
dcl_2d s1
add r0.xyz, c2, -v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mad_pp r0.xyz, r0, r0.w, c3
nrm_pp r1.xyz, r0
dp3_pp r0.x, v1, r1
max r1.x, r0.x, c9.y
mov r0.z, c9.z
mul r0.x, r0.z, c8.x
pow r2.x, r1.x, r0.x
texld_pp r0, v0, s1
mul r0.w, r0.w, r2.x
mul r0.xyz, r0, c6
mul_pp r0.xyz, r0, c7
mad r1, v2.xyzx, c9.xxxy, c9.yyyx
dp4 r2.x, c0, r1
dp4 r2.y, c1, r1
texld_pp r1, r2, s0
mul_pp r1.xyz, r1.w, c4
mul r2.xyz, r1, c5
mul_pp r0.xyz, r0, r1
mul r1.xyz, r0.w, r2
dp3_pp r0.w, v1, c3
max_pp r1.w, r0.w, c9.y
mad_pp oC0.xyz, r0, r1.w, r1
mov_pp oC0.w, c9.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Vector 208 [_Color]
Vector 224 [_Tint]
Float 256 [_Shininess]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
"ps_4_0
eefiecedkeogiejbbogchaapepkicdebkaiglkcfabaaaaaacaafaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdaaeaaaaeaaaaaaaamabaaaafjaaaaaeegiocaaa
aaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaaakiacaaaaaaaaaaa
baaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaai
ocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaanaaaaaadiaaaaai
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaaaaaaaaaaaoaaaaaadiaaaaai
dcaabaaaabaaaaaafgbfbaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaadcaaaaak
dcaabaaaabaaaaaaegiacaaaaaaaaaaaajaaaaaaagbabaaaadaaaaaaegaabaaa
abaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaalaaaaaakgbkbaaa
adaaaaaaegaabaaaabaaaaaaaaaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaa
egiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaa
abaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagajbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaa
acaaaaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "opengl " {
Keywords { "POINT" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT" "FOG_EXP" }
Matrix 0 [_LightMatrix0] 3
Vector 8 [_Color]
Vector 6 [_LightColor0]
Float 10 [_Shininess]
Vector 7 [_SpecColor]
Vector 9 [_Tint]
Vector 3 [_WorldSpaceCameraPos]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_FogParams]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
def c11, 1, 0, 128, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord4 v3.x
dcl_2d s0
dcl_2d s1
add r0.xyz, c3, -v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
add r1.xyz, c4, -v2
nrm_pp r2.xyz, r1
mad_pp r0.xyz, r0, r0.w, r2
dp3_pp r0.w, v1, r2
max_pp r1.x, r0.w, c11.y
nrm_pp r2.xyz, r0
dp3_pp r0.x, v1, r2
max r1.y, r0.x, c11.y
mov r0.z, c11.z
mul r0.x, r0.z, c10.x
pow r2.x, r1.y, r0.x
texld_pp r0, v0, s1
mul r0.w, r0.w, r2.x
mul r0.xyz, r0, c8
mul_pp r0.xyz, r0, c9
mad r2, v2.xyzx, c11.xxxy, c11.yyyx
dp4 r3.x, c0, r2
dp4 r3.y, c1, r2
dp4 r3.z, c2, r2
dp3 r1.y, r3, r3
texld_pp r2, r1.y, s0
mul_pp r1.yzw, r2.x, c6.xxyz
mul r2.xyz, r1.yzww, c7
mul_pp r0.xyz, r0, r1.yzww
mul r1.yzw, r0.w, r2.xxyz
mad_pp r0.xyz, r0, r1.x, r1.yzww
mul r0.w, c5.y, v3.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, c11.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Vector 208 [_Color]
Vector 224 [_Tint]
Float 256 [_Shininess]
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
eefiecedffpmbgeagbnlhgjpalhhenhlogdebajoabaaaaaadiagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcdaafaaaaeaaaaaaaemabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaiaebaaaaaa
adaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaabaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaacaaaaaajgahbaaaaaaaaaaadeaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaeddiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
anaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
aoaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaadaaaaaaegiccaaaaaaaaaaa
akaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaa
adaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaa
alaaaaaakgbkbaaaadaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaakgakbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaa
agaabaaaacaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaaadaaaaaa
egacbaaaacaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaa
aaaaaaaaagajbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaackbabaaa
abaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
Vector 5 [_Color]
Vector 3 [_LightColor0]
Float 7 [_Shininess]
Vector 4 [_SpecColor]
Vector 6 [_Tint]
Vector 0 [_WorldSpaceCameraPos]
Vector 1 [_WorldSpaceLightPos0]
Vector 2 [unity_FogParams]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
def c8, 0, 128, 1, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord4 v3.x
dcl_2d s0
add r0.xyz, c0, -v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mad_pp r0.xyz, r0, r0.w, c1
nrm_pp r1.xyz, r0
dp3_pp r0.x, v1, r1
max r1.x, r0.x, c8.x
mov r0.y, c8.y
mul r0.x, r0.y, c7.x
pow r2.x, r1.x, r0.x
texld_pp r0, v0, s0
mul r0.w, r0.w, r2.x
mul r0.xyz, r0, c5
mul_pp r0.xyz, r0, c6
mul_pp r0.xyz, r0, c3
mov r1.xyz, c3
mul r1.xyz, r1, c4
mul r1.xyz, r0.w, r1
dp3_pp r0.w, v1, c1
max_pp r1.w, r0.w, c8.x
mad_pp r0.xyz, r0, r1.w, r1
mul r0.w, c2.y, v3.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, c8.z

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 224
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Vector 144 [_Color]
Vector 160 [_Tint]
Float 192 [_Shininess]
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
eefiecedpnhpohdgcjlbcbllkfiglmjmolncnkhkabaaaaaanmaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcneadaaaaeaaaaaaapfaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaia
ebaaaaaaadaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaaabeaaaaa
aaaaaaeddiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaiocaabaaaaaaaaaaa
agajbaaaabaaaaaaagijcaaaaaaaaaaaajaaaaaadiaaaaaiocaabaaaaaaaaaaa
fgaobaaaaaaaaaaaagijcaaaaaaaaaaaakaaaaaadiaaaaaiocaabaaaaaaaaaaa
fgaobaaaaaaaaaaaagijcaaaaaaaaaaaagaaaaaadiaaaaajhcaabaaaabaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaabaaaaaaibcaabaaaaaaaaaaa
egbcbaaaacaaaaaaegiccaaaacaaaaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaa
aaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaa
ckbabaaaabaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "FOG_EXP" }
Matrix 0 [_LightMatrix0]
Vector 9 [_Color]
Vector 7 [_LightColor0]
Float 11 [_Shininess]
Vector 8 [_SpecColor]
Vector 10 [_Tint]
Vector 4 [_WorldSpaceCameraPos]
Vector 5 [_WorldSpaceLightPos0]
Vector 6 [unity_FogParams]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
def c12, 1, 0, 0.5, 128
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord4 v3.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
mad r0, v2.xyzx, c12.xxxy, c12.yyyx
dp4 r1.x, c3, r0
rcp r1.x, r1.x
dp4 r2.x, c0, r0
dp4 r2.y, c1, r0
dp4 r2.z, c2, r0
mad r0.xy, r2, r1.x, c12.z
dp3 r0.z, r2, r2
texld_pp r1, r0.z, s1
texld_pp r0, r0, s0
mul r0.x, r1.x, r0.w
mul_pp r0.xyz, r0.x, c7
cmp_pp r0.xyz, -r2.z, c12.y, r0
mul r1.xyz, r0, c8
add r2.xyz, c4, -v2
dp3 r0.w, r2, r2
rsq r0.w, r0.w
add r3.xyz, c5, -v2
nrm_pp r4.xyz, r3
mad_pp r2.xyz, r2, r0.w, r4
dp3_pp r0.w, v1, r4
max_pp r1.w, r0.w, c12.y
nrm_pp r3.xyz, r2
dp3_pp r0.w, v1, r3
max r2.x, r0.w, c12.y
mov r0.w, c12.w
mul r0.w, r0.w, c11.x
pow r3.x, r2.x, r0.w
texld_pp r2, v0, s2
mul r0.w, r2.w, r3.x
mul r2.xyz, r2, c9
mul_pp r2.xyz, r2, c10
mul_pp r0.xyz, r0, r2
mul r1.xyz, r0.w, r1
mad_pp r0.xyz, r0, r1.w, r1
mul r0.w, c6.y, v3.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, c12.x

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Vector 208 [_Color]
Vector 224 [_Tint]
Float 256 [_Shininess]
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
eefiecedapgdbahhmoglbbalmekkilhmkffpjdneabaaaaaadmahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcdeagaaaaeaaaaaaainabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaadaaaaaaegiocaaa
aaaaaaaaakaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaajaaaaaa
agbabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaalaaaaaakgbkbaaaadaaaaaaegaobaaaaaaaaaaaaaaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaamaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaaaaaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaagaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaabaaaaah
bcaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaa
aaaaaaaadkaabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaahaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaia
ebaaaaaaadaaaaaaegiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaajhcaabaaaadaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaadaaaaaa
egacbaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaabaaaaaah
icaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaaibcaabaaaacaaaaaaakiacaaaaaaaaaaabaaaaaaa
abeaaaaaaaaaaaeddiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
acaaaaaabjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaanaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaaoaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaa
ckbabaaaabaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
Matrix 0 [_LightMatrix0] 3
Vector 8 [_Color]
Vector 6 [_LightColor0]
Float 10 [_Shininess]
Vector 7 [_SpecColor]
Vector 9 [_Tint]
Vector 3 [_WorldSpaceCameraPos]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_FogParams]
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
def c11, 1, 0, 128, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord4 v3.x
dcl_cube s0
dcl_2d s1
dcl_2d s2
mad r0, v2.xyzx, c11.xxxy, c11.yyyx
dp4 r1.x, c0, r0
dp4 r1.y, c1, r0
dp4 r1.z, c2, r0
dp3 r0.x, r1, r1
texld r1, r1, s0
texld r0, r0.x, s1
mul_pp r0.x, r1.w, r0.x
mul_pp r0.xyz, r0.x, c6
mul r1.xyz, r0, c7
add r2.xyz, c3, -v2
dp3 r0.w, r2, r2
rsq r0.w, r0.w
add r3.xyz, c4, -v2
nrm_pp r4.xyz, r3
mad_pp r2.xyz, r2, r0.w, r4
dp3_pp r0.w, v1, r4
max_pp r1.w, r0.w, c11.y
nrm_pp r3.xyz, r2
dp3_pp r0.w, v1, r3
max r2.x, r0.w, c11.y
mov r2.z, c11.z
mul r0.w, r2.z, c10.x
pow r3.x, r2.x, r0.w
texld_pp r2, v0, s2
mul r0.w, r2.w, r3.x
mul r2.xyz, r2, c8
mul_pp r2.xyz, r2, c9
mul_pp r0.xyz, r0, r2
mul r1.xyz, r0.w, r1
mad_pp r0.xyz, r0, r1.w, r1
mul r0.w, c5.y, v3.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, c11.x

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Vector 208 [_Color]
Vector 224 [_Tint]
Float 256 [_Shininess]
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
eefiecedgpnldjjgchhjphmjfobjlmdcjmpeffdbabaaaaaajeagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcimafaaaaeaaaaaaagdabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaiaebaaaaaaadaaaaaa
egiccaaaacaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
acaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaabaaaaaabaaaaaahccaabaaa
aaaaaaaaegbcbaaaacaaaaaajgahbaaaaaaaaaaadeaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaaakiacaaa
aaaaaaaabaaaaaaaabeaaaaaaaaaaaeddiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaoaaaaaa
diaaaaaihcaabaaaacaaaaaafgbfbaaaadaaaaaaegiccaaaaaaaaaaaakaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaaadaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaaalaaaaaa
kgbkbaaaadaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaa
acaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegacbaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaakgakbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaa
dkaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaa
aaaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaa
acaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaa
agajbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaackbabaaaabaaaaaa
bkiacaaaadaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
Matrix 0 [_LightMatrix0] 2
Vector 7 [_Color]
Vector 5 [_LightColor0]
Float 9 [_Shininess]
Vector 6 [_SpecColor]
Vector 8 [_Tint]
Vector 2 [_WorldSpaceCameraPos]
Vector 3 [_WorldSpaceLightPos0]
Vector 4 [unity_FogParams]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
def c10, 1, 0, 128, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord4 v3.x
dcl_2d s0
dcl_2d s1
add r0.xyz, c2, -v2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mad_pp r0.xyz, r0, r0.w, c3
nrm_pp r1.xyz, r0
dp3_pp r0.x, v1, r1
max r1.x, r0.x, c10.y
mov r0.z, c10.z
mul r0.x, r0.z, c9.x
pow r2.x, r1.x, r0.x
texld_pp r0, v0, s1
mul r0.w, r0.w, r2.x
mul r0.xyz, r0, c7
mul_pp r0.xyz, r0, c8
mad r1, v2.xyzx, c10.xxxy, c10.yyyx
dp4 r2.x, c0, r1
dp4 r2.y, c1, r1
texld_pp r1, r2, s0
mul_pp r1.xyz, r1.w, c5
mul r2.xyz, r1, c6
mul_pp r0.xyz, r0, r1
mul r1.xyz, r0.w, r2
dp3_pp r0.w, v1, c3
max_pp r1.w, r0.w, c10.y
mad_pp r0.xyz, r0, r1.w, r1
mul r0.w, c4.y, v3.x
exp_sat r0.w, -r0.w
mul_pp oC0.xyz, r0, r0.w
mov_pp oC0.w, c10.x

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 288
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 112 [_SpecColor]
Vector 208 [_Color]
Vector 224 [_Tint]
Float 256 [_Shininess]
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
eefiecedcffpdmmoaebpodjaoajdeecdmlkdlmebabaaaaaameafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefclmaeaaaaeaaaaaaacpabaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaiaebaaaaaa
adaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaacaaaaaaegacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakiacaaaaaaaaaaabaaaaaaaabeaaaaaaaaaaaed
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaiocaabaaaaaaaaaaaagajbaaa
abaaaaaaagijcaaaaaaaaaaaanaaaaaadiaaaaaiocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagijcaaaaaaaaaaaaoaaaaaadiaaaaaidcaabaaaabaaaaaafgbfbaaa
adaaaaaaegiacaaaaaaaaaaaakaaaaaadcaaaaakdcaabaaaabaaaaaaegiacaaa
aaaaaaaaajaaaaaaagbabaaaadaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegaabaaaabaaaaaa
aaaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaaegiacaaaaaaaaaaaamaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaabaaaaaaegiccaaaaaaaaaaa
agaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
ahaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaabaaaaaai
bcaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaacaaaaaaaaaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaajhcaabaaa
aaaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
icaabaaaaaaaaaaackbabaaaabaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaag
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  GpuProgramID 172097
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
varying vec3 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
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
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = normalize(((
    (v_1.xyz * gl_Normal.x)
   + 
    (v_2.xyz * gl_Normal.y)
  ) + (v_3.xyz * gl_Normal.z)));
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform float _Shininess;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 res_1;
  res_1.xyz = ((xlv_TEXCOORD0 * 0.5) + 0.5);
  res_1.w = _Shininess;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_position o0
dcl_texcoord o1.xyz
dcl_texcoord1 o2.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o2.x, c4, v0
dp4 o2.y, c5, v0
dp4 o2.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o1.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedinidogaapcaihlhlafeaicjabdmdpgobabaaaaaaneaeaaaaadaaaaaa
cmaaaaaaceabaaaajeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdiadaaaaeaaaabaa
moaaaaaafjaaaaaeegiocaaaaaaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaaaaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaaaaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Float 0 [_Shininess]
"ps_3_0
def c1, 0.5, 0, 0, 0
dcl_texcoord_pp v0.xyz
mad_pp oC0.xyz, v0, c1.x, c1.x
mov_pp oC0.w, c0.x

"
}
SubProgram "d3d11 " {
ConstBuffer "$Globals" 208
Float 192 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0
eefiecediejmeplcalbfkhggijkpdafbfdiflgbpabaaaaaagaabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefciiaaaaaaeaaaaaaaccaaaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaagcbaaaadhcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaadcaaaaaphccabaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaadgaaaaagiccabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadoaaaaab
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" }
  ZWrite Off
  GpuProgramID 221401
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec4 v_4;
  float cse_5;
  cse_5 = _World2Object[0].x;
  v_4.x = cse_5;
  float cse_6;
  cse_6 = _World2Object[1].x;
  v_4.y = cse_6;
  float cse_7;
  cse_7 = _World2Object[2].x;
  v_4.z = cse_7;
  float cse_8;
  cse_8 = _World2Object[3].x;
  v_4.w = cse_8;
  vec4 v_9;
  float cse_10;
  cse_10 = _World2Object[0].y;
  v_9.x = cse_10;
  float cse_11;
  cse_11 = _World2Object[1].y;
  v_9.y = cse_11;
  float cse_12;
  cse_12 = _World2Object[2].y;
  v_9.z = cse_12;
  float cse_13;
  cse_13 = _World2Object[3].y;
  v_9.w = cse_13;
  vec4 v_14;
  float cse_15;
  cse_15 = _World2Object[0].z;
  v_14.x = cse_15;
  float cse_16;
  cse_16 = _World2Object[1].z;
  v_14.y = cse_16;
  float cse_17;
  cse_17 = _World2Object[2].z;
  v_14.z = cse_17;
  float cse_18;
  cse_18 = _World2Object[3].z;
  v_14.w = cse_18;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_9.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  vec3 I_20;
  I_20 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec4 o_21;
  vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * 0.5);
  vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_2.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 v_24;
  v_24.x = cse_5;
  v_24.y = cse_6;
  v_24.z = cse_7;
  v_24.w = cse_8;
  vec4 v_25;
  v_25.x = cse_10;
  v_25.y = cse_11;
  v_25.z = cse_12;
  v_25.w = cse_13;
  vec4 v_26;
  v_26.x = cse_15;
  v_26.y = cse_16;
  v_26.z = cse_17;
  v_26.w = cse_18;
  vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_24.xyz * gl_Normal.x)
   + 
    (v_25.xyz * gl_Normal.y)
  ) + (v_26.xyz * gl_Normal.z)));
  vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_27;
  vec3 x2_29;
  vec3 x1_30;
  x1_30.x = dot (unity_SHAr, tmpvar_28);
  x1_30.y = dot (unity_SHAg, tmpvar_28);
  x1_30.z = dot (unity_SHAb, tmpvar_28);
  vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_27.xyzz * tmpvar_27.yzzx);
  x2_29.x = dot (unity_SHBr, tmpvar_31);
  x2_29.y = dot (unity_SHBg, tmpvar_31);
  x2_29.z = dot (unity_SHBb, tmpvar_31);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (I_20 - (2.0 * (
    dot (tmpvar_19, I_20)
   * tmpvar_19)));
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_3);
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = ((x2_29 + (unity_SHC.xyz * 
    ((tmpvar_27.x * tmpvar_27.x) - (tmpvar_27.y * tmpvar_27.y))
  )) + x1_30);
}


#endif
#ifdef FRAGMENT
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform samplerCube _Skybox;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform vec4 _ReflectColor;
uniform float _Reflection;
uniform sampler2D _LightBuffer;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 c_1;
  vec4 light_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = -(log2(texture2DProj (_LightBuffer, xlv_TEXCOORD5)));
  light_2.w = tmpvar_4.w;
  light_2.xyz = (tmpvar_4.xyz + xlv_TEXCOORD7);
  vec4 c_5;
  c_5.xyz = (((
    (tmpvar_3 * _Color)
   * _Tint).xyz * light_2.xyz) + ((light_2.xyz * _SpecColor.xyz) * (tmpvar_4.w * tmpvar_3.w)));
  c_5.w = 1.0;
  c_1.xyz = (c_5.xyz + ((textureCube (_Skybox, xlv_TEXCOORD1) * 
    (_Reflection * (1.0 - dot (normalize(
      normalize(xlv_TEXCOORD4)
    ), xlv_TEXCOORD2)))
  ).xyz * _ReflectColor.xyz));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 20 [_MainTex_ST]
Vector 11 [_ProjectionParams]
Vector 12 [_ScreenParams]
Vector 10 [_WorldSpaceCameraPos]
Vector 15 [unity_SHAb]
Vector 14 [unity_SHAg]
Vector 13 [unity_SHAr]
Vector 18 [unity_SHBb]
Vector 17 [unity_SHBg]
Vector 16 [unity_SHBr]
Vector 19 [unity_SHC]
"vs_3_0
def c21, 0.5, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8.xyz
mad o1.xy, v2, c20, c20.zwzw
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, -r0, c10
mov o4.xyz, r0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r2.xyz, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad o2.xyz, r2, -r0.x, -r1
mov o5.xyz, r1
dp4 r0.y, c1, v0
mul r1.x, r0.y, c11.x
mul r1.w, r1.x, c21.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c21.x
mad o6.xy, r1.z, c12.zwzw, r1.xwzw
mul r1.x, r2.y, r2.y
mad r1.x, r2.x, r2.x, -r1.x
mul r3, r2.yzzx, r2.xyzz
dp4 r4.x, c16, r3
dp4 r4.y, c17, r3
dp4 r4.z, c18, r3
mad r1.xyz, c19, r1.x, r4
mov r2.w, c21.y
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mov o3.xyz, r2
add o8.xyz, r1, r3
dp4 r0.z, c2, v0
mov o0, r0
mov o6.zw, r0
mov o7, c21.z

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 240
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedleanbcofegegfnifnbfcogbalbachnkhabaaaaaaaaajaaaaadaaaaaa
cmaaaaaaceabaaaaceacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcneagaaaaeaaaabaalfabaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagfaaaaad
hccabaaaaiaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaa
aaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaa
adaaaaaabcaaaaaadiaaaaaibcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaa
adaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
acaaaaaaaaaaaaajhcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaa
abaaaaaaaeaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaaacaaaaaabaaaaaai
bcaabaaaacaaaaaaegacbaiaebaaaaaaadaaaaaaegacbaaaabaaaaaaaaaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaalhccabaaa
acaaaaaaegacbaaaabaaaaaaagaabaiaebaaaaaaacaaaaaaegacbaiaebaaaaaa
adaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaadaaaaaadgaaaaafhccabaaa
adaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaacaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaagaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaacaaaaaamgaabaaa
acaaaaaadgaaaaaipccabaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaabaaaaaaegakbaaa
abaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaa
aaaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaa
aaaaaaahhccabaaaaiaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec4 v_4;
  float cse_5;
  cse_5 = _World2Object[0].x;
  v_4.x = cse_5;
  float cse_6;
  cse_6 = _World2Object[1].x;
  v_4.y = cse_6;
  float cse_7;
  cse_7 = _World2Object[2].x;
  v_4.z = cse_7;
  float cse_8;
  cse_8 = _World2Object[3].x;
  v_4.w = cse_8;
  vec4 v_9;
  float cse_10;
  cse_10 = _World2Object[0].y;
  v_9.x = cse_10;
  float cse_11;
  cse_11 = _World2Object[1].y;
  v_9.y = cse_11;
  float cse_12;
  cse_12 = _World2Object[2].y;
  v_9.z = cse_12;
  float cse_13;
  cse_13 = _World2Object[3].y;
  v_9.w = cse_13;
  vec4 v_14;
  float cse_15;
  cse_15 = _World2Object[0].z;
  v_14.x = cse_15;
  float cse_16;
  cse_16 = _World2Object[1].z;
  v_14.y = cse_16;
  float cse_17;
  cse_17 = _World2Object[2].z;
  v_14.z = cse_17;
  float cse_18;
  cse_18 = _World2Object[3].z;
  v_14.w = cse_18;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_9.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  vec3 I_20;
  I_20 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec4 o_21;
  vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * 0.5);
  vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_2.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 v_24;
  v_24.x = cse_5;
  v_24.y = cse_6;
  v_24.z = cse_7;
  v_24.w = cse_8;
  vec4 v_25;
  v_25.x = cse_10;
  v_25.y = cse_11;
  v_25.z = cse_12;
  v_25.w = cse_13;
  vec4 v_26;
  v_26.x = cse_15;
  v_26.y = cse_16;
  v_26.z = cse_17;
  v_26.w = cse_18;
  vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_24.xyz * gl_Normal.x)
   + 
    (v_25.xyz * gl_Normal.y)
  ) + (v_26.xyz * gl_Normal.z)));
  vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_27;
  vec3 x2_29;
  vec3 x1_30;
  x1_30.x = dot (unity_SHAr, tmpvar_28);
  x1_30.y = dot (unity_SHAg, tmpvar_28);
  x1_30.z = dot (unity_SHAb, tmpvar_28);
  vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_27.xyzz * tmpvar_27.yzzx);
  x2_29.x = dot (unity_SHBr, tmpvar_31);
  x2_29.y = dot (unity_SHBg, tmpvar_31);
  x2_29.z = dot (unity_SHBb, tmpvar_31);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (I_20 - (2.0 * (
    dot (tmpvar_19, I_20)
   * tmpvar_19)));
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_3);
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = ((x2_29 + (unity_SHC.xyz * 
    ((tmpvar_27.x * tmpvar_27.x) - (tmpvar_27.y * tmpvar_27.y))
  )) + x1_30);
}


#endif
#ifdef FRAGMENT
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform samplerCube _Skybox;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform vec4 _ReflectColor;
uniform float _Reflection;
uniform sampler2D _LightBuffer;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD7;
void main ()
{
  vec4 c_1;
  vec4 light_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_LightBuffer, xlv_TEXCOORD5);
  light_2.w = tmpvar_4.w;
  light_2.xyz = (tmpvar_4.xyz + xlv_TEXCOORD7);
  vec4 c_5;
  c_5.xyz = (((
    (tmpvar_3 * _Color)
   * _Tint).xyz * light_2.xyz) + ((light_2.xyz * _SpecColor.xyz) * (tmpvar_4.w * tmpvar_3.w)));
  c_5.w = 1.0;
  c_1.xyz = (c_5.xyz + ((textureCube (_Skybox, xlv_TEXCOORD1) * 
    (_Reflection * (1.0 - dot (normalize(
      normalize(xlv_TEXCOORD4)
    ), xlv_TEXCOORD2)))
  ).xyz * _ReflectColor.xyz));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 20 [_MainTex_ST]
Vector 11 [_ProjectionParams]
Vector 12 [_ScreenParams]
Vector 10 [_WorldSpaceCameraPos]
Vector 15 [unity_SHAb]
Vector 14 [unity_SHAg]
Vector 13 [unity_SHAr]
Vector 18 [unity_SHBb]
Vector 17 [unity_SHBg]
Vector 16 [unity_SHBr]
Vector 19 [unity_SHC]
"vs_3_0
def c21, 0.5, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8.xyz
mad o1.xy, v2, c20, c20.zwzw
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, -r0, c10
mov o4.xyz, r0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r2.xyz, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad o2.xyz, r2, -r0.x, -r1
mov o5.xyz, r1
dp4 r0.y, c1, v0
mul r1.x, r0.y, c11.x
mul r1.w, r1.x, c21.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c21.x
mad o6.xy, r1.z, c12.zwzw, r1.xwzw
mul r1.x, r2.y, r2.y
mad r1.x, r2.x, r2.x, -r1.x
mul r3, r2.yzzx, r2.xyzz
dp4 r4.x, c16, r3
dp4 r4.y, c17, r3
dp4 r4.z, c18, r3
mad r1.xyz, c19, r1.x, r4
mov r2.w, c21.y
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mov o3.xyz, r2
add o8.xyz, r1, r3
dp4 r0.z, c2, v0
mov o0, r0
mov o6.zw, r0
mov o7, c21.z

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 240
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedleanbcofegegfnifnbfcogbalbachnkhabaaaaaaaaajaaaaadaaaaaa
cmaaaaaaceabaaaaceacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaomaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaomaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaomaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaomaaaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcneagaaaaeaaaabaalfabaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaagfaaaaad
hccabaaaaiaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaa
aaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaa
adaaaaaabcaaaaaadiaaaaaibcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaa
adaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaa
adaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaa
adaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaa
baaaaaaadiaaaaaiccaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaa
bbaaaaaadiaaaaaiecaabaaaacaaaaaackbabaaaacaaaaaackiacaaaadaaaaaa
bcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
acaaaaaaaaaaaaajhcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaa
abaaaaaaaeaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaaacaaaaaabaaaaaai
bcaabaaaacaaaaaaegacbaiaebaaaaaaadaaaaaaegacbaaaabaaaaaaaaaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaalhccabaaa
acaaaaaaegacbaaaabaaaaaaagaabaiaebaaaaaaacaaaaaaegacbaiaebaaaaaa
adaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaadaaaaaadgaaaaafhccabaaa
adaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaacaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaagaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaacaaaaaamgaabaaa
acaaaaaadgaaaaaipccabaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaabaaaaaaegakbaaa
abaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaa
aaaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaa
aaaaaaahhccabaaaaiaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
varying float xlv_TEXCOORD8;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec4 v_4;
  float cse_5;
  cse_5 = _World2Object[0].x;
  v_4.x = cse_5;
  float cse_6;
  cse_6 = _World2Object[1].x;
  v_4.y = cse_6;
  float cse_7;
  cse_7 = _World2Object[2].x;
  v_4.z = cse_7;
  float cse_8;
  cse_8 = _World2Object[3].x;
  v_4.w = cse_8;
  vec4 v_9;
  float cse_10;
  cse_10 = _World2Object[0].y;
  v_9.x = cse_10;
  float cse_11;
  cse_11 = _World2Object[1].y;
  v_9.y = cse_11;
  float cse_12;
  cse_12 = _World2Object[2].y;
  v_9.z = cse_12;
  float cse_13;
  cse_13 = _World2Object[3].y;
  v_9.w = cse_13;
  vec4 v_14;
  float cse_15;
  cse_15 = _World2Object[0].z;
  v_14.x = cse_15;
  float cse_16;
  cse_16 = _World2Object[1].z;
  v_14.y = cse_16;
  float cse_17;
  cse_17 = _World2Object[2].z;
  v_14.z = cse_17;
  float cse_18;
  cse_18 = _World2Object[3].z;
  v_14.w = cse_18;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_9.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  vec3 I_20;
  I_20 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec4 o_21;
  vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * 0.5);
  vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_2.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 v_24;
  v_24.x = cse_5;
  v_24.y = cse_6;
  v_24.z = cse_7;
  v_24.w = cse_8;
  vec4 v_25;
  v_25.x = cse_10;
  v_25.y = cse_11;
  v_25.z = cse_12;
  v_25.w = cse_13;
  vec4 v_26;
  v_26.x = cse_15;
  v_26.y = cse_16;
  v_26.z = cse_17;
  v_26.w = cse_18;
  vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_24.xyz * gl_Normal.x)
   + 
    (v_25.xyz * gl_Normal.y)
  ) + (v_26.xyz * gl_Normal.z)));
  vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_27;
  vec3 x2_29;
  vec3 x1_30;
  x1_30.x = dot (unity_SHAr, tmpvar_28);
  x1_30.y = dot (unity_SHAg, tmpvar_28);
  x1_30.z = dot (unity_SHAb, tmpvar_28);
  vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_27.xyzz * tmpvar_27.yzzx);
  x2_29.x = dot (unity_SHBr, tmpvar_31);
  x2_29.y = dot (unity_SHBg, tmpvar_31);
  x2_29.z = dot (unity_SHBb, tmpvar_31);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (I_20 - (2.0 * (
    dot (tmpvar_19, I_20)
   * tmpvar_19)));
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_3);
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = ((x2_29 + (unity_SHC.xyz * 
    ((tmpvar_27.x * tmpvar_27.x) - (tmpvar_27.y * tmpvar_27.y))
  )) + x1_30);
  xlv_TEXCOORD8 = tmpvar_2.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform samplerCube _Skybox;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform vec4 _ReflectColor;
uniform float _Reflection;
uniform sampler2D _LightBuffer;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD7;
varying float xlv_TEXCOORD8;
void main ()
{
  vec4 c_1;
  vec4 light_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = -(log2(texture2DProj (_LightBuffer, xlv_TEXCOORD5)));
  light_2.w = tmpvar_4.w;
  light_2.xyz = (tmpvar_4.xyz + xlv_TEXCOORD7);
  vec4 c_5;
  c_5.xyz = (((
    (tmpvar_3 * _Color)
   * _Tint).xyz * light_2.xyz) + ((light_2.xyz * _SpecColor.xyz) * (tmpvar_4.w * tmpvar_3.w)));
  c_5.w = 1.0;
  c_1.w = c_5.w;
  c_1.xyz = (c_5.xyz + ((textureCube (_Skybox, xlv_TEXCOORD1) * 
    (_Reflection * (1.0 - dot (normalize(
      normalize(xlv_TEXCOORD4)
    ), xlv_TEXCOORD2)))
  ).xyz * _ReflectColor.xyz));
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD8))
  ), 0.0, 1.0)));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 20 [_MainTex_ST]
Vector 11 [_ProjectionParams]
Vector 12 [_ScreenParams]
Vector 10 [_WorldSpaceCameraPos]
Vector 15 [unity_SHAb]
Vector 14 [unity_SHAg]
Vector 13 [unity_SHAr]
Vector 18 [unity_SHBb]
Vector 17 [unity_SHBg]
Vector 16 [unity_SHBr]
Vector 19 [unity_SHC]
"vs_3_0
def c21, 0.5, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8.xyz
dcl_texcoord8 o9.x
mad o1.xy, v2, c20, c20.zwzw
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, -r0, c10
mov o4.xyz, r0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r2.xyz, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad o2.xyz, r2, -r0.x, -r1
mov o5.xyz, r1
dp4 r0.y, c1, v0
mul r1.x, r0.y, c11.x
mul r1.w, r1.x, c21.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c21.x
mad o6.xy, r1.z, c12.zwzw, r1.xwzw
mul r1.x, r2.y, r2.y
mad r1.x, r2.x, r2.x, -r1.x
mul r3, r2.yzzx, r2.xyzz
dp4 r4.x, c16, r3
dp4 r4.y, c17, r3
dp4 r4.z, c18, r3
mad r1.xyz, c19, r1.x, r4
mov r2.w, c21.y
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mov o3.xyz, r2
add o8.xyz, r1, r3
dp4 r0.z, c2, v0
mov o0, r0
mov o6.zw, r0
mov o9.x, r0.z
mov o7, c21.z

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 240
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedlcdokamaifabpidegefpdbdchjmgealmabaaaaaafeajaaaaadaaaaaa
cmaaaaaaceabaaaadmacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheobaabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaaeabaaaaaiaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaaeabaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaaeabaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaaeabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaaaeabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaaeabaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaaeabaaaaagaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaaaeabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
baahaaaaeaaaabaameabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
gfaaaaadhccabaaaaiaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafeccabaaaabaaaaaackaabaaaaaaaaaaadgaaaaafmccabaaaagaaaaaa
kgaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajhcaabaaaadaaaaaaegacbaia
ebaaaaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaadgaaaaafhccabaaaaeaaaaaa
egacbaaaacaaaaaabaaaaaaiecaabaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaalhccabaaaacaaaaaaegacbaaaabaaaaaakgakbaiaebaaaaaa
aaaaaaaaegacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaa
adaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakfcaabaaa
aaaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaa
diaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaadpaaaaaaah
dccabaaaagaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadgaaaaaipccabaaa
ahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaaaaaaaaahhccabaaaaiaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "UNITY_HDR_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD7;
varying float xlv_TEXCOORD8;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec4 v_4;
  float cse_5;
  cse_5 = _World2Object[0].x;
  v_4.x = cse_5;
  float cse_6;
  cse_6 = _World2Object[1].x;
  v_4.y = cse_6;
  float cse_7;
  cse_7 = _World2Object[2].x;
  v_4.z = cse_7;
  float cse_8;
  cse_8 = _World2Object[3].x;
  v_4.w = cse_8;
  vec4 v_9;
  float cse_10;
  cse_10 = _World2Object[0].y;
  v_9.x = cse_10;
  float cse_11;
  cse_11 = _World2Object[1].y;
  v_9.y = cse_11;
  float cse_12;
  cse_12 = _World2Object[2].y;
  v_9.z = cse_12;
  float cse_13;
  cse_13 = _World2Object[3].y;
  v_9.w = cse_13;
  vec4 v_14;
  float cse_15;
  cse_15 = _World2Object[0].z;
  v_14.x = cse_15;
  float cse_16;
  cse_16 = _World2Object[1].z;
  v_14.y = cse_16;
  float cse_17;
  cse_17 = _World2Object[2].z;
  v_14.z = cse_17;
  float cse_18;
  cse_18 = _World2Object[3].z;
  v_14.w = cse_18;
  vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_4.xyz * gl_Normal.x)
   + 
    (v_9.xyz * gl_Normal.y)
  ) + (v_14.xyz * gl_Normal.z)));
  vec3 I_20;
  I_20 = (tmpvar_3 - _WorldSpaceCameraPos);
  vec4 o_21;
  vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * 0.5);
  vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_2.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 v_24;
  v_24.x = cse_5;
  v_24.y = cse_6;
  v_24.z = cse_7;
  v_24.w = cse_8;
  vec4 v_25;
  v_25.x = cse_10;
  v_25.y = cse_11;
  v_25.z = cse_12;
  v_25.w = cse_13;
  vec4 v_26;
  v_26.x = cse_15;
  v_26.y = cse_16;
  v_26.z = cse_17;
  v_26.w = cse_18;
  vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_24.xyz * gl_Normal.x)
   + 
    (v_25.xyz * gl_Normal.y)
  ) + (v_26.xyz * gl_Normal.z)));
  vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_27;
  vec3 x2_29;
  vec3 x1_30;
  x1_30.x = dot (unity_SHAr, tmpvar_28);
  x1_30.y = dot (unity_SHAg, tmpvar_28);
  x1_30.z = dot (unity_SHAb, tmpvar_28);
  vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_27.xyzz * tmpvar_27.yzzx);
  x2_29.x = dot (unity_SHBr, tmpvar_31);
  x2_29.y = dot (unity_SHBg, tmpvar_31);
  x2_29.z = dot (unity_SHBb, tmpvar_31);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (I_20 - (2.0 * (
    dot (tmpvar_19, I_20)
   * tmpvar_19)));
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_3);
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = tmpvar_1;
  xlv_TEXCOORD7 = ((x2_29 + (unity_SHC.xyz * 
    ((tmpvar_27.x * tmpvar_27.x) - (tmpvar_27.y * tmpvar_27.y))
  )) + x1_30);
  xlv_TEXCOORD8 = tmpvar_2.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform samplerCube _Skybox;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform vec4 _ReflectColor;
uniform float _Reflection;
uniform sampler2D _LightBuffer;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD7;
varying float xlv_TEXCOORD8;
void main ()
{
  vec4 c_1;
  vec4 light_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_LightBuffer, xlv_TEXCOORD5);
  light_2.w = tmpvar_4.w;
  light_2.xyz = (tmpvar_4.xyz + xlv_TEXCOORD7);
  vec4 c_5;
  c_5.xyz = (((
    (tmpvar_3 * _Color)
   * _Tint).xyz * light_2.xyz) + ((light_2.xyz * _SpecColor.xyz) * (tmpvar_4.w * tmpvar_3.w)));
  c_5.w = 1.0;
  c_1.w = c_5.w;
  c_1.xyz = (c_5.xyz + ((textureCube (_Skybox, xlv_TEXCOORD1) * 
    (_Reflection * (1.0 - dot (normalize(
      normalize(xlv_TEXCOORD4)
    ), xlv_TEXCOORD2)))
  ).xyz * _ReflectColor.xyz));
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD8))
  ), 0.0, 1.0)));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 20 [_MainTex_ST]
Vector 11 [_ProjectionParams]
Vector 12 [_ScreenParams]
Vector 10 [_WorldSpaceCameraPos]
Vector 15 [unity_SHAb]
Vector 14 [unity_SHAg]
Vector 13 [unity_SHAr]
Vector 18 [unity_SHBb]
Vector 17 [unity_SHBg]
Vector 16 [unity_SHBr]
Vector 19 [unity_SHC]
"vs_3_0
def c21, 0.5, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8.xyz
dcl_texcoord8 o9.x
mad o1.xy, v2, c20, c20.zwzw
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r1.xyz, -r0, c10
mov o4.xyz, r0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r2.xyz, r0
dp3 r0.x, -r1, r2
add r0.x, r0.x, r0.x
mad o2.xyz, r2, -r0.x, -r1
mov o5.xyz, r1
dp4 r0.y, c1, v0
mul r1.x, r0.y, c11.x
mul r1.w, r1.x, c21.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c21.x
mad o6.xy, r1.z, c12.zwzw, r1.xwzw
mul r1.x, r2.y, r2.y
mad r1.x, r2.x, r2.x, -r1.x
mul r3, r2.yzzx, r2.xyzz
dp4 r4.x, c16, r3
dp4 r4.y, c17, r3
dp4 r4.z, c18, r3
mad r1.xyz, c19, r1.x, r4
mov r2.w, c21.y
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mov o3.xyz, r2
add o8.xyz, r1, r3
dp4 r0.z, c2, v0
mov o0, r0
mov o6.zw, r0
mov o9.x, r0.z
mov o7, c21.z

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 240
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedlcdokamaifabpidegefpdbdchjmgealmabaaaaaafeajaaaaadaaaaaa
cmaaaaaaceabaaaadmacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheobaabaaaaakaaaaaaaiaaaaaapiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaaeabaaaaaiaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaaaeabaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaaeabaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaaaeabaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaaaeabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaaeabaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaaeabaaaaagaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaaaeabaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
baahaaaaeaaaabaameabaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
gfaaaaadhccabaaaaiaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafeccabaaaabaaaaaackaabaaaaaaaaaaadgaaaaafmccabaaaagaaaaaa
kgaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaacaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajhcaabaaaadaaaaaaegacbaia
ebaaaaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaadgaaaaafhccabaaaaeaaaaaa
egacbaaaacaaaaaabaaaaaaiecaabaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaalhccabaaaacaaaaaaegacbaaaabaaaaaakgakbaiaebaaaaaa
aaaaaaaaegacbaiaebaaaaaaadaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaa
adaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakfcaabaaa
aaaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaa
diaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaadpaaaaaaah
dccabaaaagaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadgaaaaaipccabaaa
ahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaaaaaaaaahhccabaaaaiaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 1 [_Color]
Vector 3 [_ReflectColor]
Float 4 [_Reflection]
Vector 0 [_SpecColor]
Vector 2 [_Tint]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
SetTexture 2 [_LightBuffer] 2D 2
"ps_3_0
def c5, 1, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord4_pp v3.xyz
dcl_texcoord5 v4
dcl_texcoord7 v5.xyz
dcl_2d s0
dcl_cube s1
dcl_2d s2
texldp_pp r0, v4, s2
log_pp r1.x, r0.x
log_pp r1.y, r0.y
log_pp r1.z, r0.z
log_pp r0.x, r0.w
add_pp r0.yzw, -r1.xxyz, v5.xxyz
mul_pp r1.xyz, r0.yzww, c0
texld_pp r2, v0, s0
mul_pp r0.x, -r0.x, r2.w
mul r2.xyz, r2, c1
mul_pp r2.xyz, r2, c2
mul_pp r1.xyz, r0.x, r1
mad_pp r0.xyz, r2, r0.yzww, r1
nrm_pp r1.xyz, v3
dp3 r0.w, r1, v2
add_pp r0.w, -r0.w, c5.x
mul r0.w, r0.w, c4.x
texld_pp r1, v1, s1
mul_pp r1.xyz, r0.w, r1
mad_pp oC0.xyz, r1, c3, r0
mov_pp oC0.w, c5.x

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 240
Vector 112 [_SpecColor]
Vector 144 [_Color]
Vector 160 [_Tint]
Vector 176 [_ReflectColor]
Float 196 [_Reflection]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlacndniidfbpgljhpoejhenffobfihnjabaaaaaalaaeaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefceiadaaaaeaaaaaaancaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadlcbabaaaagaaaaaagcbaaaadhcbabaaaaiaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
agaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
egbcbaaaaiaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaajaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaakaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegbcbaaaadaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaabaaaaaaegbcbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaaaaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaalaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Vector 1 [_Color]
Vector 3 [_ReflectColor]
Float 4 [_Reflection]
Vector 0 [_SpecColor]
Vector 2 [_Tint]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
SetTexture 2 [_LightBuffer] 2D 2
"ps_3_0
def c5, 1, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord4_pp v3.xyz
dcl_texcoord5 v4
dcl_texcoord7 v5.xyz
dcl_2d s0
dcl_cube s1
dcl_2d s2
texld_pp r0, v0, s0
texldp_pp r1, v4, s2
mul_pp r0.w, r0.w, r1.w
mul r0.xyz, r0, c1
mul_pp r0.xyz, r0, c2
add_pp r1.xyz, r1, v5
mul_pp r2.xyz, r1, c0
mul_pp r2.xyz, r0.w, r2
mad_pp r0.xyz, r0, r1, r2
nrm_pp r1.xyz, v3
dp3 r0.w, r1, v2
add_pp r0.w, -r0.w, c5.x
mul r0.w, r0.w, c4.x
texld_pp r1, v1, s1
mul_pp r1.xyz, r0.w, r1
mad_pp oC0.xyz, r1, c3, r0
mov_pp oC0.w, c5.x

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 240
Vector 112 [_SpecColor]
Vector 144 [_Color]
Vector 160 [_Tint]
Vector 176 [_ReflectColor]
Float 196 [_Reflection]
BindCB  "$Globals" 0
"ps_4_0
eefiecedflikhhjfdkcbkcgcfajhclkcjpfmeahfabaaaaaajeaeaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefccmadaaaaeaaaaaaamlaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadlcbabaaaagaaaaaagcbaaaadhcbabaaaaiaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
agaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaaiaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaakaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegbcbaaaadaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaabaaaaaa
egbcbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaaaaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "HDR_LIGHT_PREPASS_OFF" }
Vector 3 [_Color]
Vector 5 [_ReflectColor]
Float 6 [_Reflection]
Vector 2 [_SpecColor]
Vector 4 [_Tint]
Vector 0 [unity_FogColor]
Vector 1 [unity_FogParams]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
SetTexture 2 [_LightBuffer] 2D 2
"ps_3_0
def c7, 1, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord4_pp v3.xyz
dcl_texcoord5 v4
dcl_texcoord7 v5.xyz
dcl_texcoord8 v6.x
dcl_2d s0
dcl_cube s1
dcl_2d s2
texldp_pp r0, v4, s2
log_pp r1.x, r0.x
log_pp r1.y, r0.y
log_pp r1.z, r0.z
log_pp r0.x, r0.w
add_pp r0.yzw, -r1.xxyz, v5.xxyz
mul_pp r1.xyz, r0.yzww, c2
texld_pp r2, v0, s0
mul_pp r0.x, -r0.x, r2.w
mul r2.xyz, r2, c3
mul_pp r2.xyz, r2, c4
mul_pp r1.xyz, r0.x, r1
mad_pp r0.xyz, r2, r0.yzww, r1
nrm_pp r1.xyz, v3
dp3 r0.w, r1, v2
add_pp r0.w, -r0.w, c7.x
mul r0.w, r0.w, c6.x
texld_pp r1, v1, s1
mul_pp r1.xyz, r0.w, r1
mad_pp r0.xyz, r1, c5, r0
add r0.xyz, r0, -c0
mul r0.w, c1.y, v6.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c0
mov_pp oC0.w, c7.x

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 240
Vector 112 [_SpecColor]
Vector 144 [_Color]
Vector 160 [_Tint]
Vector 176 [_ReflectColor]
Float 196 [_Reflection]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedmhmooojdcglnikfbljibaohackdgljejabaaaaaaieafaaaaadaaaaaa
cmaaaaaaeeabaaaahiabaaaaejfdeheobaabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaaeabaaaaaiaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaaeabaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaaeabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaaeabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaaaeabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaaeabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapalaaaaaeabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaaeabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaeaeaaaa
eaaaaaaaababaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadlcbabaaa
agaaaaaagcbaaaadhcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaacpaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegbcbaaaaiaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egbcbaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaa
adaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaa
amaaaaaaefaaaaajpcaabaaaabaaaaaaegbcbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
alaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaackbabaaa
abaaaaaabkiacaaaabaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "UNITY_HDR_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "UNITY_HDR_ON" }
Vector 3 [_Color]
Vector 5 [_ReflectColor]
Float 6 [_Reflection]
Vector 2 [_SpecColor]
Vector 4 [_Tint]
Vector 0 [unity_FogColor]
Vector 1 [unity_FogParams]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
SetTexture 2 [_LightBuffer] 2D 2
"ps_3_0
def c7, 1, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord4_pp v3.xyz
dcl_texcoord5 v4
dcl_texcoord7 v5.xyz
dcl_texcoord8 v6.x
dcl_2d s0
dcl_cube s1
dcl_2d s2
texld_pp r0, v0, s0
texldp_pp r1, v4, s2
mul_pp r0.w, r0.w, r1.w
mul r0.xyz, r0, c3
mul_pp r0.xyz, r0, c4
add_pp r1.xyz, r1, v5
mul_pp r2.xyz, r1, c2
mul_pp r2.xyz, r0.w, r2
mad_pp r0.xyz, r0, r1, r2
nrm_pp r1.xyz, v3
dp3 r0.w, r1, v2
add_pp r0.w, -r0.w, c7.x
mul r0.w, r0.w, c6.x
texld_pp r1, v1, s1
mul_pp r1.xyz, r0.w, r1
mad_pp r0.xyz, r1, c5, r0
add r0.xyz, r0, -c0
mul r0.w, c1.y, v6.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c0
mov_pp oC0.w, c7.x

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 240
Vector 112 [_SpecColor]
Vector 144 [_Color]
Vector 160 [_Tint]
Vector 176 [_ReflectColor]
Float 196 [_Reflection]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedelgmhepnapbbgjlojllnnkhbibbnapioabaaaaaagiafaaaaadaaaaaa
cmaaaaaaeeabaaaahiabaaaaejfdeheobaabaaaaakaaaaaaaiaaaaaapiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaaeabaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaaeabaaaaaiaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaaeabaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaaeabaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaaeabaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaaaaaaaeabaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaaeabaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapalaaaaaeabaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaaaeabaaaaahaaaaaaaaaaaaaa
adaaaaaaaiaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiadaaaa
eaaaaaaapkaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadlcbabaaa
agaaaaaagcbaaaadhcbabaaaaiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaaiaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaafaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egbcbaaaadaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaa
aaaaaaaaamaaaaaaefaaaaajpcaabaaaabaaaaaaegbcbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaalaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
ckbabaaaabaaaaaabkiacaaaabaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
}
 }
 Pass {
  Name "DEFERRED"
  Tags { "LIGHTMODE"="Deferred" "RenderType"="Opaque" }
  GpuProgramID 322862
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
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
  vec3 I_7;
  I_7 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec3 x2_8;
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_8.x = dot (unity_SHBr, tmpvar_9);
  x2_8.y = dot (unity_SHBg, tmpvar_9);
  x2_8.z = dot (unity_SHBb, tmpvar_9);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (I_7 - (2.0 * (
    dot (tmpvar_6, I_7)
   * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_2);
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = (x2_8 + (unity_SHC.xyz * (
    (tmpvar_6.x * tmpvar_6.x)
   - 
    (tmpvar_6.y * tmpvar_6.y)
  )));
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform samplerCube _Skybox;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform vec4 _ReflectColor;
uniform float _Shininess;
uniform float _Reflection;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec4 outDiffuse_1;
  vec4 outEmission_2;
  vec4 tmpvar_3;
  tmpvar_3 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color) * _Tint);
  vec3 tmpvar_4;
  tmpvar_4 = ((textureCube (_Skybox, xlv_TEXCOORD1) * (_Reflection * 
    (1.0 - dot (normalize(normalize(xlv_TEXCOORD4)), xlv_TEXCOORD2))
  )).xyz * _ReflectColor.xyz);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = xlv_TEXCOORD2;
  vec3 x1_6;
  x1_6.x = dot (unity_SHAr, tmpvar_5);
  x1_6.y = dot (unity_SHAg, tmpvar_5);
  x1_6.z = dot (unity_SHAb, tmpvar_5);
  vec4 emission_7;
  vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_3.xyz;
  vec4 tmpvar_9;
  tmpvar_9.xyz = _SpecColor.xyz;
  tmpvar_9.w = _Shininess;
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((xlv_TEXCOORD2 * 0.5) + 0.5);
  vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_4;
  emission_7.w = tmpvar_11.w;
  emission_7.xyz = (tmpvar_4 + (tmpvar_3.xyz * (xlv_TEXCOORD6 + x1_6)));
  outDiffuse_1.xyz = tmpvar_8.xyz;
  outEmission_2.w = emission_7.w;
  outDiffuse_1.w = 1.0;
  outEmission_2.xyz = exp2(-(emission_7.xyz));
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = tmpvar_9;
  gl_FragData[2] = tmpvar_10;
  gl_FragData[3] = outEmission_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 15 [_MainTex_ST]
Vector 10 [_WorldSpaceCameraPos]
Vector 13 [unity_SHBb]
Vector 12 [unity_SHBg]
Vector 11 [unity_SHBr]
Vector 14 [unity_SHC]
"vs_3_0
def c16, 0, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6
dcl_texcoord6 o7.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c15, c15.zwzw
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r2.xyz, -r0, c10
mov o4.xyz, r0
dp3 r0.x, -r2, r1
add r0.x, r0.x, r0.x
mad o2.xyz, r1, -r0.x, -r2
mov o5.xyz, r2
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
mov o3.xyz, r1
dp4 r1.x, c11, r2
dp4 r1.y, c12, r2
dp4 r1.z, c13, r2
mad o7.xyz, c14, r0.x, r1
mov o6, c16.x

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 240
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
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
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedbbjfeccjjfccpmpclpigibdeokhkenhnabaaaaaamaahaaaaadaaaaaa
cmaaaaaaceabaaaaamacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefckmafaaaaeaaaabaaglabaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadhccabaaa
ahaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
anaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaalhccabaaaacaaaaaaegacbaaaaaaaaaaapgapbaiaebaaaaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaa
dgaaaaafhccabaaaadaaaaaaegacbaaaaaaaaaaadgaaaaaipccabaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaaaaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaaaaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaaaaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaabaaaaaadcaaaaakhccabaaaahaaaaaa
egiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD6;
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
  vec3 I_7;
  I_7 = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec3 x2_8;
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_8.x = dot (unity_SHBr, tmpvar_9);
  x2_8.y = dot (unity_SHBg, tmpvar_9);
  x2_8.z = dot (unity_SHBb, tmpvar_9);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (I_7 - (2.0 * (
    dot (tmpvar_6, I_7)
   * tmpvar_6)));
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_2);
  xlv_TEXCOORD5 = tmpvar_1;
  xlv_TEXCOORD6 = (x2_8 + (unity_SHC.xyz * (
    (tmpvar_6.x * tmpvar_6.x)
   - 
    (tmpvar_6.y * tmpvar_6.y)
  )));
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform samplerCube _Skybox;
uniform vec4 _Color;
uniform vec4 _Tint;
uniform vec4 _ReflectColor;
uniform float _Shininess;
uniform float _Reflection;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD6;
void main ()
{
  vec4 outDiffuse_1;
  vec4 tmpvar_2;
  tmpvar_2 = ((texture2D (_MainTex, xlv_TEXCOORD0) * _Color) * _Tint);
  vec3 tmpvar_3;
  tmpvar_3 = ((textureCube (_Skybox, xlv_TEXCOORD1) * (_Reflection * 
    (1.0 - dot (normalize(normalize(xlv_TEXCOORD4)), xlv_TEXCOORD2))
  )).xyz * _ReflectColor.xyz);
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = xlv_TEXCOORD2;
  vec3 x1_5;
  x1_5.x = dot (unity_SHAr, tmpvar_4);
  x1_5.y = dot (unity_SHAg, tmpvar_4);
  x1_5.z = dot (unity_SHAb, tmpvar_4);
  vec4 emission_6;
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_2.xyz;
  vec4 tmpvar_8;
  tmpvar_8.xyz = _SpecColor.xyz;
  tmpvar_8.w = _Shininess;
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((xlv_TEXCOORD2 * 0.5) + 0.5);
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_3;
  emission_6.w = tmpvar_10.w;
  emission_6.xyz = (tmpvar_3 + (tmpvar_2.xyz * (xlv_TEXCOORD6 + x1_5)));
  outDiffuse_1.xyz = tmpvar_7.xyz;
  outDiffuse_1.w = 1.0;
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = tmpvar_8;
  gl_FragData[2] = tmpvar_9;
  gl_FragData[3] = emission_6;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 15 [_MainTex_ST]
Vector 10 [_WorldSpaceCameraPos]
Vector 13 [unity_SHBb]
Vector 12 [unity_SHBg]
Vector 11 [unity_SHBr]
Vector 14 [unity_SHC]
"vs_3_0
def c16, 0, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord5 o6
dcl_texcoord6 o7.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c15, c15.zwzw
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
add r2.xyz, -r0, c10
mov o4.xyz, r0
dp3 r0.x, -r2, r1
add r0.x, r0.x, r0.x
mad o2.xyz, r1, -r0.x, -r2
mov o5.xyz, r2
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
mov o3.xyz, r1
dp4 r1.x, c11, r2
dp4 r1.y, c12, r2
dp4 r1.z, c13, r2
mad o7.xyz, c14, r0.x, r1
mov o6, c16.x

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 240
Vector 208 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
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
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedbbjfeccjjfccpmpclpigibdeokhkenhnabaaaaaamaahaaaaadaaaaaa
cmaaaaaaceabaaaaamacaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaneaaaaaa
agaaaaaaaaaaaaaaadaaaaaaahaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefckmafaaaaeaaaabaaglabaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagfaaaaadhccabaaa
ahaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
anaaaaaaogikcaaaaaaaaaaaanaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaa
abaaaaaaegiccaaaabaaaaaaaeaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaalhccabaaaacaaaaaaegacbaaaaaaaaaaapgapbaiaebaaaaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadgaaaaafhccabaaaafaaaaaaegacbaaaacaaaaaa
dgaaaaafhccabaaaadaaaaaaegacbaaaaaaaaaaadgaaaaaipccabaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaaaaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaaaaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaaaaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaabaaaaaadcaaaaakhccabaaaahaaaaaa
egiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 4 [_Color]
Vector 6 [_ReflectColor]
Float 8 [_Reflection]
Float 7 [_Shininess]
Vector 3 [_SpecColor]
Vector 5 [_Tint]
Vector 2 [unity_SHAb]
Vector 1 [unity_SHAg]
Vector 0 [unity_SHAr]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
"ps_3_0
def c9, 1, 0, 0.5, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord4_pp v3.xyz
dcl_texcoord6_pp v4.xyz
dcl_2d s0
dcl_cube s1
nrm_pp r0.xyz, v3
dp3 r0.x, r0, v2
add_pp r0.x, -r0.x, c9.x
mul r0.x, r0.x, c8.x
texld_pp r1, v1, s1
mul_pp r0.xyz, r0.x, r1
mad_pp r1, v2.xyzx, c9.xxxy, c9.yyyx
dp4_pp r2.x, c0, r1
dp4_pp r2.y, c1, r1
dp4_pp r2.z, c2, r1
add_pp r1.xyz, r2, v4
texld_pp r2, v0, s0
mul r2.xyz, r2, c4
mul_pp r2.xyz, r2, c5
mul_pp r1.xyz, r1, r2
mov_pp oC0.xyz, r2
mad_pp r0.xyz, r0, c6, r1
exp_pp oC3.x, -r0.x
exp_pp oC3.y, -r0.y
exp_pp oC3.z, -r0.z
mov_pp oC0.w, c9.x
mov_pp oC1.xyz, c3
mov_pp oC1.w, c7.x
mad_pp oC2, v2.xyzx, c9.zzzy, c9.zzzx
mov_pp oC3.w, c9.x

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
ConstBuffer "$Globals" 240
Vector 112 [_SpecColor]
Vector 144 [_Color]
Vector 160 [_Tint]
Vector 176 [_ReflectColor]
Float 192 [_Shininess]
Float 196 [_Reflection]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedmnkchghpmgplgjfeamdioeokjhfigoilabaaaaaahiafaaaaadaaaaaa
cmaaaaaabeabaaaajaabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheoheaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaagiaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagiaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaagiaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoaadaaaaeaaaaaaapiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaacjaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafidaaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaafaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaakaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdgaaaaaghccabaaa
abaaaaaaegiccaaaaaaaaaaaahaaaaaadgaaaaagiccabaaaabaaaaaaakiacaaa
aaaaaaaaamaaaaaadcaaaaaphccabaaaacaaaaaaegbcbaaaadaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaadgaaaaaficcabaaaacaaaaaaabeaaaaaaaaaiadpdgaaaaafhcaabaaa
abaaaaaaegbcbaaaadaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaabaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaahaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaa
afaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaadaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaa
efaaaaajpcaabaaaabaaaaaaegbcbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaa
egacbaaaaaaaaaaabjaaaaaghccabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaa
dgaaaaaficcabaaaadaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Vector 4 [_Color]
Vector 6 [_ReflectColor]
Float 8 [_Reflection]
Float 7 [_Shininess]
Vector 3 [_SpecColor]
Vector 5 [_Tint]
Vector 2 [unity_SHAb]
Vector 1 [unity_SHAg]
Vector 0 [unity_SHAr]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
"ps_3_0
def c9, 1, 0, 0.5, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_texcoord4_pp v3.xyz
dcl_texcoord6_pp v4.xyz
dcl_2d s0
dcl_cube s1
nrm_pp r0.xyz, v3
dp3 r0.x, r0, v2
add_pp r0.x, -r0.x, c9.x
mul r0.x, r0.x, c8.x
texld_pp r1, v1, s1
mul_pp r0.xyz, r0.x, r1
mad_pp r1, v2.xyzx, c9.xxxy, c9.yyyx
dp4_pp r2.x, c0, r1
dp4_pp r2.y, c1, r1
dp4_pp r2.z, c2, r1
add_pp r1.xyz, r2, v4
texld_pp r2, v0, s0
mul r2.xyz, r2, c4
mul_pp r2.xyz, r2, c5
mul_pp r1.xyz, r1, r2
mov_pp oC0.xyz, r2
mad_pp oC3.xyz, r0, c6, r1
mov_pp oC0.w, c9.x
mov_pp oC1.xyz, c3
mov_pp oC1.w, c7.x
mad_pp oC2, v2.xyzx, c9.zzzy, c9.zzzx
mov_pp oC3.w, c9.x

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] CUBE 1
ConstBuffer "$Globals" 240
Vector 112 [_SpecColor]
Vector 144 [_Color]
Vector 160 [_Tint]
Vector 176 [_ReflectColor]
Float 192 [_Shininess]
Float 196 [_Reflection]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedekkpnaoodlcggblcnelfjoofnbompiihabaaaaaagaafaaaaadaaaaaa
cmaaaaaabeabaaaajaabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheoheaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaagiaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagiaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaagiaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmiadaaaaeaaaaaaapcaaaaaa
fjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaacjaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafidaaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaafaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaakaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdgaaaaaghccabaaa
abaaaaaaegiccaaaaaaaaaaaahaaaaaadgaaaaagiccabaaaabaaaaaaakiacaaa
aaaaaaaaamaaaaaadcaaaaaphccabaaaacaaaaaaegbcbaaaadaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaadgaaaaaficcabaaaacaaaaaaabeaaaaaaaaaiadpdgaaaaafhcaabaaa
abaaaaaaegbcbaaaadaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaabaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaahaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaa
afaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaadaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaa
efaaaaajpcaabaaaabaaaaaaegbcbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaalaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaadaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
}
 }
}
Fallback "Diffuse"
}