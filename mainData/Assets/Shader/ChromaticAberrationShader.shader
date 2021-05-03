Shader "Hidden/ChromaticAberration" {
Properties {
 _MainTex ("Base", 2D) = "" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 44818
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
uniform vec4 _MainTex_TexelSize;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 cse_1;
  cse_1 = (_MainTex_TexelSize.xy * 0.5);
  vec2 cse_2;
  cse_2 = (_MainTex_TexelSize.xy * vec2(0.5, -0.5));
  gl_FragData[0] = (((
    (texture2D (_MainTex, (xlv_TEXCOORD0 + cse_1)) + texture2D (_MainTex, (xlv_TEXCOORD0 - cse_1)))
   + texture2D (_MainTex, 
    (xlv_TEXCOORD0 + cse_2)
  )) + texture2D (_MainTex, (xlv_TEXCOORD0 - cse_2))) / 4.0);
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
Vector 0 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c1, 0.5, -0.5, 0.25, 0
dcl t0.xy
dcl_2d s0
mov r0.xy, c1
mad r1.xy, c0, r0.x, t0
mad r2.xy, c0, -r0.x, t0
mad r3.xy, c0, r0, t0
mad r0.xy, c0, -r0, t0
texld_pp r1, r1, s0
texld r2, r2, s0
texld r3, r3, s0
texld r0, r0, s0
add_pp r1, r1, r2
add_pp r1, r3, r1
add_pp r0, r0, r1
mul_pp r0, r0, c1.z
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 144
Vector 96 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedipdggohobplbigbfompfjnioicejlcjpabaaaaaajaacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaabaaaa
eaaaaaaaheaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadcaaaaanpcaabaaaaaaaaaaa
egiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaalp
egbebaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaopcaabaaaacaaaaaaegiecaia
ebaaaaaaaaaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaalp
egbebaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaa
aaaaaaaadiaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiado
aaaaiadoaaaaiadoaaaaiadodoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 144
Vector 96 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecednalnobnnoeanehfignfgacpoolgapbldabaaaaaapaadaaaaaeaaaaaa
daaaaaaaimabaaaageadaaaalmadaaaaebgpgodjfeabaaaafeabaaaaaaacpppp
caabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadpaaaaaalp
aaaaiadoaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
abaaaaacaaaaadiaabaaoekaaeaaaaaeabaaadiaaaaaoekaaaaaaaiaaaaaoela
aeaaaaaeacaaadiaaaaaoekaaaaaaaibaaaaoelaaeaaaaaeadaaadiaaaaaoeka
aaaaoeiaaaaaoelaaeaaaaaeaaaaadiaaaaaoekaaaaaoeibaaaaoelaecaaaaad
abaacpiaabaaoeiaaaaioekaecaaaaadacaaapiaacaaoeiaaaaioekaecaaaaad
adaaapiaadaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeiaaaaioekaacaaaaad
abaacpiaabaaoeiaacaaoeiaacaaaaadabaacpiaadaaoeiaabaaoeiaacaaaaad
aaaacpiaaaaaoeiaabaaoeiaafaaaaadaaaacpiaaaaaoeiaabaakkkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcnaabaaaaeaaaaaaaheaaaaaafjaaaaae
egiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaadcaaaaanpcaabaaaaaaaaaaaegiecaaaaaaaaaaaagaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaalpegbebaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaaaaaaaaaogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaaopcaabaaaacaaaaaaegiecaiaebaaaaaaaaaaaaaaagaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaalpegbebaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaakpccabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiado
doaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 97360
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
uniform vec4 _MainTex_TexelSize;
uniform float _ChromaticAberration;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  vec2 tmpvar_2;
  tmpvar_2 = ((xlv_TEXCOORD0 - 0.5) * 2.0);
  color_1.xzw = texture2D (_MainTex, xlv_TEXCOORD0).xzw;
  color_1.y = texture2D (_MainTex, (xlv_TEXCOORD0 - ((
    (_MainTex_TexelSize.xy * _ChromaticAberration)
   * tmpvar_2) * dot (tmpvar_2, tmpvar_2)))).y;
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
Float 1 [_ChromaticAberration]
Vector 0 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c2, -0.5, 0, 9.99999975e-005, 0
dcl_pp t0.xy
dcl_2d s0
mov r0.xy, c0
mul r0.xy, r0, c1.x
add_pp r0.zw, t0.wzyx, c2.x
add_pp r1.xy, r0.wzyx, r0.wzyx
mul r0.xy, r0, r1
dp2add_pp r0.z, r1, r1, c2.y
mad_pp r0.xy, r0, -r0.z, t0
texld r0, r0, s0
texld_pp r1, t0, s0
mad_pp r1.y, r1.y, c2.z, r0.y
mov_pp oC0, r1

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 144
Vector 96 [_MainTex_TexelSize]
Float 112 [_ChromaticAberration]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhinhcnepebdeacfgijechmhdhdknlbfbabaaaaaafaacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaabaaaa
eaaaaaaageaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaadiaaaaajdcaabaaaaaaaaaaa
egiacaaaaaaaaaaaagaaaaaaagiacaaaaaaaaaaaahaaaaaaaaaaaaakmcaabaaa
aaaaaaaaagbebaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaalpaaaaaalp
aaaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaakgaobaaaaaaaaaaadiaaaaah
dcaabaaaaaaaaaaaogakbaaaaaaaaaaaegaabaaaaaaaaaaaapaaaaahecaabaaa
aaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaadcaaaaakdcaabaaaaaaaaaaa
egaabaiaebaaaaaaaaaaaaaakgakbaaaaaaaaaaaegbabaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dgaaaaafcccabaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaafnccabaaa
aaaaaaaaagaobaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 144
Vector 96 [_MainTex_TexelSize]
Float 112 [_ChromaticAberration]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedejbfldelnpnbglpmcddgkgahgkbclbbnabaaaaaaheadaaaaaeaaaaaa
daaaaaaafaabaaaaoiacaaaaeaadaaaaebgpgodjbiabaaaabiabaaaaaaacpppp
oeaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaagaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaalpaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaajaaaaiapka
abaaaaacaaaaadiaaaaaoekaafaaaaadaaaaadiaaaaaoeiaabaaaakaacaaaaad
aaaacmiaaaaabllaacaaaakaacaaaaadabaacdiaaaaabliaaaaabliaafaaaaad
aaaaadiaaaaaoeiaabaaoeiafkaaaaaeaaaaceiaabaaoeiaabaaoeiaacaaffka
aeaaaaaeaaaacdiaaaaaoeiaaaaakkibaaaaoelaecaaaaadaaaacpiaaaaaoeia
aaaioekaecaaaaadabaacpiaaaaaoelaaaaioekaabaaaaacabaacciaaaaaffia
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcjaabaaaaeaaaaaaageaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaadiaaaaajdcaabaaaaaaaaaaaegiacaaaaaaaaaaa
agaaaaaaagiacaaaaaaaaaaaahaaaaaaaaaaaaakmcaabaaaaaaaaaaaagbebaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaalpaaaaaalpaaaaaaahmcaabaaa
aaaaaaaakgaobaaaaaaaaaaakgaobaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaa
ogakbaaaaaaaaaaaegaabaaaaaaaaaaaapaaaaahecaabaaaaaaaaaaaogakbaaa
aaaaaaaaogakbaaaaaaaaaaadcaaaaakdcaabaaaaaaaaaaaegaabaiaebaaaaaa
aaaaaaaakgakbaaaaaaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaafcccabaaa
aaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaafnccabaaaaaaaaaaaagaobaaa
aaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 190419
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
uniform vec4 _MainTex_TexelSize;
uniform float _ChromaticAberration;
uniform float _AxialAberration;
uniform float _Luminance;
uniform vec2 _BlurDistance;
vec2 SmallDiscKernel[9];
varying vec2 xlv_TEXCOORD0;
void main ()
{
  SmallDiscKernel[0] = vec2(-0.926212, -0.40581);
  SmallDiscKernel[1] = vec2(-0.695914, 0.457137);
  SmallDiscKernel[2] = vec2(-0.203345, 0.820716);
  SmallDiscKernel[3] = vec2(0.96234, -0.194983);
  SmallDiscKernel[4] = vec2(0.473434, -0.480026);
  SmallDiscKernel[5] = vec2(0.519456, 0.767022);
  SmallDiscKernel[6] = vec2(0.185461, -0.893124);
  SmallDiscKernel[7] = vec2(0.89642, 0.412458);
  SmallDiscKernel[8] = vec2(-0.32194, -0.932615);
  vec4 blurredTap_2;
  float maxOfs_3;
  vec4 color_4;
  vec2 uv_5;
  uv_5 = xlv_TEXCOORD0;
  vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0 - 0.5) * 2.0);
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, tmpvar_6);
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_4 = tmpvar_8;
  maxOfs_3 = clamp (max (_AxialAberration, (
    (_ChromaticAberration * tmpvar_7)
   * tmpvar_7)), _BlurDistance.x, _BlurDistance.y);
  blurredTap_2 = (tmpvar_8 * 0.1);
  for (int l_1 = 0; l_1 < 9; l_1++) {
    blurredTap_2.xyz = (blurredTap_2.xyz + texture2D (_MainTex, (uv_5 + (
      (SmallDiscKernel[l_1] * _MainTex_TexelSize.xy)
     * maxOfs_3))).xyz);
  };
  blurredTap_2.xyz = (blurredTap_2.xyz / 9.2);
  vec3 tmpvar_9;
  tmpvar_9 = (abs((blurredTap_2.xyz - tmpvar_8.xyz)) * unity_ColorSpaceLuminance.xyz);
  color_4.xz = mix (tmpvar_8.xz, blurredTap_2.xz, vec2(clamp ((_Luminance * 
    (((tmpvar_9.x + tmpvar_9.y) + tmpvar_9.z) + ((2.0 * sqrt(
      (tmpvar_9.y * (tmpvar_9.x + tmpvar_9.z))
    )) * unity_ColorSpaceLuminance.w))
  ), 0.0, 1.0)));
  gl_FragData[0] = color_4;
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
Float 3 [_AxialAberration]
Vector 5 [_BlurDistance]
Float 2 [_ChromaticAberration]
Float 4 [_Luminance]
Vector 1 [_MainTex_TexelSize]
Vector 0 [unity_ColorSpaceLuminance]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c6, -0.5, 0, -0.405809999, -0.926212013
def c7, 0.100000001, -0.69591397, 0.457136989, 0.108695656
def c8, -0.321940005, -0.932614982, 2, 0
def c9, 0.185461, -0.893123984, 0.412458003, 0.896420002
def c10, 0.473434001, -0.480026007, 0.767022014, 0.519456029
def c11, -0.203345001, 0.820716023, -0.194983006, 0.962339997
dcl_pp t0.xy
dcl_2d s0
mov r0.xy, c1
mul r1.xy, r0, c7.yzxw
add_pp r0.zw, t0.wzyx, c6.x
add_pp r2.xy, r0.wzyx, r0.wzyx
dp2add_pp r0.z, r2, r2, c6.y
mul_pp r0.z, r0.z, r0.z
mul_pp r0.z, r0.z, c2.x
max_pp r1.z, c3.x, r0.z
max_pp r0.z, r1.z, c5.x
min_pp r1.z, c5.y, r0.z
mad_pp r1.xy, r1, r1.z, t0
mul r0.zw, r0.wzyx, c6
mad_pp r2.xy, r0.wzyx, r1.z, t0
mul r0.zw, r0.wzyx, c11.wzyx
mad_pp r3.xy, r0.wzyx, r1.z, t0
mul r0.zw, r0.wzyx, c11
mad_pp r4.xy, r0.wzyx, r1.z, t0
mul r0.zw, r0.wzyx, c10.wzyx
mad_pp r5.xy, r0.wzyx, r1.z, t0
mul r0.zw, r0.wzyx, c10
mad_pp r6.xy, r0.wzyx, r1.z, t0
mul r0.zw, r0.wzyx, c9.wzyx
mad_pp r7.xy, r0.wzyx, r1.z, t0
mul r0.zw, r0.wzyx, c9
mad_pp r8.xy, r0.wzyx, r1.z, t0
mul r0.xy, r0, c8
mad_pp r0.xy, r0, r1.z, t0
texld_pp r1, r1, s0
texld_pp r2, r2, s0
texld_pp r9, t0, s0
texld_pp r3, r3, s0
texld_pp r4, r4, s0
texld_pp r5, r5, s0
texld_pp r6, r6, s0
texld_pp r7, r7, s0
texld_pp r8, r8, s0
texld_pp r0, r0, s0
mad_pp r2.xyz, r9, c7.x, r2
add_pp r1.xyz, r1, r2
add_pp r1.xyz, r3, r1
add_pp r1.xyz, r4, r1
add_pp r1.xyz, r5, r1
add_pp r1.xyz, r6, r1
add_pp r1.xyz, r7, r1
add_pp r1.xyz, r8, r1
add_pp r0.xyz, r0, r1
mad_pp r0.xyz, r0, c7.w, -r9
abs_pp r1.xyz, r0
mul_pp r2.xyz, r1, c0
add_pp r0.y, r2.z, r2.x
mul_pp r0.y, r0.y, r2.y
add_pp r0.w, r2.y, r2.x
mad_pp r0.w, r1.z, c0.z, r0.w
rsq_pp r0.y, r0.y
rcp_pp r0.y, r0.y
mul_pp r0.y, r0.y, c0.w
mad_pp r0.y, r0.y, c8.z, r0.w
mul_sat_pp r0.y, r0.y, c4.x
mad_pp r9.xz, r0.y, r0, r9
mov_pp oC0, r9

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 144
Vector 48 [unity_ColorSpaceLuminance]
Vector 96 [_MainTex_TexelSize]
Float 112 [_ChromaticAberration]
Float 116 [_AxialAberration]
Float 120 [_Luminance]
Vector 128 [_BlurDistance] 2
BindCB  "$Globals" 0
"ps_4_0
eefiecedpcaagfikmlcilfgehgldmhcadhakhnomabaaaaaafiafaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjiaeaaaa
eaaaaaaacgabaaaadfbiaaaacgaaaaaadlbmgnlpfemgmploaaaaaaaaaaaaaaaa
glchdclpnmanokdoaaaaaaaaaaaaaaaakmdjfalohcbkfcdpaaaaaaaaaaaaaaaa
okflhgdpkakjehloaaaaaaaaaaaaaaaapbgfpcdopimfpfloaaaaaaaaaaaaaaaa
bcplaedpiofleedpaaaaaaaaaaaaaaaahnojdndomgkdgelpaaaaaaaaaaaaaaaa
mihlgfdplccnnddoaaaaaaaaaaaaaaaafcnfkelonllpgolpaaaaaaaaaaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaaaaaaakdcaabaaaaaaaaaaaegbabaaaabaaaaaa
aceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaaaaaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaahaaaaaadeaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaahaaaaaadeaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaaddaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaadiaaaaakocaabaaaaaaaaaaaagajbaaaabaaaaaa
aceaaaaaaaaaaaaamnmmmmdnmnmmmmdnmnmmmmdndgaaaaafhcaabaaaacaaaaaa
jgahbaaaaaaaaaaadgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaaaaadaaaaaab
cbaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaaajaaaaaaadaaaead
akaabaaaadaaaaaadiaaaaajdcaabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaa
egjajaaadkaabaaaacaaaaaadcaaaaajdcaabaaaadaaaaaaegaabaaaadaaaaaa
agaabaaaaaaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaaboaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaabaaaaaabgaaaaabdcaaaaanhcaabaaaaaaaaaaaegacbaaa
acaaaaaaaceaaaaanejlnodnnejlnodnnejlnodnaaaaaaaaegacbaiaebaaaaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaaegacbaiaibaaaaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaaaaaaaaahkcaabaaaaaaaaaaafgajbaaaacaaaaaaagaabaaa
acaaaaaadcaaaaalccaabaaaaaaaaaaackaabaiaibaaaaaaaaaaaaaackiacaaa
aaaaaaaaadaaaaaabkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaacaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
apaaaaaiicaabaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaapgapbaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadicaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaaaaaaaaaaahaaaaaadcaaaaaj
fccabaaaaaaaaaaafgafbaaaaaaaaaaaagacbaaaaaaaaaaaagacbaaaabaaaaaa
dgaaaaafkccabaaaaaaaaaaafganbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 144
Vector 48 [unity_ColorSpaceLuminance]
Vector 96 [_MainTex_TexelSize]
Float 112 [_ChromaticAberration]
Float 116 [_AxialAberration]
Float 120 [_Luminance]
Vector 128 [_BlurDistance] 2
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedhfgagldglimehimpelhciakkilfdkmjmabaaaaaaaiajaaaaaeaaaaaa
daaaaaaajaaeaaaahmaiaaaaneaiaaaaebgpgodjfiaeaaaafiaeaaaaaaacpppp
biaeaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaadaaabaaaaaaaaaaaaaaaaaaagaaadaaabaaaaaaaaaaaaacppppfbaaaaaf
aeaaapkaaaaaaalpaaaaaaaafemgmplodlbmgnlpfbaaaaafafaaapkamnmmmmdn
glchdclpnmanokdonejlnodnfbaaaaafagaaapkafcnfkelonllpgolpaaaaaaaa
aaaaaaaafbaaaaafahaaapkahnojdndomgkdgelplccnnddomihlgfdpfbaaaaaf
aiaaapkapbgfpcdopimfpfloiofleedpbcplaedpfbaaaaafajaaapkakmdjfalo
hcbkfcdpkakjehlookflhgdpbpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaja
aaaiapkaabaaaaacaaaaadiaabaaoekaafaaaaadabaaadiaaaaaoeiaafaamjka
acaaaaadaaaacmiaaaaabllaaeaaaakaacaaaaadacaacdiaaaaabliaaaaablia
fkaaaaaeaaaaceiaacaaoeiaacaaoeiaaeaaffkaafaaaaadaaaaceiaaaaakkia
aaaakkiaafaaaaadaaaaceiaaaaakkiaacaaaakaalaaaaadabaaceiaacaaffka
aaaakkiaalaaaaadaaaaceiaabaakkiaadaaaakaakaaaaadabaaceiaadaaffka
aaaakkiaaeaaaaaeabaacdiaabaaoeiaabaakkiaaaaaoelaafaaaaadaaaaamia
aaaabliaaeaaoekaaeaaaaaeacaacdiaaaaabliaabaakkiaaaaaoelaafaaaaad
aaaaamiaaaaabliaajaablkaaeaaaaaeadaacdiaaaaabliaabaakkiaaaaaoela
afaaaaadaaaaamiaaaaabliaajaaoekaaeaaaaaeaeaacdiaaaaabliaabaakkia
aaaaoelaafaaaaadaaaaamiaaaaabliaaiaablkaaeaaaaaeafaacdiaaaaablia
abaakkiaaaaaoelaafaaaaadaaaaamiaaaaabliaaiaaoekaaeaaaaaeagaacdia
aaaabliaabaakkiaaaaaoelaafaaaaadaaaaamiaaaaabliaahaablkaaeaaaaae
ahaacdiaaaaabliaabaakkiaaaaaoelaafaaaaadaaaaamiaaaaabliaahaaoeka
aeaaaaaeaiaacdiaaaaabliaabaakkiaaaaaoelaafaaaaadaaaaadiaaaaaoeia
agaaoekaaeaaaaaeaaaacdiaaaaaoeiaabaakkiaaaaaoelaecaaaaadabaacpia
abaaoeiaaaaioekaecaaaaadacaacpiaacaaoeiaaaaioekaecaaaaadajaacpia
aaaaoelaaaaioekaecaaaaadadaacpiaadaaoeiaaaaioekaecaaaaadaeaacpia
aeaaoeiaaaaioekaecaaaaadafaacpiaafaaoeiaaaaioekaecaaaaadagaacpia
agaaoeiaaaaioekaecaaaaadahaacpiaahaaoeiaaaaioekaecaaaaadaiaacpia
aiaaoeiaaaaioekaecaaaaadaaaacpiaaaaaoeiaaaaioekaaeaaaaaeacaachia
ajaaoeiaafaaaakaacaaoeiaacaaaaadabaachiaabaaoeiaacaaoeiaacaaaaad
abaachiaadaaoeiaabaaoeiaacaaaaadabaachiaaeaaoeiaabaaoeiaacaaaaad
abaachiaafaaoeiaabaaoeiaacaaaaadabaachiaagaaoeiaabaaoeiaacaaaaad
abaachiaahaaoeiaabaaoeiaacaaaaadabaachiaaiaaoeiaabaaoeiaacaaaaad
aaaachiaaaaaoeiaabaaoeiaaeaaaaaeaaaachiaaaaaoeiaafaappkaajaaoeib
cdaaaaacabaachiaaaaaoeiaaiaaaaadaaaacciaabaaoeiaaaaaoekaafaaaaad
aaaadciaaaaaffiaacaakkkaaeaaaaaeajaacfiaaaaaffiaaaaaoeiaajaaoeia
abaaaaacaaaicpiaajaaoeiappppaaaafdeieefcoeadaaaaeaaaaaaapjaaaaaa
dfbiaaaacgaaaaaadlbmgnlpfemgmploaaaaaaaaaaaaaaaaglchdclpnmanokdo
aaaaaaaaaaaaaaaakmdjfalohcbkfcdpaaaaaaaaaaaaaaaaokflhgdpkakjehlo
aaaaaaaaaaaaaaaapbgfpcdopimfpfloaaaaaaaaaaaaaaaabcplaedpiofleedp
aaaaaaaaaaaaaaaahnojdndomgkdgelpaaaaaaaaaaaaaaaamihlgfdplccnnddo
aaaaaaaaaaaaaaaafcnfkelonllpgolpaaaaaaaaaaaaaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaaaaaaaakdcaabaaaaaaaaaaaegbabaaaabaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaaaaaaaaaaaaaaaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaadeaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
ahaaaaaadeaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaaddaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
aiaaaaaadiaaaaakocaabaaaaaaaaaaaagajbaaaabaaaaaaaceaaaaaaaaaaaaa
mnmmmmdnmnmmmmdnmnmmmmdndgaaaaafhcaabaaaacaaaaaajgahbaaaaaaaaaaa
dgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaa
adaaaaaadkaabaaaacaaaaaaabeaaaaaajaaaaaaadaaaeadakaabaaaadaaaaaa
diaaaaajdcaabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaegjajaaadkaabaaa
acaaaaaadcaaaaajdcaabaaaadaaaaaaegaabaaaadaaaaaaagaabaaaaaaaaaaa
egbabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaaboaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
abaaaaaabgaaaaabdcaaaaanhcaabaaaaaaaaaaaegacbaaaacaaaaaaaceaaaaa
nejlnodnnejlnodnnejlnodnaaaaaaaaegacbaiaebaaaaaaabaaaaaabaaaaaaj
ccaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaa
dicaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaaaaaaaaaaahaaaaaa
dcaaaaajfccabaaaaaaaaaaafgafbaaaaaaaaaaaagacbaaaaaaaaaaaagacbaaa
abaaaaaadgaaaaafkccabaaaaaaaaaaafganbaaaabaaaaaadoaaaaabejfdeheo
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