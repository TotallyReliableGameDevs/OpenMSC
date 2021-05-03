Shader "Hidden/SSAA" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 35699
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_TexelSize;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD0_1;
varying vec2 xlv_TEXCOORD0_2;
varying vec2 xlv_TEXCOORD0_3;
varying vec2 xlv_TEXCOORD0_4;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1.x = 0.0;
  tmpvar_1.y = _MainTex_TexelSize.y;
  vec2 tmpvar_2;
  tmpvar_2 = (tmpvar_1 * 1.75);
  vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = _MainTex_TexelSize.x;
  vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 1.75);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (gl_MultiTexCoord0.xy - tmpvar_2);
  xlv_TEXCOORD0_1 = (gl_MultiTexCoord0.xy - tmpvar_4);
  xlv_TEXCOORD0_2 = (gl_MultiTexCoord0.xy + tmpvar_4);
  xlv_TEXCOORD0_3 = (gl_MultiTexCoord0.xy + tmpvar_2);
  xlv_TEXCOORD0_4 = gl_MultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _MainTex;
uniform vec4 _MainTex_TexelSize;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD0_1;
varying vec2 xlv_TEXCOORD0_2;
varying vec2 xlv_TEXCOORD0_3;
varying vec2 xlv_TEXCOORD0_4;
void main ()
{
  vec4 outColor_1;
  vec3 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, xlv_TEXCOORD0).xyz * unity_ColorSpaceLuminance.xyz);
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0_1).xyz * unity_ColorSpaceLuminance.xyz);
  vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0_2).xyz * unity_ColorSpaceLuminance.xyz);
  vec3 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0_3).xyz * unity_ColorSpaceLuminance.xyz);
  vec2 tmpvar_6;
  tmpvar_6.x = (((
    (tmpvar_5.x + tmpvar_5.y)
   + tmpvar_5.z) + (
    (2.0 * sqrt((tmpvar_5.y * (tmpvar_5.x + tmpvar_5.z))))
   * unity_ColorSpaceLuminance.w)) - ((
    (tmpvar_2.x + tmpvar_2.y)
   + tmpvar_2.z) + (
    (2.0 * sqrt((tmpvar_2.y * (tmpvar_2.x + tmpvar_2.z))))
   * unity_ColorSpaceLuminance.w)));
  tmpvar_6.y = (((
    (tmpvar_4.x + tmpvar_4.y)
   + tmpvar_4.z) + (
    (2.0 * sqrt((tmpvar_4.y * (tmpvar_4.x + tmpvar_4.z))))
   * unity_ColorSpaceLuminance.w)) - ((
    (tmpvar_3.x + tmpvar_3.y)
   + tmpvar_3.z) + (
    (2.0 * sqrt((tmpvar_3.y * (tmpvar_3.x + tmpvar_3.z))))
   * unity_ColorSpaceLuminance.w)));
  float tmpvar_7;
  tmpvar_7 = sqrt(dot (tmpvar_6, tmpvar_6));
  if ((tmpvar_7 < 0.0625)) {
    outColor_1 = texture2D (_MainTex, xlv_TEXCOORD0_4);
  } else {
    vec2 tmpvar_8;
    tmpvar_8 = (tmpvar_6 * (_MainTex_TexelSize.xy / tmpvar_7));
    outColor_1 = (((
      ((texture2D (_MainTex, xlv_TEXCOORD0_4) + (texture2D (_MainTex, (xlv_TEXCOORD0_4 + 
        (tmpvar_8 * 0.5)
      )) * 0.9)) + (texture2D (_MainTex, (xlv_TEXCOORD0_4 - (tmpvar_8 * 0.5))) * 0.9))
     + 
      (texture2D (_MainTex, (xlv_TEXCOORD0_4 + tmpvar_8)) * 0.75)
    ) + (texture2D (_MainTex, 
      (xlv_TEXCOORD0_4 - tmpvar_8)
    ) * 0.75)) / 4.3);
  };
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
def c5, 1.75, 0, 0, 0
dcl_position v0
dcl_texcoord v1
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mov r0.x, c5.x
mul r0.yz, r0.x, c4.xyxw
mov r0.xw, c5.y
add oT0.xy, -r0, v1
add oT1.xy, -r0.zwzw, v1
add oT2.xy, r0.zwzw, v1
add oT3.xy, r0, v1
mov oT4.xy, v1

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 112
Vector 96 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedbcbcdikeikndlpnppbolmlnpdkfjiefnabaaaaaaeiadaaaaadaaaaaa
cmaaaaaaiaaaaaaadiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcaiacaaaa
eaaaabaaicaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaaddccabaaaafaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaalgcaabaaaaaaaaaaafgiecaaaaaaaaaaa
agaaaaaaaceaaaaaaaaaaaaaaaaaoadpaaaaoadpaaaaaaaadgaaaaaijcaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaidccabaaa
abaaaaaaegaabaiaebaaaaaaaaaaaaaaegbabaaaabaaaaaaaaaaaaaidccabaaa
acaaaaaaogakbaiaebaaaaaaaaaaaaaaegbabaaaabaaaaaaaaaaaaahdccabaaa
adaaaaaaogakbaaaaaaaaaaaegbabaaaabaaaaaaaaaaaaahdccabaaaaeaaaaaa
egaabaaaaaaaaaaaegbabaaaabaaaaaadgaaaaafdccabaaaafaaaaaaegbabaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 112
Vector 96 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedagpmhbdifloabfljadfmejmbaeighgkoabaaaaaakmaeaaaaaeaaaaaa
daaaaaaajaabaaaakaadaaaapeadaaaaebgpgodjfiabaaaafiabaaaaaaacpopp
biabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaagaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaoadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaafaaaaadaaaaagia
aaaaaaiaabaamekaabaaaaacaaaaajiaagaaffkaacaaaaadaaaaadoaaaaaoeib
abaaoejaacaaaaadabaaadoaaaaaooibabaaoejaacaaaaadacaaadoaaaaaooia
abaaoejaacaaaaadadaaadoaaaaaoeiaabaaoejaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacaeaaadoaabaaoejappppaaaafdeieefcaiacaaaaeaaaabaaicaaaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaaddccabaaa
afaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaalgcaabaaaaaaaaaaafgiecaaaaaaaaaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaoadpaaaaoadpaaaaaaaadgaaaaaijcaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaidccabaaaabaaaaaaegaabaia
ebaaaaaaaaaaaaaaegbabaaaabaaaaaaaaaaaaaidccabaaaacaaaaaaogakbaia
ebaaaaaaaaaaaaaaegbabaaaabaaaaaaaaaaaaahdccabaaaadaaaaaaogakbaaa
aaaaaaaaegbabaaaabaaaaaaaaaaaaahdccabaaaaeaaaaaaegaabaaaaaaaaaaa
egbabaaaabaaaaaadgaaaaafdccabaaaafaaaaaaegbabaaaabaaaaaadoaaaaab
ejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
faepfdejfeejepeoaafeeffiedepepfceeaaklklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 1 [_MainTex_TexelSize]
Vector 0 [unity_ColorSpaceLuminance]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c2, 2, 0, -0.0625, 0.5
def c3, 0.899999976, 0.75, 0.232558131, 0
dcl t0.xy
dcl t1.xy
dcl t2.xy
dcl t3.xy
dcl t4.xy
dcl_2d s0
texld_pp r0, t0, s0
texld_pp r1, t3, s0
texld_pp r2, t1, s0
texld_pp r3, t2, s0
mul_pp r4.xyz, r0, c0
add_pp r1.w, r4.z, r4.x
mul_pp r1.w, r1.w, r4.y
add_pp r2.w, r4.y, r4.x
mad_pp r2.w, r0.z, c0.z, r2.w
rsq_pp r1.w, r1.w
rcp_pp r1.w, r1.w
mul_pp r1.w, r1.w, c0.w
mad_pp r1.w, r1.w, c2.x, r2.w
mul_pp r0.xyz, r1, c0
add_pp r2.w, r0.z, r0.x
mul_pp r2.w, r0.y, r2.w
add_pp r3.w, r0.y, r0.x
mad_pp r3.w, r1.z, c0.z, r3.w
rsq_pp r2.w, r2.w
rcp_pp r2.w, r2.w
mul_pp r2.w, r2.w, c0.w
mad_pp r2.w, r2.w, c2.x, r3.w
add_pp r2.w, r1.w, -r2.w
mov_pp r0.x, -r2.w
mul_pp r1.xyz, r2, c0
add_pp r3.w, r1.z, r1.x
mul_pp r3.w, r1.y, r3.w
add_pp r0.z, r1.y, r1.x
mad_pp r0.z, r2.z, c0.z, r0.z
rsq_pp r0.w, r3.w
rcp_pp r0.w, r0.w
mul_pp r0.w, r0.w, c0.w
mad_pp r3.w, r0.w, c2.x, r0.z
mul_pp r1.xyz, r3, c0
add_pp r0.z, r1.z, r1.x
mul_pp r0.z, r0.z, r1.y
add_pp r0.w, r1.y, r1.x
mad_pp r0.w, r3.z, c0.z, r0.w
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
mul_pp r0.z, r0.z, c0.w
mad_pp r0.z, r0.z, c2.x, r0.w
add_pp r0.y, -r3.w, r0.z
dp2add_pp r0.z, r0, r0, c2.y
rsq_pp r0.z, r0.z
mul r1.xy, r0.z, c1
rcp r0.z, r0.z
add r0.z, r0.z, c2.z
mad r2.xy, r0, r1, t4
mul_pp r1.zw, r0.wzyx, r1.wzyx
mad r0.xy, r0, -r1, t4
mad r1.xy, r1.wzyx, -c2.w, t4
mad r3.xy, r1.wzyx, c2.w, t4
texld r2, r2, s0
texld r4, r0, s0
texld r3, r3, s0
texld r1, r1, s0
texld_pp r5, t4, s0
mad_pp r3, r3, c3.x, r5
mad_pp r1, r1, c3.x, r3
mad_pp r1, r2, c3.y, r1
mad_pp r1, r4, c3.y, r1
mul_pp r1, r1, c3.z
cmp_pp r0, r0.z, r1, r5
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 48 [unity_ColorSpaceLuminance]
Vector 96 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgfikoiecnjaaajingcdeighjmkmmcagkabaaaaaanmaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclmahaaaa
eaaaaaaaopabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaa
aeaaaaaagcbaaaaddcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
afaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaailcaabaaaaaaaaaaaegaibaaaaaaaaaaaegiicaaa
aaaaaaaaadaaaaaaaaaaaaahjcaabaaaaaaaaaaafganbaaaaaaaaaaaagaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaa
adaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaapaaaaai
ccaabaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaafgafbaaaaaaaaaaaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
ocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaadaaaaaaaaaaaaah
kcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaackaabaaaabaaaaaackiacaaaaaaaaaaaadaaaaaabkaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaaapaaaaaiecaabaaaaaaaaaaapgipcaaa
aaaaaaaaadaaaaaakgakbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaailcaabaaaabaaaaaaegaibaaa
abaaaaaaegiicaaaaaaaaaaaadaaaaaaaaaaaaahmcaabaaaaaaaaaaafganbaaa
abaaaaaaagaabaaaabaaaaaadcaaaaakecaabaaaaaaaaaaackaabaaaabaaaaaa
ckiacaaaaaaaaaaaadaaaaaackaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaapaaaaaiicaabaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaapgapbaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaailcaabaaaabaaaaaaegaibaaaabaaaaaaegiicaaaaaaaaaaa
adaaaaaaaaaaaaahjcaabaaaabaaaaaafganbaaaabaaaaaaagaabaaaabaaaaaa
dcaaaaakicaabaaaaaaaaaaackaabaaaabaaaaaackiacaaaaaaaaaaaadaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaapaaaaaibcaabaaa
abaaaaaapgipcaaaaaaaaaaaadaaaaaaagaabaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaagbcaabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaaaaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaabaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadbaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadnaoaaaaaifcaabaaa
aaaaaaaaagibcaaaaaaaaaaaagaaaaaaagaabaaaaaaaaaaadiaaaaahmcaabaaa
abaaaaaaagaibaaaaaaaaaaaagaebaaaabaaaaaadcaaaaamdcaabaaaacaaaaaa
ogakbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaegbabaaa
afaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaanmcaabaaaabaaaaaakgaobaiaebaaaaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpagbebaaaafaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajmcaabaaaabaaaaaaagaebaaaabaaaaaaagaibaaaaaaaaaaaagbebaaa
afaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaakfcaabaaaaaaaaaaaagabbaiaebaaaaaaabaaaaaa
agacbaaaaaaaaaaaagbbbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaigaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabpaaaeadbkaabaaaaaaaaaaa
efaaaaajpccabaaaaaaaaaaaegbabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaabcaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaaafaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaacaaaaaa
aceaaaaaggggggdpggggggdpggggggdpggggggdpegaobaaaaaaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaaggggggdpggggggdpggggggdp
ggggggdpegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaaeaaaaaa
aceaaaaaaaaaeadpaaaaeadpaaaaeadpaaaaeadpegaobaaaaaaaaaaadcaaaaam
pcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaeadpaaaaeadpaaaaeadp
aaaaeadpegaobaaaaaaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaalicdgodolicdgodolicdgodolicdgodobfaaaaabdoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 48 [unity_ColorSpaceLuminance]
Vector 96 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedafciodibkhljhilncailoohcghciohamabaaaaaabaajaaaaaeaaaaaa
daaaaaaacaadaaaaceaiaaaanmaiaaaaebgpgodjoiacaaaaoiacaaaaaaacpppp
kiacaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaadaaabaaaaaaaaaaaaaaaaaaagaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaaaaaaaaaialnaaaaaadpggggggdpfbaaaaafadaaapkaaaaaeadp
licdgodoaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaia
abaaadlabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaaadlabpaaaaac
aaaaaaiaaeaaadlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpiaaaaaoela
aaaioekaecaaaaadabaacpiaadaaoelaaaaioekaecaaaaadacaacpiaabaaoela
aaaioekaecaaaaadadaacpiaacaaoelaaaaioekaaiaaaaadabaaciiaaaaaoeia
aaaaoekaaiaaaaadacaaciiaabaaoeiaaaaaoekaacaaaaadacaaciiaabaappia
acaappibabaaaaacaaaacbiaacaappibaiaaaaadadaaciiaacaaoeiaaaaaoeka
aiaaaaadaaaaceiaadaaoeiaaaaaoekaacaaaaadaaaacciaadaappibaaaakkia
fkaaaaaeaaaaceiaaaaaoeiaaaaaoeiaacaaaakaahaaaaacaaaaceiaaaaakkia
afaaaaadabaaadiaaaaakkiaabaaoekaagaaaaacaaaaaeiaaaaakkiaacaaaaad
aaaaaeiaaaaakkiaacaaffkaafaaaaadabaacmiaaaaabliaabaabliaaeaaaaae
acaaadiaabaabliaacaakkkbaeaaoelaaeaaaaaeadaaadiaabaabliaacaakkka
aeaaoelaaeaaaaaeaeaaadiaaaaaoeiaabaaoeiaaeaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoeibaeaaoelaecaaaaadabaaapiaadaaoeiaaaaioekaecaaaaad
acaaapiaacaaoeiaaaaioekaecaaaaadadaacpiaaeaaoelaaaaioekaecaaaaad
afaaapiaaaaaoeiaaaaioekaecaaaaadaeaaapiaaeaaoeiaaaaioekaaeaaaaae
abaacpiaabaaoeiaacaappkaadaaoeiaaeaaaaaeabaacpiaacaaoeiaacaappka
abaaoeiaaeaaaaaeabaacpiaaeaaoeiaadaaaakaabaaoeiaaeaaaaaeabaacpia
afaaoeiaadaaaakaabaaoeiaafaaaaadabaacpiaabaaoeiaadaaffkafiaaaaae
aaaacpiaaaaakkiaabaaoeiaadaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcpmaeaaaaeaaaaaaadpabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaaddcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaaiccaabaaaaaaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaaiecaabaaa
aaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaai
icaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaaaaaaaai
bcaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaag
bcaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaaaaaaaaaiccaabaaaabaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
egaabaaaabaaaaaaegaabaaaabaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadbaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadn
aoaaaaaifcaabaaaaaaaaaaaagibcaaaaaaaaaaaagaaaaaaagaabaaaaaaaaaaa
diaaaaahmcaabaaaabaaaaaaagaibaaaaaaaaaaaagaebaaaabaaaaaadcaaaaam
dcaabaaaacaaaaaaogakbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaaegbabaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaanmcaabaaaabaaaaaakgaobaia
ebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpagbebaaa
afaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajmcaabaaaabaaaaaaagaebaaaabaaaaaaagaibaaa
aaaaaaaaagbebaaaafaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaakfcaabaaaaaaaaaaaagabbaia
ebaaaaaaabaaaaaaagacbaaaaaaaaaaaagbbbaaaafaaaaaaefaaaaajpcaabaaa
abaaaaaaigaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabpaaaead
bkaabaaaaaaaaaaaefaaaaajpccabaaaaaaaaaaaegbabaaaafaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaabcaaaaabefaaaaajpcaabaaaaaaaaaaaegbabaaa
afaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaacaaaaaaaceaaaaaggggggdpggggggdpggggggdpggggggdpegaobaaa
aaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaadaaaaaaaceaaaaaggggggdp
ggggggdpggggggdpggggggdpegaobaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaa
egaobaaaaeaaaaaaaceaaaaaaaaaeadpaaaaeadpaaaaeadpaaaaeadpegaobaaa
aaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaeadp
aaaaeadpaaaaeadpaaaaeadpegaobaaaaaaaaaaadiaaaaakpccabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaalicdgodolicdgodolicdgodolicdgodobfaaaaab
doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}