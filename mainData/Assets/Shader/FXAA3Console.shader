Shader "Hidden/FXAA III (Console)" {
Properties {
 _MainTex ("-", 2D) = "white" { }
 _EdgeThresholdMin ("Edge threshold min", Float) = 0.125
 _EdgeThreshold ("Edge Threshold", Float) = 0.25
 _EdgeSharpness ("Edge sharpness", Float) = 4
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 40769
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_TexelSize;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 rcpSize_1;
  vec4 extents_2;
  vec4 tmpvar_3;
  vec2 cse_4;
  cse_4 = (_MainTex_TexelSize.xy * 0.5);
  extents_2.xy = (gl_MultiTexCoord0.xy - cse_4);
  extents_2.zw = (gl_MultiTexCoord0.xy + cse_4);
  rcpSize_1.xy = (-(_MainTex_TexelSize.xy) * 0.5);
  rcpSize_1.zw = cse_4;
  tmpvar_3.xy = (rcpSize_1.xy * 4.0);
  tmpvar_3.zw = (cse_4 * 4.0);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
  xlv_TEXCOORD1 = extents_2;
  xlv_TEXCOORD2 = rcpSize_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _MainTex;
uniform float _EdgeThresholdMin;
uniform float _EdgeThreshold;
uniform float _EdgeSharpness;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec3 tmpvar_1;
  vec2 dir_2;
  float tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (texture2DLod (_MainTex, xlv_TEXCOORD1.xy, 0.0).xyz * unity_ColorSpaceLuminance.xyz);
  tmpvar_3 = (((tmpvar_4.x + tmpvar_4.y) + tmpvar_4.z) + ((2.0 * 
    sqrt((tmpvar_4.y * (tmpvar_4.x + tmpvar_4.z)))
  ) * unity_ColorSpaceLuminance.w));
  float tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6 = (texture2DLod (_MainTex, xlv_TEXCOORD1.xw, 0.0).xyz * unity_ColorSpaceLuminance.xyz);
  tmpvar_5 = (((tmpvar_6.x + tmpvar_6.y) + tmpvar_6.z) + ((2.0 * 
    sqrt((tmpvar_6.y * (tmpvar_6.x + tmpvar_6.z)))
  ) * unity_ColorSpaceLuminance.w));
  vec3 tmpvar_7;
  tmpvar_7 = (texture2DLod (_MainTex, xlv_TEXCOORD1.zy, 0.0).xyz * unity_ColorSpaceLuminance.xyz);
  float tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_9 = (texture2DLod (_MainTex, xlv_TEXCOORD1.zw, 0.0).xyz * unity_ColorSpaceLuminance.xyz);
  tmpvar_8 = (((tmpvar_9.x + tmpvar_9.y) + tmpvar_9.z) + ((2.0 * 
    sqrt((tmpvar_9.y * (tmpvar_9.x + tmpvar_9.z)))
  ) * unity_ColorSpaceLuminance.w));
  vec4 tmpvar_10;
  tmpvar_10 = texture2DLod (_MainTex, xlv_TEXCOORD0, 0.0);
  float tmpvar_11;
  vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_10.xyz * unity_ColorSpaceLuminance.xyz);
  tmpvar_11 = (((tmpvar_12.x + tmpvar_12.y) + tmpvar_12.z) + ((2.0 * 
    sqrt((tmpvar_12.y * (tmpvar_12.x + tmpvar_12.z)))
  ) * unity_ColorSpaceLuminance.w));
  float tmpvar_13;
  tmpvar_13 = (((
    (tmpvar_7.x + tmpvar_7.y)
   + tmpvar_7.z) + (
    (2.0 * sqrt((tmpvar_7.y * (tmpvar_7.x + tmpvar_7.z))))
   * unity_ColorSpaceLuminance.w)) + 0.002604167);
  float tmpvar_14;
  tmpvar_14 = max (max (tmpvar_13, tmpvar_8), max (tmpvar_3, tmpvar_5));
  float tmpvar_15;
  tmpvar_15 = min (min (tmpvar_13, tmpvar_8), min (tmpvar_3, tmpvar_5));
  float tmpvar_16;
  tmpvar_16 = max (_EdgeThresholdMin, (tmpvar_14 * _EdgeThreshold));
  float tmpvar_17;
  tmpvar_17 = (tmpvar_5 - tmpvar_13);
  float tmpvar_18;
  tmpvar_18 = (max (tmpvar_14, tmpvar_11) - min (tmpvar_15, tmpvar_11));
  float tmpvar_19;
  tmpvar_19 = (tmpvar_8 - tmpvar_3);
  if ((tmpvar_18 < tmpvar_16)) {
    tmpvar_1 = tmpvar_10.xyz;
  } else {
    dir_2.x = (tmpvar_17 + tmpvar_19);
    dir_2.y = (tmpvar_17 - tmpvar_19);
    vec2 tmpvar_20;
    tmpvar_20 = normalize(dir_2);
    vec4 tmpvar_21;
    tmpvar_21.zw = vec2(0.0, 0.0);
    tmpvar_21.xy = (xlv_TEXCOORD0 - (tmpvar_20 * xlv_TEXCOORD2.zw));
    vec4 tmpvar_22;
    tmpvar_22.zw = vec2(0.0, 0.0);
    tmpvar_22.xy = (xlv_TEXCOORD0 + (tmpvar_20 * xlv_TEXCOORD2.zw));
    vec2 tmpvar_23;
    tmpvar_23 = clamp ((tmpvar_20 / (
      min (abs(tmpvar_20.x), abs(tmpvar_20.y))
     * _EdgeSharpness)), vec2(-2.0, -2.0), vec2(2.0, 2.0));
    dir_2 = tmpvar_23;
    vec4 tmpvar_24;
    tmpvar_24.zw = vec2(0.0, 0.0);
    tmpvar_24.xy = (xlv_TEXCOORD0 - (tmpvar_23 * xlv_TEXCOORD3.zw));
    vec4 tmpvar_25;
    tmpvar_25.zw = vec2(0.0, 0.0);
    tmpvar_25.xy = (xlv_TEXCOORD0 + (tmpvar_23 * xlv_TEXCOORD3.zw));
    vec3 tmpvar_26;
    tmpvar_26 = (texture2DLod (_MainTex, tmpvar_21.xy, 0.0).xyz + texture2DLod (_MainTex, tmpvar_22.xy, 0.0).xyz);
    vec3 tmpvar_27;
    tmpvar_27 = (((texture2DLod (_MainTex, tmpvar_24.xy, 0.0).xyz + texture2DLod (_MainTex, tmpvar_25.xy, 0.0).xyz) * 0.25) + (tmpvar_26 * 0.25));
    float tmpvar_28;
    vec3 tmpvar_29;
    tmpvar_29 = (tmpvar_26 * unity_ColorSpaceLuminance.xyz);
    tmpvar_28 = (((tmpvar_29.x + tmpvar_29.y) + tmpvar_29.z) + ((2.0 * 
      sqrt((tmpvar_29.y * (tmpvar_29.x + tmpvar_29.z)))
    ) * unity_ColorSpaceLuminance.w));
    bool tmpvar_30;
    if ((tmpvar_28 < tmpvar_15)) {
      tmpvar_30 = bool(1);
    } else {
      vec3 tmpvar_31;
      tmpvar_31 = (tmpvar_27 * unity_ColorSpaceLuminance.xyz);
      tmpvar_30 = (((
        (tmpvar_31.x + tmpvar_31.y)
       + tmpvar_31.z) + (
        (2.0 * sqrt((tmpvar_31.y * (tmpvar_31.x + tmpvar_31.z))))
       * unity_ColorSpaceLuminance.w)) > tmpvar_14);
    };
    if (tmpvar_30) {
      tmpvar_1 = (tmpvar_26 * 0.5);
    } else {
      tmpvar_1 = tmpvar_27;
    };
  };
  vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_1;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_3_0
def c5, -0.5, 0.5, -2, 0
dcl_position v0
dcl_texcoord v1
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mov r0.xy, c4
mad o2.xy, r0, -c5.y, v1
mad o2.zw, r0.xyxy, c5.y, v1.xyxy
mul o4.xy, r0, c5.z
add o4.zw, c4.xyxy, c4.xyxy
mov o1.xy, v1
mul r0, r0.xyxy, c5.xxyy
mov o3, r0

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 112 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedcfjfadhnfkmlccjpdfpnpaaehcfpmdjaabaaaaaafmadaaaaadaaaaaa
cmaaaaaaiaaaaaaacaabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcdeacaaaaeaaaabaainaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaadcaaaaao
dccabaaaacaaaaaaegiacaiaebaaaaaaaaaaaaaaahaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaegbabaaaabaaaaaadcaaaaanmccabaaaacaaaaaa
agiecaaaaaaaaaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
agbebaaaabaaaaaadiaaaaalpcaabaaaaaaaaaaaegiecaaaaaaaaaaaahaaaaaa
aceaaaaaaaaaaalpaaaaaalpaaaaaadpaaaaaadpdgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaldccabaaaaeaaaaaaegiacaaaaaaaaaaaahaaaaaa
aceaaaaaaaaaaamaaaaaaamaaaaaaaaaaaaaaaaaaaaaaaajmccabaaaaeaaaaaa
agiecaaaaaaaaaaaahaaaaaaagiecaaaaaaaaaaaahaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Float 3 [_EdgeSharpness]
Float 2 [_EdgeThreshold]
Float 1 [_EdgeThresholdMin]
Vector 0 [unity_ColorSpaceLuminance]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
def c4, 1, 0, 0.00260416674, -2
def c5, 0.25, 0.5, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2.zw
dcl_texcoord3 v3.zw
dcl_2d s0
mul r0, c4.xxyy, v1.xyxx
texldl_pp r0, r0, s0
mul_pp r0.xyw, r0.xyzz, c0.xyzz
add_pp r0.xw, r0.yyzw, r0.x
mad_pp r0.x, r0.z, c0.z, r0.x
mul_pp r0.y, r0.w, r0.y
rsq_pp r0.y, r0.y
rcp_pp r0.y, r0.y
dp2add_pp r0.x, c0.w, r0.y, r0.x
mul r1, c4.xxyy, v1.xwxx
texldl_pp r1, r1, s0
mul_pp r0.yzw, r1.xxyz, c0.xxyz
add_pp r0.yw, r0.xzzw, r0.y
mad_pp r0.y, r1.z, c0.z, r0.y
mul_pp r0.z, r0.w, r0.z
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp2add_pp r0.y, c0.w, r0.z, r0.y
mul r1, c4.xxyy, v1.zyxx
texldl_pp r1, r1, s0
mul_pp r1.xyw, r1.xyzz, c0.xyzz
add_pp r0.zw, r1.xyyw, r1.x
mad_pp r0.z, r1.z, c0.z, r0.z
mul_pp r0.w, r0.w, r1.y
rsq_pp r0.w, r0.w
rcp_pp r0.w, r0.w
dp2add_pp r0.z, c0.w, r0.w, r0.z
mul r1, c4.xxyy, v1.zwxx
texldl_pp r1, r1, s0
mul_pp r1.xyw, r1.xyzz, c0.xyzz
add_pp r1.xw, r1.yyzw, r1.x
mad_pp r0.w, r1.z, c0.z, r1.x
mul_pp r1.x, r1.w, r1.y
rsq_pp r1.x, r1.x
rcp_pp r1.x, r1.x
dp2add_pp r0.w, c0.w, r1.x, r0.w
mul r1, c4.xxyy, v0.xyxx
texldl_pp r1, r1, s0
mul_pp r2.xyz, r1, c0
add_pp r2.xz, r2.yyzw, r2.x
mad_pp r1.w, r1.z, c0.z, r2.x
mul_pp r2.x, r2.z, r2.y
rsq_pp r2.x, r2.x
rcp_pp r2.x, r2.x
dp2add_pp r1.w, c0.w, r2.x, r1.w
max_pp r2.x, r0.x, r0.y
add_pp r0.z, r0.z, c4.z
min_pp r2.y, r0.y, r0.x
max_pp r2.z, r0.z, r0.w
min_pp r2.w, r0.w, r0.z
max_pp r3.x, r2.z, r2.x
min_pp r3.y, r2.y, r2.w
mul_pp r2.x, r3.x, c2.x
min_pp r2.y, r1.w, r3.y
max_pp r3.z, c1.x, r2.x
max_pp r2.x, r3.x, r1.w
add_pp r1.w, -r2.y, r2.x
if_lt r1.w, r3.z
else
add_pp r0.xy, -r0.xzzw, r0.wyzw
add_pp r2.x, r0.x, r0.y
add_pp r2.y, -r0.x, r0.y
dp2add_pp r0.x, r2, r2, c4.y
rsq_pp r0.x, r0.x
mul_pp r0.xy, r0.x, r2
mov r2.xy, v0
mad r4.xy, r0, -v2.zwzw, r2
mov r4.zw, c4.y
texldl_pp r4, r4, s0
mad r5.xy, r0, v2.zwzw, r2
mov r5.zw, c4.y
texldl_pp r5, r5, s0
min_pp r1.w, r0_abs.y, r0_abs.x
mul_pp r0.z, r1.w, c3.x
rcp r0.z, r0.z
mul_pp r0.xy, r0.z, r0
max_pp r2.zw, r0.xyxy, c4.w
min_pp r0.xy, r2.zwzw, -c4.w
mad r6.xy, r0, -v3.zwzw, r2
mov r6.zw, c4.y
texldl_pp r6, r6, s0
mad r0.xy, r0, v3.zwzw, r2
mov r0.zw, c4.y
texldl_pp r0, r0, s0
add_pp r2.xyz, r4, r5
add_pp r0.xyz, r0, r6
mul_pp r4.xyz, r2, c5.x
mad_pp r0.xyz, r0, c5.x, r4
mul_pp r4.xyz, r2, c0
add_pp r3.zw, r4.xyyz, r4.x
mad_pp r0.w, r2.z, c0.z, r3.z
mul_pp r1.w, r3.w, r4.y
rsq_pp r1.w, r1.w
rcp_pp r1.w, r1.w
dp2add_pp r0.w, c0.w, r1.w, r0.w
add r0.w, -r3.y, r0.w
cmp r0.w, r0.w, c4.y, c4.x
mul_pp r3.yzw, r0.xxyz, c0.xxyz
add_pp r3.yw, r3.xzzw, r3.y
mad_pp r1.w, r0.z, c0.z, r3.y
mul_pp r2.w, r3.w, r3.z
rsq_pp r2.w, r2.w
rcp_pp r2.w, r2.w
dp2add_pp r1.w, c0.w, r2.w, r1.w
add r1.w, -r1.w, r3.x
cmp r1.w, r1.w, c4.y, c4.x
add r0.w, r0.w, r1.w
mul_pp r2.xyz, r2, c5.y
cmp_pp r1.xyz, -r0.w, r0, r2
endif
mov_pp oC0.xyz, r1
mov_pp oC0.w, c4.x

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 128
Vector 48 [unity_ColorSpaceLuminance]
Float 96 [_EdgeThresholdMin]
Float 100 [_EdgeThreshold]
Float 104 [_EdgeSharpness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedemfmimiekokehcanbhmkaccohdjjlnfgabaaaaaafianaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapamaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcfaamaaaaeaaaaaaabeadaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaadmcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
eiaaaaalpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaailcaabaaaaaaaaaaaegaibaaaaaaaaaaa
egiicaaaaaaaaaaaadaaaaaaaaaaaaahjcaabaaaaaaaaaaafganbaaaaaaaaaaa
agaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaackiacaaa
aaaaaaaaadaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
apaaaaaiccaabaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaafgafbaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaeiaaaaal
pcaabaaaabaaaaaamgbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaa
aaaaaaaaadaaaaaaaaaaaaahkcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaa
aaaaaaaadcaaaaakccaabaaaaaaaaaaackaabaaaabaaaaaackiacaaaaaaaaaaa
adaaaaaabkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaapaaaaai
ecaabaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaakgakbaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaeiaaaaalpcaabaaa
abaaaaaaggbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaailcaabaaaabaaaaaaegaibaaaabaaaaaaegiicaaaaaaaaaaa
adaaaaaaaaaaaaahmcaabaaaaaaaaaaafganbaaaabaaaaaaagaabaaaabaaaaaa
dcaaaaakecaabaaaaaaaaaaackaabaaaabaaaaaackiacaaaaaaaaaaaadaaaaaa
ckaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaa
abaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaapaaaaaiicaabaaa
aaaaaaaapgipcaaaaaaaaaaaadaaaaaapgapbaaaaaaaaaaaaaaaaaahecaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaaeiaaaaalpcaabaaaabaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaailcaabaaaabaaaaaaegaibaaaabaaaaaaegiicaaaaaaaaaaaadaaaaaa
aaaaaaahjcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaaabaaaaaadcaaaaak
icaabaaaaaaaaaaackaabaaaabaaaaaackiacaaaaaaaaaaaadaaaaaaakaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaabaaaaaa
elaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaapaaaaaibcaabaaaabaaaaaa
pgipcaaaaaaaaaaaadaaaaaaagaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaaeiaaaaalpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaaaaaaaah
fcaabaaaacaaaaaafgagbaaaacaaaaaaagaabaaaacaaaaaadcaaaaakicaabaaa
abaaaaaackaabaaaabaaaaaackiacaaaaaaaaaaaadaaaaaaakaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaackaabaaaacaaaaaabkaabaaaacaaaaaaelaaaaaf
bcaabaaaacaaaaaaakaabaaaacaaaaaaapaaaaaibcaabaaaacaaaaaapgipcaaa
aaaaaaaaadaaaaaaagaabaaaacaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaklkkckdldeaaaaahfcaabaaaacaaaaaafgahbaaaaaaaaaaaagacbaaa
aaaaaaaaddaaaaahkcaabaaaacaaaaaafganbaaaaaaaaaaaagaibaaaaaaaaaaa
deaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaackaabaaaacaaaaaaddaaaaah
ccaabaaaacaaaaaabkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaaiecaabaaa
acaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaagaaaaaaddaaaaahicaabaaa
acaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaadeaaaaaiecaabaaaacaaaaaa
ckaabaaaacaaaaaaakiacaaaaaaaaaaaagaaaaaadeaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaia
ebaaaaaaacaaaaaadkaabaaaabaaaaaabnaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaackaabaaaacaaaaaabpaaaeaddkaabaaaabaaaaaaaaaaaaaidcaabaaa
aaaaaaaaigaabaiaebaaaaaaaaaaaaaahgapbaaaaaaaaaaaaaaaaaahbcaabaaa
adaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaiccaabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaabaaaadaaaaaa
dcaaaaakmcaabaaaaaaaaaaaagaebaiaebaaaaaaaaaaaaaakgbobaaaadaaaaaa
agbebaaaabaaaaaaeiaaaaalpcaabaaaadaaaaaaogakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaajmcaabaaaaaaaaaaa
agaebaaaaaaaaaaakgbobaaaadaaaaaaagbebaaaabaaaaaaeiaaaaalpcaabaaa
aeaaaaaaogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaaddaaaaajecaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaakaabaia
ibaaaaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaaa
aaaaaaaaagaaaaaaaoaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaakgakbaaa
aaaaaaaadeaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaama
aaaaaamaaaaaaaaaaaaaaaaaddaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaadcaaaaakmcaabaaaaaaaaaaa
agaebaiaebaaaaaaaaaaaaaakgbobaaaaeaaaaaaagbebaaaabaaaaaaeiaaaaal
pcaabaaaafaaaaaaogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaaogbkbaaa
aeaaaaaaegbabaaaabaaaaaaeiaaaaalpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaafaaaaaadiaaaaakhcaabaaaaeaaaaaaegacbaaa
adaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaaaaa
egacbaaaaeaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaaadaaaaaaegiccaaa
aaaaaaaaadaaaaaaaaaaaaahmcaabaaaacaaaaaafgajbaaaaeaaaaaaagaabaaa
aeaaaaaadcaaaaakicaabaaaaaaaaaaackaabaaaadaaaaaackiacaaaaaaaaaaa
adaaaaaackaabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaa
bkaabaaaaeaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaapaaaaai
icaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaapgapbaaaabaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadbaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaaiocaabaaaacaaaaaa
agajbaaaaaaaaaaaagijcaaaaaaaaaaaadaaaaaaaaaaaaahkcaabaaaacaaaaaa
kgaobaaaacaaaaaafgafbaaaacaaaaaadcaaaaakicaabaaaabaaaaaackaabaaa
aaaaaaaackiacaaaaaaaaaaaadaaaaaabkaabaaaacaaaaaadiaaaaahccaabaaa
acaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaaelaaaaafccaabaaaacaaaaaa
bkaabaaaacaaaaaaapaaaaaiccaabaaaacaaaaaapgipcaaaaaaaaaaaadaaaaaa
fgafbaaaacaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaa
acaaaaaadbaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaa
dmaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaak
hcaabaaaacaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaadhaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaabfaaaaabdgaaaaafhccabaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
}
 }
}
Fallback Off
}