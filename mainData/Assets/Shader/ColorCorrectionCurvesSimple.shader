Shader "Hidden/ColorCorrectionCurvesSimple" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "" { }
 _RgbTex ("_RgbTex (RGB)", 2D) = "" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 33095
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
uniform sampler2D _RgbTex;
uniform float _Saturation;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec2 tmpvar_3;
  tmpvar_3.y = 0.125;
  tmpvar_3.x = tmpvar_2.x;
  vec2 tmpvar_4;
  tmpvar_4.y = 0.375;
  tmpvar_4.x = tmpvar_2.y;
  vec2 tmpvar_5;
  tmpvar_5.y = 0.625;
  tmpvar_5.x = tmpvar_2.z;
  vec4 tmpvar_6;
  tmpvar_6.xyz = (((texture2D (_RgbTex, tmpvar_3).xyz * vec3(1.0, 0.0, 0.0)) + (texture2D (_RgbTex, tmpvar_4).xyz * vec3(0.0, 1.0, 0.0))) + (texture2D (_RgbTex, tmpvar_5).xyz * vec3(0.0, 0.0, 1.0)));
  tmpvar_6.w = tmpvar_2.w;
  color_1.w = tmpvar_6.w;
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6.xyz * unity_ColorSpaceLuminance.xyz);
  color_1.xyz = mix (vec3(((
    (tmpvar_7.x + tmpvar_7.y)
   + tmpvar_7.z) + (
    (2.0 * sqrt((tmpvar_7.y * (tmpvar_7.x + tmpvar_7.z))))
   * unity_ColorSpaceLuminance.w))), tmpvar_6.xyz, vec3(_Saturation));
  gl_FragData[0] = color_1;
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
Float 1 [_Saturation]
Vector 0 [unity_ColorSpaceLuminance]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RgbTex] 2D 1
"ps_2_0
def c2, 0.125, 0.375, 0.625, 2
def c3, 0, 1, 0, 0
dcl_pp t0.xy
dcl_2d s0
dcl_2d s1
texld_pp r0, t0, s0
mov_pp r1.y, c2.y
mov_pp r1.x, r0.y
mov_pp r0.y, c2.x
mov_pp r2.x, r0.z
mov_pp r2.y, c2.z
texld r1, r1, s1
texld r3, r0, s1
texld r2, r2, s1
mul_pp r1.xyz, r1, c3
mad_pp r1.xyz, r3, c3.yzxw, r1
mad_pp r1.xyz, r2, c3.zxyw, r1
mul_pp r2.xyz, r1, c0
add_pp r1.w, r2.z, r2.x
mul_pp r1.w, r1.w, r2.y
add_pp r2.x, r2.y, r2.x
mad_pp r2.x, r1.z, c0.z, r2.x
rsq_pp r1.w, r1.w
rcp_pp r1.w, r1.w
mul_pp r1.w, r1.w, c0.w
mad_pp r1.w, r1.w, c2.w, r2.x
lrp_pp r0.xyz, c1.x, r1, r1.w
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RgbTex] 2D 1
ConstBuffer "$Globals" 112
Vector 48 [unity_ColorSpaceLuminance]
Float 96 [_Saturation]
BindCB  "$Globals" 0
"ps_4_0
eefiecedomclckagkcblbbjadbhdlljckgjknealabaaaaaamaadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaadaaaa
eaaaaaaamaaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaadgaaaaaikcaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaadoaaaaaaaaaaaamadoefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaacghnbaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaffcaabaaaaaaaaaaa
fgagbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaakhcaabaaaacaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
egacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaaf
ccaabaaaabaaaaaaabeaaaaaaaaacadpefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaamhcaabaaaaaaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaaaaaaaaahfcaabaaaabaaaaaafgagbaaaabaaaaaaagaabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaak
bcaabaaaabaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaaadaaaaaaakaabaaa
abaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaapaaaaaiicaabaaa
aaaaaaaapgipcaaaaaaaaaaaadaaaaaapgapbaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaa
pgapbaiaebaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaa
agiacaaaaaaaaaaaagaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RgbTex] 2D 1
ConstBuffer "$Globals" 112
Vector 48 [unity_ColorSpaceLuminance]
Float 96 [_Saturation]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedfdkmoomjmnphbhechckofmfakibfngcnabaaaaaakaaeaaaaaeaaaaaa
daaaaaaalmabaaaabeaeaaaagmaeaaaaebgpgodjieabaaaaieabaaaaaaacpppp
eaabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaadaaabaaaaaaaaaaaaaaaaaaagaaabaaabaaaaaaaaaaaaacpppp
fbaaaaafacaaapkaaaaaaadoaaaamadoaaaacadpaaaaaaaafbaaaaafadaaapka
aaaaaaaaaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaacpiaaaaaoela
aaaioekaabaaaaacabaacciaacaaffkaabaaaaacabaacbiaaaaaffiaabaaaaac
aaaacciaacaaaakaabaaaaacacaacbiaaaaakkiaabaaaaacacaacciaacaakkka
ecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadadaaapiaaaaaoeiaabaioeka
ecaaaaadacaaapiaacaaoeiaabaioekaafaaaaadabaachiaabaaoeiaadaaoeka
aeaaaaaeabaachiaadaaoeiaadaamjkaabaaoeiaaeaaaaaeabaachiaacaaoeia
adaanckaabaaoeiaaiaaaaadabaaciiaabaaoeiaaaaaoekabcaaaaaeaaaachia
abaaaakaabaaoeiaabaappiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
faacaaaaeaaaaaaajeaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadgaaaaaikcaabaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaadoaaaaaaaaaaaamadoefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaacghnbaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaffcaabaaa
aaaaaaaafgagbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaakhcaabaaaacaaaaaa
egacbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
dgaaaaafccaabaaaabaaaaaaabeaaaaaaaaacadpefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaa
egacbaaaaaaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaaaaaaaaaihcaabaaaaaaaaaaapgapbaiaebaaaaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaaagiacaaaaaaaaaaaagaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
}
Fallback Off
}