Shader "Car/LightsEmmissive" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" { }
 _Intensity ("_Intensity", Range(0,3)) = 1
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  GpuProgramID 40587
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
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
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  vec3 x2_6;
  vec3 x1_7;
  x1_7.x = dot (unity_SHAr, tmpvar_5);
  x1_7.y = dot (unity_SHAg, tmpvar_5);
  x1_7.z = dot (unity_SHAb, tmpvar_5);
  vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_4.xyzz * tmpvar_4.yzzx);
  x2_6.x = dot (unity_SHBr, tmpvar_8);
  x2_6.y = dot (unity_SHBg, tmpvar_8);
  x2_6.z = dot (unity_SHBb, tmpvar_8);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD3 = ((x2_6 + (unity_SHC.xyz * 
    ((tmpvar_4.x * tmpvar_4.x) - (tmpvar_4.y * tmpvar_4.y))
  )) + x1_7);
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Intensity;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = 0.0;
  c_3.w = c_4.w;
  c_3.xyz = (c_4.xyz + (tmpvar_2.xyz * xlv_TEXCOORD3));
  c_1.xyz = (c_3.xyz + (tmpvar_2.xyz * _Intensity));
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
Vector 17 [_MainTex_ST]
Vector 12 [unity_SHAb]
Vector 11 [unity_SHAg]
Vector 10 [unity_SHAr]
Vector 15 [unity_SHBb]
Vector 14 [unity_SHBg]
Vector 13 [unity_SHBr]
Vector 16 [unity_SHC]
"vs_2_0
def c18, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c17, c17.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mad r0.xyz, c16, r0.x, r3
mov r1.w, c18.x
dp4 r2.x, c10, r1
dp4 r2.y, c11, r1
dp4 r2.z, c12, r1
mov oT1.xyz, r1
add oT3.xyz, r0, r2

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
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
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedglpcpknadddbhbbkmdncfaikjmniiggcabaaaaaaaaahaaaaadaaaaaa
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
adamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcdeafaaaaeaaaabaaenabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaa
abaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
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
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedafbknmkfnkgdginmccinheeemkfkgbhjabaaaaaaaaakaaaaaeaaaaaa
daaaaaaacmadaaaagiaiaaaagaajaaaaebgpgodjpeacaaaapeacaaaaaaacpopp
jmacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaalaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaaaaaeaaajaaaaaaaaaa
acaaamaaahaaanaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbeaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoeka
abaaookaafaaaaadaaaaahiaaaaaffjaaoaaoekaaeaaaaaeaaaaahiaanaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaahiaapaaoekaaaaakkjaaaaaoeiaaeaaaaae
acaaahoabaaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajabbaaaaka
afaaaaadaaaaaciaacaaaajabcaaaakaafaaaaadaaaaaeiaacaaaajabdaaaaka
afaaaaadabaaabiaacaaffjabbaaffkaafaaaaadabaaaciaacaaffjabcaaffka
afaaaaadabaaaeiaacaaffjabdaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
afaaaaadabaaabiaacaakkjabbaakkkaafaaaaadabaaaciaacaakkjabcaakkka
afaaaaadabaaaeiaacaakkjabdaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
ceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaae
aaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeia
ajaaaaadadaaabiaafaaoekaacaaoeiaajaaaaadadaaaciaagaaoekaacaaoeia
ajaaaaadadaaaeiaahaaoekaacaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaaaaia
adaaoeiaabaaaaacabaaaiiabeaaaakaajaaaaadacaaabiaacaaoekaabaaoeia
ajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaadacaaaeiaaeaaoekaabaaoeia
abaaaaacabaaahoaabaaoeiaacaaaaadadaaahoaaaaaoeiaacaaoeiaafaaaaad
aaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcdeafaaaaeaaaabaaenabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaae
egiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaa
aaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaa
cmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaa
egaobaaaaaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
oaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
ojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
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
varying vec4 xlv_TEXCOORD4;
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
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  vec3 x2_7;
  vec3 x1_8;
  x1_8.x = dot (unity_SHAr, tmpvar_6);
  x1_8.y = dot (unity_SHAg, tmpvar_6);
  x1_8.z = dot (unity_SHAb, tmpvar_6);
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyzz * tmpvar_5.yzzx);
  x2_7.x = dot (unity_SHBr, tmpvar_9);
  x2_7.y = dot (unity_SHBg, tmpvar_9);
  x2_7.z = dot (unity_SHBb, tmpvar_9);
  vec4 o_10;
  vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_1 * 0.5);
  vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD3 = ((x2_7 + (unity_SHC.xyz * 
    ((tmpvar_5.x * tmpvar_5.x) - (tmpvar_5.y * tmpvar_5.y))
  )) + x1_8);
  xlv_TEXCOORD4 = o_10;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Intensity;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = ((tmpvar_2.xyz * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = 0.0;
  c_3.w = c_4.w;
  c_3.xyz = (c_4.xyz + (tmpvar_2.xyz * xlv_TEXCOORD3));
  c_1.xyz = (c_3.xyz + (tmpvar_2.xyz * _Intensity));
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
Vector 19 [_MainTex_ST]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 14 [unity_SHAb]
Vector 13 [unity_SHAg]
Vector 12 [unity_SHAr]
Vector 17 [unity_SHBb]
Vector 16 [unity_SHBg]
Vector 15 [unity_SHBr]
Vector 18 [unity_SHC]
"vs_2_0
def c20, 1, 0.5, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c19, c19.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c15, r2
dp4 r3.y, c16, r2
dp4 r3.z, c17, r2
mad r0.xyz, c18, r0.x, r3
mov r1.w, c20.x
dp4 r2.x, c12, r1
dp4 r2.y, c13, r1
dp4 r2.z, c14, r1
mov oT1.xyz, r1
add oT3.xyz, r0, r2
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c20.y
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c20.y
mad oT4.xy, r1.z, c11.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov oPos, r0
mov oT4.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
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
eefiecedlhndficbopdfnnkidnaijhoagnacmdodabaaaaaamaahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
nmafaaaaeaaaabaahhabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaac
afaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
bcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakbcaabaaaacaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaacaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaa
abaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaa
cjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaa
ckaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaa
claaaaaaegaobaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
cmaaaaaaagaabaaaacaaaaaaegacbaaaaeaaaaaadgaaaaaficaabaaaabaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaabaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaabaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaabaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaacaaaaaaegacbaaa
adaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
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
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
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
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  vec3 x2_7;
  vec3 x1_8;
  x1_8.x = dot (unity_SHAr, tmpvar_6);
  x1_8.y = dot (unity_SHAg, tmpvar_6);
  x1_8.z = dot (unity_SHAb, tmpvar_6);
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyzz * tmpvar_5.yzzx);
  x2_7.x = dot (unity_SHBr, tmpvar_9);
  x2_7.y = dot (unity_SHBg, tmpvar_9);
  x2_7.z = dot (unity_SHBb, tmpvar_9);
  vec4 tmpvar_10;
  tmpvar_10 = (unity_4LightPosX0 - tmpvar_1.x);
  vec4 tmpvar_11;
  tmpvar_11 = (unity_4LightPosY0 - tmpvar_1.y);
  vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosZ0 - tmpvar_1.z);
  vec4 tmpvar_13;
  tmpvar_13 = (((tmpvar_10 * tmpvar_10) + (tmpvar_11 * tmpvar_11)) + (tmpvar_12 * tmpvar_12));
  vec4 tmpvar_14;
  tmpvar_14 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_10 * tmpvar_5.x) + (tmpvar_11 * tmpvar_5.y)) + (tmpvar_12 * tmpvar_5.z))
   * 
    inversesqrt(tmpvar_13)
  )) * (1.0/((1.0 + 
    (tmpvar_13 * unity_4LightAtten0)
  ))));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = (((x2_7 + 
    (unity_SHC.xyz * ((tmpvar_5.x * tmpvar_5.x) - (tmpvar_5.y * tmpvar_5.y)))
  ) + x1_8) + ((
    ((unity_LightColor[0].xyz * tmpvar_14.x) + (unity_LightColor[1].xyz * tmpvar_14.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_14.z)
  ) + (unity_LightColor[3].xyz * tmpvar_14.w)));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Intensity;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = 0.0;
  c_3.w = c_4.w;
  c_3.xyz = (c_4.xyz + (tmpvar_2.xyz * xlv_TEXCOORD3));
  c_1.xyz = (c_3.xyz + (tmpvar_2.xyz * _Intensity));
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
Vector 25 [_MainTex_ST]
Vector 17 [unity_4LightAtten0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 20 [unity_SHAb]
Vector 19 [unity_SHAg]
Vector 18 [unity_SHAr]
Vector 23 [unity_SHBb]
Vector 22 [unity_SHBg]
Vector 21 [unity_SHBr]
Vector 24 [unity_SHC]
"vs_2_0
def c26, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c4, v0
dp4 oPos.y, c5, v0
dp4 oPos.z, c6, v0
dp4 oPos.w, c7, v0
mad oT0.xy, v2, c25, c25.zwzw
mul r0.xyz, v1.y, c12
mad r0.xyz, c11, v1.x, r0
mad r0.xyz, c13, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c21, r2
dp4 r3.y, c22, r2
dp4 r3.z, c23, r2
mad r0.xyz, c24, r0.x, r3
mov r1.w, c26.x
dp4 r2.x, c18, r1
dp4 r2.y, c19, r1
dp4 r2.z, c20, r1
add r0.xyz, r0, r2
dp4 r2.y, c9, v0
add r3, -r2.y, c15
mul r4, r1.y, r3
mul r3, r3, r3
dp4 r2.x, c8, v0
add r5, -r2.x, c14
mad r4, r5, r1.x, r4
mad r3, r5, r5, r3
dp4 r2.z, c10, v0
add r5, -r2.z, c16
mov oT2.xyz, r2
mad r2, r5, r1.z, r4
mov oT1.xyz, r1
mad r1, r5, r5, r3
rsq r3.x, r1.x
rsq r3.y, r1.y
rsq r3.z, r1.z
rsq r3.w, r1.w
mov r4.x, c26.x
mad r1, r1, c17, r4.x
mul r2, r2, r3
max r2, r2, c26.y
rcp r3.x, r1.x
rcp r3.y, r1.y
rcp r3.z, r1.z
rcp r3.w, r1.w
mul r1, r2, r3
mul r2.xyz, r1.y, c1
mad r2.xyz, c0, r1.x, r2
mad r1.xyz, c2, r1.z, r2
mad r1.xyz, c3, r1.w, r1
add oT3.xyz, r0, r1

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmcafebnfdahffilkippfemammonknpfeabaaaaaammajaaaaadaaaaaa
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
adamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcaaaiaaaaeaaaabaaaaacaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaabaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaa
egiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaia
ebaaaaaaabaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaa
fgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
adaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaa
abaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaabaaaaaakgakbaia
ebaaaaaaabaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaa
egaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaa
aaaaaaaaegaobaaaabaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaa
dcaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
adaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaabaaaaaadcaaaaanpcaabaaa
abaaaaaaegaobaaaabaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedgeanciieifejiedjbjcdaabdhbneplogabaaaaaajaaoaaaaaeaaaaaa
daaaaaaapaaeaaaapiamaaaapaanaaaaebgpgodjliaeaaaaliaeaaaaaaacpopp
feaeaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaalaa
abaaabaaaaaaaaaaabaaacaaaiaaacaaaaaaaaaaabaacgaaahaaakaaaaaaaaaa
acaaaaaaaeaabbaaaaaaaaaaacaaamaaahaabfaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbmaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaabiaacaaaajabjaaaaka
afaaaaadaaaaaciaacaaaajabkaaaakaafaaaaadaaaaaeiaacaaaajablaaaaka
afaaaaadabaaabiaacaaffjabjaaffkaafaaaaadabaaaciaacaaffjabkaaffka
afaaaaadabaaaeiaacaaffjablaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
afaaaaadabaaabiaacaakkjabjaakkkaafaaaaadabaaaciaacaakkjabkaakkka
afaaaaadabaaaeiaacaakkjablaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
ceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaae
aaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeia
ajaaaaadadaaabiaanaaoekaacaaoeiaajaaaaadadaaaciaaoaaoekaacaaoeia
ajaaaaadadaaaeiaapaaoekaacaaoeiaaeaaaaaeaaaaahiabaaaoekaaaaaaaia
adaaoeiaabaaaaacabaaaiiabmaaaakaajaaaaadacaaabiaakaaoekaabaaoeia
ajaaaaadacaaaciaalaaoekaabaaoeiaajaaaaadacaaaeiaamaaoekaabaaoeia
acaaaaadaaaaahiaaaaaoeiaacaaoeiaafaaaaadacaaahiaaaaaffjabgaaoeka
aeaaaaaeacaaahiabfaaoekaaaaaaajaacaaoeiaaeaaaaaeacaaahiabhaaoeka
aaaakkjaacaaoeiaaeaaaaaeacaaahiabiaaoekaaaaappjaacaaoeiaacaaaaad
adaaapiaacaaffibadaaoekaafaaaaadaeaaapiaabaaffiaadaaoeiaafaaaaad
adaaapiaadaaoeiaadaaoeiaacaaaaadafaaapiaacaaaaibacaaoekaaeaaaaae
aeaaapiaafaaoeiaabaaaaiaaeaaoeiaaeaaaaaeadaaapiaafaaoeiaafaaoeia
adaaoeiaacaaaaadafaaapiaacaakkibaeaaoekaabaaaaacacaaahoaacaaoeia
aeaaaaaeacaaapiaafaaoeiaabaakkiaaeaaoeiaabaaaaacabaaahoaabaaoeia
aeaaaaaeabaaapiaafaaoeiaafaaoeiaadaaoeiaahaaaaacadaaabiaabaaaaia
ahaaaaacadaaaciaabaaffiaahaaaaacadaaaeiaabaakkiaahaaaaacadaaaiia
abaappiaabaaaaacaeaaabiabmaaaakaaeaaaaaeabaaapiaabaaoeiaafaaoeka
aeaaaaiaafaaaaadacaaapiaacaaoeiaadaaoeiaalaaaaadacaaapiaacaaoeia
bmaaffkaagaaaaacadaaabiaabaaaaiaagaaaaacadaaaciaabaaffiaagaaaaac
adaaaeiaabaakkiaagaaaaacadaaaiiaabaappiaafaaaaadabaaapiaacaaoeia
adaaoeiaafaaaaadacaaahiaabaaffiaahaaoekaaeaaaaaeacaaahiaagaaoeka
abaaaaiaacaaoeiaaeaaaaaeabaaahiaaiaaoekaabaakkiaacaaoeiaaeaaaaae
abaaahiaajaaoekaabaappiaabaaoeiaacaaaaadadaaahoaaaaaoeiaabaaoeia
afaaaaadaaaaapiaaaaaffjabcaaoekaaeaaaaaeaaaaapiabbaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiabdaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
beaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefcaaaiaaaaeaaaabaaaaacaaaa
fjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaa
fjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacagaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
abaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakicaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaia
ebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaacmaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaaj
pcaabaaaadaaaaaafgafbaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaadaaaaaa
diaaaaahpcaabaaaaeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaa
afaaaaaaagaabaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaaj
pcaabaaaabaaaaaakgakbaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaaeaaaaaa
dcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaaabaaaaaakgakbaaaaaaaaaaa
egaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaa
afaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaa
abaaaaaadcaaaaanpcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaabaaaaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaabaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaa
aeaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheopaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
nbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
oaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
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
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
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
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  vec3 x2_8;
  vec3 x1_9;
  x1_9.x = dot (unity_SHAr, tmpvar_7);
  x1_9.y = dot (unity_SHAg, tmpvar_7);
  x1_9.z = dot (unity_SHAb, tmpvar_7);
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_8.x = dot (unity_SHBr, tmpvar_10);
  x2_8.y = dot (unity_SHBg, tmpvar_10);
  x2_8.z = dot (unity_SHBb, tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = (unity_4LightPosX0 - tmpvar_2.x);
  vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosY0 - tmpvar_2.y);
  vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosZ0 - tmpvar_2.z);
  vec4 tmpvar_14;
  tmpvar_14 = (((tmpvar_11 * tmpvar_11) + (tmpvar_12 * tmpvar_12)) + (tmpvar_13 * tmpvar_13));
  vec4 tmpvar_15;
  tmpvar_15 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_11 * tmpvar_6.x) + (tmpvar_12 * tmpvar_6.y)) + (tmpvar_13 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_14)
  )) * (1.0/((1.0 + 
    (tmpvar_14 * unity_4LightAtten0)
  ))));
  vec4 o_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_1 * 0.5);
  vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (((x2_8 + 
    (unity_SHC.xyz * ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y)))
  ) + x1_9) + ((
    ((unity_LightColor[0].xyz * tmpvar_15.x) + (unity_LightColor[1].xyz * tmpvar_15.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_15.z)
  ) + (unity_LightColor[3].xyz * tmpvar_15.w)));
  xlv_TEXCOORD4 = o_16;
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Intensity;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = ((tmpvar_2.xyz * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = 0.0;
  c_3.w = c_4.w;
  c_3.xyz = (c_4.xyz + (tmpvar_2.xyz * xlv_TEXCOORD3));
  c_1.xyz = (c_3.xyz + (tmpvar_2.xyz * _Intensity));
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
Vector 27 [_MainTex_ST]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 19 [unity_4LightAtten0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 22 [unity_SHAb]
Vector 21 [unity_SHAg]
Vector 20 [unity_SHAr]
Vector 25 [unity_SHBb]
Vector 24 [unity_SHBg]
Vector 23 [unity_SHBr]
Vector 26 [unity_SHC]
"vs_2_0
def c28, 1, 0, 0.5, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c27, c27.zwzw
mul r0.xyz, v1.y, c12
mad r0.xyz, c11, v1.x, r0
mad r0.xyz, c13, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c23, r2
dp4 r3.y, c24, r2
dp4 r3.z, c25, r2
mad r0.xyz, c26, r0.x, r3
mov r1.w, c28.x
dp4 r2.x, c20, r1
dp4 r2.y, c21, r1
dp4 r2.z, c22, r1
add r0.xyz, r0, r2
dp4 r2.y, c9, v0
add r3, -r2.y, c17
mul r4, r1.y, r3
mul r3, r3, r3
dp4 r2.x, c8, v0
add r5, -r2.x, c16
mad r4, r5, r1.x, r4
mad r3, r5, r5, r3
dp4 r2.z, c10, v0
add r5, -r2.z, c18
mov oT2.xyz, r2
mad r2, r5, r1.z, r4
mov oT1.xyz, r1
mad r1, r5, r5, r3
rsq r3.x, r1.x
rsq r3.y, r1.y
rsq r3.z, r1.z
rsq r3.w, r1.w
mov r4.x, c28.x
mad r1, r1, c19, r4.x
mul r2, r2, r3
max r2, r2, c28.y
rcp r3.x, r1.x
rcp r3.y, r1.y
rcp r3.z, r1.z
rcp r3.w, r1.w
mul r1, r2, r3
mul r2.xyz, r1.y, c1
mad r2.xyz, c0, r1.x, r2
mad r1.xyz, c2, r1.z, r2
mad r1.xyz, c3, r1.w, r1
add oT3.xyz, r0, r1
dp4 r0.y, c5, v0
mul r1.x, r0.y, c14.x
mul r1.w, r1.x, c28.z
dp4 r0.x, c4, v0
dp4 r0.w, c7, v0
mul r1.xz, r0.xyww, c28.z
mad oT4.xy, r1.z, c15.zwzw, r1.xwzw
dp4 r0.z, c6, v0
mov oPos, r0
mov oT4.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
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
eefiecedkicpldpfkldihjclfgjbldkidoobckhpabaaaaaaimakaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
kiaiaaaaeaaaabaackacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaac
ahaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
bcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaacaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaibcaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
acaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaacaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaacaaaaaa
diaaaaahicaabaaaacaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaak
icaabaaaacaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaa
acaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaa
bbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaa
bbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaa
bbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaacaaaaaa
egacbaaaaeaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaaeaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaaaaaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaaaaaaaaajpcaabaaa
aeaaaaaafgafbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaah
pcaabaaaafaaaaaafgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaahpcaabaaa
aeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaaagaaaaaa
agaabaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaa
acaaaaaakgakbaiaebaaaaaaacaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaaj
pcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaaafaaaaaa
dcaaaaajpcaabaaaabaaaaaaegaobaaaacaaaaaakgakbaaaabaaaaaaegaobaaa
afaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaa
egaobaaaaeaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaacaaaaaa
dcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaacaaaaaaafaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaa
abaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
ajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaaeaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
afaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedoodhfbficggnbkagjemmnhbpkmjbnpggabaaaaaaaiamaaaaaeaaaaaa
daaaaaaanaadaaaafiakaaaafaalaaaaebgpgodjjiadaaaajiadaaaaaaacpopp
deadaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaalaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaiaaaeaaajaaaaaaaaaa
adaaaaaaaeaaanaaaaaaaaaaadaaamaaahaabbaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbiaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjabcaaoeka
aeaaaaaeaaaaahiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabdaaoeka
aaaakkjaaaaaoeiaaeaaaaaeacaaahoabeaaoekaaaaappjaaaaaoeiaafaaaaad
aaaaabiaacaaaajabfaaaakaafaaaaadaaaaaciaacaaaajabgaaaakaafaaaaad
aaaaaeiaacaaaajabhaaaakaafaaaaadabaaabiaacaaffjabfaaffkaafaaaaad
abaaaciaacaaffjabgaaffkaafaaaaadabaaaeiaacaaffjabhaaffkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjabfaakkkaafaaaaad
abaaaciaacaakkjabgaakkkaafaaaaadabaaaeiaacaakkjabhaakkkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabia
abaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaad
acaaapiaabaacjiaabaakeiaajaaaaadadaaabiaafaaoekaacaaoeiaajaaaaad
adaaaciaagaaoekaacaaoeiaajaaaaadadaaaeiaahaaoekaacaaoeiaaeaaaaae
aaaaahiaaiaaoekaaaaaaaiaadaaoeiaabaaaaacabaaaiiabiaaaakaajaaaaad
acaaabiaacaaoekaabaaoeiaajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaad
acaaaeiaaeaaoekaabaaoeiaabaaaaacabaaahoaabaaoeiaacaaaaadadaaahoa
aaaaoeiaacaaoeiaafaaaaadaaaaapiaaaaaffjabcaaoekaaeaaaaaeaaaaapia
bbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabdaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiabeaaoekaaaaappjaaaaaoeiaafaaaaadabaaapiaaaaaffia
akaaoekaaeaaaaaeabaaapiaajaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapia
alaaoekaaaaakkiaabaaoeiaaeaaaaaeaeaaapoaamaaoekaaaaappiaabaaoeia
afaaaaadaaaaapiaaaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
baaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefciaagaaaaeaaaabaakaabaaaa
fjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaa
fjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaa
aaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaa
cmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaa
egaobaaaaaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaajaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaacaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaakaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaafaaaaaaegiocaaaacaaaaaa
alaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheopaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
nbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
oaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedemkkhdnamoaknnmogkgkgliimlkmloelabaaaaaajibaaaaaaeaaaaaa
daaaaaaajeafaaaaoiaoaaaaoaapaaaaebgpgodjfmafaaaafmafaaaaaaacpopp
omaeaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaalaa
abaaabaaaaaaaaaaabaaacaaaiaaacaaaaaaaaaaabaacgaaahaaakaaaaaaaaaa
acaaaiaaaeaabbaaaaaaaaaaadaaaaaaaeaabfaaaaaaaaaaadaaamaaahaabjaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafcaaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaad
aaaaabiaacaaaajabnaaaakaafaaaaadaaaaaciaacaaaajaboaaaakaafaaaaad
aaaaaeiaacaaaajabpaaaakaafaaaaadabaaabiaacaaffjabnaaffkaafaaaaad
abaaaciaacaaffjaboaaffkaafaaaaadabaaaeiaacaaffjabpaaffkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjabnaakkkaafaaaaad
abaaaciaacaakkjaboaakkkaafaaaaadabaaaeiaacaakkjabpaakkkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabia
abaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaad
acaaapiaabaacjiaabaakeiaajaaaaadadaaabiaanaaoekaacaaoeiaajaaaaad
adaaaciaaoaaoekaacaaoeiaajaaaaadadaaaeiaapaaoekaacaaoeiaaeaaaaae
aaaaahiabaaaoekaaaaaaaiaadaaoeiaabaaaaacabaaaiiacaaaaakaajaaaaad
acaaabiaakaaoekaabaaoeiaajaaaaadacaaaciaalaaoekaabaaoeiaajaaaaad
acaaaeiaamaaoekaabaaoeiaacaaaaadaaaaahiaaaaaoeiaacaaoeiaafaaaaad
acaaahiaaaaaffjabkaaoekaaeaaaaaeacaaahiabjaaoekaaaaaaajaacaaoeia
aeaaaaaeacaaahiablaaoekaaaaakkjaacaaoeiaaeaaaaaeacaaahiabmaaoeka
aaaappjaacaaoeiaacaaaaadadaaapiaacaaffibadaaoekaafaaaaadaeaaapia
abaaffiaadaaoeiaafaaaaadadaaapiaadaaoeiaadaaoeiaacaaaaadafaaapia
acaaaaibacaaoekaaeaaaaaeaeaaapiaafaaoeiaabaaaaiaaeaaoeiaaeaaaaae
adaaapiaafaaoeiaafaaoeiaadaaoeiaacaaaaadafaaapiaacaakkibaeaaoeka
abaaaaacacaaahoaacaaoeiaaeaaaaaeacaaapiaafaaoeiaabaakkiaaeaaoeia
abaaaaacabaaahoaabaaoeiaaeaaaaaeabaaapiaafaaoeiaafaaoeiaadaaoeia
ahaaaaacadaaabiaabaaaaiaahaaaaacadaaaciaabaaffiaahaaaaacadaaaeia
abaakkiaahaaaaacadaaaiiaabaappiaabaaaaacaeaaabiacaaaaakaaeaaaaae
abaaapiaabaaoeiaafaaoekaaeaaaaiaafaaaaadacaaapiaacaaoeiaadaaoeia
alaaaaadacaaapiaacaaoeiacaaaffkaagaaaaacadaaabiaabaaaaiaagaaaaac
adaaaciaabaaffiaagaaaaacadaaaeiaabaakkiaagaaaaacadaaaiiaabaappia
afaaaaadabaaapiaacaaoeiaadaaoeiaafaaaaadacaaahiaabaaffiaahaaoeka
aeaaaaaeacaaahiaagaaoekaabaaaaiaacaaoeiaaeaaaaaeabaaahiaaiaaoeka
abaakkiaacaaoeiaaeaaaaaeabaaahiaajaaoekaabaappiaabaaoeiaacaaaaad
adaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffjabkaaoekaaeaaaaae
aaaaapiabjaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiablaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabmaaoekaaaaappjaaaaaoeiaafaaaaadabaaapia
aaaaffiabcaaoekaaeaaaaaeabaaapiabbaaoekaaaaaaaiaabaaoeiaaeaaaaae
abaaapiabdaaoekaaaaakkiaabaaoeiaaeaaaaaeaeaaapoabeaaoekaaaaappia
abaaoeiaafaaaaadaaaaapiaaaaaffjabgaaoekaaeaaaaaeaaaaapiabfaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiabhaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiabiaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcemajaaaaeaaaabaa
fdacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
cnaaaaaafjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacagaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaa
diaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
abaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakicaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaia
ebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaacmaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaaj
pcaabaaaadaaaaaafgafbaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaadaaaaaa
diaaaaahpcaabaaaaeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaah
pcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaa
afaaaaaaagaabaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaaj
pcaabaaaabaaaaaakgakbaiaebaaaaaaabaaaaaaegiocaaaabaaaaaaaeaaaaaa
dcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaaabaaaaaakgakbaaaaaaaaaaa
egaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaa
afaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaa
abaaaaaadcaaaaanpcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaabaaaaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaabaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaa
aeaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaacaaaaaaajaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaa
aiaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaafaaaaaaegiocaaaacaaaaaaalaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
oaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
ojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
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
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  vec3 x2_7;
  vec3 x1_8;
  x1_8.x = dot (unity_SHAr, tmpvar_6);
  x1_8.y = dot (unity_SHAg, tmpvar_6);
  x1_8.z = dot (unity_SHAb, tmpvar_6);
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyzz * tmpvar_5.yzzx);
  x2_7.x = dot (unity_SHBr, tmpvar_9);
  x2_7.y = dot (unity_SHBg, tmpvar_9);
  x2_7.z = dot (unity_SHBb, tmpvar_9);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD3 = ((x2_7 + (unity_SHC.xyz * 
    ((tmpvar_5.x * tmpvar_5.x) - (tmpvar_5.y * tmpvar_5.y))
  )) + x1_8);
  xlv_TEXCOORD5 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Intensity;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = 0.0;
  c_3.w = c_4.w;
  c_3.xyz = (c_4.xyz + (tmpvar_2.xyz * xlv_TEXCOORD3));
  c_1.w = c_3.w;
  c_1.xyz = (c_3.xyz + (tmpvar_2.xyz * _Intensity));
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(clamp (xlv_TEXCOORD5, 0.0, 1.0)));
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
Vector 18 [_MainTex_ST]
Vector 17 [unity_FogParams]
Vector 12 [unity_SHAb]
Vector 11 [unity_SHAg]
Vector 10 [unity_SHAr]
Vector 15 [unity_SHBb]
Vector 14 [unity_SHBg]
Vector 13 [unity_SHBr]
Vector 16 [unity_SHC]
"vs_2_0
def c19, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c18, c18.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mad r0.xyz, c16, r0.x, r3
mov r1.w, c19.x
dp4 r2.x, c10, r1
dp4 r2.y, c11, r1
dp4 r2.z, c12, r1
mov oT1.xyz, r1
add oT3.xyz, r0, r2
dp4 r0.x, c2, v0
mul r0.y, r0.x, c17.y
mov oPos.z, r0.x
exp oT5.x, -r0.y

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
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
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0
eefiecedkffmfdmnhkmdiecmjhddhfoddonpfkhgabaaaaaaiaahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
jmafaaaaeaaaabaaghabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaae
egiocaaaadaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaa
aaaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaa
abaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
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
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0_level_9_1
eefiecedpnekppapcipoddmmhpjgjhfabjdfckklabaaaaaakiakaaaaaeaaaaaa
daaaaaaafeadaaaapiaiaaaapaajaaaaebgpgodjbmadaaaabmadaaaaaaacpopp
liacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaalaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaaaaaeaaajaaaaaaaaaa
acaaamaaahaaanaaaaaaaaaaadaaabaaabaabeaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbfaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaaoaaoeka
aeaaaaaeaaaaahiaanaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaapaaoeka
aaaakkjaaaaaoeiaaeaaaaaeacaaahoabaaaoekaaaaappjaaaaaoeiaafaaaaad
aaaaabiaacaaaajabbaaaakaafaaaaadaaaaaciaacaaaajabcaaaakaafaaaaad
aaaaaeiaacaaaajabdaaaakaafaaaaadabaaabiaacaaffjabbaaffkaafaaaaad
abaaaciaacaaffjabcaaffkaafaaaaadabaaaeiaacaaffjabdaaffkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjabbaakkkaafaaaaad
abaaaciaacaakkjabcaakkkaafaaaaadabaaaeiaacaakkjabdaakkkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabia
abaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaad
acaaapiaabaacjiaabaakeiaajaaaaadadaaabiaafaaoekaacaaoeiaajaaaaad
adaaaciaagaaoekaacaaoeiaajaaaaadadaaaeiaahaaoekaacaaoeiaaeaaaaae
aaaaahiaaiaaoekaaaaaaaiaadaaoeiaabaaaaacabaaaiiabfaaaakaajaaaaad
acaaabiaacaaoekaabaaoeiaajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaad
acaaaeiaaeaaoekaabaaoeiaabaaaaacabaaahoaabaaoeiaacaaaaadadaaahoa
aaaaoeiaacaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapia
ajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaakkia
beaaffkaaoaaaaacaaaaaeoaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcjmafaaaaeaaaabaa
ghabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
cnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaaeegiocaaaadaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
adaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
acaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
acaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
acaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaa
abaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaa
adaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
acaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
acaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
acaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaa
aeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheopaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
nbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
oaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaa
abaaaaaaaealaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX
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
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
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
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  vec3 x2_7;
  vec3 x1_8;
  x1_8.x = dot (unity_SHAr, tmpvar_6);
  x1_8.y = dot (unity_SHAg, tmpvar_6);
  x1_8.z = dot (unity_SHAb, tmpvar_6);
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyzz * tmpvar_5.yzzx);
  x2_7.x = dot (unity_SHBr, tmpvar_9);
  x2_7.y = dot (unity_SHBg, tmpvar_9);
  x2_7.z = dot (unity_SHBb, tmpvar_9);
  vec4 o_10;
  vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_1 * 0.5);
  vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD3 = ((x2_7 + (unity_SHC.xyz * 
    ((tmpvar_5.x * tmpvar_5.x) - (tmpvar_5.y * tmpvar_5.y))
  )) + x1_8);
  xlv_TEXCOORD4 = o_10;
  xlv_TEXCOORD5 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Intensity;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = ((tmpvar_2.xyz * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = 0.0;
  c_3.w = c_4.w;
  c_3.xyz = (c_4.xyz + (tmpvar_2.xyz * xlv_TEXCOORD3));
  c_1.w = c_3.w;
  c_1.xyz = (c_3.xyz + (tmpvar_2.xyz * _Intensity));
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(clamp (xlv_TEXCOORD5, 0.0, 1.0)));
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
Vector 20 [_MainTex_ST]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 19 [unity_FogParams]
Vector 14 [unity_SHAb]
Vector 13 [unity_SHAg]
Vector 12 [unity_SHAr]
Vector 17 [unity_SHBb]
Vector 16 [unity_SHBg]
Vector 15 [unity_SHBr]
Vector 18 [unity_SHC]
"vs_2_0
def c21, 1, 0.5, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c20, c20.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c15, r2
dp4 r3.y, c16, r2
dp4 r3.z, c17, r2
mad r0.xyz, c18, r0.x, r3
mov r1.w, c21.x
dp4 r2.x, c12, r1
dp4 r2.y, c13, r1
dp4 r2.z, c14, r1
mov oT1.xyz, r1
add oT3.xyz, r0, r2
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c21.y
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c21.y
mad oT4.xy, r1.z, c11.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mul r1.x, r0.z, c19.y
exp oT5.x, -r1.x
mov oPos, r0
mov oT4.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
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
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0
eefiecediljlccbmcommmcagofepaolgjhijinacabaaaaaacmaiaaaaadaaaaaa
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
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdaagaaaaeaaaabaa
imabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafjaaaaaeegiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaackaabaaaaaaaaaaabkiacaaaaeaaaaaa
abaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaa
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
abaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaahbcaabaaa
acaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaacaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaadiaaaaah
pcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaa
aeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaa
aeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaa
aeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaacaaaaaaegacbaaaaeaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaaaaaaaaahhccabaaaaeaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
afaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
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
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  vec3 x2_8;
  vec3 x1_9;
  x1_9.x = dot (unity_SHAr, tmpvar_7);
  x1_9.y = dot (unity_SHAg, tmpvar_7);
  x1_9.z = dot (unity_SHAb, tmpvar_7);
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_8.x = dot (unity_SHBr, tmpvar_10);
  x2_8.y = dot (unity_SHBg, tmpvar_10);
  x2_8.z = dot (unity_SHBb, tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = (unity_4LightPosX0 - tmpvar_2.x);
  vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosY0 - tmpvar_2.y);
  vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosZ0 - tmpvar_2.z);
  vec4 tmpvar_14;
  tmpvar_14 = (((tmpvar_11 * tmpvar_11) + (tmpvar_12 * tmpvar_12)) + (tmpvar_13 * tmpvar_13));
  vec4 tmpvar_15;
  tmpvar_15 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_11 * tmpvar_6.x) + (tmpvar_12 * tmpvar_6.y)) + (tmpvar_13 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_14)
  )) * (1.0/((1.0 + 
    (tmpvar_14 * unity_4LightAtten0)
  ))));
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (((x2_8 + 
    (unity_SHC.xyz * ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y)))
  ) + x1_9) + ((
    ((unity_LightColor[0].xyz * tmpvar_15.x) + (unity_LightColor[1].xyz * tmpvar_15.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_15.z)
  ) + (unity_LightColor[3].xyz * tmpvar_15.w)));
  xlv_TEXCOORD5 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Intensity;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = 0.0;
  c_3.w = c_4.w;
  c_3.xyz = (c_4.xyz + (tmpvar_2.xyz * xlv_TEXCOORD3));
  c_1.w = c_3.w;
  c_1.xyz = (c_3.xyz + (tmpvar_2.xyz * _Intensity));
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(clamp (xlv_TEXCOORD5, 0.0, 1.0)));
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
Vector 26 [_MainTex_ST]
Vector 17 [unity_4LightAtten0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 25 [unity_FogParams]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 20 [unity_SHAb]
Vector 19 [unity_SHAg]
Vector 18 [unity_SHAr]
Vector 23 [unity_SHBb]
Vector 22 [unity_SHBg]
Vector 21 [unity_SHBr]
Vector 24 [unity_SHC]
"vs_2_0
def c27, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c4, v0
dp4 oPos.y, c5, v0
dp4 oPos.w, c7, v0
mad oT0.xy, v2, c26, c26.zwzw
mul r0.xyz, v1.y, c12
mad r0.xyz, c11, v1.x, r0
mad r0.xyz, c13, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c21, r2
dp4 r3.y, c22, r2
dp4 r3.z, c23, r2
mad r0.xyz, c24, r0.x, r3
mov r1.w, c27.x
dp4 r2.x, c18, r1
dp4 r2.y, c19, r1
dp4 r2.z, c20, r1
add r0.xyz, r0, r2
dp4 r2.y, c9, v0
add r3, -r2.y, c15
mul r4, r1.y, r3
mul r3, r3, r3
dp4 r2.x, c8, v0
add r5, -r2.x, c14
mad r4, r5, r1.x, r4
mad r3, r5, r5, r3
dp4 r2.z, c10, v0
add r5, -r2.z, c16
mov oT2.xyz, r2
mad r2, r5, r1.z, r4
mov oT1.xyz, r1
mad r1, r5, r5, r3
rsq r3.x, r1.x
rsq r3.y, r1.y
rsq r3.z, r1.z
rsq r3.w, r1.w
mov r4.x, c27.x
mad r1, r1, c17, r4.x
mul r2, r2, r3
max r2, r2, c27.y
rcp r3.x, r1.x
rcp r3.y, r1.y
rcp r3.z, r1.z
rcp r3.w, r1.w
mul r1, r2, r3
mul r2.xyz, r1.y, c1
mad r2.xyz, c0, r1.x, r2
mad r1.xyz, c2, r1.z, r2
mad r1.xyz, c3, r1.w, r1
add oT3.xyz, r0, r1
dp4 r0.x, c6, v0
mul r0.y, r0.x, c25.y
mov oPos.z, r0.x
exp oT5.x, -r0.y

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0
eefiecedmhakfnmnicfijmanjdnkillpkljddhaaabaaaaaaemakaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
giaiaaaaeaaaabaabkacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaae
egiocaaaadaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaac
agaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaa
aaaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaabaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaa
egiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaia
ebaaaaaaabaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaa
fgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
adaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaa
abaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaabaaaaaakgakbaia
ebaaaaaaabaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaa
egaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaa
aaaaaaaaegaobaaaabaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaa
dcaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
adaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaabaaaaaadcaaaaanpcaabaaa
abaaaaaaegaobaaaabaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0_level_9_1
eefiecedbmpaodlihlfebhgfppaghdpagcileogkabaaaaaadiapaaaaaeaaaaaa
daaaaaaabiafaaaaiianaaaaiaaoaaaaebgpgodjoaaeaaaaoaaeaaaaaaacpopp
haaeaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaalaa
abaaabaaaaaaaaaaabaaacaaaiaaacaaaaaaaaaaabaacgaaahaaakaaaaaaaaaa
acaaaaaaaeaabbaaaaaaaaaaacaaamaaahaabfaaaaaaaaaaadaaabaaabaabmaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbnaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaad
aaaaabiaacaaaajabjaaaakaafaaaaadaaaaaciaacaaaajabkaaaakaafaaaaad
aaaaaeiaacaaaajablaaaakaafaaaaadabaaabiaacaaffjabjaaffkaafaaaaad
abaaaciaacaaffjabkaaffkaafaaaaadabaaaeiaacaaffjablaaffkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjabjaakkkaafaaaaad
abaaaciaacaakkjabkaakkkaafaaaaadabaaaeiaacaakkjablaakkkaacaaaaad
aaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabia
abaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaad
acaaapiaabaacjiaabaakeiaajaaaaadadaaabiaanaaoekaacaaoeiaajaaaaad
adaaaciaaoaaoekaacaaoeiaajaaaaadadaaaeiaapaaoekaacaaoeiaaeaaaaae
aaaaahiabaaaoekaaaaaaaiaadaaoeiaabaaaaacabaaaiiabnaaaakaajaaaaad
acaaabiaakaaoekaabaaoeiaajaaaaadacaaaciaalaaoekaabaaoeiaajaaaaad
acaaaeiaamaaoekaabaaoeiaacaaaaadaaaaahiaaaaaoeiaacaaoeiaafaaaaad
acaaahiaaaaaffjabgaaoekaaeaaaaaeacaaahiabfaaoekaaaaaaajaacaaoeia
aeaaaaaeacaaahiabhaaoekaaaaakkjaacaaoeiaaeaaaaaeacaaahiabiaaoeka
aaaappjaacaaoeiaacaaaaadadaaapiaacaaffibadaaoekaafaaaaadaeaaapia
abaaffiaadaaoeiaafaaaaadadaaapiaadaaoeiaadaaoeiaacaaaaadafaaapia
acaaaaibacaaoekaaeaaaaaeaeaaapiaafaaoeiaabaaaaiaaeaaoeiaaeaaaaae
adaaapiaafaaoeiaafaaoeiaadaaoeiaacaaaaadafaaapiaacaakkibaeaaoeka
abaaaaacacaaahoaacaaoeiaaeaaaaaeacaaapiaafaaoeiaabaakkiaaeaaoeia
abaaaaacabaaahoaabaaoeiaaeaaaaaeabaaapiaafaaoeiaafaaoeiaadaaoeia
ahaaaaacadaaabiaabaaaaiaahaaaaacadaaaciaabaaffiaahaaaaacadaaaeia
abaakkiaahaaaaacadaaaiiaabaappiaabaaaaacaeaaabiabnaaaakaaeaaaaae
abaaapiaabaaoeiaafaaoekaaeaaaaiaafaaaaadacaaapiaacaaoeiaadaaoeia
alaaaaadacaaapiaacaaoeiabnaaffkaagaaaaacadaaabiaabaaaaiaagaaaaac
adaaaciaabaaffiaagaaaaacadaaaeiaabaakkiaagaaaaacadaaaiiaabaappia
afaaaaadabaaapiaacaaoeiaadaaoeiaafaaaaadacaaahiaabaaffiaahaaoeka
aeaaaaaeacaaahiaagaaoekaabaaaaiaacaaoeiaaeaaaaaeabaaahiaaiaaoeka
abaakkiaacaaoeiaaeaaaaaeabaaahiaajaaoekaabaappiaabaaoeiaacaaaaad
adaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffjabcaaoekaaeaaaaae
aaaaapiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabdaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabeaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaakkiabmaaffkaaoaaaaacaaaaaeoaabaaaaibaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcgiaiaaaa
eaaaabaabkacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafjaaaaaeegiocaaa
adaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacagaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaa
bkiacaaaadaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
alaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaa
acaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaa
acaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaa
ckiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaabaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaadgaaaaaf
icaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaa
abaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
abaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
abaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaa
abaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaa
aaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaabaaaaaa
egiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaabaaaaaakgakbaiaebaaaaaa
abaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaa
afaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaa
egaobaaaabaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaa
adaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaadcaaaaaj
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
eeaaaaafpcaabaaaadaaaaaaegaobaaaabaaaaaadcaaaaanpcaabaaaabaaaaaa
egaobaaaabaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpaoaaaaakpcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
oaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
ojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
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
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  vec3 x2_8;
  vec3 x1_9;
  x1_9.x = dot (unity_SHAr, tmpvar_7);
  x1_9.y = dot (unity_SHAg, tmpvar_7);
  x1_9.z = dot (unity_SHAb, tmpvar_7);
  vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_6.xyzz * tmpvar_6.yzzx);
  x2_8.x = dot (unity_SHBr, tmpvar_10);
  x2_8.y = dot (unity_SHBg, tmpvar_10);
  x2_8.z = dot (unity_SHBb, tmpvar_10);
  vec4 tmpvar_11;
  tmpvar_11 = (unity_4LightPosX0 - tmpvar_2.x);
  vec4 tmpvar_12;
  tmpvar_12 = (unity_4LightPosY0 - tmpvar_2.y);
  vec4 tmpvar_13;
  tmpvar_13 = (unity_4LightPosZ0 - tmpvar_2.z);
  vec4 tmpvar_14;
  tmpvar_14 = (((tmpvar_11 * tmpvar_11) + (tmpvar_12 * tmpvar_12)) + (tmpvar_13 * tmpvar_13));
  vec4 tmpvar_15;
  tmpvar_15 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_11 * tmpvar_6.x) + (tmpvar_12 * tmpvar_6.y)) + (tmpvar_13 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_14)
  )) * (1.0/((1.0 + 
    (tmpvar_14 * unity_4LightAtten0)
  ))));
  vec4 o_16;
  vec4 tmpvar_17;
  tmpvar_17 = (tmpvar_1 * 0.5);
  vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_17.x;
  tmpvar_18.y = (tmpvar_17.y * _ProjectionParams.x);
  o_16.xy = (tmpvar_18 + tmpvar_17.w);
  o_16.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (((x2_8 + 
    (unity_SHC.xyz * ((tmpvar_6.x * tmpvar_6.x) - (tmpvar_6.y * tmpvar_6.y)))
  ) + x1_9) + ((
    ((unity_LightColor[0].xyz * tmpvar_15.x) + (unity_LightColor[1].xyz * tmpvar_15.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_15.z)
  ) + (unity_LightColor[3].xyz * tmpvar_15.w)));
  xlv_TEXCOORD4 = o_16;
  xlv_TEXCOORD5 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 unity_FogColor;
uniform vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Intensity;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = ((tmpvar_2.xyz * (_LightColor0.xyz * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = 0.0;
  c_3.w = c_4.w;
  c_3.xyz = (c_4.xyz + (tmpvar_2.xyz * xlv_TEXCOORD3));
  c_1.w = c_3.w;
  c_1.xyz = (c_3.xyz + (tmpvar_2.xyz * _Intensity));
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(clamp (xlv_TEXCOORD5, 0.0, 1.0)));
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
Vector 28 [_MainTex_ST]
Vector 14 [_ProjectionParams]
Vector 15 [_ScreenParams]
Vector 19 [unity_4LightAtten0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 27 [unity_FogParams]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 22 [unity_SHAb]
Vector 21 [unity_SHAg]
Vector 20 [unity_SHAr]
Vector 25 [unity_SHBb]
Vector 24 [unity_SHBg]
Vector 23 [unity_SHBr]
Vector 26 [unity_SHC]
"vs_2_0
def c29, 1, 0, 0.5, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c28, c28.zwzw
mul r0.xyz, v1.y, c12
mad r0.xyz, c11, v1.x, r0
mad r0.xyz, c13, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c23, r2
dp4 r3.y, c24, r2
dp4 r3.z, c25, r2
mad r0.xyz, c26, r0.x, r3
mov r1.w, c29.x
dp4 r2.x, c20, r1
dp4 r2.y, c21, r1
dp4 r2.z, c22, r1
add r0.xyz, r0, r2
dp4 r2.y, c9, v0
add r3, -r2.y, c17
mul r4, r1.y, r3
mul r3, r3, r3
dp4 r2.x, c8, v0
add r5, -r2.x, c16
mad r4, r5, r1.x, r4
mad r3, r5, r5, r3
dp4 r2.z, c10, v0
add r5, -r2.z, c18
mov oT2.xyz, r2
mad r2, r5, r1.z, r4
mov oT1.xyz, r1
mad r1, r5, r5, r3
rsq r3.x, r1.x
rsq r3.y, r1.y
rsq r3.z, r1.z
rsq r3.w, r1.w
mov r4.x, c29.x
mad r1, r1, c19, r4.x
mul r2, r2, r3
max r2, r2, c29.y
rcp r3.x, r1.x
rcp r3.y, r1.y
rcp r3.z, r1.z
rcp r3.w, r1.w
mul r1, r2, r3
mul r2.xyz, r1.y, c1
mad r2.xyz, c0, r1.x, r2
mad r1.xyz, c2, r1.z, r2
mad r1.xyz, c3, r1.w, r1
add oT3.xyz, r0, r1
dp4 r0.y, c5, v0
mul r1.x, r0.y, c14.x
mul r1.w, r1.x, c29.z
dp4 r0.x, c4, v0
dp4 r0.w, c7, v0
mul r1.xz, r0.xyww, c29.z
mad oT4.xy, r1.z, c15.zwzw, r1.xwzw
dp4 r0.z, c6, v0
mul r1.x, r0.z, c27.y
exp oT5.x, -r1.x
mov oPos, r0
mov oT4.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
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
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0
eefieceddifdofobjkameplkkonmghcpgoildlgfabaaaaaapiakaaaaadaaaaaa
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
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpmaiaaaaeaaaabaa
dpacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafjaaaaaeegiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaackaabaaaaaaaaaaabkiacaaaaeaaaaaa
abaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadiaaaaaibcaabaaaabaaaaaaakbabaaaacaaaaaaakiacaaa
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
abaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaafhccabaaa
adaaaaaaegacbaaaacaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaacaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaacaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaa
abaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaa
cjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaa
ckaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaa
claaaaaaegaobaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaa
cmaaaaaapgapbaaaacaaaaaaegacbaaaaeaaaaaadgaaaaaficaabaaaabaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaabaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaabaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaabaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaa
aeaaaaaaaaaaaaajpcaabaaaaeaaaaaafgafbaiaebaaaaaaacaaaaaaegiocaaa
acaaaaaaadaaaaaadiaaaaahpcaabaaaafaaaaaafgafbaaaabaaaaaaegaobaaa
aeaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaa
aaaaaaajpcaabaaaagaaaaaaagaabaiaebaaaaaaacaaaaaaegiocaaaacaaaaaa
acaaaaaaaaaaaaajpcaabaaaacaaaaaakgakbaiaebaaaaaaacaaaaaaegiocaaa
acaaaaaaaeaaaaaadcaaaaajpcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaa
abaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaacaaaaaa
kgakbaaaabaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaa
agaaaaaaegaobaaaagaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaa
aeaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaa
egiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
aoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
egaobaaaacaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
aeaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
acaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaagaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
aaaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
afaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0_level_9_1
eefiecedgmkfadmagfcbcpljhdbdiemjjcdmmphpabaaaaaalaamaaaaaeaaaaaa
daaaaaaapiadaaaaoiakaaaaoaalaaaaebgpgodjmaadaaaamaadaaaaaaacpopp
faadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaalaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaiaaaeaaajaaaaaaaaaa
adaaaaaaaeaaanaaaaaaaaaaadaaamaaahaabbaaaaaaaaaaaeaaabaaabaabiaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbjaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaad
aaaaahiaaaaaffjabcaaoekaaeaaaaaeaaaaahiabbaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabdaaoekaaaaakkjaaaaaoeiaaeaaaaaeacaaahoabeaaoeka
aaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajabfaaaakaafaaaaadaaaaacia
acaaaajabgaaaakaafaaaaadaaaaaeiaacaaaajabhaaaakaafaaaaadabaaabia
acaaffjabfaaffkaafaaaaadabaaaciaacaaffjabgaaffkaafaaaaadabaaaeia
acaaffjabhaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabia
acaakkjabfaakkkaafaaaaadabaaaciaacaakkjabgaakkkaafaaaaadabaaaeia
acaakkjabhaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahia
aaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaia
abaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeiaajaaaaadadaaabia
afaaoekaacaaoeiaajaaaaadadaaaciaagaaoekaacaaoeiaajaaaaadadaaaeia
ahaaoekaacaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaaaaiaadaaoeiaabaaaaac
abaaaiiabjaaaakaajaaaaadacaaabiaacaaoekaabaaoeiaajaaaaadacaaacia
adaaoekaabaaoeiaajaaaaadacaaaeiaaeaaoekaabaaoeiaabaaaaacabaaahoa
abaaoeiaacaaaaadadaaahoaaaaaoeiaacaaoeiaafaaaaadaaaaapiaaaaaffja
bcaaoekaaeaaaaaeaaaaapiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
bdaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabeaaoekaaaaappjaaaaaoeia
afaaaaadabaaapiaaaaaffiaakaaoekaaeaaaaaeabaaapiaajaaoekaaaaaaaia
abaaoeiaaeaaaaaeabaaapiaalaaoekaaaaakkiaabaaoeiaaeaaaaaeaeaaapoa
amaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffjaaoaaoekaaeaaaaae
aaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaakkiabiaaffkaaoaaaaacaaaaaeoaabaaaaibaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcoiagaaaa
eaaaabaalkabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaaeegiocaaa
adaaaaaabdaaaaaafjaaaaaeegiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaa
aeaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
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
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaadaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaa
abaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaa
adaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
acaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
acaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
acaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaa
aeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaacaaaaaaajaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaa
aiaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaafaaaaaaegiocaaaacaaaaaaalaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
oaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
ojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
lmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityShadows" 416
Matrix 128 [unity_World2Shadow0]
Matrix 192 [unity_World2Shadow1]
Matrix 256 [unity_World2Shadow2]
Matrix 320 [unity_World2Shadow3]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0_level_9_1
eefiecedobahdipophcilafihpjlejobmjblkonhabaaaaaaeabbaaaaaeaaaaaa
daaaaaaalmafaaaahiapaaaahabaaaaaebgpgodjieafaaaaieafaaaaaaacpopp
aiafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaalaa
abaaabaaaaaaaaaaabaaacaaaiaaacaaaaaaaaaaabaacgaaahaaakaaaaaaaaaa
acaaaiaaaeaabbaaaaaaaaaaadaaaaaaaeaabfaaaaaaaaaaadaaamaaahaabjaa
aaaaaaaaaeaaabaaabaacaaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafcbaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoeja
abaaoekaabaaookaafaaaaadaaaaabiaacaaaajabnaaaakaafaaaaadaaaaacia
acaaaajaboaaaakaafaaaaadaaaaaeiaacaaaajabpaaaakaafaaaaadabaaabia
acaaffjabnaaffkaafaaaaadabaaaciaacaaffjaboaaffkaafaaaaadabaaaeia
acaaffjabpaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabia
acaakkjabnaakkkaafaaaaadabaaaciaacaakkjaboaakkkaafaaaaadabaaaeia
acaakkjabpaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaceaaaaacabaaahia
aaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaaeaaaaabiaabaaaaia
abaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeiaajaaaaadadaaabia
anaaoekaacaaoeiaajaaaaadadaaaciaaoaaoekaacaaoeiaajaaaaadadaaaeia
apaaoekaacaaoeiaaeaaaaaeaaaaahiabaaaoekaaaaaaaiaadaaoeiaabaaaaac
abaaaiiacbaaaakaajaaaaadacaaabiaakaaoekaabaaoeiaajaaaaadacaaacia
alaaoekaabaaoeiaajaaaaadacaaaeiaamaaoekaabaaoeiaacaaaaadaaaaahia
aaaaoeiaacaaoeiaafaaaaadacaaahiaaaaaffjabkaaoekaaeaaaaaeacaaahia
bjaaoekaaaaaaajaacaaoeiaaeaaaaaeacaaahiablaaoekaaaaakkjaacaaoeia
aeaaaaaeacaaahiabmaaoekaaaaappjaacaaoeiaacaaaaadadaaapiaacaaffib
adaaoekaafaaaaadaeaaapiaabaaffiaadaaoeiaafaaaaadadaaapiaadaaoeia
adaaoeiaacaaaaadafaaapiaacaaaaibacaaoekaaeaaaaaeaeaaapiaafaaoeia
abaaaaiaaeaaoeiaaeaaaaaeadaaapiaafaaoeiaafaaoeiaadaaoeiaacaaaaad
afaaapiaacaakkibaeaaoekaabaaaaacacaaahoaacaaoeiaaeaaaaaeacaaapia
afaaoeiaabaakkiaaeaaoeiaabaaaaacabaaahoaabaaoeiaaeaaaaaeabaaapia
afaaoeiaafaaoeiaadaaoeiaahaaaaacadaaabiaabaaaaiaahaaaaacadaaacia
abaaffiaahaaaaacadaaaeiaabaakkiaahaaaaacadaaaiiaabaappiaabaaaaac
aeaaabiacbaaaakaaeaaaaaeabaaapiaabaaoeiaafaaoekaaeaaaaiaafaaaaad
acaaapiaacaaoeiaadaaoeiaalaaaaadacaaapiaacaaoeiacbaaffkaagaaaaac
adaaabiaabaaaaiaagaaaaacadaaaciaabaaffiaagaaaaacadaaaeiaabaakkia
agaaaaacadaaaiiaabaappiaafaaaaadabaaapiaacaaoeiaadaaoeiaafaaaaad
acaaahiaabaaffiaahaaoekaaeaaaaaeacaaahiaagaaoekaabaaaaiaacaaoeia
aeaaaaaeabaaahiaaiaaoekaabaakkiaacaaoeiaaeaaaaaeabaaahiaajaaoeka
abaappiaabaaoeiaacaaaaadadaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapia
aaaaffjabkaaoekaaeaaaaaeaaaaapiabjaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiablaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabmaaoekaaaaappja
aaaaoeiaafaaaaadabaaapiaaaaaffiabcaaoekaaeaaaaaeabaaapiabbaaoeka
aaaaaaiaabaaoeiaaeaaaaaeabaaapiabdaaoekaaaaakkiaabaaoeiaaeaaaaae
aeaaapoabeaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffjabgaaoeka
aeaaaaaeaaaaapiabfaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabhaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiabiaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaakkiacaaaffkaaoaaaaacaaaaaeoaabaaaaibaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefc
leajaaaaeaaaabaagnacaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaaamaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafjaaaaaeegiocaaaaeaaaaaaacaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
eccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacagaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaa
bkiacaaaaeaaaaaaabaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
alaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
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
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaabaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaadgaaaaaf
icaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaa
abaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
abaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
abaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaa
abaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaa
aaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaabaaaaaa
egiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaabaaaaaakgakbaiaebaaaaaa
abaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaa
afaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaa
egaobaaaabaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaa
adaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaadcaaaaaj
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
eeaaaaafpcaabaaaadaaaaaaegaobaaaabaaaaaadcaaaaanpcaabaaaabaaaaaa
egaobaaaabaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpaoaaaaakpcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegaobaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaajaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaacaaaaaaaiaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaakaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaafaaaaaaegiocaaaacaaaaaa
alaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheopaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
nbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
oaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaa
laaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaa
abaaaaaaaealaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
lmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Vector 2 [_Color]
Float 3 [_Intensity]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c4, 0, 1, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t3.xyz
dcl_2d s0
texld_pp r0, t0, s0
dp3_pp r0.w, t1, c0
max_pp r1.w, r0.w, c4.x
mul_pp r0.xyz, r0, c2
mul_pp r1.xyz, r0, c1
mul_pp r2.xyz, r0, t3
mad_pp r1.xyz, r1, r1.w, r2
mad_pp r0.xyz, r0, c3.x, r1
mov_pp r0.w, c4.y
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 160 [_Intensity]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedakcnaaheplidjkpbkljejlmhiebpgajkabaaaaaakeacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcjmabaaaaeaaaaaaaghaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaabaaaaaaibcaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaa
ajaaaaaadiaaaaaihcaabaaaabaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaa
agaaaaaadiaaaaahhcaabaaaacaaaaaajgahbaaaaaaaaaaaegbcbaaaaeaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhccabaaaaaaaaaaajgahbaaaaaaaaaaaagiacaaaaaaaaaaa
akaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 160 [_Intensity]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedjkgoknbjacpigebpinmkkafjipejkohiabaaaaaaomadaaaaaeaaaaaa
daaaaaaaheabaaaabiadaaaaliadaaaaebgpgodjdmabaaaadmabaaaaaaacpppp
paaaaaaaemaaaaaaadaaciaaaaaaemaaaaaaemaaabaaceaaaaaaemaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaaaaaajaaacaaabaaaaaaaaaaabaaaaaaabaaadaa
aaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaia
adaachlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpiaaaaaoelaaaaioeka
aiaaaaadaaaaciiaabaaoelaadaaoekaalaaaaadabaaciiaaaaappiaaeaaaaka
afaaaaadaaaachiaaaaaoeiaabaaoekaafaaaaadabaachiaaaaaoeiaaaaaoeka
afaaaaadacaachiaaaaaoeiaadaaoelaaeaaaaaeabaachiaabaaoeiaabaappia
acaaoeiaaeaaaaaeaaaachiaaaaaoeiaacaaaakaabaaoeiaabaaaaacaaaaciia
aeaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcjmabaaaaeaaaaaaa
ghaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaaibcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaiocaabaaa
aaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaa
abaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaa
acaaaaaajgahbaaaaaaaaaaaegbcbaaaaeaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaa
aaaaaaaajgahbaaaaaaaaaaaagiacaaaaaaaaaaaakaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Vector 2 [_Color]
Float 3 [_Intensity]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
def c4, 0, 1, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t3.xyz
dcl_pp t4
dcl_2d s0
dcl_2d s1
texldp_pp r0, t4, s0
texld_pp r1, t0, s1
dp3_pp r1.w, t1, c0
max_pp r0.y, r1.w, c4.x
mul_pp r2.xyz, r0.x, c1
mul_pp r1.xyz, r1, c2
mul_pp r2.xyz, r2, r1
mul_pp r3.xyz, r1, t3
mad_pp r0.xyz, r2, r0.y, r3
mad_pp r0.xyz, r1, c3.x, r0
mov_pp r0.w, c4.y
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 160 [_Intensity]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedpogllgkjijiefbpdokjenopaagjopjmiabaaaaaaeaadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccaacaaaa
eaaaaaaaiiaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaabaaaaaaibcaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aoaaaaahgcaabaaaaaaaaaaaagbbbaaaafaaaaaapgbpbaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaajgafbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaaagaabaaaabaaaaaaagijcaaaaaaaaaaaagaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
ajaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaadcaaaaaj
hcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 15 [_ShadowMapTexture] 2D 15
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 160 [_Intensity]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
"ps_4_0_level_9_1
eefiecedklhmcgacmpnknalcfdomeeoldpobcnlcabaaaaaaemafaaaaafaaaaaa
deaaaaaaoaabaaaafaaeaaaagaaeaaaabiafaaaaebgpgodjkeabaaaakeabaaaa
aaacppppeiabaaaafmaaaaaaaeaacmaaaaaafmaaaaaafmaaacaaceaaaaaafmaa
apapaaaaaaaaabaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaacaaabaaaaaaaaaa
abaaaaaaabaaadaaaaaaaaaaacaabiaaabaaaeaaaaaaaaaaaaacppppfbaaaaaf
afaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaia
aeaacplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaacpiaaeaaoelaaaaioekaecaaaaadabaacpiaaaaaoelaabaioekaaiaaaaad
abaaciiaabaaoelaadaaoekaalaaaaadaaaacciaabaappiaafaaffkaabaaaaac
abaaaiiaafaaaakabcaaaaaeacaaciiaaaaaaaiaabaappiaaeaaaakaafaaaaad
acaachiaacaappiaaaaaoekaafaaaaadabaachiaabaaoeiaabaaoekaafaaaaad
acaachiaacaaoeiaabaaoeiaafaaaaadadaachiaabaaoeiaadaaoelaaeaaaaae
aaaachiaacaaoeiaaaaaffiaadaaoeiaaeaaaaaeaaaachiaabaaoeiaacaaaaka
aaaaoeiaabaaaaacaaaaciiaafaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcgiacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabjaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaiaaadaagabaaaapaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaapaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaai
bcaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaehaaaaalccaabaaa
aaaaaaaaegbabaaaafaaaaaaaghabaaaapaaaaaaaagabaaaapaaaaaackbabaaa
afaaaaaaaaaaaaajecaabaaaaaaaaaaaakiacaiaebaaaaaaacaaaaaabiaaaaaa
abeaaaaaaaaaiadpdcaaaaakccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaa
aaaaaaaaakiacaaaacaaaaaabiaaaaaadiaaaaaiocaabaaaaaaaaaaafgafbaaa
aaaaaaaaagijcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaahocaabaaaaaaaaaaa
fgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
abaaaaaaegbcbaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaaaaaaaaaegacbaaa
abaaaaaaagiacaaaaaaaaaaaakaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaabfdegejdaaiaaaaaaiaaaaaaaaaaaaaaa
ejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Vector 3 [_Color]
Float 4 [_Intensity]
Vector 2 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [unity_FogColor]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c5, 0, 1, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t3.xyz
dcl t5.x
dcl_2d s0
texld_pp r0, t0, s0
dp3_pp r0.w, t1, c0
max_pp r1.w, r0.w, c5.x
mul_pp r0.xyz, r0, c3
mul_pp r1.xyz, r0, c2
mul_pp r2.xyz, r0, t3
mad_pp r1.xyz, r1, r1.w, r2
mad_pp r0.xyz, r0, c4.x, r1
mov_sat r0.w, t5.x
lrp_pp r1.xyz, r0.w, r0, c1
mov_pp r1.w, c5.y
mov_pp oC0, r1

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 160 [_Intensity]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityFog" 2
"ps_4_0
eefiecedmjamgffccddeejjdaakhmobilmnlkbfaabaaaaaadiadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbiacaaaa
eaaaaaaaigaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaaibcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaiocaabaaa
aaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaa
abaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaa
acaaaaaajgahbaaaaaaaaaaaegbcbaaaaeaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaajgahbaaaaaaaaaaaagiacaaaaaaaaaaaakaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
aaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadcaaaaakhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 160 [_Intensity]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityFog" 2
"ps_4_0_level_9_1
eefiecedlpgcomgkipdkhpmpfecfbheecfanlcblabaaaaaakmaeaaaaaeaaaaaa
daaaaaaakaabaaaamaadaaaahiaeaaaaebgpgodjgiabaaaagiabaaaaaaacpppp
baabaaaafiaaaaaaaeaaciaaaaaafiaaaaaafiaaabaaceaaaaaafiaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaaaaaajaaacaaabaaaaaaaaaaabaaaaaaabaaadaa
aaaaaaaaacaaaaaaabaaaeaaaaaaaaaaaaacppppfbaaaaafafaaapkaaaaaaaaa
aaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaia
abaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaajaaaaiapkaecaaaaad
aaaacpiaaaaaoelaaaaioekaaiaaaaadaaaaciiaabaaoelaadaaoekaalaaaaad
abaaciiaaaaappiaafaaaakaafaaaaadaaaachiaaaaaoeiaabaaoekaafaaaaad
abaachiaaaaaoeiaaaaaoekaafaaaaadacaachiaaaaaoeiaadaaoelaaeaaaaae
abaachiaabaaoeiaabaappiaacaaoeiaaeaaaaaeaaaachiaaaaaoeiaacaaaaka
abaaoeiaabaaaaacaaaabiiaaaaakklabcaaaaaeabaachiaaaaappiaaaaaoeia
aeaaoekaabaaaaacabaaciiaafaaffkaabaaaaacaaaicpiaabaaoeiappppaaaa
fdeieefcbiacaaaaeaaaaaaaigaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
baaaaaaibcaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaajaaaaaa
diaaaaaihcaabaaaabaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
diaaaaahhcaabaaaacaaaaaajgahbaaaaaaaaaaaegbcbaaaaeaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaajgahbaaaaaaaaaaaagiacaaaaaaaaaaaakaaaaaa
egacbaaaabaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaacaaaaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaa
dcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
acaaaaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
ejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
keaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaeaeaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
Vector 3 [_Color]
Float 4 [_Intensity]
Vector 2 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [unity_FogColor]
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
def c5, 0, 1, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t3.xyz
dcl_pp t4
dcl t5.x
dcl_2d s0
dcl_2d s1
texldp_pp r0, t4, s0
texld_pp r1, t0, s1
dp3_pp r1.w, t1, c0
max_pp r0.y, r1.w, c5.x
mul_pp r2.xyz, r0.x, c2
mul_pp r1.xyz, r1, c3
mul_pp r2.xyz, r2, r1
mul_pp r3.xyz, r1, t3
mad_pp r0.xyz, r2, r0.y, r3
mad_pp r0.xyz, r1, c4.x, r0
mov_sat r0.w, t5.x
lrp_pp r1.xyz, r0.w, r0, c1
mov_pp r1.w, c5.y
mov_pp oC0, r1

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 160 [_Intensity]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityFog" 2
"ps_4_0
eefiecedffemdlplhgeknbaoalpgcpkmkfhiffdoabaaaaaaneadaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjmacaaaaeaaaaaaakhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaaibcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaaoaaaaahgcaabaaaaaaaaaaa
agbbbaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaa
agaabaaaabaaaaaaagijcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaahocaabaaa
aaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaabaaaaaaegbcbaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaa
aaaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
egacbaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaa
dgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadcaaaaakhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 15 [_ShadowMapTexture] 2D 15
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
Float 160 [_Intensity]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityShadows" 416
Vector 384 [_LightShadowData]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityShadows" 2
BindCB  "UnityFog" 3
"ps_4_0_level_9_1
eefiecedekdojekhinpikenpnoopmbegpjmppmmpabaaaaaaamagaaaaafaaaaaa
deaaaaaaamacaaaapiaeaaaaaiafaaaaniafaaaaebgpgodjnaabaaaanaabaaaa
aaacppppgiabaaaagiaaaaaaafaacmaaaaaagiaaaaaagiaaacaaceaaaaaagiaa
apapaaaaaaaaabaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaacaaabaaaaaaaaaa
abaaaaaaabaaadaaaaaaaaaaacaabiaaabaaaeaaaaaaaaaaadaaaaaaabaaafaa
aaaaaaaaaaacppppfbaaaaafagaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaia
adaachlabpaaaaacaaaaaaiaaeaacplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkaecaaaaadaaaacpiaaeaaoelaaaaioekaecaaaaadabaacpia
aaaaoelaabaioekaaiaaaaadabaaciiaabaaoelaadaaoekaalaaaaadaaaaccia
abaappiaagaaffkaabaaaaacabaaaiiaagaaaakabcaaaaaeacaaciiaaaaaaaia
abaappiaaeaaaakaafaaaaadacaachiaacaappiaaaaaoekaafaaaaadabaachia
abaaoeiaabaaoekaafaaaaadacaachiaacaaoeiaabaaoeiaafaaaaadadaachia
abaaoeiaadaaoelaaeaaaaaeaaaachiaacaaoeiaaaaaffiaadaaoeiaaeaaaaae
aaaachiaabaaoeiaacaaaakaaaaaoeiaabaaaaacaaaabiiaaaaakklabcaaaaae
abaachiaaaaappiaaaaaoeiaafaaoekaabaaaaacabaaciiaagaaaakaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefcoeacaaaaeaaaaaaaljaaaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaabjaaaaaafjaaaaaeegiocaaaadaaaaaaabaaaaaafkaaaaad
aagabaaaaaaaaaaafkaiaaadaagabaaaapaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaapaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaabaaaaaaibcaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ehaaaaalccaabaaaaaaaaaaaegbabaaaafaaaaaaaghabaaaapaaaaaaaagabaaa
apaaaaaackbabaaaafaaaaaaaaaaaaajecaabaaaaaaaaaaaakiacaiaebaaaaaa
acaaaaaabiaaaaaaabeaaaaaaaaaiadpdcaaaaakccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaaakiacaaaacaaaaaabiaaaaaadiaaaaaiocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagijcaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaa
jgahbaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaadaaaaaa
aaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadcaaaaakhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaadaaaaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabfdegejdaaiaaaaaa
iaaaaaaaaaaaaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaeaeaaaa
lmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalmaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Blend One One
  GpuProgramID 123790
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
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_3;
  tmpvar_3 = (_LightMatrix0 * tmpvar_2).xyz;
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (_LightColor0.xyz * texture2D (_LightTexture0, vec2(
    dot (tmpvar_3, tmpvar_3)
  )).w)) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_5.w = 0.0;
  c_4.w = c_5.w;
  c_4.xyz = c_5.xyz;
  c_1.xyz = c_4.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c10, c10.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedcclnehojdkibdcbfmlpdnknanopapjmiabaaaaaaeaafaaaaadaaaaaa
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
egiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaa
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
SubProgram "d3d11_9x " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedblpiibknlikpnajeagnpbhedmfnpomimabaaaaaagmahaaaaaeaaaaaa
daaaaaaafiacaaaaomafaaaaoeagaaaaebgpgodjcaacaaaacaacaaaaaaacpopp
neabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaapaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaooka
afaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeacaaahoa
ajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajaakaaaakaafaaaaad
aaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeiaacaaaajaamaaaakaafaaaaad
abaaabiaacaaffjaakaaffkaafaaaaadabaaaciaacaaffjaalaaffkaafaaaaad
abaaaeiaacaaffjaamaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaad
abaaabiaacaakkjaakaakkkaafaaaaadabaaaciaacaakkjaalaakkkaafaaaaad
abaaaeiaacaakkjaamaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoa
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcimadaaaa
eaaaabaaodaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaa
ogikcaaaaaaaaaaaapaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
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
egacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
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
feeffiedepepfceeaaklklkl"
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
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec4 c_1;
  vec4 c_2;
  vec4 c_3;
  c_3.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_3.w = 0.0;
  c_2.w = c_3.w;
  c_2.xyz = c_3.xyz;
  c_1.xyz = c_2.xyz;
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
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c10, c10.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmjknhbnjnicgnicnimimedndifdeoepaabaaaaaaeaafaaaaadaaaaaa
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
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
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
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedhdiflfjodnildjalloefgmfginbaennaabaaaaaagmahaaaaaeaaaaaa
daaaaaaafiacaaaaomafaaaaoeagaaaaebgpgodjcaacaaaacaacaaaaaaacpopp
neabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaalaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaooka
afaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeacaaahoa
ajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajaakaaaakaafaaaaad
aaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeiaacaaaajaamaaaakaafaaaaad
abaaabiaacaaffjaakaaffkaafaaaaadabaaaciaacaaffjaalaaffkaafaaaaad
abaaaeiaacaaffjaamaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaad
abaaabiaacaakkjaakaakkkaafaaaaadabaaaciaacaakkjaalaakkkaafaaaaad
abaaaeiaacaakkjaamaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoa
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcimadaaaa
eaaaabaaodaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
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
egacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
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
feeffiedepepfceeaaklklkl"
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
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = xlv_TEXCOORD2;
  vec4 tmpvar_3;
  tmpvar_3 = (_LightMatrix0 * tmpvar_2);
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (_LightColor0.xyz * 
    ((float((tmpvar_3.z > 0.0)) * texture2D (_LightTexture0, ((tmpvar_3.xy / tmpvar_3.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (tmpvar_3.xyz, tmpvar_3.xyz))).w)
  )) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_5.w = 0.0;
  c_4.w = c_5.w;
  c_4.xyz = c_5.xyz;
  c_1.xyz = c_4.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c10, c10.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedcclnehojdkibdcbfmlpdnknanopapjmiabaaaaaaeaafaaaaadaaaaaa
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
egiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaa
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
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedblpiibknlikpnajeagnpbhedmfnpomimabaaaaaagmahaaaaaeaaaaaa
daaaaaaafiacaaaaomafaaaaoeagaaaaebgpgodjcaacaaaacaacaaaaaaacpopp
neabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaapaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaooka
afaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeacaaahoa
ajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajaakaaaakaafaaaaad
aaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeiaacaaaajaamaaaakaafaaaaad
abaaabiaacaaffjaakaaffkaafaaaaadabaaaciaacaaffjaalaaffkaafaaaaad
abaaaeiaacaaffjaamaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaad
abaaabiaacaakkjaakaakkkaafaaaaadabaaaciaacaakkjaalaakkkaafaaaaad
abaaaeiaacaakkjaamaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoa
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcimadaaaa
eaaaabaaodaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaa
ogikcaaaaaaaaaaaapaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
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
egacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
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
feeffiedepepfceeaaklklkl"
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
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform samplerCube _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_3;
  tmpvar_3 = (_LightMatrix0 * tmpvar_2).xyz;
  vec4 c_4;
  vec4 c_5;
  c_5.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (_LightColor0.xyz * 
    (texture2D (_LightTextureB0, vec2(dot (tmpvar_3, tmpvar_3))).w * textureCube (_LightTexture0, tmpvar_3).w)
  )) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_5.w = 0.0;
  c_4.w = c_5.w;
  c_4.xyz = c_5.xyz;
  c_1.xyz = c_4.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c10, c10.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedcclnehojdkibdcbfmlpdnknanopapjmiabaaaaaaeaafaaaaadaaaaaa
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
egiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaa
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
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedblpiibknlikpnajeagnpbhedmfnpomimabaaaaaagmahaaaaaeaaaaaa
daaaaaaafiacaaaaomafaaaaoeagaaaaebgpgodjcaacaaaacaacaaaaaaacpopp
neabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaapaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaooka
afaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeacaaahoa
ajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajaakaaaakaafaaaaad
aaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeiaacaaaajaamaaaakaafaaaaad
abaaabiaacaaffjaakaaffkaafaaaaadabaaaciaacaaffjaalaaffkaafaaaaad
abaaaeiaacaaffjaamaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaad
abaaabiaacaakkjaakaakkkaafaaaaadabaaaciaacaakkjaalaakkkaafaaaaad
abaaaeiaacaakkjaamaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoa
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcimadaaaa
eaaaabaaodaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaa
ogikcaaaaaaaaaaaapaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
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
egacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
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
feeffiedepepfceeaaklklkl"
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
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = xlv_TEXCOORD2;
  vec4 c_3;
  vec4 c_4;
  c_4.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (_LightColor0.xyz * texture2D (_LightTexture0, 
    (_LightMatrix0 * tmpvar_2)
  .xy).w)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_4.w = 0.0;
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
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_MainTex_ST]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c10, c10.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedcclnehojdkibdcbfmlpdnknanopapjmiabaaaaaaeaafaaaaadaaaaaa
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
egiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaa
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
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedblpiibknlikpnajeagnpbhedmfnpomimabaaaaaagmahaaaaaeaaaaaa
daaaaaaafiacaaaaomafaaaaoeagaaaaebgpgodjcaacaaaacaacaaaaaaacpopp
neabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaapaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaooka
afaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaaeaaaaahiaagaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeacaaahoa
ajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajaakaaaakaafaaaaad
aaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeiaacaaaajaamaaaakaafaaaaad
abaaabiaacaaffjaakaaffkaafaaaaadabaaaciaacaaffjaalaaffkaafaaaaad
abaaaeiaacaaffjaamaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaad
abaaabiaacaakkjaakaakkkaafaaaaadabaaaciaacaakkjaalaakkkaafaaaaad
abaaaeiaacaakkjaamaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeiaaiaaaaad
aaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiiaaaaappiaafaaaaadabaaahoa
aaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcimadaaaa
eaaaabaaodaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaa
ogikcaaaaaaaaaaaapaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
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
egacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
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
feeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "POINT" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
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
  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_3;
  tmpvar_3 = (_LightMatrix0 * tmpvar_2).xyz;
  vec4 c_4;
  c_4.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (_LightColor0.xyz * texture2D (_LightTexture0, vec2(
    dot (tmpvar_3, tmpvar_3)
  )).w)) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_4.w = 0.0;
  c_1.xyz = mix (vec3(0.0, 0.0, 0.0), c_4.xyz, vec3(clamp (xlv_TEXCOORD4, 0.0, 1.0)));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c11, c11.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0
dp4 r0.x, c2, v0
mul r0.y, r0.x, c10.y
mov oPos.z, r0.x
exp oT4.x, -r0.y

"
}
SubProgram "d3d11 " {
Keywords { "POINT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedpiljmnnpmblldcfkjjdfficlhifchpejabaaaaaamaafaaaaadaaaaaa
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
aaklklklfdeieefcpeadaaaaeaaaabaapnaaaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaag
eccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaa
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
SubProgram "d3d11_9x " {
Keywords { "POINT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedoilnkjhnhikmpjhlekjdkidembnjgnodabaaaaaabeaiaaaaaeaaaaaa
daaaaaaaiaacaaaahmagaaaaheahaaaaebgpgodjeiacaaaaeiacaaaaaaacpopp
paabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaapaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeacaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabia
acaaaajaakaaaakaafaaaaadaaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeia
acaaaajaamaaaakaafaaaaadabaaabiaacaaffjaakaaffkaafaaaaadabaaacia
acaaffjaalaaffkaafaaaaadabaaaeiaacaaffjaamaaffkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjaakaakkkaafaaaaadabaaacia
acaakkjaalaakkkaafaaaaadabaaaeiaacaakkjaamaakkkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiia
aaaappiaafaaaaadabaaahoaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
afaaaaadabaaabiaaaaakkiaanaaffkaaoaaaaacaaaaaeoaabaaaaibaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefcpeadaaaaeaaaabaapnaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaackaabaaaaaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheo
paaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaa
adaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaealaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
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
  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 c_2;
  c_2.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * _LightColor0.xyz) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_2.w = 0.0;
  c_1.xyz = mix (vec3(0.0, 0.0, 0.0), c_2.xyz, vec3(clamp (xlv_TEXCOORD4, 0.0, 1.0)));
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
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c11, c11.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0
dp4 r0.x, c2, v0
mul r0.y, r0.x, c10.y
mov oPos.z, r0.x
exp oT4.x, -r0.y

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefieceddndieekidfgnoaenanbdakdbicopfolcabaaaaaamaafaaaaadaaaaaa
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
aaklklklfdeieefcpeadaaaaeaaaabaapnaaaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaag
eccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
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
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedgbmilpnpmpgkihceidplkdhdlfjiojmaabaaaaaabeaiaaaaaeaaaaaa
daaaaaaaiaacaaaahmagaaaaheahaaaaebgpgodjeiacaaaaeiacaaaaaaacpopp
paabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaalaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeacaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabia
acaaaajaakaaaakaafaaaaadaaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeia
acaaaajaamaaaakaafaaaaadabaaabiaacaaffjaakaaffkaafaaaaadabaaacia
acaaffjaalaaffkaafaaaaadabaaaeiaacaaffjaamaaffkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjaakaakkkaafaaaaadabaaacia
acaakkjaalaakkkaafaaaaadabaaaeiaacaakkjaamaakkkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiia
aaaappiaafaaaaadabaaahoaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
afaaaaadabaaabiaaaaakkiaanaaffkaaoaaaaacaaaaaeoaabaaaaibaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefcpeadaaaaeaaaabaapnaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaackaabaaaaaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheo
paaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaa
adaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaealaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
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
  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = xlv_TEXCOORD2;
  vec4 tmpvar_3;
  tmpvar_3 = (_LightMatrix0 * tmpvar_2);
  vec4 c_4;
  c_4.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (_LightColor0.xyz * 
    ((float((tmpvar_3.z > 0.0)) * texture2D (_LightTexture0, ((tmpvar_3.xy / tmpvar_3.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (tmpvar_3.xyz, tmpvar_3.xyz))).w)
  )) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_4.w = 0.0;
  c_1.xyz = mix (vec3(0.0, 0.0, 0.0), c_4.xyz, vec3(clamp (xlv_TEXCOORD4, 0.0, 1.0)));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c11, c11.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0
dp4 r0.x, c2, v0
mul r0.y, r0.x, c10.y
mov oPos.z, r0.x
exp oT4.x, -r0.y

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedpiljmnnpmblldcfkjjdfficlhifchpejabaaaaaamaafaaaaadaaaaaa
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
aaklklklfdeieefcpeadaaaaeaaaabaapnaaaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaag
eccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaa
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
SubProgram "d3d11_9x " {
Keywords { "SPOT" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedoilnkjhnhikmpjhlekjdkidembnjgnodabaaaaaabeaiaaaaaeaaaaaa
daaaaaaaiaacaaaahmagaaaaheahaaaaebgpgodjeiacaaaaeiacaaaaaaacpopp
paabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaapaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeacaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabia
acaaaajaakaaaakaafaaaaadaaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeia
acaaaajaamaaaakaafaaaaadabaaabiaacaaffjaakaaffkaafaaaaadabaaacia
acaaffjaalaaffkaafaaaaadabaaaeiaacaaffjaamaaffkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjaakaakkkaafaaaaadabaaacia
acaakkjaalaakkkaafaaaaadabaaaeiaacaakkjaamaakkkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiia
aaaappiaafaaaaadabaaahoaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
afaaaaadabaaabiaaaaakkiaanaaffkaaoaaaaacaaaaaeoaabaaaaibaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefcpeadaaaaeaaaabaapnaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaackaabaaaaaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheo
paaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaa
adaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaealaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
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
  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform samplerCube _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = xlv_TEXCOORD2;
  vec3 tmpvar_3;
  tmpvar_3 = (_LightMatrix0 * tmpvar_2).xyz;
  vec4 c_4;
  c_4.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (_LightColor0.xyz * 
    (texture2D (_LightTextureB0, vec2(dot (tmpvar_3, tmpvar_3))).w * textureCube (_LightTexture0, tmpvar_3).w)
  )) * max (0.0, dot (xlv_TEXCOORD1, 
    normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2))
  )));
  c_4.w = 0.0;
  c_1.xyz = mix (vec3(0.0, 0.0, 0.0), c_4.xyz, vec3(clamp (xlv_TEXCOORD4, 0.0, 1.0)));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c11, c11.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0
dp4 r0.x, c2, v0
mul r0.y, r0.x, c10.y
mov oPos.z, r0.x
exp oT4.x, -r0.y

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedpiljmnnpmblldcfkjjdfficlhifchpejabaaaaaamaafaaaaadaaaaaa
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
aaklklklfdeieefcpeadaaaaeaaaabaapnaaaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaag
eccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaa
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
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedoilnkjhnhikmpjhlekjdkidembnjgnodabaaaaaabeaiaaaaaeaaaaaa
daaaaaaaiaacaaaahmagaaaaheahaaaaebgpgodjeiacaaaaeiacaaaaaaacpopp
paabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaapaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeacaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabia
acaaaajaakaaaakaafaaaaadaaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeia
acaaaajaamaaaakaafaaaaadabaaabiaacaaffjaakaaffkaafaaaaadabaaacia
acaaffjaalaaffkaafaaaaadabaaaeiaacaaffjaamaaffkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjaakaakkkaafaaaaadabaaacia
acaakkjaalaakkkaafaaaaadabaaaeiaacaakkjaamaakkkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiia
aaaappiaafaaaaadabaaahoaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
afaaaaadabaaabiaaaaakkiaanaaffkaaoaaaaacaaaaaeoaabaaaaibaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefcpeadaaaaeaaaabaapnaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaackaabaaaaaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheo
paaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaa
adaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaealaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_FogParams;
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
  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_1.z)));
}


#endif
#ifdef FRAGMENT
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mat4 _LightMatrix0;
uniform sampler2D _MainTex;
uniform vec4 _Color;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = xlv_TEXCOORD2;
  vec4 c_3;
  c_3.xyz = (((texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz * (_LightColor0.xyz * texture2D (_LightTexture0, 
    (_LightMatrix0 * tmpvar_2)
  .xy).w)) * max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)));
  c_3.w = 0.0;
  c_1.xyz = mix (vec3(0.0, 0.0, 0.0), c_3.xyz, vec3(clamp (xlv_TEXCOORD4, 0.0, 1.0)));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
Vector 11 [_MainTex_ST]
Vector 10 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c11, c11.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT1.xyz, r0.w, r0
dp4 r0.x, c2, v0
mul r0.y, r0.x, c10.y
mov oPos.z, r0.x
exp oT4.x, -r0.y

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedpiljmnnpmblldcfkjjdfficlhifchpejabaaaaaamaafaaaaadaaaaaa
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
aaklklklfdeieefcpeadaaaaeaaaabaapnaaaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaag
eccabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaa
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
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 240 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedoilnkjhnhikmpjhlekjdkidembnjgnodabaaaaaabeaiaaaaaeaaaaaa
daaaaaaaiaacaaaahmagaaaaheahaaaaebgpgodjeiacaaaaeiacaaaaaaacpopp
paabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaapaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaahaaagaaaaaaaaaa
acaaabaaabaaanaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoa
adaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaahaaoekaaeaaaaae
aaaaahiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkja
aaaaoeiaaeaaaaaeacaaahoaajaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabia
acaaaajaakaaaakaafaaaaadaaaaaciaacaaaajaalaaaakaafaaaaadaaaaaeia
acaaaajaamaaaakaafaaaaadabaaabiaacaaffjaakaaffkaafaaaaadabaaacia
acaaffjaalaaffkaafaaaaadabaaaeiaacaaffjaamaaffkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjaakaakkkaafaaaaadabaaacia
acaakkjaalaakkkaafaaaaadabaaaeiaacaakkjaamaakkkaacaaaaadaaaaahia
aaaaoeiaabaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeiaahaaaaacaaaaaiia
aaaappiaafaaaaadabaaahoaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
afaaaaadabaaabiaaaaakkiaanaaffkaaoaaaaacaaaaaeoaabaaaaibaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefcpeadaaaaeaaaabaapnaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaabdaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaackaabaaaaaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaa
abaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheo
paaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaa
adaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaealaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
Vector 5 [_Color]
Vector 4 [_LightColor0]
Vector 3 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
def c6, 1, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl_2d s0
dcl_2d s1
mov r0.xyz, t2
mov_pp r0.w, c6.x
dp4_pp r1.x, c0, r0
dp4_pp r1.y, c1, r0
dp4_pp r1.z, c2, r0
dp3_pp r0.xy, r1, r1
texld_pp r0, r0, s0
texld_pp r1, t0, s1
mul_pp r0.xyz, r0.x, c4
mul_pp r1.xyz, r1, c5
mul_pp r0.xyz, r0, r1
add r1.xyz, -t2, c3
nrm_pp r2.xyz, r1
dp3_pp r0.w, t1, r2
max_pp r1.x, r0.w, c6.y
mul_pp r0.xyz, r0, r1.x
mov_pp r0.w, c6.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefieceddjmgbhefongecikidfolkbmjjllabaagabaaaaaaleadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmeacaaaaeaaaaaaalbaaaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaadaaaaaaegiccaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaa
agbabaaaadaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaalaaaaaakgbkbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
abaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedmjbenilmblhmbaghflbneehejlhbndhjabaaaaaahiafaaaaaeaaaaaa
daaaaaaapaabaaaalmaeaaaaeeafaaaaebgpgodjliabaaaaliabaaaaaaacpppp
giabaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaabaaaaaa
aaababaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaaabaaaaaa
abaaagaaaaaaaaaaaaacppppfbaaaaafahaaapkaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaachlabpaaaaac
aaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
afaaaaadaaaachiaacaafflaacaaoekaaeaaaaaeaaaachiaabaaoekaacaaaala
aaaaoeiaaeaaaaaeaaaachiaadaaoekaacaakklaaaaaoeiaacaaaaadaaaachia
aaaaoeiaaeaaoekaaiaaaaadaaaacdiaaaaaoeiaaaaaoeiaecaaaaadaaaacpia
aaaaoeiaaaaioekaecaaaaadabaacpiaaaaaoelaabaioekaafaaaaadaaaachia
aaaaaaiaaaaaoekaafaaaaadabaachiaabaaoeiaafaaoekaafaaaaadaaaachia
aaaaoeiaabaaoeiaacaaaaadabaaahiaacaaoelbagaaoekaceaaaaacacaachia
abaaoeiaaiaaaaadaaaaciiaabaaoelaacaaoeiaalaaaaadabaacbiaaaaappia
ahaaaakaafaaaaadaaaachiaaaaaoeiaabaaaaiaabaaaaacaaaaciiaahaaffka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcmeacaaaaeaaaaaaalbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
adaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaajaaaaaaagbabaaaadaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaagaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
anaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 2 [_Color]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c3, 0, 1, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_2d s0
texld_pp r0, t0, s0
mul_pp r0.xyz, r0, c2
mul_pp r0.xyz, r0, c1
dp3_pp r0.w, t1, c0
max_pp r1.w, r0.w, c3.x
mul_pp r0.xyz, r0, r1.w
mov_pp r0.w, c3.y
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedfcoflngecmmhckhopeljeciifnhnnjieabaaaaaadeacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefceeabaaaaeaaaaaaafbaaaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
ajaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
agaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaa
aaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedmofpihnfbgdkjjgllifecalaoenminanabaaaaaaeiadaaaaaeaaaaaa
daaaaaaaeaabaaaaimacaaaabeadaaaaebgpgodjaiabaaaaaiabaaaaaaacpppp
lmaaaaaaemaaaaaaadaaciaaaaaaemaaaaaaemaaabaaceaaaaaaemaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaaaaaajaaabaaabaaaaaaaaaaabaaaaaaabaaacaa
aaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaja
aaaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaafaaaaadaaaachiaaaaaoeia
abaaoekaafaaaaadaaaachiaaaaaoeiaaaaaoekaaiaaaaadaaaaciiaabaaoela
acaaoekaalaaaaadabaaciiaaaaappiaadaaaakaafaaaaadaaaachiaaaaaoeia
abaappiaabaaaaacaaaaciiaadaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefceeabaaaaeaaaaaaafbaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaai
icaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Matrix 0 [_LightMatrix0]
Vector 6 [_Color]
Vector 5 [_LightColor0]
Vector 4 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
def c7, 1, 0.5, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
mov r0.xyz, t2
mov_pp r0.w, c7.x
dp4_pp r1.x, c0, r0
dp4_pp r1.y, c1, r0
dp4_pp r1.z, c2, r0
dp4_pp r1.w, c3, r0
rcp r1.w, r1.w
mad_pp r0.xy, r1, r1.w, c7.y
dp3_pp r1.xy, r1, r1
texld_pp r0, r0, s0
texld_pp r2, r1, s1
texld_pp r3, t0, s2
mul r3.w, r0.w, r2.x
mul_pp r0.xyz, r3.w, c5
cmp_pp r0.xyz, -r1.z, c7.z, r0
mul_pp r1.xyz, r3, c6
mul_pp r0.xyz, r0, r1
add r1.xyz, -t2, c4
nrm_pp r2.xyz, r1
dp3_pp r0.w, t1, r2
max_pp r1.x, r0.w, c7.z
mul_pp r0.xyz, r0, r1.x
mov_pp r0.w, c7.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedigljcjaoneinopkaejcmbjiamhhmddcdabaaaaaakiaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcliadaaaaeaaaaaaaooaaaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaadaaaaaaegiocaaaaaaaaaaa
akaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaajaaaaaaagbabaaa
adaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
alaaaaaakgbkbaaaadaaaaaaegaobaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaamaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaa
abaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
agaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaabaaaaahbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaa
dkaabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
acaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaanaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaa
adaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedkfdkdleladchpmibkfjdihojjcjbkippabaaaaaanaagaaaaaeaaaaaa
daaaaaaafeacaaaabeagaaaajmagaaaaebgpgodjbmacaaaabmacaaaaaaacpppp
miabaaaafeaaaaaaadaadaaaaaaafeaaaaaafeaaadaaceaaaaaafeaaabaaaaaa
acababaaaaacacaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaa
abaaaaaaabaaagaaaaaaaaaaaaacppppfbaaaaafahaaapkaaaaaaadpaaaaaaaa
aaaaiadpaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaachla
bpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkaafaaaaadaaaacpiaacaafflaacaaoeka
aeaaaaaeaaaacpiaabaaoekaacaaaalaaaaaoeiaaeaaaaaeaaaacpiaadaaoeka
acaakklaaaaaoeiaacaaaaadaaaacpiaaaaaoeiaaeaaoekaagaaaaacaaaaaiia
aaaappiaaeaaaaaeabaacdiaaaaaoeiaaaaappiaahaaaakaaiaaaaadaaaacdia
aaaaoeiaaaaaoeiaecaaaaadabaacpiaabaaoeiaaaaioekaecaaaaadacaacpia
aaaaoeiaabaioekaecaaaaadadaacpiaaaaaoelaacaioekaafaaaaadadaaaiia
abaappiaacaaaaiaafaaaaadabaachiaadaappiaaaaaoekafiaaaaaeaaaachia
aaaakkibahaaffkaabaaoeiaafaaaaadabaachiaadaaoeiaafaaoekaafaaaaad
aaaachiaaaaaoeiaabaaoeiaacaaaaadabaaahiaacaaoelbagaaoekaceaaaaac
acaachiaabaaoeiaaiaaaaadaaaaciiaabaaoelaacaaoeiaalaaaaadabaacbia
aaaappiaahaaffkaafaaaaadaaaachiaaaaaoeiaabaaaaiaabaaaaacaaaaciia
ahaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcliadaaaaeaaaaaaa
ooaaaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
adaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaajaaaaaaagbabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegaobaaaaaaaaaaa
aaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaamaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaaaaaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaagaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaa
abaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
abaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Matrix 0 [_LightMatrix0] 3
Vector 5 [_Color]
Vector 4 [_LightColor0]
Vector 3 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
def c6, 1, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl_cube s0
dcl_2d s1
dcl_2d s2
mov r0.xyz, t2
mov_pp r0.w, c6.x
dp4_pp r1.x, c0, r0
dp4_pp r1.y, c1, r0
dp4_pp r1.z, c2, r0
dp3_pp r0.xy, r1, r1
texld r1, r1, s0
texld r0, r0, s1
texld_pp r2, t0, s2
mul_pp r2.w, r1.w, r0.x
mul_pp r0.xyz, r2.w, c4
mul_pp r1.xyz, r2, c5
mul_pp r0.xyz, r0, r1
add r1.xyz, -t2, c3
nrm_pp r2.xyz, r1
dp3_pp r0.w, t1, r2
max_pp r1.x, r0.w, c6.y
mul_pp r0.xyz, r0, r1.x
mov_pp r0.w, c6.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedankidodhcphkpkkhfmalipljneadkgfpabaaaaaabaaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefccaadaaaaeaaaaaaamiaaaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaadaaaaaaegiccaaaaaaaaaaa
akaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaa
adaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
alaaaaaakgbkbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegacbaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaa
aaaaaaaadkaabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaa
egbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
hccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedjjhglnfildfoahjodkgbnpmgfcofbpcoabaaaaaabaagaaaaaeaaaaaa
daaaaaaacmacaaaafeafaaaanmafaaaaebgpgodjpeabaaaapeabaaaaaaacpppp
kaabaaaafeaaaaaaadaadaaaaaaafeaaaaaafeaaadaaceaaaaaafeaaacaaaaaa
abababaaaaacacaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaa
abaaaaaaabaaagaaaaaaaaaaaaacppppfbaaaaafahaaapkaaaaaaaaaaaaaiadp
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaachla
bpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaajiaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkaafaaaaadaaaachiaacaafflaacaaoeka
aeaaaaaeaaaachiaabaaoekaacaaaalaaaaaoeiaaeaaaaaeaaaachiaadaaoeka
acaakklaaaaaoeiaacaaaaadaaaachiaaaaaoeiaaeaaoekaaiaaaaadaaaaciia
aaaaoeiaaaaaoeiaabaaaaacabaacdiaaaaappiaecaaaaadaaaaapiaaaaaoeia
aaaioekaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadacaacpiaaaaaoela
acaioekaafaaaaadacaaciiaaaaappiaabaaaaiaafaaaaadaaaachiaacaappia
aaaaoekaafaaaaadabaachiaacaaoeiaafaaoekaafaaaaadaaaachiaaaaaoeia
abaaoeiaacaaaaadabaaahiaacaaoelbagaaoekaceaaaaacacaachiaabaaoeia
aiaaaaadaaaaciiaabaaoelaacaaoeiaalaaaaadabaacbiaaaaappiaahaaaaka
afaaaaadaaaachiaaaaaoeiaabaaaaiaabaaaaacaaaaciiaahaaffkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefccaadaaaaeaaaaaaamiaaaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaadaaaaaaegiccaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaa
agbabaaaadaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaalaaaaaakgbkbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egacbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaapgapbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaah
bcaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
abaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Matrix 0 [_LightMatrix0] 2
Vector 4 [_Color]
Vector 3 [_LightColor0]
Vector 2 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
def c5, 1, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl_2d s0
dcl_2d s1
mov r0.xyz, t2
mov_pp r0.w, c5.x
dp4_pp r1.x, c0, r0
dp4_pp r1.y, c1, r0
texld_pp r0, r1, s0
texld_pp r1, t0, s1
mul_pp r0.xyz, r0.w, c3
mul_pp r1.xyz, r1, c4
mul_pp r0.xyz, r0, r1
dp3_pp r0.w, t1, c2
max_pp r1.x, r0.w, c5.y
mul_pp r0.xyz, r0, r1.x
mov_pp r0.w, c5.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedppakfflheanfkcjoniddfjogoajclhncabaaaaaacmadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdmacaaaaeaaaaaaaipaaaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaadiaaaaaidcaabaaaaaaaaaaafgbfbaaaadaaaaaaegiacaaa
aaaaaaaaakaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaajaaaaaa
agbabaaaadaaaaaaegaabaaaaaaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
aaaaaaaaalaaaaaakgbkbaaaadaaaaaaegaabaaaaaaaaaaaaaaaaaaidcaabaaa
aaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaai
icaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecednnjmbhmaaekilgimadkdfbflclicfjalabaaaaaameaeaaaaaeaaaaaa
daaaaaaameabaaaaaiaeaaaajaaeaaaaebgpgodjimabaaaaimabaaaaaaacpppp
dmabaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaabaaaaaa
aaababaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaaabaaaaaa
abaaagaaaaaaaaaaaaacppppfbaaaaafahaaapkaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaachlabpaaaaac
aaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
afaaaaadaaaacdiaacaafflaacaaoekaaeaaaaaeaaaacdiaabaaoekaacaaaala
aaaaoeiaaeaaaaaeaaaacdiaadaaoekaacaakklaaaaaoeiaacaaaaadaaaacdia
aaaaoeiaaeaaoekaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadabaacpia
aaaaoelaabaioekaafaaaaadaaaachiaaaaappiaaaaaoekaafaaaaadabaachia
abaaoeiaafaaoekaafaaaaadaaaachiaaaaaoeiaabaaoeiaaiaaaaadaaaaciia
abaaoelaagaaoekaalaaaaadabaacbiaaaaappiaahaaaakaafaaaaadaaaachia
aaaaoeiaabaaaaiaabaaaaacaaaaciiaahaaffkaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcdmacaaaaeaaaaaaaipaaaaaafjaaaaaeegiocaaaaaaaaaaa
aoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaadiaaaaaidcaabaaaaaaaaaaafgbfbaaaadaaaaaaegiacaaaaaaaaaaa
akaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaajaaaaaaagbabaaa
adaaaaaaegaabaaaaaaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaa
alaaaaaakgbkbaaaadaaaaaaegaabaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaamaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaaiicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT" "FOG_EXP" }
Matrix 0 [_LightMatrix0] 3
Vector 5 [_Color]
Vector 4 [_LightColor0]
Vector 3 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
def c6, 1, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl t4.x
dcl_2d s0
dcl_2d s1
mov r0.xyz, t2
mov_pp r0.w, c6.x
dp4_pp r1.x, c0, r0
dp4_pp r1.y, c1, r0
dp4_pp r1.z, c2, r0
dp3_pp r0.xy, r1, r1
texld_pp r0, r0, s0
texld_pp r1, t0, s1
mul_pp r0.xyz, r0.x, c4
mul_pp r1.xyz, r1, c5
mul_pp r0.xyz, r0, r1
add r1.xyz, -t2, c3
nrm_pp r2.xyz, r1
dp3_pp r0.w, t1, r2
max_pp r1.x, r0.w, c6.y
mul_pp r0.xyz, r0, r1.x
mov_sat r0.w, t4.x
mul_pp r0.xyz, r0, r0.w
mov_pp r0.w, c6.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "POINT" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedefpcllclbjdfhbnocaadkfikgefiobeiabaaaaaaaiaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcaaadaaaaeaaaaaaamaaaaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaadaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
ajaaaaaaagbabaaaadaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaagaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedalnpglenhjdpjjgkoabbfocbhnfeihjbabaaaaaaoiafaaaaaeaaaaaa
daaaaaaaamacaaaabeafaaaaleafaaaaebgpgodjneabaaaaneabaaaaaaacpppp
ieabaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaabaaaaaa
aaababaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaaabaaaaaa
abaaagaaaaaaaaaaaaacppppfbaaaaafahaaapkaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaachlabpaaaaac
aaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
afaaaaadaaaachiaacaafflaacaaoekaaeaaaaaeaaaachiaabaaoekaacaaaala
aaaaoeiaaeaaaaaeaaaachiaadaaoekaacaakklaaaaaoeiaacaaaaadaaaachia
aaaaoeiaaeaaoekaaiaaaaadaaaacdiaaaaaoeiaaaaaoeiaecaaaaadaaaacpia
aaaaoeiaaaaioekaecaaaaadabaacpiaaaaaoelaabaioekaafaaaaadaaaachia
aaaaaaiaaaaaoekaafaaaaadabaachiaabaaoeiaafaaoekaafaaaaadaaaachia
aaaaoeiaabaaoeiaacaaaaadabaaahiaacaaoelbagaaoekaceaaaaacacaachia
abaaoeiaaiaaaaadaaaaciiaabaaoelaacaaoeiaalaaaaadabaacbiaaaaappia
ahaaaakaafaaaaadaaaachiaaaaaoeiaabaaaaiaabaaaaacaaaabiiaaaaakkla
afaaaaadaaaachiaaaaaoeiaaaaappiaabaaaaacaaaaciiaahaaffkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcaaadaaaaeaaaaaaamaaaaaaafjaaaaae
egiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaadaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaaadaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaamaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaanaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaa
egiccaaaabaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
Vector 2 [_Color]
Vector 1 [_LightColor0]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c3, 0, 1, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t4.x
dcl_2d s0
texld_pp r0, t0, s0
mul_pp r0.xyz, r0, c2
mul_pp r0.xyz, r0, c1
dp3_pp r0.w, t1, c0
max_pp r1.w, r0.w, c3.x
mul_pp r0.xyz, r0, r1.w
mov_sat r0.w, t4.x
mul_pp r0.xyz, r0, r0.w
mov_pp r0.w, c3.y
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedoeogibmgdgaaogpamljdkkbdfkgeocldabaaaaaaiiacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefciaabaaaaeaaaaaaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaajaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaagaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaa
abaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 192
Vector 96 [_LightColor0]
Vector 144 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefieceddanikaglpaompaggggpjiiommdhoombjabaaaaaaliadaaaaaeaaaaaa
daaaaaaafmabaaaaoeacaaaaieadaaaaebgpgodjceabaaaaceabaaaaaaacpppp
niaaaaaaemaaaaaaadaaciaaaaaaemaaaaaaemaaabaaceaaaaaaemaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaaaaaajaaabaaabaaaaaaaaaaabaaaaaaabaaacaa
aaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaja
aaaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaafaaaaadaaaachiaaaaaoeia
abaaoekaafaaaaadaaaachiaaaaaoeiaaaaaoekaaiaaaaadaaaaciiaabaaoela
acaaoekaalaaaaadabaaciiaaaaappiaadaaaakaafaaaaadaaaachiaaaaaoeia
abaappiaabaaaaacaaaabiiaaaaakklaafaaaaadaaaachiaaaaaoeiaaaaappia
abaaaaacaaaaciiaadaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
iaabaaaaeaaaaaaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
ajaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
agaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaa
aaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgcaaaaf
icaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaeaeaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "FOG_EXP" }
Matrix 0 [_LightMatrix0]
Vector 6 [_Color]
Vector 5 [_LightColor0]
Vector 4 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
def c7, 1, 0.5, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl t4.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
mov r0.xyz, t2
mov_pp r0.w, c7.x
dp4_pp r1.x, c0, r0
dp4_pp r1.y, c1, r0
dp4_pp r1.z, c2, r0
dp4_pp r1.w, c3, r0
rcp r1.w, r1.w
mad_pp r0.xy, r1, r1.w, c7.y
dp3_pp r1.xy, r1, r1
texld_pp r0, r0, s0
texld_pp r2, r1, s1
texld_pp r3, t0, s2
mul r3.w, r0.w, r2.x
mul_pp r0.xyz, r3.w, c5
cmp_pp r0.xyz, -r1.z, c7.z, r0
mul_pp r1.xyz, r3, c6
mul_pp r0.xyz, r0, r1
add r1.xyz, -t2, c4
nrm_pp r2.xyz, r1
dp3_pp r0.w, t1, r2
max_pp r1.x, r0.w, c7.z
mul_pp r0.xyz, r0, r1.x
mov_sat r0.w, t4.x
mul_pp r0.xyz, r0, r0.w
mov_pp r0.w, c7.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedfegmagejjeimikegofkmkgpajdgkflgaabaaaaaapmaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpeadaaaaeaaaaaaapnaaaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaadaaaaaaegiocaaa
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
aaaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaia
ebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaa
ckbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTexture0] 2D 0
SetTexture 2 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedchafegbbeejdldegnlphmjagckdjpainabaaaaaaeaahaaaaaeaaaaaa
daaaaaaahaacaaaagmagaaaaamahaaaaebgpgodjdiacaaaadiacaaaaaaacpppp
oeabaaaafeaaaaaaadaadaaaaaaafeaaaaaafeaaadaaceaaaaaafeaaabaaaaaa
acababaaaaacacaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaa
abaaaaaaabaaagaaaaaaaaaaaaacppppfbaaaaafahaaapkaaaaaaadpaaaaaaaa
aaaaiadpaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaachla
bpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkaafaaaaadaaaacpiaacaafflaacaaoeka
aeaaaaaeaaaacpiaabaaoekaacaaaalaaaaaoeiaaeaaaaaeaaaacpiaadaaoeka
acaakklaaaaaoeiaacaaaaadaaaacpiaaaaaoeiaaeaaoekaagaaaaacaaaaaiia
aaaappiaaeaaaaaeabaacdiaaaaaoeiaaaaappiaahaaaakaaiaaaaadaaaacdia
aaaaoeiaaaaaoeiaecaaaaadabaacpiaabaaoeiaaaaioekaecaaaaadacaacpia
aaaaoeiaabaioekaecaaaaadadaacpiaaaaaoelaacaioekaafaaaaadadaaaiia
abaappiaacaaaaiaafaaaaadabaachiaadaappiaaaaaoekafiaaaaaeaaaachia
aaaakkibahaaffkaabaaoeiaafaaaaadabaachiaadaaoeiaafaaoekaafaaaaad
aaaachiaaaaaoeiaabaaoeiaacaaaaadabaaahiaacaaoelbagaaoekaceaaaaac
acaachiaabaaoeiaaiaaaaadaaaaciiaabaaoelaacaaoeiaalaaaaadabaacbia
aaaappiaahaaffkaafaaaaadaaaachiaaaaaoeiaabaaaaiaabaaaaacaaaabiia
aaaakklaafaaaaadaaaachiaaaaaoeiaaaaappiaabaaaaacaaaaaiiaahaakkka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcpeadaaaaeaaaaaaapnaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadecbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaadaaaaaaegiocaaaaaaaaaaaakaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaaajaaaaaaagbabaaaadaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaa
egaobaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaamaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaa
aaaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaagaabaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
anaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
Matrix 0 [_LightMatrix0] 3
Vector 5 [_Color]
Vector 4 [_LightColor0]
Vector 3 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
def c6, 1, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl t4.x
dcl_cube s0
dcl_2d s1
dcl_2d s2
mov r0.xyz, t2
mov_pp r0.w, c6.x
dp4_pp r1.x, c0, r0
dp4_pp r1.y, c1, r0
dp4_pp r1.z, c2, r0
dp3_pp r0.xy, r1, r1
texld r1, r1, s0
texld r0, r0, s1
texld_pp r2, t0, s2
mul_pp r2.w, r1.w, r0.x
mul_pp r0.xyz, r2.w, c4
mul_pp r1.xyz, r2, c5
mul_pp r0.xyz, r0, r1
add r1.xyz, -t2, c3
nrm_pp r2.xyz, r1
dp3_pp r0.w, t1, r2
max_pp r1.x, r0.w, c6.y
mul_pp r0.xyz, r0, r1.x
mov_sat r0.w, t4.x
mul_pp r0.xyz, r0, r0.w
mov_pp r0.w, c6.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedpggmpgmkpldcaofdnamgaihdlbhcejbkabaaaaaageaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcfmadaaaaeaaaaaaanhaaaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaadaaaaaaegiccaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaa
agbabaaaadaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaalaaaaaakgbkbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egacbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaapgapbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaah
bcaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaanaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
abaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgcaaaaf
icaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaapgapbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedcdimpgdkedbiondhaachgckmafamhkgfabaaaaaaiaagaaaaaeaaaaaa
daaaaaaaeiacaaaakmafaaaaemagaaaaebgpgodjbaacaaaabaacaaaaaaacpppp
lmabaaaafeaaaaaaadaadaaaaaaafeaaaaaafeaaadaaceaaaaaafeaaacaaaaaa
abababaaaaacacaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaa
abaaaaaaabaaagaaaaaaaaaaaaacppppfbaaaaafahaaapkaaaaaaaaaaaaaiadp
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaachla
bpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaajiaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkaafaaaaadaaaachiaacaafflaacaaoeka
aeaaaaaeaaaachiaabaaoekaacaaaalaaaaaoeiaaeaaaaaeaaaachiaadaaoeka
acaakklaaaaaoeiaacaaaaadaaaachiaaaaaoeiaaeaaoekaaiaaaaadaaaaciia
aaaaoeiaaaaaoeiaabaaaaacabaacdiaaaaappiaecaaaaadaaaaapiaaaaaoeia
aaaioekaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadacaacpiaaaaaoela
acaioekaafaaaaadacaaciiaaaaappiaabaaaaiaafaaaaadaaaachiaacaappia
aaaaoekaafaaaaadabaachiaacaaoeiaafaaoekaafaaaaadaaaachiaaaaaoeia
abaaoeiaacaaaaadabaaahiaacaaoelbagaaoekaceaaaaacacaachiaabaaoeia
aiaaaaadaaaaciiaabaaoelaacaaoeiaalaaaaadabaacbiaaaaappiaahaaaaka
afaaaaadaaaachiaaaaaoeiaabaaaaiaabaaaaacaaaabiiaaaaakklaafaaaaad
aaaachiaaaaaoeiaaaaappiaabaaaaacaaaaciiaahaaffkaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcfmadaaaaeaaaaaaanhaaaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafidaaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
adaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaajaaaaaaagbabaaaadaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegacbaaaaaaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegacbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaaaaaaaaapgapbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
anaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
Matrix 0 [_LightMatrix0] 2
Vector 4 [_Color]
Vector 3 [_LightColor0]
Vector 2 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
def c5, 1, 0, 0, 0
dcl t0.xy
dcl_pp t1.xyz
dcl t2.xyz
dcl t4.x
dcl_2d s0
dcl_2d s1
mov r0.xyz, t2
mov_pp r0.w, c5.x
dp4_pp r1.x, c0, r0
dp4_pp r1.y, c1, r0
texld_pp r0, r1, s0
texld_pp r1, t0, s1
mul_pp r0.xyz, r0.w, c3
mul_pp r1.xyz, r1, c4
mul_pp r0.xyz, r0, r1
dp3_pp r0.w, t1, c2
max_pp r1.x, r0.w, c5.y
mul_pp r0.xyz, r0, r1.x
mov_sat r0.w, t4.x
mul_pp r0.xyz, r0, r0.w
mov_pp r0.w, c5.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedodepbddmelkgkimikkdolpgckkljdgchabaaaaaaiaadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefchiacaaaaeaaaaaaajoaaaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaadiaaaaaidcaabaaaaaaaaaaafgbfbaaaadaaaaaa
egiacaaaaaaaaaaaakaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaa
ajaaaaaaagbabaaaadaaaaaaegaabaaaaaaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegaabaaaaaaaaaaaaaaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaamaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
anaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaaiicaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgcaaaaficaabaaa
aaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Vector 208 [_Color]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedmppciephmipkgalkimjhafaigkhheadeabaaaaaadeafaaaaaeaaaaaa
daaaaaaaoaabaaaagaaeaaaaaaafaaaaebgpgodjkiabaaaakiabaaaaaaacpppp
fiabaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaabaaaaaa
aaababaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaafaaabaaaaaaaaaaabaaaaaa
abaaagaaaaaaaaaaaaacppppfbaaaaafahaaapkaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaachlabpaaaaac
aaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
afaaaaadaaaacdiaacaafflaacaaoekaaeaaaaaeaaaacdiaabaaoekaacaaaala
aaaaoeiaaeaaaaaeaaaacdiaadaaoekaacaakklaaaaaoeiaacaaaaadaaaacdia
aaaaoeiaaeaaoekaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadabaacpia
aaaaoelaabaioekaafaaaaadaaaachiaaaaappiaaaaaoekaafaaaaadabaachia
abaaoeiaafaaoekaafaaaaadaaaachiaaaaaoeiaabaaoeiaaiaaaaadaaaaciia
abaaoelaagaaoekaalaaaaadabaacbiaaaaappiaahaaaakaafaaaaadaaaachia
aaaaoeiaabaaaaiaabaaaaacaaaabiiaaaaakklaafaaaaadaaaachiaaaaaoeia
aaaappiaabaaaaacaaaaciiaahaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefchiacaaaaeaaaaaaajoaaaaaafjaaaaaeegiocaaaaaaaaaaaaoaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaadiaaaaaidcaabaaaaaaaaaaafgbfbaaaadaaaaaa
egiacaaaaaaaaaaaakaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaa
ajaaaaaaagbabaaaadaaaaaaegaabaaaaaaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaaegaabaaaaaaaaaaaaaaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaamaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
anaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaaiicaabaaaaaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgcaaaaficaabaaa
aaaaaaaackbabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
ejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
imaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaaaeaeaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  GpuProgramID 176558
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
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 res_1;
  res_1.xyz = ((xlv_TEXCOORD0 * 0.5) + 0.5);
  res_1.w = 0.0;
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
"vs_2_0
dcl_position v0
dcl_normal v1
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
dp4 oT1.x, c4, v0
dp4 oT1.y, c5, v0
dp4 oT1.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul oT0.xyz, r0.w, r0

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
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecedfimbpiggiminkfbhlgdjijhgmgblgjidabaaaaaaneagaaaaaeaaaaaa
daaaaaaacmacaaaagmafaaaageagaaaaebgpgodjpeabaaaapeabaaaaaaacpopp
leabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaamaaahaaafaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaahiaaaaaffja
agaaoekaaeaaaaaeaaaaahiaafaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahia
ahaaoekaaaaakkjaaaaaoeiaaeaaaaaeabaaahoaaiaaoekaaaaappjaaaaaoeia
afaaaaadaaaaabiaacaaaajaajaaaakaafaaaaadaaaaaciaacaaaajaakaaaaka
afaaaaadaaaaaeiaacaaaajaalaaaakaafaaaaadabaaabiaacaaffjaajaaffka
afaaaaadabaaaciaacaaffjaakaaffkaafaaaaadabaaaeiaacaaffjaalaaffka
acaaaaadaaaaahiaaaaaoeiaabaaoeiaafaaaaadabaaabiaacaakkjaajaakkka
afaaaaadabaaaciaacaakkjaakaakkkaafaaaaadabaaaeiaacaakkjaalaakkka
acaaaaadaaaaahiaaaaaoeiaabaaoeiaaiaaaaadaaaaaiiaaaaaoeiaaaaaoeia
ahaaaaacaaaaaiiaaaaappiaafaaaaadaaaaahoaaaaappiaaaaaoeiaafaaaaad
aaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapiaabaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcdiadaaaaeaaaabaamoaaaaaafjaaaaae
egiocaaaaaaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaaaaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
aaaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
aaaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
aaaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaaaaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
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
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
"ps_2_0
def c0, 0.5, 0, 0, 0
dcl_pp t0.xyz
mad_pp r0.xyz, t0, c0.x, c0.x
mov_pp r0.w, c0.y
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
"ps_4_0
eefiecedahndifnccigjgehbcgabbojggkeiepneabaaaaaaemabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheaaaaaaeaaaaaaabnaaaaaa
gcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaadcaaaaaphccabaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
"ps_4_0_level_9_1
eefiecedlhbojekhenomcgbelfdkmofngcodlfjbabaaaaaaneabaaaaaeaaaaaa
daaaaaaaleaaaaaadaabaaaakaabaaaaebgpgodjhmaaaaaahmaaaaaaaaacpppp
fiaaaaaaceaaaaaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaacpppp
fbaaaaafaaaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaachlaaeaaaaaeaaaachiaaaaaoelaaaaaaakaaaaaaakaabaaaaacaaaaciia
aaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcheaaaaaaeaaaaaaa
bnaaaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaadcaaaaap
hccabaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" }
  ZWrite Off
  GpuProgramID 260376
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL
#ifdef VERTEX
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
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * gl_Normal.x)
   + 
    (v_7.xyz * gl_Normal.y)
  ) + (v_8.xyz * gl_Normal.z)));
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  vec3 x2_11;
  vec3 x1_12;
  x1_12.x = dot (unity_SHAr, tmpvar_10);
  x1_12.y = dot (unity_SHAg, tmpvar_10);
  x1_12.z = dot (unity_SHAb, tmpvar_10);
  vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_9.xyzz * tmpvar_9.yzzx);
  x2_11.x = dot (unity_SHBr, tmpvar_13);
  x2_11.y = dot (unity_SHBg, tmpvar_13);
  x2_11.z = dot (unity_SHBb, tmpvar_13);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_3;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((x2_11 + (unity_SHC.xyz * 
    ((tmpvar_9.x * tmpvar_9.x) - (tmpvar_9.y * tmpvar_9.y))
  )) + x1_12);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Intensity;
uniform sampler2D _LightBuffer;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 light_2;
  vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  vec4 tmpvar_4;
  tmpvar_4 = -(log2(texture2DProj (_LightBuffer, xlv_TEXCOORD2)));
  light_2.w = tmpvar_4.w;
  light_2.xyz = (tmpvar_4.xyz + xlv_TEXCOORD4);
  vec4 c_5;
  c_5.xyz = (tmpvar_3.xyz * light_2.xyz);
  c_5.w = 0.0;
  c_1.xyz = (c_5.xyz + (tmpvar_3.xyz * _Intensity));
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
Vector 19 [_MainTex_ST]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 14 [unity_SHAb]
Vector 13 [unity_SHAg]
Vector 12 [unity_SHAr]
Vector 17 [unity_SHBb]
Vector 16 [unity_SHBg]
Vector 15 [unity_SHBr]
Vector 18 [unity_SHC]
"vs_2_0
def c20, 0.5, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c19, c19.zwzw
dp4 oT1.x, c4, v0
dp4 oT1.y, c5, v0
dp4 oT1.z, c6, v0
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c20.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c20.x
mad oT2.xy, r1.z, c11.zwzw, r1.xwzw
mul r1.xyz, v1.y, c8
mad r1.xyz, c7, v1.x, r1
mad r1.xyz, c9, v1.z, r1
nrm r2.xyz, r1
mul r1.x, r2.y, r2.y
mad r1.x, r2.x, r2.x, -r1.x
mul r3, r2.yzzx, r2.xyzz
dp4 r4.x, c15, r3
dp4 r4.y, c16, r3
dp4 r4.z, c17, r3
mad r1.xyz, c18, r1.x, r4
mov r2.w, c20.y
dp4 r3.x, c12, r2
dp4 r3.y, c13, r2
dp4 r3.z, c14, r2
add oT4.xyz, r1, r3
dp4 r0.z, c2, v0
mov oPos, r0
mov oT2.zw, r0
mov oT3, c20.z

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
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
eefiecednmfjkehbcgpomfcgfkffmdbnlmpmiapbabaaaaaammahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oiafaaaaeaaaabaahkabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
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
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
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
"vs_4_0_level_9_1
eefiecedajpemciclkepfonoangnhdmoefnjdhloabaaaaaacealaaaaaeaaaaaa
daaaaaaaieadaaaaheajaaaagmakaaaaebgpgodjemadaaaaemadaaaaaaacpopp
oiacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaalaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaacgaaahaaadaaaaaaaaaa
adaaaaaaaeaaakaaaaaaaaaaadaaamaaahaaaoaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbfaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaapaaoeka
aeaaaaaeaaaaahiaaoaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabaaaoeka
aaaakkjaaaaaoeiaaeaaaaaeabaaahoabbaaoekaaaaappjaaaaaoeiaafaaaaad
aaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaacaaaakaafaaaaadabaaaiia
abaaaaiabfaaaakaafaaaaadabaaafiaaaaapeiabfaaaakaacaaaaadacaaadoa
abaakkiaabaaomiaafaaaaadabaaabiaacaaaajabcaaaakaafaaaaadabaaacia
acaaaajabdaaaakaafaaaaadabaaaeiaacaaaajabeaaaakaafaaaaadacaaabia
acaaffjabcaaffkaafaaaaadacaaaciaacaaffjabdaaffkaafaaaaadacaaaeia
acaaffjabeaaffkaacaaaaadabaaahiaabaaoeiaacaaoeiaafaaaaadacaaabia
acaakkjabcaakkkaafaaaaadacaaaciaacaakkjabdaakkkaafaaaaadacaaaeia
acaakkjabeaakkkaacaaaaadabaaahiaabaaoeiaacaaoeiaceaaaaacacaaahia
abaaoeiaafaaaaadabaaabiaacaaffiaacaaffiaaeaaaaaeabaaabiaacaaaaia
acaaaaiaabaaaaibafaaaaadadaaapiaacaacjiaacaakeiaajaaaaadaeaaabia
agaaoekaadaaoeiaajaaaaadaeaaaciaahaaoekaadaaoeiaajaaaaadaeaaaeia
aiaaoekaadaaoeiaaeaaaaaeabaaahiaajaaoekaabaaaaiaaeaaoeiaabaaaaac
acaaaiiabfaaffkaajaaaaadadaaabiaadaaoekaacaaoeiaajaaaaadadaaacia
aeaaoekaacaaoeiaajaaaaadadaaaeiaafaaoekaacaaoeiaacaaaaadaeaaahoa
abaaoeiaadaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeiaabaaaaacadaaapoabfaakkka
ppppaaaafdeieefcoiafaaaaeaaaabaahkabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaa
alaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaa
acaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLSL
#ifdef VERTEX
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
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * gl_Normal.x)
   + 
    (v_7.xyz * gl_Normal.y)
  ) + (v_8.xyz * gl_Normal.z)));
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  vec3 x2_11;
  vec3 x1_12;
  x1_12.x = dot (unity_SHAr, tmpvar_10);
  x1_12.y = dot (unity_SHAg, tmpvar_10);
  x1_12.z = dot (unity_SHAb, tmpvar_10);
  vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_9.xyzz * tmpvar_9.yzzx);
  x2_11.x = dot (unity_SHBr, tmpvar_13);
  x2_11.y = dot (unity_SHBg, tmpvar_13);
  x2_11.z = dot (unity_SHBb, tmpvar_13);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_3;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((x2_11 + (unity_SHC.xyz * 
    ((tmpvar_9.x * tmpvar_9.x) - (tmpvar_9.y * tmpvar_9.y))
  )) + x1_12);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Intensity;
uniform sampler2D _LightBuffer;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
void main ()
{
  vec4 c_1;
  vec4 light_2;
  vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_2.w = tmpvar_4.w;
  light_2.xyz = (tmpvar_4.xyz + xlv_TEXCOORD4);
  vec4 c_5;
  c_5.xyz = (tmpvar_3.xyz * light_2.xyz);
  c_5.w = 0.0;
  c_1.xyz = (c_5.xyz + (tmpvar_3.xyz * _Intensity));
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
Vector 19 [_MainTex_ST]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 14 [unity_SHAb]
Vector 13 [unity_SHAg]
Vector 12 [unity_SHAr]
Vector 17 [unity_SHBb]
Vector 16 [unity_SHBg]
Vector 15 [unity_SHBr]
Vector 18 [unity_SHC]
"vs_2_0
def c20, 0.5, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c19, c19.zwzw
dp4 oT1.x, c4, v0
dp4 oT1.y, c5, v0
dp4 oT1.z, c6, v0
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c20.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c20.x
mad oT2.xy, r1.z, c11.zwzw, r1.xwzw
mul r1.xyz, v1.y, c8
mad r1.xyz, c7, v1.x, r1
mad r1.xyz, c9, v1.z, r1
nrm r2.xyz, r1
mul r1.x, r2.y, r2.y
mad r1.x, r2.x, r2.x, -r1.x
mul r3, r2.yzzx, r2.xyzz
dp4 r4.x, c15, r3
dp4 r4.y, c16, r3
dp4 r4.z, c17, r3
mad r1.xyz, c18, r1.x, r4
mov r2.w, c20.y
dp4 r3.x, c12, r2
dp4 r3.y, c13, r2
dp4 r3.z, c14, r2
add oT4.xyz, r1, r3
dp4 r0.z, c2, v0
mov oPos, r0
mov oT2.zw, r0
mov oT3, c20.z

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
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
eefiecednmfjkehbcgpomfcgfkffmdbnlmpmiapbabaaaaaammahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oiafaaaaeaaaabaahkabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
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
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
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
"vs_4_0_level_9_1
eefiecedajpemciclkepfonoangnhdmoefnjdhloabaaaaaacealaaaaaeaaaaaa
daaaaaaaieadaaaaheajaaaagmakaaaaebgpgodjemadaaaaemadaaaaaaacpopp
oiacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaalaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaacgaaahaaadaaaaaaaaaa
adaaaaaaaeaaakaaaaaaaaaaadaaamaaahaaaoaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbfaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaahiaaaaaffjaapaaoeka
aeaaaaaeaaaaahiaaoaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabaaaoeka
aaaakkjaaaaaoeiaaeaaaaaeabaaahoabbaaoekaaaaappjaaaaaoeiaafaaaaad
aaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaacaaaakaafaaaaadabaaaiia
abaaaaiabfaaaakaafaaaaadabaaafiaaaaapeiabfaaaakaacaaaaadacaaadoa
abaakkiaabaaomiaafaaaaadabaaabiaacaaaajabcaaaakaafaaaaadabaaacia
acaaaajabdaaaakaafaaaaadabaaaeiaacaaaajabeaaaakaafaaaaadacaaabia
acaaffjabcaaffkaafaaaaadacaaaciaacaaffjabdaaffkaafaaaaadacaaaeia
acaaffjabeaaffkaacaaaaadabaaahiaabaaoeiaacaaoeiaafaaaaadacaaabia
acaakkjabcaakkkaafaaaaadacaaaciaacaakkjabdaakkkaafaaaaadacaaaeia
acaakkjabeaakkkaacaaaaadabaaahiaabaaoeiaacaaoeiaceaaaaacacaaahia
abaaoeiaafaaaaadabaaabiaacaaffiaacaaffiaaeaaaaaeabaaabiaacaaaaia
acaaaaiaabaaaaibafaaaaadadaaapiaacaacjiaacaakeiaajaaaaadaeaaabia
agaaoekaadaaoeiaajaaaaadaeaaaciaahaaoekaadaaoeiaajaaaaadaeaaaeia
aiaaoekaadaaoeiaaeaaaaaeabaaahiaajaaoekaabaaaaiaaeaaoeiaabaaaaac
acaaaiiabfaaffkaajaaaaadadaaabiaadaaoekaacaaoeiaajaaaaadadaaacia
aeaaoekaacaaoeiaajaaaaadadaaaeiaafaaoekaacaaoeiaacaaaaadaeaaahoa
abaaoeiaadaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeiaabaaaaacadaaapoabfaakkka
ppppaaaafdeieefcoiafaaaaeaaaabaahkabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaa
alaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
adaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaadaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaadaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaa
acaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL
#ifdef VERTEX
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
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * gl_Normal.x)
   + 
    (v_7.xyz * gl_Normal.y)
  ) + (v_8.xyz * gl_Normal.z)));
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  vec3 x2_11;
  vec3 x1_12;
  x1_12.x = dot (unity_SHAr, tmpvar_10);
  x1_12.y = dot (unity_SHAg, tmpvar_10);
  x1_12.z = dot (unity_SHAb, tmpvar_10);
  vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_9.xyzz * tmpvar_9.yzzx);
  x2_11.x = dot (unity_SHBr, tmpvar_13);
  x2_11.y = dot (unity_SHBg, tmpvar_13);
  x2_11.z = dot (unity_SHBb, tmpvar_13);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_3;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((x2_11 + (unity_SHC.xyz * 
    ((tmpvar_9.x * tmpvar_9.x) - (tmpvar_9.y * tmpvar_9.y))
  )) + x1_12);
  xlv_TEXCOORD5 = exp2(-((unity_FogParams.y * tmpvar_2.z)));
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Intensity;
uniform sampler2D _LightBuffer;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec4 light_2;
  vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  vec4 tmpvar_4;
  tmpvar_4 = -(log2(texture2DProj (_LightBuffer, xlv_TEXCOORD2)));
  light_2.w = tmpvar_4.w;
  light_2.xyz = (tmpvar_4.xyz + xlv_TEXCOORD4);
  vec4 c_5;
  c_5.xyz = (tmpvar_3.xyz * light_2.xyz);
  c_5.w = 0.0;
  c_1.w = c_5.w;
  c_1.xyz = (c_5.xyz + (tmpvar_3.xyz * _Intensity));
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(clamp (xlv_TEXCOORD5, 0.0, 1.0)));
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
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 19 [unity_FogParams]
Vector 14 [unity_SHAb]
Vector 13 [unity_SHAg]
Vector 12 [unity_SHAr]
Vector 17 [unity_SHBb]
Vector 16 [unity_SHBg]
Vector 15 [unity_SHBr]
Vector 18 [unity_SHC]
"vs_2_0
def c21, 0.5, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c20, c20.zwzw
dp4 oT1.x, c4, v0
dp4 oT1.y, c5, v0
dp4 oT1.z, c6, v0
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c21.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c21.x
mad oT2.xy, r1.z, c11.zwzw, r1.xwzw
mul r1.xyz, v1.y, c8
mad r1.xyz, c7, v1.x, r1
mad r1.xyz, c9, v1.z, r1
nrm r2.xyz, r1
mul r1.x, r2.y, r2.y
mad r1.x, r2.x, r2.x, -r1.x
mul r3, r2.yzzx, r2.xyzz
dp4 r4.x, c15, r3
dp4 r4.y, c16, r3
dp4 r4.z, c17, r3
mad r1.xyz, c18, r1.x, r4
mov r2.w, c21.y
dp4 r3.x, c12, r2
dp4 r3.y, c13, r2
dp4 r3.z, c14, r2
add oT4.xyz, r1, r3
dp4 r0.z, c2, v0
mul r1.x, r0.z, c19.y
exp oT5.x, -r1.x
mov oPos, r0
mov oT2.zw, r0
mov oT3, c21.z

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
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
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0
eefiecedacdoglmdfndibecafbogmgomankfdhniabaaaaaadiaiaaaaadaaaaaa
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
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdmagaaaaeaaaabaa
ipabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafjaaaaaeegiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaackaabaaaaaaaaaaabkiacaaaaeaaaaaa
abaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaa
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
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaa
abaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaa
adaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
acaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
acaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
acaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaa
afaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
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
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0_level_9_1
eefiecedmhbobejeokjkeojoinmfhiobnjfdmdbgabaaaaaalialaaaaaeaaaaaa
daaaaaaakmadaaaapaajaaaaoiakaaaaebgpgodjheadaaaaheadaaaaaaacpopp
aeadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaalaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaacgaaahaaadaaaaaaaaaa
adaaaaaaaeaaakaaaaaaaaaaadaaamaaahaaaoaaaaaaaaaaaeaaabaaabaabfaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbgaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaad
aaaaahiaaaaaffjaapaaoekaaeaaaaaeaaaaahiaaoaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabaaaoekaaaaakkjaaaaaoeiaaeaaaaaeabaaahoabbaaoeka
aaaappjaaaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapia
akaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
acaaaakaafaaaaadabaaaiiaabaaaaiabgaaaakaafaaaaadabaaafiaaaaapeia
bgaaaakaacaaaaadacaaadoaabaakkiaabaaomiaafaaaaadabaaabiaacaaaaja
bcaaaakaafaaaaadabaaaciaacaaaajabdaaaakaafaaaaadabaaaeiaacaaaaja
beaaaakaafaaaaadacaaabiaacaaffjabcaaffkaafaaaaadacaaaciaacaaffja
bdaaffkaafaaaaadacaaaeiaacaaffjabeaaffkaacaaaaadabaaahiaabaaoeia
acaaoeiaafaaaaadacaaabiaacaakkjabcaakkkaafaaaaadacaaaciaacaakkja
bdaakkkaafaaaaadacaaaeiaacaakkjabeaakkkaacaaaaadabaaahiaabaaoeia
acaaoeiaceaaaaacacaaahiaabaaoeiaafaaaaadabaaabiaacaaffiaacaaffia
aeaaaaaeabaaabiaacaaaaiaacaaaaiaabaaaaibafaaaaadadaaapiaacaacjia
acaakeiaajaaaaadaeaaabiaagaaoekaadaaoeiaajaaaaadaeaaaciaahaaoeka
adaaoeiaajaaaaadaeaaaeiaaiaaoekaadaaoeiaaeaaaaaeabaaahiaajaaoeka
abaaaaiaaeaaoeiaabaaaaacacaaaiiabgaaffkaajaaaaadadaaabiaadaaoeka
acaaoeiaajaaaaadadaaaciaaeaaoekaacaaoeiaajaaaaadadaaaeiaafaaoeka
acaaoeiaacaaaaadaeaaahoaabaaoeiaadaaoeiaafaaaaadabaaabiaaaaakkia
bfaaffkaaoaaaaacaaaaaeoaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeiaabaaaaac
adaaapoabgaakkkappppaaaafdeieefcdmagaaaaeaaaabaaipabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafjaaaaae
egiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaackaabaaaaaaaaaaabkiacaaaaeaaaaaaabaaaaaabjaaaaag
eccabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
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
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaf
icaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaa
acaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaa
acaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaa
acaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
oaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaa
lmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "UNITY_HDR_ON" }
"!!GLSL
#ifdef VERTEX
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
uniform vec4 unity_FogParams;
uniform vec4 _MainTex_ST;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 v_6;
  v_6.x = _World2Object[0].x;
  v_6.y = _World2Object[1].x;
  v_6.z = _World2Object[2].x;
  v_6.w = _World2Object[3].x;
  vec4 v_7;
  v_7.x = _World2Object[0].y;
  v_7.y = _World2Object[1].y;
  v_7.z = _World2Object[2].y;
  v_7.w = _World2Object[3].y;
  vec4 v_8;
  v_8.x = _World2Object[0].z;
  v_8.y = _World2Object[1].z;
  v_8.z = _World2Object[2].z;
  v_8.w = _World2Object[3].z;
  vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * gl_Normal.x)
   + 
    (v_7.xyz * gl_Normal.y)
  ) + (v_8.xyz * gl_Normal.z)));
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_9;
  vec3 x2_11;
  vec3 x1_12;
  x1_12.x = dot (unity_SHAr, tmpvar_10);
  x1_12.y = dot (unity_SHAg, tmpvar_10);
  x1_12.z = dot (unity_SHAb, tmpvar_10);
  vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_9.xyzz * tmpvar_9.yzzx);
  x2_11.x = dot (unity_SHBr, tmpvar_13);
  x2_11.y = dot (unity_SHBg, tmpvar_13);
  x2_11.z = dot (unity_SHBb, tmpvar_13);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD2 = o_3;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = ((x2_11 + (unity_SHC.xyz * 
    ((tmpvar_9.x * tmpvar_9.x) - (tmpvar_9.y * tmpvar_9.y))
  )) + x1_12);
  xlv_TEXCOORD5 = exp2(-((unity_FogParams.y * tmpvar_2.z)));
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Intensity;
uniform sampler2D _LightBuffer;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 c_1;
  vec4 light_2;
  vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_2.w = tmpvar_4.w;
  light_2.xyz = (tmpvar_4.xyz + xlv_TEXCOORD4);
  vec4 c_5;
  c_5.xyz = (tmpvar_3.xyz * light_2.xyz);
  c_5.w = 0.0;
  c_1.w = c_5.w;
  c_1.xyz = (c_5.xyz + (tmpvar_3.xyz * _Intensity));
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(clamp (xlv_TEXCOORD5, 0.0, 1.0)));
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
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 19 [unity_FogParams]
Vector 14 [unity_SHAb]
Vector 13 [unity_SHAg]
Vector 12 [unity_SHAr]
Vector 17 [unity_SHBb]
Vector 16 [unity_SHBg]
Vector 15 [unity_SHBr]
Vector 18 [unity_SHC]
"vs_2_0
def c21, 0.5, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
mad oT0.xy, v2, c20, c20.zwzw
dp4 oT1.x, c4, v0
dp4 oT1.y, c5, v0
dp4 oT1.z, c6, v0
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c21.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c21.x
mad oT2.xy, r1.z, c11.zwzw, r1.xwzw
mul r1.xyz, v1.y, c8
mad r1.xyz, c7, v1.x, r1
mad r1.xyz, c9, v1.z, r1
nrm r2.xyz, r1
mul r1.x, r2.y, r2.y
mad r1.x, r2.x, r2.x, -r1.x
mul r3, r2.yzzx, r2.xyzz
dp4 r4.x, c15, r3
dp4 r4.y, c16, r3
dp4 r4.z, c17, r3
mad r1.xyz, c18, r1.x, r4
mov r2.w, c21.y
dp4 r3.x, c12, r2
dp4 r3.y, c13, r2
dp4 r3.z, c14, r2
add oT4.xyz, r1, r3
dp4 r0.z, c2, v0
mul r1.x, r0.z, c19.y
exp oT5.x, -r1.x
mov oPos, r0
mov oT2.zw, r0
mov oT3, c21.z

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
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
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0
eefiecedacdoglmdfndibecafbogmgomankfdhniabaaaaaadiaiaaaaadaaaaaa
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
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdmagaaaaeaaaabaa
ipabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bdaaaaaafjaaaaaeegiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaackaabaaaaaaaaaaabkiacaaaaeaaaaaa
abaaaaaabjaaaaageccabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaa
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
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaa
abaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaa
adaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
acaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
acaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
acaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaa
afaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 176 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
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
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
BindCB  "UnityFog" 4
"vs_4_0_level_9_1
eefiecedmhbobejeokjkeojoinmfhiobnjfdmdbgabaaaaaalialaaaaaeaaaaaa
daaaaaaakmadaaaapaajaaaaoiakaaaaebgpgodjheadaaaaheadaaaaaaacpopp
aeadaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaalaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaacgaaahaaadaaaaaaaaaa
adaaaaaaaeaaakaaaaaaaaaaadaaamaaahaaaoaaaaaaaaaaaeaaabaaabaabfaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbgaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaafaaaaad
aaaaahiaaaaaffjaapaaoekaaeaaaaaeaaaaahiaaoaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabaaaoekaaaaakkjaaaaaoeiaaeaaaaaeabaaahoabbaaoeka
aaaappjaaaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapia
akaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
acaaaakaafaaaaadabaaaiiaabaaaaiabgaaaakaafaaaaadabaaafiaaaaapeia
bgaaaakaacaaaaadacaaadoaabaakkiaabaaomiaafaaaaadabaaabiaacaaaaja
bcaaaakaafaaaaadabaaaciaacaaaajabdaaaakaafaaaaadabaaaeiaacaaaaja
beaaaakaafaaaaadacaaabiaacaaffjabcaaffkaafaaaaadacaaaciaacaaffja
bdaaffkaafaaaaadacaaaeiaacaaffjabeaaffkaacaaaaadabaaahiaabaaoeia
acaaoeiaafaaaaadacaaabiaacaakkjabcaakkkaafaaaaadacaaaciaacaakkja
bdaakkkaafaaaaadacaaaeiaacaakkjabeaakkkaacaaaaadabaaahiaabaaoeia
acaaoeiaceaaaaacacaaahiaabaaoeiaafaaaaadabaaabiaacaaffiaacaaffia
aeaaaaaeabaaabiaacaaaaiaacaaaaiaabaaaaibafaaaaadadaaapiaacaacjia
acaakeiaajaaaaadaeaaabiaagaaoekaadaaoeiaajaaaaadaeaaaciaahaaoeka
adaaoeiaajaaaaadaeaaaeiaaiaaoekaadaaoeiaaeaaaaaeabaaahiaajaaoeka
abaaaaiaaeaaoeiaabaaaaacacaaaiiabgaaffkaajaaaaadadaaabiaadaaoeka
acaaoeiaajaaaaadadaaaciaaeaaoekaacaaoeiaajaaaaadadaaaeiaafaaoeka
acaaoeiaacaaaaadaeaaahoaabaaoeiaadaaoeiaafaaaaadabaaabiaaaaakkia
bfaaffkaaoaaaaacaaaaaeoaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeiaabaaaaac
adaaapoabgaakkkappppaaaafdeieefcdmagaaaaeaaaabaaipabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabdaaaaaafjaaaaae
egiocaaaaeaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadeccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaackaabaaaaaaaaaaabkiacaaaaeaaaaaaabaaaaaabjaaaaag
eccabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaa
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
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaf
icaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaa
acaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaa
acaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaa
acaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
oaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaaaealaaaa
lmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Float 1 [_Intensity]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"ps_2_0
def c2, 1, 0, 0, 0
dcl t0.xy
dcl t2
dcl t4.xyz
dcl_2d s0
dcl_2d s1
texldp_pp r0, t2, s1
texld_pp r1, t0, s0
log_pp r2.x, r0.x
log_pp r2.y, r0.y
log_pp r2.z, r0.z
add_pp r0.xyz, -r2, t4
mul_pp r1.xyz, r1, c0
mul_pp r2.xyz, r1, c1.x
mad_pp r0.xyz, r1, r0, r2
mov_pp r0.w, c2.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 160 [_Intensity]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlinhpogjeeahiomlmbibkmobfghogbdjabaaaaaalmacaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjmabaaaa
eaaaaaaaghaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
lcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaa
adaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaacpaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegbcbaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 160 [_Intensity]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedfocknfnabnabchpjpkimiabobolmhpioabaaaaaabiaeaaaaaeaaaaaa
daaaaaaaiiabaaaacmadaaaaoeadaaaaebgpgodjfaabaaaafaabaaaaaaacpppp
biabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaajaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkaagaaaaacaaaaaiiaacaapplaafaaaaadaaaaadiaaaaappia
acaaoelaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadabaacpiaaaaaoela
aaaioekaapaaaaacacaacbiaaaaaaaiaapaaaaacacaacciaaaaaffiaapaaaaac
acaaceiaaaaakkiaacaaaaadaaaachiaacaaoeibaeaaoelaafaaaaadabaachia
abaaoeiaaaaaoekaafaaaaadacaachiaabaaoeiaabaaaakaaeaaaaaeaaaachia
abaaoeiaaaaaoeiaacaaoeiaabaaaaacaaaaciiaacaaaakaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcjmabaaaaeaaaaaaaghaaaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaa
abaaaaaaagiacaaaaaaaaaaaakaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Vector 0 [_Color]
Float 1 [_Intensity]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"ps_2_0
def c2, 1, 0, 0, 0
dcl t0.xy
dcl t2
dcl t4.xyz
dcl_2d s0
dcl_2d s1
texldp_pp r0, t2, s1
texld_pp r1, t0, s0
add_pp r0.xyz, r0, t4
mul_pp r1.xyz, r1, c0
mul_pp r2.xyz, r1, c1.x
mad_pp r0.xyz, r1, r0, r2
mov_pp r0.w, c2.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 160 [_Intensity]
BindCB  "$Globals" 0
"ps_4_0
eefiecedomhphmamfbonembkogpeblifimbdpdedabaaaaaakeacaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcieabaaaa
eaaaaaaagbaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
lcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaa
adaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
afaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaajaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaagiacaaa
aaaaaaaaakaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 160 [_Intensity]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedemapdfconjlaojkdljcflmeojejhplababaaaaaanmadaaaaaeaaaaaa
daaaaaaageabaaaapaacaaaakiadaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
peaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaajaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkaagaaaaacaaaaaiiaacaapplaafaaaaadaaaaadiaaaaappia
acaaoelaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadabaacpiaaaaaoela
aaaioekaacaaaaadaaaachiaaaaaoeiaaeaaoelaafaaaaadabaachiaabaaoeia
aaaaoekaafaaaaadacaachiaabaaoeiaabaaaakaaeaaaaaeaaaachiaabaaoeia
aaaaoeiaacaaoeiaabaaaaacaaaaciiaacaaaakaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcieabaaaaeaaaaaaagbaaaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaacaaaaaa
egacbaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "HDR_LIGHT_PREPASS_OFF" }
Vector 1 [_Color]
Float 2 [_Intensity]
Vector 0 [unity_FogColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"ps_2_0
def c3, 1, 0, 0, 0
dcl t0.xy
dcl t2
dcl t4.xyz
dcl t5.x
dcl_2d s0
dcl_2d s1
texldp_pp r0, t2, s1
texld_pp r1, t0, s0
log_pp r2.x, r0.x
log_pp r2.y, r0.y
log_pp r2.z, r0.z
add_pp r0.xyz, -r2, t4
mul_pp r1.xyz, r1, c1
mul_pp r2.xyz, r1, c2.x
mad_pp r0.xyz, r1, r0, r2
mov_sat r0.w, t5.x
lrp_pp r1.xyz, r0.w, r0, c0
mov_pp r1.w, c3.x
mov_pp oC0, r1

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 160 [_Intensity]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedclhcnibcjegljedgjlmblanfoncdnhhgabaaaaaafaadaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbiacaaaaeaaaaaaaigaaaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaaf
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaaacaaaaaa
egacbaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaadgcaaaaf
icaabaaaaaaaaaaackbabaaaabaaaaaadcaaaaakhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 160 [_Intensity]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0_level_9_1
eefiecedpegboaoimnnejbmkedloaeicmkbdobpdabaaaaaaniaeaaaaaeaaaaaa
daaaaaaaleabaaaaneadaaaakeaeaaaaebgpgodjhmabaaaahmabaaaaaaacpppp
diabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaajaaacaaaaaaaaaaaaaaabaaaaaaabaaacaaaaaaaaaaaaacpppp
fbaaaaafadaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaahlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaiaaeaaahlabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaacaappla
afaaaaadaaaaadiaaaaappiaacaaoelaecaaaaadaaaacpiaaaaaoeiaabaioeka
ecaaaaadabaacpiaaaaaoelaaaaioekaapaaaaacacaacbiaaaaaaaiaapaaaaac
acaacciaaaaaffiaapaaaaacacaaceiaaaaakkiaacaaaaadaaaachiaacaaoeib
aeaaoelaafaaaaadabaachiaabaaoeiaaaaaoekaafaaaaadacaachiaabaaoeia
abaaaakaaeaaaaaeaaaachiaabaaoeiaaaaaoeiaacaaoeiaabaaaaacaaaabiia
aaaakklabcaaaaaeabaachiaaaaappiaaaaaoeiaacaaoekaabaaaaacabaaciia
adaaaakaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcbiacaaaaeaaaaaaa
igaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadlcbabaaaadaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
cpaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaa
dgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadcaaaaakhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaabaaaaaaaeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "UNITY_HDR_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "UNITY_HDR_ON" }
Vector 1 [_Color]
Float 2 [_Intensity]
Vector 0 [unity_FogColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
"ps_2_0
def c3, 1, 0, 0, 0
dcl t0.xy
dcl t2
dcl t4.xyz
dcl t5.x
dcl_2d s0
dcl_2d s1
texldp_pp r0, t2, s1
texld_pp r1, t0, s0
add_pp r0.xyz, r0, t4
mul_pp r1.xyz, r1, c1
mul_pp r2.xyz, r1, c2.x
mad_pp r0.xyz, r1, r0, r2
mov_sat r0.w, t5.x
lrp_pp r1.xyz, r0.w, r0, c0
mov_pp r1.w, c3.x
mov_pp oC0, r1

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 160 [_Intensity]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedobpakpfhlpjmcndgihngbmeapkgohjciabaaaaaadiadaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaacaaaaeaaaaaaaiaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadcaaaaakhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 208
Vector 144 [_Color]
Float 160 [_Intensity]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0_level_9_1
eefiecedgdgiifgohncdcegfmcklgbagijfgohahabaaaaaajmaeaaaaaeaaaaaa
daaaaaaajaabaaaajiadaaaagiaeaaaaebgpgodjfiabaaaafiabaaaaaaacpppp
beabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaajaaacaaaaaaaaaaaaaaabaaaaaaabaaacaaaaaaaaaaaaacpppp
fbaaaaafadaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaahlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaiaaeaaahlabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaacaappla
afaaaaadaaaaadiaaaaappiaacaaoelaecaaaaadaaaacpiaaaaaoeiaabaioeka
ecaaaaadabaacpiaaaaaoelaaaaioekaacaaaaadaaaachiaaaaaoeiaaeaaoela
afaaaaadabaachiaabaaoeiaaaaaoekaafaaaaadacaachiaabaaoeiaabaaaaka
aeaaaaaeaaaachiaabaaoeiaaaaaoeiaacaaoeiaabaaaaacaaaabiiaaaaakkla
bcaaaaaeabaachiaaaaappiaaaaaoeiaacaaoekaabaaaaacabaaciiaadaaaaka
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcaaacaaaaeaaaaaaaiaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadecbabaaaabaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaaakaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aaaaaaaadgcaaaaficaabaaaaaaaaaaackbabaaaabaaaaaadcaaaaakhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaabaaaaaaaeaeaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaa
lmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "DEFERRED"
  Tags { "LIGHTMODE"="Deferred" "RenderType"="Opaque" }
  GpuProgramID 274267
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL
#ifdef VERTEX
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
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
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
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  vec3 x2_7;
  vec3 x1_8;
  x1_8.x = dot (unity_SHAr, tmpvar_6);
  x1_8.y = dot (unity_SHAg, tmpvar_6);
  x1_8.z = dot (unity_SHAb, tmpvar_6);
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyzz * tmpvar_5.yzzx);
  x2_7.x = dot (unity_SHBr, tmpvar_9);
  x2_7.y = dot (unity_SHBg, tmpvar_9);
  x2_7.z = dot (unity_SHBb, tmpvar_9);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((x2_7 + (unity_SHC.xyz * 
    ((tmpvar_5.x * tmpvar_5.x) - (tmpvar_5.y * tmpvar_5.y))
  )) + x1_8);
}


#endif
#ifdef FRAGMENT
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Intensity;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 outDiffuse_1;
  vec4 outEmission_2;
  vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz * _Intensity);
  vec4 emission_5;
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_3.xyz;
  vec4 tmpvar_7;
  tmpvar_7.xyz = _SpecColor.xyz;
  tmpvar_7.w = 0.0;
  vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = ((xlv_TEXCOORD1 * 0.5) + 0.5);
  vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_4;
  emission_5.w = tmpvar_9.w;
  emission_5.xyz = (tmpvar_4 + (tmpvar_3.xyz * xlv_TEXCOORD5));
  outDiffuse_1.xyz = tmpvar_6.xyz;
  outEmission_2.w = emission_5.w;
  outDiffuse_1.w = 1.0;
  outEmission_2.xyz = exp2(-(emission_5.xyz));
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = tmpvar_7;
  gl_FragData[2] = tmpvar_8;
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
Vector 17 [_MainTex_ST]
Vector 12 [unity_SHAb]
Vector 11 [unity_SHAg]
Vector 10 [unity_SHAr]
Vector 15 [unity_SHBb]
Vector 14 [unity_SHBg]
Vector 13 [unity_SHBr]
Vector 16 [unity_SHC]
"vs_2_0
def c18, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c17, c17.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mad r0.xyz, c16, r0.x, r3
mov r1.w, c18.x
dp4 r2.x, c10, r1
dp4 r2.y, c11, r1
dp4 r2.z, c12, r1
mov oT1.xyz, r1
add oT5.xyz, r0, r2
mov oT4, c18.y

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 176 [_MainTex_ST]
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
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhcgciibgdacibploakicokpnlmcpkdehabaaaaaaeeahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
gaafaaaaeaaaabaafiabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaibcaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
hccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaa
egaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaa
agaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaa
aaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaa
aaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaa
aaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 176 [_MainTex_ST]
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
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedpcnmiafbcjbpddmlbephkciodpkojclcabaaaaaafaakaaaaaeaaaaaa
daaaaaaadiadaaaakaaiaaaajiajaaaaebgpgodjaaadaaaaaaadaaaaaaacpopp
kiacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaalaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaaaaaeaaajaaaaaaaaaa
acaaamaaahaaanaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbeaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoeka
abaaookaafaaaaadaaaaahiaaaaaffjaaoaaoekaaeaaaaaeaaaaahiaanaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaahiaapaaoekaaaaakkjaaaaaoeiaaeaaaaae
acaaahoabaaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajabbaaaaka
afaaaaadaaaaaciaacaaaajabcaaaakaafaaaaadaaaaaeiaacaaaajabdaaaaka
afaaaaadabaaabiaacaaffjabbaaffkaafaaaaadabaaaciaacaaffjabcaaffka
afaaaaadabaaaeiaacaaffjabdaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
afaaaaadabaaabiaacaakkjabbaakkkaafaaaaadabaaaciaacaakkjabcaakkka
afaaaaadabaaaeiaacaakkjabdaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
ceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaae
aaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeia
ajaaaaadadaaabiaafaaoekaacaaoeiaajaaaaadadaaaciaagaaoekaacaaoeia
ajaaaaadadaaaeiaahaaoekaacaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaaaaia
adaaoeiaabaaaaacabaaaiiabeaaaakaajaaaaadacaaabiaacaaoekaabaaoeia
ajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaadacaaaeiaaeaaoekaabaaoeia
abaaaaacabaaahoaabaaoeiaacaaaaadaeaaahoaaaaaoeiaacaaoeiaafaaaaad
aaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacadaaapoabeaaffkappppaaaafdeieefcgaafaaaa
eaaaabaafiabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaa
abaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab
ejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
njaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
oaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
keaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLSL
#ifdef VERTEX
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
varying vec4 xlv_TEXCOORD4;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
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
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  vec3 x2_7;
  vec3 x1_8;
  x1_8.x = dot (unity_SHAr, tmpvar_6);
  x1_8.y = dot (unity_SHAg, tmpvar_6);
  x1_8.z = dot (unity_SHAb, tmpvar_6);
  vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyzz * tmpvar_5.yzzx);
  x2_7.x = dot (unity_SHBr, tmpvar_9);
  x2_7.y = dot (unity_SHBg, tmpvar_9);
  x2_7.z = dot (unity_SHBb, tmpvar_9);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = (_Object2World * gl_Vertex).xyz;
  xlv_TEXCOORD4 = tmpvar_1;
  xlv_TEXCOORD5 = ((x2_7 + (unity_SHC.xyz * 
    ((tmpvar_5.x * tmpvar_5.x) - (tmpvar_5.y * tmpvar_5.y))
  )) + x1_8);
}


#endif
#ifdef FRAGMENT
uniform vec4 _SpecColor;
uniform sampler2D _MainTex;
uniform vec4 _Color;
uniform float _Intensity;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec3 xlv_TEXCOORD5;
void main ()
{
  vec4 outDiffuse_1;
  vec4 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2.xyz * _Intensity);
  vec4 emission_4;
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  vec4 tmpvar_6;
  tmpvar_6.xyz = _SpecColor.xyz;
  tmpvar_6.w = 0.0;
  vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = ((xlv_TEXCOORD1 * 0.5) + 0.5);
  vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_3;
  emission_4.w = tmpvar_8.w;
  emission_4.xyz = (tmpvar_3 + (tmpvar_2.xyz * xlv_TEXCOORD5));
  outDiffuse_1.xyz = tmpvar_5.xyz;
  outDiffuse_1.w = 1.0;
  gl_FragData[0] = outDiffuse_1;
  gl_FragData[1] = tmpvar_6;
  gl_FragData[2] = tmpvar_7;
  gl_FragData[3] = emission_4;
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
Vector 17 [_MainTex_ST]
Vector 12 [unity_SHAb]
Vector 11 [unity_SHAg]
Vector 10 [unity_SHAr]
Vector 15 [unity_SHBb]
Vector 14 [unity_SHBg]
Vector 13 [unity_SHBr]
Vector 16 [unity_SHC]
"vs_2_0
def c18, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mad oT0.xy, v2, c17, c17.zwzw
dp4 oT2.x, c4, v0
dp4 oT2.y, c5, v0
dp4 oT2.z, c6, v0
mul r0.xyz, v1.y, c8
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c13, r2
dp4 r3.y, c14, r2
dp4 r3.z, c15, r2
mad r0.xyz, c16, r0.x, r3
mov r1.w, c18.x
dp4 r2.x, c10, r1
dp4 r2.y, c11, r1
dp4 r2.z, c12, r1
mov oT1.xyz, r1
add oT5.xyz, r0, r2
mov oT4, c18.y

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 176 [_MainTex_ST]
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
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhcgciibgdacibploakicokpnlmcpkdehabaaaaaaeeahaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
gaafaaaaeaaaabaafiabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaibcaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
hccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaiaebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaa
egaobaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaa
agaabaaaabaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaa
aaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaa
aaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaa
aaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 176 [_MainTex_ST]
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
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedpcnmiafbcjbpddmlbephkciodpkojclcabaaaaaafaakaaaaaeaaaaaa
daaaaaaadiadaaaakaaiaaaajiajaaaaebgpgodjaaadaaaaaaadaaaaaaacpopp
kiacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaalaa
abaaabaaaaaaaaaaabaacgaaahaaacaaaaaaaaaaacaaaaaaaeaaajaaaaaaaaaa
acaaamaaahaaanaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbeaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoeka
abaaookaafaaaaadaaaaahiaaaaaffjaaoaaoekaaeaaaaaeaaaaahiaanaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaahiaapaaoekaaaaakkjaaaaaoeiaaeaaaaae
acaaahoabaaaoekaaaaappjaaaaaoeiaafaaaaadaaaaabiaacaaaajabbaaaaka
afaaaaadaaaaaciaacaaaajabcaaaakaafaaaaadaaaaaeiaacaaaajabdaaaaka
afaaaaadabaaabiaacaaffjabbaaffkaafaaaaadabaaaciaacaaffjabcaaffka
afaaaaadabaaaeiaacaaffjabdaaffkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
afaaaaadabaaabiaacaakkjabbaakkkaafaaaaadabaaaciaacaakkjabcaakkka
afaaaaadabaaaeiaacaakkjabdaakkkaacaaaaadaaaaahiaaaaaoeiaabaaoeia
ceaaaaacabaaahiaaaaaoeiaafaaaaadaaaaabiaabaaffiaabaaffiaaeaaaaae
aaaaabiaabaaaaiaabaaaaiaaaaaaaibafaaaaadacaaapiaabaacjiaabaakeia
ajaaaaadadaaabiaafaaoekaacaaoeiaajaaaaadadaaaciaagaaoekaacaaoeia
ajaaaaadadaaaeiaahaaoekaacaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaaaaia
adaaoeiaabaaaaacabaaaiiabeaaaakaajaaaaadacaaabiaacaaoekaabaaoeia
ajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaadacaaaeiaaeaaoekaabaaoeia
abaaaaacabaaahoaabaaoeiaacaaaaadaeaaahoaaaaaoeiaacaaoeiaafaaaaad
aaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacadaaapoabeaaffkappppaaaafdeieefcgaafaaaa
eaaaabaafiabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaaibcaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaa
akbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
bkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaa
acaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaa
acaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaia
ebaaaaaaabaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaa
abaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaa
aaaaaaahhccabaaaafaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab
ejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
njaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaoaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
oaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
keaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
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
Float 2 [_Intensity]
Vector 0 [_SpecColor]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c3, 1, 0, 0.5, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t5.xyz
dcl_2d s0
texld_pp r0, t0, s0
mov_pp r1.w, c3.x
mul_pp r1.xyz, r0, c1
mov_pp oC0, r1
mov_pp r0.xyz, c0
mov_pp r0.w, c3.y
mov_pp oC1, r0
mad_pp r0.xyz, t1, c3.z, c3.z
mov_pp r0.w, c3.x
mov_pp oC2, r0
mul_pp r0.xyz, r1, t5
mad_pp r0.xyz, r1, c2.x, r0
exp_pp r1.x, -r0.x
exp_pp r1.y, -r0.y
exp_pp r1.z, -r0.z
mov_pp r1.w, c3.x
mov_pp oC3, r1

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 208
Vector 112 [_SpecColor]
Vector 144 [_Color]
Float 160 [_Intensity]
BindCB  "$Globals" 0
"ps_4_0
eefiecedadekkamhdlajoablhcaefhbnbheopkniabaaaaaafeadaaaaadaaaaaa
cmaaaaaaoeaaaaaagaabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheoheaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaagiaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaagiaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaagiaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcomabaaaaeaaaaaaahlaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaajaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaabaaaaaaegiccaaaaaaaaaaaahaaaaaadgaaaaaf
iccabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphccabaaaacaaaaaaegbcbaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadgaaaaaficcabaaaacaaaaaaabeaaaaaaaaaiadp
diaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaaegbcbaaaafaaaaaadcaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaakaaaaaaegacbaaa
abaaaaaabjaaaaaghccabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaadgaaaaaf
iccabaaaadaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 208
Vector 112 [_SpecColor]
Vector 144 [_Color]
Float 160 [_Intensity]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmndnkmlbmefbalmjkbbnomjjomignfhmabaaaaaaniaeaaaaaeaaaaaa
daaaaaaalaabaaaakeadaaaafmaeaaaaebgpgodjhiabaaaahiabaaaaaaacpppp
diabaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaahaaabaaaaaaaaaaaaaaaaaaajaaacaaabaaaaaaaaaaaaacppppfbaaaaaf
adaaapkaaaaaiadpaaaaaaaaaaaaaadpaaaaaaaabpaaaaacaaaaaaiaaaaaadla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaja
aaaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaacabaaciiaadaaaaka
afaaaaadabaachiaaaaaoeiaabaaoekaabaaaaacaaaicpiaabaaoeiaabaaaaac
aaaachiaaaaaoekaabaaaaacaaaaciiaadaaffkaabaaaaacabaicpiaaaaaoeia
aeaaaaaeaaaachiaabaaoelaadaakkkaadaakkkaabaaaaacaaaaciiaadaaaaka
abaaaaacacaicpiaaaaaoeiaafaaaaadaaaachiaabaaoeiaaeaaoelaaeaaaaae
aaaachiaabaaoeiaacaaaakaaaaaoeiaaoaaaaacabaacbiaaaaaaaibaoaaaaac
abaacciaaaaaffibaoaaaaacabaaceiaaaaakkibabaaaaacabaaciiaadaaaaka
abaaaaacadaicpiaabaaoeiappppaaaafdeieefcomabaaaaeaaaaaaahlaaaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaa
dgaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaa
egiccaaaaaaaaaaaahaaaaaadgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphccabaaaacaaaaaaegbcbaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaaf
iccabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegbcbaaaafaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaakaaaaaaegacbaaaabaaaaaabjaaaaaghccabaaaadaaaaaa
egacbaiaebaaaaaaaaaaaaaadgaaaaaficcabaaaadaaaaaaabeaaaaaaaaaiadp
doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
heaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaagiaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagiaaaaaa
acaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaagiaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
Vector 1 [_Color]
Float 2 [_Intensity]
Vector 0 [_SpecColor]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c3, 1, 0, 0.5, 0
dcl t0.xy
dcl_pp t1.xyz
dcl_pp t5.xyz
dcl_2d s0
texld_pp r0, t0, s0
mov_pp r1.w, c3.x
mul_pp r1.xyz, r0, c1
mov_pp oC0, r1
mov_pp r0.xyz, c0
mov_pp r0.w, c3.y
mov_pp oC1, r0
mad_pp r0.xyz, t1, c3.z, c3.z
mov_pp r0.w, c3.x
mov_pp oC2, r0
mul_pp r0.xyz, r1, t5
mad_pp r0.xyz, r1, c2.x, r0
mov_pp r0.w, c3.x
mov_pp oC3, r0

"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 208
Vector 112 [_SpecColor]
Vector 144 [_Color]
Float 160 [_Intensity]
BindCB  "$Globals" 0
"ps_4_0
eefieceddohkfaeokopckfmgphnbmpipmnijpgflabaaaaaadmadaaaaadaaaaaa
cmaaaaaaoeaaaaaagaabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheoheaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaagiaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaagiaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaagiaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcneabaaaaeaaaaaaahfaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaajaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaghccabaaaabaaaaaaegiccaaaaaaaaaaaahaaaaaadgaaaaaf
iccabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphccabaaaacaaaaaaegbcbaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadgaaaaaficcabaaaacaaaaaaabeaaaaaaaaaiadp
diaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaaegbcbaaaafaaaaaadcaaaaak
hccabaaaadaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaakaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaadaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 208
Vector 112 [_SpecColor]
Vector 144 [_Color]
Float 160 [_Intensity]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedolddeehhgcindhjhfcofkkjlfabfhgccabaaaaaajmaeaaaaaeaaaaaa
daaaaaaaimabaaaagiadaaaacaaeaaaaebgpgodjfeabaaaafeabaaaaaaacpppp
beabaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaahaaabaaaaaaaaaaaaaaaaaaajaaacaaabaaaaaaaaaaaaacppppfbaaaaaf
adaaapkaaaaaiadpaaaaaaaaaaaaaadpaaaaaaaabpaaaaacaaaaaaiaaaaaadla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaja
aaaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaacabaaciiaadaaaaka
afaaaaadabaachiaaaaaoeiaabaaoekaabaaaaacaaaicpiaabaaoeiaabaaaaac
aaaachiaaaaaoekaabaaaaacaaaaciiaadaaffkaabaaaaacabaicpiaaaaaoeia
aeaaaaaeaaaachiaabaaoelaadaakkkaadaakkkaabaaaaacaaaaciiaadaaaaka
abaaaaacacaicpiaaaaaoeiaafaaaaadaaaachiaabaaoeiaaeaaoelaaeaaaaae
aaaachiaabaaoeiaacaaaakaaaaaoeiaabaaaaacaaaaciiaadaaaakaabaaaaac
adaicpiaaaaaoeiappppaaaafdeieefcneabaaaaeaaaaaaahfaaaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaac
acaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadgaaaaaf
hccabaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaghccabaaaabaaaaaaegiccaaa
aaaaaaaaahaaaaaadgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaap
hccabaaaacaaaaaaegbcbaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaaficcabaaa
acaaaaaaabeaaaaaaaaaiadpdiaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaa
egbcbaaaafaaaaaadcaaaaakhccabaaaadaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaakaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaadaaaaaaabeaaaaa
aaaaiadpdoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaafaaaaaaaaaaaaaaadaaaaaa
afaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheoheaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaagiaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
giaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaagiaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "Reflective/VertexLit"
}