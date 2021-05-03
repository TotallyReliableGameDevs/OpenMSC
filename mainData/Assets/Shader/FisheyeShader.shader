Shader "Hidden/FisheyeShader" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 48385
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec2 intensity;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 realCoordOffs_1;
  vec2 tmpvar_2;
  tmpvar_2 = ((xlv_TEXCOORD0 - 0.5) * 2.0);
  realCoordOffs_1.x = (((1.0 - 
    (tmpvar_2.y * tmpvar_2.y)
  ) * intensity.y) * tmpvar_2.x);
  realCoordOffs_1.y = (((1.0 - 
    (tmpvar_2.x * tmpvar_2.x)
  ) * intensity.x) * tmpvar_2.y);
  gl_FragData[0] = texture2D (_MainTex, (xlv_TEXCOORD0 - realCoordOffs_1));
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
dcl_position v0
dcl_texcoord v1
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mov oT0.xy, v1

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedaffpdldohodkdgpagjklpapmmnbhcfmlabaaaaaaoeabaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcaeabaaaa
eaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecedmomopcjkglcmfiigcnlfbdoahcohgpeoabaaaaaalmacaaaaaeaaaaaa
daaaaaaaaeabaaaabaacaaaageacaaaaebgpgodjmmaaaaaammaaaaaaaaacpopp
jiaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapia
abaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaabaaoeja
ppppaaaafdeieefcaeabaaaaeaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaa
abaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfc
eeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 0 [intensity]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c1, -0.5, 1, 0, 0
dcl t0.xy
dcl_2d s0
add_pp r0.xy, t0, c1.x
add_pp r0.xy, r0, r0
mad r0.z, r0.y, -r0.y, c1.y
mul r0.z, r0.z, c0.y
mul_pp r1.x, r0.x, r0.z
mad r0.x, r0.x, -r0.x, c1.y
mul r0.x, r0.x, c0.x
mul_pp r1.y, r0.y, r0.x
add r0.xy, -r1, t0
texld_pp r0, r0, s0
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 96 [intensity] 2
BindCB  "$Globals" 0
"ps_4_0
eefiecedboobbmgheoghenpopdddijnchgchfkaiabaaaaaapmabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdmabaaaa
eaaaaaaaepaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egbabaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaaaaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaanmcaabaaa
aaaaaaaafgabbaiaebaaaaaaaaaaaaaafgabbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaiadpdiaaaaaimcaabaaaaaaaaaaakgaobaaaaaaaaaaa
fgibcaaaaaaaaaaaagaaaaaadcaaaaakdcaabaaaaaaaaaaaogakbaiaebaaaaaa
aaaaaaaaegaabaaaaaaaaaaaegbabaaaabaaaaaaefaaaaajpccabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 96 [intensity] 2
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddkfjmghnghnkipldidkilllhcflfdcmjabaaaaaaciadaaaaaeaaaaaa
daaaaaaafiabaaaajmacaaaapeacaaaaebgpgodjcaabaaaacaabaaaaaaacpppp
omaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaalpaaaaiadp
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
acaaaaadaaaacdiaaaaaoelaabaaaakaacaaaaadaaaacdiaaaaaoeiaaaaaoeia
aeaaaaaeaaaaaeiaaaaaffiaaaaaffibabaaffkaafaaaaadaaaaaeiaaaaakkia
aaaaffkaafaaaaadabaacbiaaaaaaaiaaaaakkiaaeaaaaaeaaaaabiaaaaaaaia
aaaaaaibabaaffkaafaaaaadaaaaabiaaaaaaaiaaaaaaakaafaaaaadabaaccia
aaaaffiaaaaaaaiaacaaaaadaaaaadiaabaaoeibaaaaoelaecaaaaadaaaacpia
aaaaoeiaaaaioekaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcdmabaaaa
eaaaaaaaepaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egbabaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaaaaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaanmcaabaaa
aaaaaaaafgabbaiaebaaaaaaaaaaaaaafgabbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaiadpdiaaaaaimcaabaaaaaaaaaaakgaobaaaaaaaaaaa
fgibcaaaaaaaaaaaagaaaaaadcaaaaakdcaabaaaaaaaaaaaogakbaiaebaaaaaa
aaaaaaaaegaabaaaaaaaaaaaegbabaaaabaaaaaaefaaaaajpccabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadoaaaaabejfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}