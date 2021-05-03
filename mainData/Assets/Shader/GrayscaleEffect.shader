Shader "Hidden/Grayscale Effect" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
 _RampTex ("Base (RGB)", 2D) = "grayscaleRamp" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 31581
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
uniform vec4 unity_ColorSpaceLuminance;
uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
uniform float _RampOffset;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 xlat_varoutput_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2.xyz * unity_ColorSpaceLuminance.xyz);
  vec2 tmpvar_4;
  tmpvar_4.y = 0.5;
  tmpvar_4.x = (((
    (tmpvar_3.x + tmpvar_3.y)
   + tmpvar_3.z) + (
    (2.0 * sqrt((tmpvar_3.y * (tmpvar_3.x + tmpvar_3.z))))
   * unity_ColorSpaceLuminance.w)) + _RampOffset);
  xlat_varoutput_1.xyz = texture2D (_RampTex, tmpvar_4).xyz;
  xlat_varoutput_1.w = tmpvar_2.w;
  gl_FragData[0] = xlat_varoutput_1;
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
Float 1 [_RampOffset]
Vector 0 [unity_ColorSpaceLuminance]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RampTex] 2D 1
"ps_2_0
def c2, 2, 0.5, 0, 0
dcl_pp t0.xy
dcl_2d s0
dcl_2d s1
texld_pp r0, t0, s0
mul_pp r1.xyz, r0, c0
add_pp r1.z, r1.z, r1.x
mul_pp r1.z, r1.z, r1.y
add_pp r1.x, r1.y, r1.x
mad_pp r1.x, r0.z, c0.z, r1.x
rsq_pp r1.y, r1.z
rcp_pp r1.y, r1.y
mul_pp r1.y, r1.y, c0.w
mad_pp r1.x, r1.y, c2.x, r1.x
add_pp r1.x, r1.x, c1.x
mov_pp r1.y, c2.y
texld_pp r1, r1, s1
mov_pp r0.xyz, r1
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RampTex] 2D 1
ConstBuffer "$Globals" 112
Vector 48 [unity_ColorSpaceLuminance]
Float 96 [_RampOffset]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkemfioljacomlkadlfdknmjijceglocdabaaaaaakiacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiabaaaa
eaaaaaaahkaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaaaaaaaaahdcaabaaaaaaaaaaa
jgafbaaaabaaaaaaagaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaa
ckiacaaaaaaaaaaaadaaaaaaakaabaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaapaaaaai
ccaabaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaafgafbaaaaaaaaaaaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaagaaaaaadgaaaaafccaabaaa
aaaaaaaaabeaaaaaaaaaaadpefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RampTex] 2D 1
ConstBuffer "$Globals" 112
Vector 48 [unity_ColorSpaceLuminance]
Float 96 [_RampOffset]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedajnpfkjcackegmckhkkejiadjiepfplgabaaaaaapaacaaaaaeaaaaaa
daaaaaaaceabaaaageacaaaalmacaaaaebgpgodjomaaaaaaomaaaaaaaaacpppp
kiaaaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaadaaabaaaaaaaaaaaaaaaaaaagaaabaaabaaaaaaaaaaaaacpppp
fbaaaaafacaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaacdlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaacpiaaaaaoelaaaaioekaaiaaaaadabaaciiaaaaaoeiaaaaaoekaacaaaaad
abaacbiaabaappiaabaaaakaabaaaaacabaacciaacaaaakaecaaaaadabaacpia
abaaoeiaabaioekaabaaaaacaaaachiaabaaoeiaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcdiabaaaaeaaaaaaaeoaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaagaaaaaadgaaaaafccaabaaaaaaaaaaa
abeaaaaaaaaaaadpefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}