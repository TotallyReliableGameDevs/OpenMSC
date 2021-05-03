Shader "Hidden/ColorCorrectionCurves" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "" { }
 _RgbTex ("_RgbTex (RGB)", 2D) = "" { }
 _ZCurve ("_ZCurve (RGB)", 2D) = "" { }
 _RgbDepthTex ("_RgbDepthTex (RGB)", 2D) = "" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 50618
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform vec4 _CameraDepthTexture_ST;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
  xlv_TEXCOORD1 = ((gl_MultiTexCoord0.xy * _CameraDepthTexture_ST.xy) + _CameraDepthTexture_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _MainTex;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _RgbTex;
uniform sampler2D _ZCurve;
uniform sampler2D _RgbDepthTex;
uniform float _Saturation;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec2 tmpvar_3;
  tmpvar_3.x = tmpvar_2.x;
  tmpvar_3.y = 0.125;
  vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_2.y;
  tmpvar_4.y = 0.375;
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_2.z;
  tmpvar_5.y = 0.625;
  vec2 tmpvar_6;
  tmpvar_6.y = 0.5;
  tmpvar_6.x = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_2.x;
  tmpvar_7.y = 0.125;
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_2.y;
  tmpvar_8.y = 0.375;
  vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_2.z;
  tmpvar_9.y = 0.625;
  vec4 tmpvar_10;
  tmpvar_10.xyz = mix (((
    (texture2D (_RgbTex, tmpvar_3).xyz * vec3(1.0, 0.0, 0.0))
   + 
    (texture2D (_RgbTex, tmpvar_4).xyz * vec3(0.0, 1.0, 0.0))
  ) + (texture2D (_RgbTex, tmpvar_5).xyz * vec3(0.0, 0.0, 1.0))), ((
    (texture2D (_RgbDepthTex, tmpvar_7).xyz * vec3(1.0, 0.0, 0.0))
   + 
    (texture2D (_RgbDepthTex, tmpvar_9).xyz * vec3(0.0, 0.0, 1.0))
  ) + (texture2D (_RgbDepthTex, tmpvar_8).xyz * vec3(0.0, 1.0, 0.0))), texture2D (_ZCurve, tmpvar_6).xxx);
  tmpvar_10.w = tmpvar_2.w;
  color_1.w = tmpvar_10.w;
  vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xyz * unity_ColorSpaceLuminance.xyz);
  color_1.xyz = mix (vec3(((
    (tmpvar_11.x + tmpvar_11.y)
   + tmpvar_11.z) + (
    (2.0 * sqrt((tmpvar_11.y * (tmpvar_11.x + tmpvar_11.z))))
   * unity_ColorSpaceLuminance.w))), tmpvar_10.xyz, vec3(_Saturation));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_CameraDepthTexture_ST]
Vector 5 [_MainTex_TexelSize]
"vs_2_0
def c6, 0, -2, 1, 0
dcl_position v0
dcl_texcoord v1
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mov oT0.xy, v1
mov r0.x, c6.x
slt r0.x, c5.y, r0.x
mad r1.xy, v1, c4, c4.zwzw
mad r0.y, r1.y, c6.y, c6.z
mad r1.z, r0.x, r0.y, r1.y
mov oT1.xy, r1.xzzw

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 96 [_CameraDepthTexture_ST]
Vector 112 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedjlfknokmhligeipnknofnafdcdnigomjabaaaaaalmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcmeabaaaaeaaaabaahbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaaabeaaaaaaaaaaaaa
dcaaaaalgcaabaaaaaaaaaaaagbbbaaaabaaaaaaagibcaaaaaaaaaaaagaaaaaa
kgilcaaaaaaaaaaaagaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaabaaaaaabkaabaaa
aaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 96 [_CameraDepthTexture_ST]
Vector 112 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedldbkponhkimlmlocagomcamdkhmejogiabaaaaaabmaeaaaaaeaaaaaa
daaaaaaaimabaaaafiadaaaakmadaaaaebgpgodjfeabaaaafeabaaaaaaacpopp
beabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaagaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaahaaaakaamaaaaadaaaaabia
acaaffkaaaaaaaiaaeaaaaaeaaaaagiaabaanajaabaanakaabaapikaaeaaaaae
aaaaaiiaaaaakkiaahaaffkaahaakkkaaeaaaaaeaaaaaeoaaaaaaaiaaaaappia
aaaakkiaabaaaaacaaaaaioaaaaaffiaafaaaaadaaaaapiaaaaaffjaaeaaoeka
aeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaadoaabaaoejappppaaaafdeieefcmeabaaaaeaaaabaahbaaaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaaabeaaaaaaaaaaaaadcaaaaal
gcaabaaaaaaaaaaaagbbbaaaabaaaaaaagibcaaaaaaaaaaaagaaaaaakgilcaaa
aaaaaaaaagaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadgaaaaafeccabaaaabaaaaaabkaabaaaaaaaaaaa
dgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaa
acaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeo
aafeeffiedepepfceeaaklklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Float 2 [_Saturation]
Vector 0 [_ZBufferParams]
Vector 1 [unity_ColorSpaceLuminance]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
SetTexture 2 [_RgbTex] 2D 2
SetTexture 3 [_ZCurve] 2D 3
SetTexture 4 [_RgbDepthTex] 2D 4
"ps_2_0
def c3, 0.125, 0.375, 0.625, 0.5
def c4, 0, 1, 0, 2
dcl t0.xy
dcl t1.xy
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
texld_pp r0, t1, s1
texld_pp r1, t0, s0
mad r0.x, c0.x, r0.x, c0.y
rcp_pp r0.x, r0.x
mov_pp r0.y, c3.w
mov_pp r2.y, c3.y
mov_pp r2.x, r1.y
mov_pp r1.y, c3.x
mov_pp r3.x, r1.z
mov_pp r3.y, c3.z
texld_pp r0, r0, s3
texld r4, r2, s2
texld r2, r2, s4
texld r5, r1, s2
texld r6, r1, s4
texld r7, r3, s2
texld r3, r3, s4
mul_pp r0.yzw, r4.wzyx, c4.wzyx
mad_pp r4.xyz, r5, c4.yzxw, r0.wzyx
mul_pp r3.xyz, r3, c4.zxyw
mad_pp r3.xyz, r6, c4.yzxw, r3
mad_pp r0.yzw, r2.wzyx, c4.wzyx, r3.wzyx
mad_pp r2.xyz, r7, c4.zxyw, r4
lrp_pp r3.xyz, r0.x, r0.wzyx, r2
mul_pp r0.xyz, r3, c1
add_pp r3.w, r0.z, r0.x
mul_pp r3.w, r0.y, r3.w
add_pp r0.x, r0.y, r0.x
mad_pp r0.x, r3.z, c1.z, r0.x
rsq_pp r3.w, r3.w
rcp_pp r3.w, r3.w
mul_pp r3.w, r3.w, c1.w
mad_pp r3.w, r3.w, c4.w, r0.x
lrp_pp r1.xyz, c2.x, r3, r3.w
mov_pp oC0, r1

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RgbTex] 2D 2
SetTexture 2 [_CameraDepthTexture] 2D 1
SetTexture 3 [_ZCurve] 2D 3
SetTexture 4 [_RgbDepthTex] 2D 4
ConstBuffer "$Globals" 144
Vector 48 [unity_ColorSpaceLuminance]
Float 128 [_Saturation]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedlneobiemnogbbioiikodpeippdpddoihabaaaaaaciagaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfaafaaaaeaaaaaaafeabaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaighnbaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaf
bcaabaaaabaaaaaabkaabaaaaaaaaaaadgaaaaaikcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaacadpaaaaaaaaaaaaaadpefaaaaajpcaabaaaacaaaaaaegaabaaa
abaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaakhcaabaaa
acaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaikcaabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaadoaaaaaaaaaaaamadoefaaaaajpcaabaaaaeaaaaaa
egaabaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaamhcaabaaa
acaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaaaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaegacbaaaacaaaaaaefaaaaaj
pcaabaaaaeaaaaaaogakbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadiaaaaakhcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadp
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaa
aaaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaalicaabaaaaaaaaaaaakiacaaa
abaaaaaaahaaaaaaakaabaaaadaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaak
ecaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaadaaaaaaaaaaaaahfcaabaaaabaaaaaafgagbaaaabaaaaaa
agaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaaabaaaaaabkaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaa
adaaaaaaakaabaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
apaaaaaiicaabaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaapgapbaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaai
hcaabaaaaaaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RgbTex] 2D 2
SetTexture 2 [_CameraDepthTexture] 2D 1
SetTexture 3 [_ZCurve] 2D 3
SetTexture 4 [_RgbDepthTex] 2D 4
ConstBuffer "$Globals" 144
Vector 48 [unity_ColorSpaceLuminance]
Float 128 [_Saturation]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedjpjjehblobdepjpddjcknldpnahjjnlkabaaaaaabiaiaaaaaeaaaaaa
daaaaaaammacaaaaheahaaaaoeahaaaaebgpgodjjeacaaaajeacaaaaaaacpppp
diacaaaafmaaaaaaadaadiaaaaaafmaaaaaafmaaafaaceaaaaaafmaaaaaaaaaa
acababaaabacacaaadadadaaaeaeaeaaaaaaadaaabaaaaaaaaaaaaaaaaaaaiaa
abaaabaaaaaaaaaaabaaahaaabaaacaaaaaaaaaaaaacppppfbaaaaafadaaapka
aaaaaadoaaaamadoaaaacadpaaaaaadpfbaaaaafaeaaapkaaaaaaaaaaaaaiadp
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
adaiapkabpaaaaacaaaaaajaaeaiapkaabaaaaacaaaaadiaaaaabllaecaaaaad
aaaacpiaaaaaoeiaabaioekaecaaaaadabaacpiaaaaaoelaaaaioekaaeaaaaae
aaaaabiaacaaaakaaaaaaaiaacaaffkaagaaaaacaaaacbiaaaaaaaiaabaaaaac
aaaacciaadaappkaabaaaaacacaacciaadaaffkaabaaaaacacaacbiaabaaffia
abaaaaacabaacciaadaaaakaabaaaaacadaacbiaabaakkiaabaaaaacadaaccia
adaakkkaecaaaaadaaaacpiaaaaaoeiaadaioekaecaaaaadaeaaapiaacaaoeia
acaioekaecaaaaadacaaapiaacaaoeiaaeaioekaecaaaaadafaaapiaabaaoeia
acaioekaecaaaaadagaaapiaabaaoeiaaeaioekaecaaaaadahaaapiaadaaoeia
acaioekaecaaaaadadaaapiaadaaoeiaaeaioekaafaaaaadaaaacoiaaeaablia
aeaablkaaeaaaaaeaeaachiaafaaoeiaaeaamjkaaaaabliaafaaaaadadaachia
adaaoeiaaeaanckaaeaaaaaeadaachiaagaaoeiaaeaamjkaadaaoeiaaeaaaaae
aaaacoiaacaabliaaeaablkaadaabliaaeaaaaaeacaachiaahaaoeiaaeaancka
aeaaoeiabcaaaaaeadaachiaaaaaaaiaaaaabliaacaaoeiaaiaaaaadadaaciia
adaaoeiaaaaaoekabcaaaaaeabaachiaabaaaakaadaaoeiaadaappiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefckaaeaaaaeaaaaaaaciabaaaafjaaaaae
egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaighnbaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaafbcaabaaa
abaaaaaabkaabaaaaaaaaaaadgaaaaaikcaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaacadpaaaaaaaaaaaaaadpefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaaeaaaaaaaagabaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadiaaaaakhcaabaaaacaaaaaa
egacbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaikcaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaadoaaaaaaaaaaaamadoefaaaaajpcaabaaaaeaaaaaaegaabaaa
aaaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaamhcaabaaaacaaaaaa
egacbaaaaeaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaegacbaaa
acaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaaaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaa
aeaaaaaaogakbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
diaaaaakhcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaadcaaaaalicaabaaaaaaaaaaaakiacaaaabaaaaaa
ahaaaaaaakaabaaaadaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaakecaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaaaaaaaaaihcaabaaaaaaaaaaapgapbaiaebaaaaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}