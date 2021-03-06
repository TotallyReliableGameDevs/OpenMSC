Shader "Hidden/Vignetting" {
Properties {
 _MainTex ("Base", 2D) = "white" { }
 _VignetteTex ("Vignette", 2D) = "white" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 9857
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _VignetteTex;
uniform float _Intensity;
uniform float _Blur;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = ((xlv_TEXCOORD0 - 0.5) * 2.0);
  float tmpvar_2;
  tmpvar_2 = dot (tmpvar_1, tmpvar_1);
  gl_FragData[0] = (mix (texture2D (_MainTex, xlv_TEXCOORD0), texture2D (_VignetteTex, xlv_TEXCOORD1), vec4(clamp (
    (_Blur * tmpvar_2)
  , 0.0, 1.0))) * (1.0 - (
    (tmpvar_2 * _Intensity)
   * 0.1)));
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
def c5, 0, -2, 1, 0
dcl_position v0
dcl_texcoord v1
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mov r0.x, c5.x
slt r0.x, c4.y, r0.x
mad r0.y, v1.y, c5.y, c5.z
mad oT1.y, r0.x, r0.y, v1.y
mov oT0.xy, v1
mov oT1.x, v1.x

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
eefiecedfimpgedgocmaglillkdiphgcohjmkbchabaaaaaahmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcieabaaaaeaaaabaagbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 112 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedficeokmohibmieaicdlfjagebifpehhkabaaaaaalmadaaaaaeaaaaaa
daaaaaaagmabaaaapiacaaaaemadaaaaebgpgodjdeabaaaadeabaaaaaaacpopp
peaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaahaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaaeoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaloaabaacejappppaaaafdeieefcieabaaaaeaaaabaagbaaaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaaabeaaaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaaj
iccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaa
dgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaa
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
Float 1 [_Blur]
Float 0 [_Intensity]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
"ps_2_0
def c2, -0.5, 0, 0.100000001, 1
dcl_pp t0.xy
dcl t1.xy
dcl_2d s0
dcl_2d s1
add_pp r0.xy, t0, c2.x
add_pp r0.xy, r0, r0
dp2add_pp r0.x, r0, r0, c2.y
mul_sat_pp r0.y, r0.x, c1.x
mul_pp r0.x, r0.x, c0.x
mad r0.x, r0.x, -c2.z, c2.w
texld_pp r1, t0, s0
texld_pp r2, t1, s1
lrp_pp r3, r0.y, r2, r1
mul_pp r0, r0.x, r3
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
ConstBuffer "$Globals" 128
Float 96 [_Intensity]
Float 100 [_Blur]
BindCB  "$Globals" 0
"ps_4_0
eefiecedenechnlaocofmnelhdodeggkfgpolpnhabaaaaaalmacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoeabaaaaeaaaaaaahjaaaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egbabaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaaaaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaapaaaaahbcaabaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
agaabaaaaaaaaaaabgifcaaaaaaaaaaaagaaaaaadgcaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaamnmmmmdnabeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaah
pccabaaaaaaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_VignetteTex] 2D 1
ConstBuffer "$Globals" 128
Float 96 [_Intensity]
Float 100 [_Blur]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedndcecfbcogbpojiaaapldlgeaibidajlabaaaaaaaiaeaaaaaeaaaaaa
daaaaaaahiabaaaageadaaaaneadaaaaebgpgodjeaabaaaaeaabaaaaaaacpppp
aiabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaagaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaalp
aaaaaaaamnmmmmdnaaaaiadpbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkaabaaaaacaaaaadiaaaaabllaecaaaaad
aaaacpiaaaaaoeiaabaioekaecaaaaadabaacpiaaaaaoelaaaaioekaacaaaaad
acaacdiaaaaaoelaabaaaakaacaaaaadacaacdiaacaaoeiaacaaoeiafkaaaaae
acaacbiaacaaoeiaacaaoeiaabaaffkaafaaaaadacaadciaacaaaaiaaaaaffka
afaaaaadacaacbiaacaaaaiaaaaaaakaaeaaaaaeacaaabiaacaaaaiaabaakkkb
abaappkabcaaaaaeadaacpiaacaaffiaaaaaoeiaabaaoeiaafaaaaadaaaacpia
acaaaaiaadaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcoeabaaaa
eaaaaaaahjaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegbabaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaa
aaaaaaaaaaaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaa
apaaaaahbcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaadiaaaaai
dcaabaaaaaaaaaaaagaabaaaaaaaaaaabgifcaaaaaaaaaaaagaaaaaadgcaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaabeaaaaamnmmmmdnabeaaaaaaaaaiadpefaaaaajpcaabaaa
abaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadiaaaaahpccabaaaaaaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}