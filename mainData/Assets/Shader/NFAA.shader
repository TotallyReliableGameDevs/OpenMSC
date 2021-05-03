Shader "Hidden/NFAA" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
 _BlurTex ("Base (RGB)", 2D) = "white" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 47188
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_TexelSize;
uniform float _OffsetScale;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD0_1;
varying vec2 xlv_TEXCOORD0_2;
varying vec2 xlv_TEXCOORD0_3;
varying vec2 xlv_TEXCOORD0_4;
varying vec2 xlv_TEXCOORD0_5;
varying vec2 xlv_TEXCOORD0_6;
varying vec2 xlv_TEXCOORD0_7;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1.x = 0.0;
  tmpvar_1.y = _MainTex_TexelSize.y;
  vec2 tmpvar_2;
  tmpvar_2 = (tmpvar_1 * _OffsetScale);
  vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = _MainTex_TexelSize.x;
  vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _OffsetScale);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (gl_MultiTexCoord0.xy + tmpvar_2);
  xlv_TEXCOORD0_1 = (gl_MultiTexCoord0.xy - tmpvar_2);
  xlv_TEXCOORD0_2 = (gl_MultiTexCoord0.xy + tmpvar_4);
  xlv_TEXCOORD0_3 = (gl_MultiTexCoord0.xy - tmpvar_4);
  xlv_TEXCOORD0_4 = ((gl_MultiTexCoord0.xy - tmpvar_4) + tmpvar_2);
  xlv_TEXCOORD0_5 = ((gl_MultiTexCoord0.xy - tmpvar_4) - tmpvar_2);
  xlv_TEXCOORD0_6 = ((gl_MultiTexCoord0.xy + tmpvar_4) + tmpvar_2);
  xlv_TEXCOORD0_7 = ((gl_MultiTexCoord0.xy + tmpvar_4) - tmpvar_2);
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _MainTex;
uniform vec4 _MainTex_TexelSize;
uniform float _BlurRadius;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD0_1;
varying vec2 xlv_TEXCOORD0_2;
varying vec2 xlv_TEXCOORD0_3;
varying vec2 xlv_TEXCOORD0_4;
varying vec2 xlv_TEXCOORD0_5;
varying vec2 xlv_TEXCOORD0_6;
varying vec2 xlv_TEXCOORD0_7;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * unity_ColorSpaceLuminance.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0_1).xyz * unity_ColorSpaceLuminance.xyz);
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0_2).xyz * unity_ColorSpaceLuminance.xyz);
  vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0_3).xyz * unity_ColorSpaceLuminance.xyz);
  float tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0_4).xyz * unity_ColorSpaceLuminance.xyz);
  tmpvar_5 = (((tmpvar_6.x + tmpvar_6.y) + tmpvar_6.z) + ((2.0 * 
    sqrt((tmpvar_6.y * (tmpvar_6.x + tmpvar_6.z)))
  ) * unity_ColorSpaceLuminance.w));
  float tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0_5).xyz * unity_ColorSpaceLuminance.xyz);
  tmpvar_7 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) + ((2.0 * 
    sqrt((tmpvar_8.y * (tmpvar_8.x + tmpvar_8.z)))
  ) * unity_ColorSpaceLuminance.w));
  float tmpvar_9;
  vec3 tmpvar_10;
  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0_6).xyz * unity_ColorSpaceLuminance.xyz);
  tmpvar_9 = (((tmpvar_10.x + tmpvar_10.y) + tmpvar_10.z) + ((2.0 * 
    sqrt((tmpvar_10.y * (tmpvar_10.x + tmpvar_10.z)))
  ) * unity_ColorSpaceLuminance.w));
  float tmpvar_11;
  vec3 tmpvar_12;
  tmpvar_12 = (texture2D (_MainTex, xlv_TEXCOORD0_7).xyz * unity_ColorSpaceLuminance.xyz);
  tmpvar_11 = (((tmpvar_12.x + tmpvar_12.y) + tmpvar_12.z) + ((2.0 * 
    sqrt((tmpvar_12.y * (tmpvar_12.x + tmpvar_12.z)))
  ) * unity_ColorSpaceLuminance.w));
  vec3 tmpvar_13;
  tmpvar_13.x = tmpvar_11;
  tmpvar_13.y = (((tmpvar_2.x + tmpvar_2.y) + tmpvar_2.z) + ((2.0 * 
    sqrt((tmpvar_2.y * (tmpvar_2.x + tmpvar_2.z)))
  ) * unity_ColorSpaceLuminance.w));
  tmpvar_13.z = tmpvar_5;
  vec3 tmpvar_14;
  tmpvar_14.x = tmpvar_7;
  tmpvar_14.y = (((tmpvar_1.x + tmpvar_1.y) + tmpvar_1.z) + ((2.0 * 
    sqrt((tmpvar_1.y * (tmpvar_1.x + tmpvar_1.z)))
  ) * unity_ColorSpaceLuminance.w));
  tmpvar_14.z = tmpvar_9;
  vec3 tmpvar_15;
  tmpvar_15.x = tmpvar_5;
  tmpvar_15.y = (((tmpvar_3.x + tmpvar_3.y) + tmpvar_3.z) + ((2.0 * 
    sqrt((tmpvar_3.y * (tmpvar_3.x + tmpvar_3.z)))
  ) * unity_ColorSpaceLuminance.w));
  tmpvar_15.z = tmpvar_7;
  vec3 tmpvar_16;
  tmpvar_16.x = tmpvar_9;
  tmpvar_16.y = (((tmpvar_4.x + tmpvar_4.y) + tmpvar_4.z) + ((2.0 * 
    sqrt((tmpvar_4.y * (tmpvar_4.x + tmpvar_4.z)))
  ) * unity_ColorSpaceLuminance.w));
  tmpvar_16.z = tmpvar_11;
  vec2 tmpvar_17;
  tmpvar_17.x = (dot (vec3(1.0, 1.0, 1.0), tmpvar_13) - dot (vec3(1.0, 1.0, 1.0), tmpvar_14));
  tmpvar_17.y = (dot (vec3(1.0, 1.0, 1.0), tmpvar_16) - dot (vec3(1.0, 1.0, 1.0), tmpvar_15));
  vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * (_MainTex_TexelSize.xy * _BlurRadius));
  vec2 tmpvar_19;
  tmpvar_19 = ((xlv_TEXCOORD0 + xlv_TEXCOORD0_1) * 0.5);
  vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_18.x;
  tmpvar_20.y = -(tmpvar_18.y);
  vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_18.x;
  tmpvar_21.y = -(tmpvar_18.y);
  gl_FragData[0] = (((
    ((texture2D (_MainTex, tmpvar_19) + texture2D (_MainTex, (tmpvar_19 + tmpvar_18))) + texture2D (_MainTex, (tmpvar_19 - tmpvar_18)))
   + texture2D (_MainTex, 
    (tmpvar_19 + tmpvar_20)
  )) + texture2D (_MainTex, (tmpvar_19 - tmpvar_21))) * 0.2);
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
Float 5 [_OffsetScale]
"vs_2_0
def c6, 0, 0, 0, 0
dcl_position v0
dcl_texcoord v1
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mov r0.xy, c4
mul r0.yz, r0.xyxw, c5.x
mov r0.xw, c6.x
add oT0.xy, r0, v1
add oT1.xy, -r0, v1
add r1.xy, -r0.zwzw, v1
add oT4.xy, r0, r1
add oT5.xy, -r0, r1
mov oT3.xy, r1
add r0.zw, r0, v1.xyxy
add oT6.xy, r0, r0.zwzw
add oT7.xy, -r0, r0.zwzw
mov oT2.xy, r0.zwzw

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 96 [_MainTex_TexelSize]
Float 112 [_OffsetScale]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedaklfghanoeplfcpjpkenfgmnpfgdbhahabaaaaaadiaeaaaaadaaaaaa
cmaaaaaaiaaaaaaaiaabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
omaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaomaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaa
omaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaadamaaaaomaaaaaaagaaaaaa
aaaaaaaaadaaaaaaahaaaaaaadamaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaa
aiaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaa
gfaaaaaddccabaaaahaaaaaagfaaaaaddccabaaaaiaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajgcaabaaa
aaaaaaaafgiecaaaaaaaaaaaagaaaaaaagiacaaaaaaaaaaaahaaaaaadgaaaaai
jcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaah
dccabaaaabaaaaaaegaabaaaaaaaaaaaegbabaaaabaaaaaaaaaaaaaidccabaaa
acaaaaaaegaabaiaebaaaaaaaaaaaaaaegbabaaaabaaaaaaaaaaaaahdcaabaaa
abaaaaaaogakbaaaaaaaaaaaegbabaaaabaaaaaadgaaaaafdccabaaaadaaaaaa
egaabaaaabaaaaaaaaaaaaaimcaabaaaaaaaaaaakgaobaiaebaaaaaaaaaaaaaa
agbebaaaabaaaaaadgaaaaafdccabaaaaeaaaaaaogakbaaaaaaaaaaaaaaaaaah
dccabaaaafaaaaaaegaabaaaaaaaaaaaogakbaaaaaaaaaaaaaaaaaaidccabaaa
agaaaaaaegaabaiaebaaaaaaaaaaaaaaogakbaaaaaaaaaaaaaaaaaahdccabaaa
ahaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaaaaaaaaaidccabaaaaiaaaaaa
egaabaiaebaaaaaaaaaaaaaaegaabaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
// Platform d3d9 had shader errors
//   <no keywords>
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 128
Vector 48 [unity_ColorSpaceLuminance]
Vector 96 [_MainTex_TexelSize]
Float 116 [_BlurRadius]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmmccfhphnflgkdilgmglamjfkmfoangbabaaaaaaiaanaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaadadaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcbiamaaaaeaaaaaaaagadaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaaddcbabaaaafaaaaaagcbaaaaddcbabaaa
agaaaaaagcbaaaaddcbabaaaahaaaaaagcbaaaaddcbabaaaaiaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaailcaabaaaaaaaaaaa
egaibaaaaaaaaaaaegiicaaaaaaaaaaaadaaaaaaaaaaaaahjcaabaaaaaaaaaaa
fganbaaaaaaaaaaaagaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaa
ckiacaaaaaaaaaaaadaaaaaaakaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaapaaaaaiccaabaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaa
fgafbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaafaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaailcaabaaaabaaaaaaegaibaaaabaaaaaaegiicaaa
aaaaaaaaadaaaaaaaaaaaaahjcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaa
abaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaakbcaabaaaabaaaaaackaabaaaabaaaaaackiacaaaaaaaaaaaadaaaaaa
akaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaapaaaaai
icaabaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaapgapbaaaaaaaaaaaaaaaaaah
ecaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaafbcaabaaa
aaaaaaaackaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaagaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaailcaabaaaacaaaaaaegaibaaa
acaaaaaaegiicaaaaaaaaaaaadaaaaaaaaaaaaahjcaabaaaacaaaaaafganbaaa
acaaaaaaagaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaa
bkaabaaaacaaaaaadcaaaaakicaabaaaabaaaaaackaabaaaacaaaaaackiacaaa
aaaaaaaaadaaaaaaakaabaaaacaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaapaaaaaiicaabaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaapgapbaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
baaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaailcaabaaaacaaaaaaegaibaaaacaaaaaa
egiicaaaaaaaaaaaadaaaaaaaaaaaaahjcaabaaaacaaaaaafganbaaaacaaaaaa
agaabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaabkaabaaa
acaaaaaadcaaaaakbcaabaaaacaaaaaackaabaaaacaaaaaackiacaaaaaaaaaaa
adaaaaaaakaabaaaacaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
apaaaaaiicaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaapgapbaaaabaaaaaa
aaaaaaahccaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaefaaaaaj
pcaabaaaadaaaaaaegbabaaaahaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaailcaabaaaadaaaaaaegaibaaaadaaaaaaegiicaaaaaaaaaaaadaaaaaa
aaaaaaahjcaabaaaadaaaaaafganbaaaadaaaaaaagaabaaaadaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaakicaabaaa
acaaaaaackaabaaaadaaaaaackiacaaaaaaaaaaaadaaaaaaakaabaaaadaaaaaa
elaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaapaaaaaiicaabaaaabaaaaaa
pgipcaaaaaaaaaaaadaaaaaapgapbaaaabaaaaaaaaaaaaahccaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaadgaaaaafbcaabaaaacaaaaaabkaabaaa
aaaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaaiaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaailcaabaaaadaaaaaaegaibaaaadaaaaaaegiicaaa
aaaaaaaaadaaaaaaaaaaaaahjcaabaaaadaaaaaafganbaaaadaaaaaaagaabaaa
adaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaakicaabaaaacaaaaaackaabaaaadaaaaaackiacaaaaaaaaaaaadaaaaaa
akaabaaaadaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaapaaaaai
icaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaapgapbaaaabaaaaaaaaaaaaah
bcaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaadgaaaaafecaabaaa
acaaaaaaakaabaaaabaaaaaabaaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaegacbaaaacaaaaaaaaaaaaaiccaabaaaacaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaailcaabaaa
adaaaaaaegaibaaaadaaaaaaegiicaaaaaaaaaaaadaaaaaaaaaaaaahmcaabaaa
acaaaaaafganbaaaadaaaaaaagaabaaaadaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaakicaabaaaabaaaaaackaabaaa
adaaaaaackiacaaaaaaaaaaaadaaaaaackaabaaaacaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaapaaaaaiicaabaaaaaaaaaaapgipcaaaaaaaaaaa
adaaaaaapgapbaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaabaaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaailcaabaaaabaaaaaa
egaibaaaabaaaaaaegiicaaaaaaaaaaaadaaaaaaaaaaaaahjcaabaaaabaaaaaa
fganbaaaabaaaaaaagaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackaabaaaabaaaaaa
ckiacaaaaaaaaaaaadaaaaaaakaabaaaabaaaaaaelaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaaapaaaaaiccaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaa
fgafbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaabaaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaibcaabaaaacaaaaaaakaabaiaebaaaaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaajdcaabaaaaaaaaaaaegiacaaaaaaaaaaa
agaaaaaafgifcaaaaaaaaaaaahaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegaabaaaacaaaaaaaaaaaaahdcaabaaaabaaaaaaegbabaaaabaaaaaa
egbabaaaacaaaaaadcaaaaammcaabaaaabaaaaaaagaebaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpagaebaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaak
mcaabaaaabaaaaaaagaebaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpefaaaaajpcaabaaaadaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaadcaaaaanmcaabaaaabaaaaaaagaebaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpagaebaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaa
adaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaadgaaaaagecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaamkcaabaaaaaaaaaaaagaebaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaaaaaaaaaadpagaibaaaaaaaaaaa
dcaaaaanfcaabaaaaaaaaaaaagabbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaaaaagacbaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
igaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaangafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaahpcaabaaa
aaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakpccabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaamnmmemdomnmmemdomnmmemdomnmmemdodoaaaaab
"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 70803
Program "vp" {
// Platform d3d9 skipped due to earlier errors
// Platform d3d9 skipped due to earlier errors
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_TexelSize;
uniform float _OffsetScale;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD0_1;
varying vec2 xlv_TEXCOORD0_2;
varying vec2 xlv_TEXCOORD0_3;
varying vec2 xlv_TEXCOORD0_4;
varying vec2 xlv_TEXCOORD0_5;
varying vec2 xlv_TEXCOORD0_6;
varying vec2 xlv_TEXCOORD0_7;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1.x = 0.0;
  tmpvar_1.y = _MainTex_TexelSize.y;
  vec2 tmpvar_2;
  tmpvar_2 = (tmpvar_1 * _OffsetScale);
  vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = _MainTex_TexelSize.x;
  vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _OffsetScale);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (gl_MultiTexCoord0.xy + tmpvar_2);
  xlv_TEXCOORD0_1 = (gl_MultiTexCoord0.xy - tmpvar_2);
  xlv_TEXCOORD0_2 = (gl_MultiTexCoord0.xy + tmpvar_4);
  xlv_TEXCOORD0_3 = (gl_MultiTexCoord0.xy - tmpvar_4);
  xlv_TEXCOORD0_4 = ((gl_MultiTexCoord0.xy - tmpvar_4) + tmpvar_2);
  xlv_TEXCOORD0_5 = ((gl_MultiTexCoord0.xy - tmpvar_4) - tmpvar_2);
  xlv_TEXCOORD0_6 = ((gl_MultiTexCoord0.xy + tmpvar_4) + tmpvar_2);
  xlv_TEXCOORD0_7 = ((gl_MultiTexCoord0.xy + tmpvar_4) - tmpvar_2);
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _MainTex;
uniform float _BlurRadius;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD0_1;
varying vec2 xlv_TEXCOORD0_2;
varying vec2 xlv_TEXCOORD0_3;
varying vec2 xlv_TEXCOORD0_4;
varying vec2 xlv_TEXCOORD0_5;
varying vec2 xlv_TEXCOORD0_6;
varying vec2 xlv_TEXCOORD0_7;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * unity_ColorSpaceLuminance.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0_1).xyz * unity_ColorSpaceLuminance.xyz);
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0_2).xyz * unity_ColorSpaceLuminance.xyz);
  vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0_3).xyz * unity_ColorSpaceLuminance.xyz);
  float tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0_4).xyz * unity_ColorSpaceLuminance.xyz);
  tmpvar_5 = (((tmpvar_6.x + tmpvar_6.y) + tmpvar_6.z) + ((2.0 * 
    sqrt((tmpvar_6.y * (tmpvar_6.x + tmpvar_6.z)))
  ) * unity_ColorSpaceLuminance.w));
  float tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0_5).xyz * unity_ColorSpaceLuminance.xyz);
  tmpvar_7 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) + ((2.0 * 
    sqrt((tmpvar_8.y * (tmpvar_8.x + tmpvar_8.z)))
  ) * unity_ColorSpaceLuminance.w));
  float tmpvar_9;
  vec3 tmpvar_10;
  tmpvar_10 = (texture2D (_MainTex, xlv_TEXCOORD0_6).xyz * unity_ColorSpaceLuminance.xyz);
  tmpvar_9 = (((tmpvar_10.x + tmpvar_10.y) + tmpvar_10.z) + ((2.0 * 
    sqrt((tmpvar_10.y * (tmpvar_10.x + tmpvar_10.z)))
  ) * unity_ColorSpaceLuminance.w));
  float tmpvar_11;
  vec3 tmpvar_12;
  tmpvar_12 = (texture2D (_MainTex, xlv_TEXCOORD0_7).xyz * unity_ColorSpaceLuminance.xyz);
  tmpvar_11 = (((tmpvar_12.x + tmpvar_12.y) + tmpvar_12.z) + ((2.0 * 
    sqrt((tmpvar_12.y * (tmpvar_12.x + tmpvar_12.z)))
  ) * unity_ColorSpaceLuminance.w));
  vec3 tmpvar_13;
  tmpvar_13.x = tmpvar_11;
  tmpvar_13.y = (((tmpvar_2.x + tmpvar_2.y) + tmpvar_2.z) + ((2.0 * 
    sqrt((tmpvar_2.y * (tmpvar_2.x + tmpvar_2.z)))
  ) * unity_ColorSpaceLuminance.w));
  tmpvar_13.z = tmpvar_5;
  vec3 tmpvar_14;
  tmpvar_14.x = tmpvar_7;
  tmpvar_14.y = (((tmpvar_1.x + tmpvar_1.y) + tmpvar_1.z) + ((2.0 * 
    sqrt((tmpvar_1.y * (tmpvar_1.x + tmpvar_1.z)))
  ) * unity_ColorSpaceLuminance.w));
  tmpvar_14.z = tmpvar_9;
  vec3 tmpvar_15;
  tmpvar_15.x = tmpvar_5;
  tmpvar_15.y = (((tmpvar_3.x + tmpvar_3.y) + tmpvar_3.z) + ((2.0 * 
    sqrt((tmpvar_3.y * (tmpvar_3.x + tmpvar_3.z)))
  ) * unity_ColorSpaceLuminance.w));
  tmpvar_15.z = tmpvar_7;
  vec3 tmpvar_16;
  tmpvar_16.x = tmpvar_9;
  tmpvar_16.y = (((tmpvar_4.x + tmpvar_4.y) + tmpvar_4.z) + ((2.0 * 
    sqrt((tmpvar_4.y * (tmpvar_4.x + tmpvar_4.z)))
  ) * unity_ColorSpaceLuminance.w));
  tmpvar_16.z = tmpvar_11;
  vec2 tmpvar_17;
  tmpvar_17.x = (dot (vec3(1.0, 1.0, 1.0), tmpvar_13) - dot (vec3(1.0, 1.0, 1.0), tmpvar_14));
  tmpvar_17.y = (dot (vec3(1.0, 1.0, 1.0), tmpvar_16) - dot (vec3(1.0, 1.0, 1.0), tmpvar_15));
  vec3 tmpvar_18;
  tmpvar_18.z = 1.0;
  tmpvar_18.xy = (tmpvar_17 * _BlurRadius);
  vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = normalize(((tmpvar_18 * 0.5) + 0.5));
  gl_FragData[0] = tmpvar_19;
}


#endif
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 96 [_MainTex_TexelSize]
Float 112 [_OffsetScale]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedaklfghanoeplfcpjpkenfgmnpfgdbhahabaaaaaadiaeaaaaadaaaaaa
cmaaaaaaiaaaaaaaiaabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
omaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaomaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaaomaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaa
omaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaadamaaaaomaaaaaaagaaaaaa
aaaaaaaaadaaaaaaahaaaaaaadamaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaa
aiaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaa
gfaaaaaddccabaaaahaaaaaagfaaaaaddccabaaaaiaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajgcaabaaa
aaaaaaaafgiecaaaaaaaaaaaagaaaaaaagiacaaaaaaaaaaaahaaaaaadgaaaaai
jcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaah
dccabaaaabaaaaaaegaabaaaaaaaaaaaegbabaaaabaaaaaaaaaaaaaidccabaaa
acaaaaaaegaabaiaebaaaaaaaaaaaaaaegbabaaaabaaaaaaaaaaaaahdcaabaaa
abaaaaaaogakbaaaaaaaaaaaegbabaaaabaaaaaadgaaaaafdccabaaaadaaaaaa
egaabaaaabaaaaaaaaaaaaaimcaabaaaaaaaaaaakgaobaiaebaaaaaaaaaaaaaa
agbebaaaabaaaaaadgaaaaafdccabaaaaeaaaaaaogakbaaaaaaaaaaaaaaaaaah
dccabaaaafaaaaaaegaabaaaaaaaaaaaogakbaaaaaaaaaaaaaaaaaaidccabaaa
agaaaaaaegaabaiaebaaaaaaaaaaaaaaogakbaaaaaaaaaaaaaaaaaahdccabaaa
ahaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaaaaaaaaaidccabaaaaiaaaaaa
egaabaiaebaaaaaaaaaaaaaaegaabaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
// Platform d3d9 skipped due to earlier errors
// Platform d3d9 had shader errors
//   <no keywords>
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 128
Vector 48 [unity_ColorSpaceLuminance]
Float 116 [_BlurRadius]
BindCB  "$Globals" 0
"ps_4_0
eefieceddnalgnfflakooohlgleikpngkihhnhhgabaaaaaalealaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaadadaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcemakaaaaeaaaaaaajdacaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaaddcbabaaaafaaaaaagcbaaaaddcbabaaa
agaaaaaagcbaaaaddcbabaaaahaaaaaagcbaaaaddcbabaaaaiaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaailcaabaaaaaaaaaaa
egaibaaaaaaaaaaaegiicaaaaaaaaaaaadaaaaaaaaaaaaahjcaabaaaaaaaaaaa
fganbaaaaaaaaaaaagaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaa
ckiacaaaaaaaaaaaadaaaaaaakaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaapaaaaaiccaabaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaa
fgafbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaafaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaailcaabaaaabaaaaaaegaibaaaabaaaaaaegiicaaa
aaaaaaaaadaaaaaaaaaaaaahjcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaa
abaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaakbcaabaaaabaaaaaackaabaaaabaaaaaackiacaaaaaaaaaaaadaaaaaa
akaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaapaaaaai
icaabaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaapgapbaaaaaaaaaaaaaaaaaah
ecaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadgaaaaafbcaabaaa
aaaaaaaackaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaagaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaailcaabaaaacaaaaaaegaibaaa
acaaaaaaegiicaaaaaaaaaaaadaaaaaaaaaaaaahjcaabaaaacaaaaaafganbaaa
acaaaaaaagaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaa
bkaabaaaacaaaaaadcaaaaakicaabaaaabaaaaaackaabaaaacaaaaaackiacaaa
aaaaaaaaadaaaaaaakaabaaaacaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaapaaaaaiicaabaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaapgapbaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
baaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaailcaabaaaacaaaaaaegaibaaaacaaaaaa
egiicaaaaaaaaaaaadaaaaaaaaaaaaahjcaabaaaacaaaaaafganbaaaacaaaaaa
agaabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaabkaabaaa
acaaaaaadcaaaaakbcaabaaaacaaaaaackaabaaaacaaaaaackiacaaaaaaaaaaa
adaaaaaaakaabaaaacaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
apaaaaaiicaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaapgapbaaaabaaaaaa
aaaaaaahccaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaefaaaaaj
pcaabaaaadaaaaaaegbabaaaahaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaailcaabaaaadaaaaaaegaibaaaadaaaaaaegiicaaaaaaaaaaaadaaaaaa
aaaaaaahjcaabaaaadaaaaaafganbaaaadaaaaaaagaabaaaadaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaakicaabaaa
acaaaaaackaabaaaadaaaaaackiacaaaaaaaaaaaadaaaaaaakaabaaaadaaaaaa
elaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaapaaaaaiicaabaaaabaaaaaa
pgipcaaaaaaaaaaaadaaaaaapgapbaaaabaaaaaaaaaaaaahccaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaadgaaaaafbcaabaaaacaaaaaabkaabaaa
aaaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaaiaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaailcaabaaaadaaaaaaegaibaaaadaaaaaaegiicaaa
aaaaaaaaadaaaaaaaaaaaaahjcaabaaaadaaaaaafganbaaaadaaaaaaagaabaaa
adaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaakicaabaaaacaaaaaackaabaaaadaaaaaackiacaaaaaaaaaaaadaaaaaa
akaabaaaadaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaapaaaaai
icaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaapgapbaaaabaaaaaaaaaaaaah
bcaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaadgaaaaafecaabaaa
acaaaaaaakaabaaaabaaaaaabaaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaegacbaaaacaaaaaaaaaaaaaiccaabaaaacaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaailcaabaaa
adaaaaaaegaibaaaadaaaaaaegiicaaaaaaaaaaaadaaaaaaaaaaaaahmcaabaaa
acaaaaaafganbaaaadaaaaaaagaabaaaadaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaakicaabaaaabaaaaaackaabaaa
adaaaaaackiacaaaaaaaaaaaadaaaaaackaabaaaacaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaapaaaaaiicaabaaaaaaaaaaapgipcaaaaaaaaaaa
adaaaaaapgapbaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaabaaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaailcaabaaaabaaaaaa
egaibaaaabaaaaaaegiicaaaaaaaaaaaadaaaaaaaaaaaaahjcaabaaaabaaaaaa
fganbaaaabaaaaaaagaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackaabaaaabaaaaaa
ckiacaaaaaaaaaaaadaaaaaaakaabaaaabaaaaaaelaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaaapaaaaaiccaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaa
fgafbaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaabaaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaibcaabaaaacaaaaaaakaabaiaebaaaaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaaacaaaaaa
fgifcaaaaaaaaaaaahaaaaaadiaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadgaaaaafecaabaaaaaaaaaaa
abeaaaaaaaaaaadpaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
}
 }
}
Fallback Off
}