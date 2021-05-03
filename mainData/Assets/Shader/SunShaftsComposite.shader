Shader "Hidden/SunShaftsComposite" {
Properties {
 _MainTex ("Base", 2D) = "" { }
 _ColorBuffer ("Color", 2D) = "" { }
 _Skybox ("Skybox", 2D) = "" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 55062
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
uniform sampler2D _ColorBuffer;
uniform vec4 _SunColor;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_FragData[0] = (1.0 - ((1.0 - texture2D (_MainTex, xlv_TEXCOORD0)) * (1.0 - 
    clamp ((texture2D (_ColorBuffer, xlv_TEXCOORD0) * _SunColor), 0.0, 1.0)
  )));
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
ConstBuffer "$Globals" 176
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedocfaccidloibkgbbomeffdgkkpdkodcjabaaaaaahmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcieabaaaaeaaaabaagbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedgpligjebalibbimgnfeojjiadombjnojabaaaaaalmadaaaaaeaaaaaa
daaaaaaagmabaaaapiacaaaaemadaaaaebgpgodjdeabaaaadeabaaaaaaacpopp
peaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaakaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaaeoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaloaabaacejappppaaaafdeieefcieabaaaaeaaaabaagbaaaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaai
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
Vector 0 [_SunColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ColorBuffer] 2D 1
"ps_2_0
def c1, 1, 0, 0, 0
dcl t0.xy
dcl t1.xy
dcl_2d s0
dcl_2d s1
texld_pp r0, t1, s1
texld_pp r1, t0, s0
mul_sat_pp r0, r0, c0
add r0, -r0, c1.x
add r1, -r1, c1.x
mad_pp r0, r1, -r0, c1.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ColorBuffer] 2D 1
ConstBuffer "$Globals" 176
Vector 112 [_SunColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedigbdjiiapinkgibgefhahbddkpdemdjaabaaaaaaemacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheabaaaaeaaaaaaafnaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadicaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaaaaaaalpcaabaaa
aaaaaaaaegaobaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaalpcaabaaaabaaaaaaegaobaiaebaaaaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdcaaaaanpccabaaaaaaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ColorBuffer] 2D 1
ConstBuffer "$Globals" 176
Vector 112 [_SunColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedabiimnlloapghbpcadgppjdjhnlkfknfabaaaaaafaadaaaaaeaaaaaa
daaaaaaadaabaaaakmacaaaabmadaaaaebgpgodjpiaaaaaapiaaaaaaaaacpppp
maaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaahaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkaabaaaaacaaaaadiaaaaabllaecaaaaad
aaaacpiaaaaaoeiaabaioekaecaaaaadabaacpiaaaaaoelaaaaioekaafaaaaad
aaaadpiaaaaaoeiaaaaaoekaacaaaaadaaaaapiaaaaaoeibabaaaakaacaaaaad
abaaapiaabaaoeibabaaaakaaeaaaaaeaaaacpiaabaaoeiaaaaaoeibabaaaaka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcheabaaaaeaaaaaaafnaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadicaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaaaaaaaalpcaabaaa
aaaaaaaaegaobaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaalpcaabaaaabaaaaaaegaobaiaebaaaaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdcaaaaanpccabaaaaaaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 93424
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform vec4 _BlurRadius4;
uniform vec4 _SunPosition;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
  xlv_TEXCOORD1 = ((_SunPosition.xy - gl_MultiTexCoord0.xy) * _BlurRadius4.xy);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
void main ()
{
  vec2 tmpvar_1;
  vec4 color_2;
  color_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = (xlv_TEXCOORD0 + xlv_TEXCOORD1);
  color_2 = (color_2 + texture2D (_MainTex, tmpvar_1));
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  color_2 = (color_2 + texture2D (_MainTex, tmpvar_1));
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  color_2 = (color_2 + texture2D (_MainTex, tmpvar_1));
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  color_2 = (color_2 + texture2D (_MainTex, tmpvar_1));
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  color_2 = (color_2 + texture2D (_MainTex, tmpvar_1));
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  gl_FragData[0] = (color_2 / 6.0);
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BlurRadius4]
Vector 5 [_SunPosition]
"vs_2_0
dcl_position v0
dcl_texcoord v1
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
add r0.xy, -v1, c5
mul oT1.xy, r0, c4
mov oT0.xy, v1

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Vector 128 [_BlurRadius4]
Vector 144 [_SunPosition]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedblhcjfdoddeobplledmmdhbbgdppbgbgabaaaaaafmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgeabaaaaeaaaabaafjaaaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aaaaaaajdcaabaaaaaaaaaaaegbabaiaebaaaaaaabaaaaaaegiacaaaaaaaaaaa
ajaaaaaadiaaaaaimccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaa
aiaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Vector 128 [_BlurRadius4]
Vector 144 [_SunPosition]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedakfbaieckpmaolojjefcbdooeobdfmioabaaaaaagaadaaaaaeaaaaaa
daaaaaaadaabaaaajmacaaaapaacaaaaebgpgodjpiaaaaaapiaaaaaaaaacpopp
liaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaaiaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaacaaaaadaaaaadiaabaaobjb
acaaobkaafaaaaadaaaaamoaaaaaeeiaabaabekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacaaaaadoaabaaoejappppaaaafdeieefcgeabaaaaeaaaabaafjaaaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aaaaaaajdcaabaaaaaaaaaaaegbabaiaebaaaaaaabaaaaaaegiacaaaaaaaaaaa
ajaaaaaadiaaaaaimccabaaaabaaaaaaagaebaaaaaaaaaaaagiecaaaaaaaaaaa
aiaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdej
feejepeoaafeeffiedepepfceeaaklklepfdeheogiaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
abaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c0, 0.166666672, 0, 0, 0
dcl t0.xy
dcl t1.xy
dcl_2d s0
mov r0.xy, t1
add r0.xy, r0, t0
add r1.xy, r0, t1
add r2.xy, r1, t1
add r3.xy, r2, t1
add r4.xy, r3, t1
texld_pp r5, t0, s0
texld_pp r0, r0, s0
texld_pp r1, r1, s0
texld_pp r2, r2, s0
texld_pp r3, r3, s0
texld_pp r4, r4, s0
add_pp r0, r0, r5
add_pp r0, r1, r0
add_pp r0, r2, r0
add_pp r0, r3, r0
add_pp r0, r4, r0
mul_pp r0, r0, c0.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedgnihoonhhjkjcdlojakefcgagicfdkdfabaaaaaaeeacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgmabaaaaeaaaaaaaflaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaadgaaaaaipcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaabaaaaaadgaaaaaf
ecaabaaaabaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahicaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaagaaaaaaadaaaeaddkaabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaah
dcaabaaaabaaaaaaegaabaaaabaaaaaaogbkbaaaabaaaaaaboaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaabaaaaaabgaaaaabdiaaaaakpccabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaklkkckdoklkkckdoklkkckdoklkkckdo
doaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedmahaooppkmafpaeclbgmbnabpkpimcffabaaaaaammadaaaaaeaaaaaa
daaaaaaaleabaaaaciadaaaajiadaaaaebgpgodjhmabaaaahmabaaaaaaacpppp
feabaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaklkkckdoaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaajaaaaiapkaacaaaaadaaaaadiaaaaablla
aaaaoelaacaaaaadabaaadiaaaaaoeiaaaaabllaacaaaaadacaaadiaabaaoeia
aaaabllaacaaaaadadaaadiaacaaoeiaaaaabllaacaaaaadaeaaadiaadaaoeia
aaaabllaecaaaaadafaacpiaaaaaoelaaaaioekaecaaaaadaaaacpiaaaaaoeia
aaaioekaecaaaaadabaacpiaabaaoeiaaaaioekaecaaaaadacaacpiaacaaoeia
aaaioekaecaaaaadadaacpiaadaaoeiaaaaioekaecaaaaadaeaacpiaaeaaoeia
aaaioekaacaaaaadaaaacpiaaaaaoeiaafaaoeiaacaaaaadaaaacpiaabaaoeia
aaaaoeiaacaaaaadaaaacpiaacaaoeiaaaaaoeiaacaaaaadaaaacpiaadaaoeia
aaaaoeiaacaaaaadaaaacpiaaeaaoeiaaaaaoeiaafaaaaadaaaacpiaaaaaoeia
aaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcgmabaaaaeaaaaaaa
flaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaadgaaaaaipcaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaabaaaaaa
dgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahicaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaagaaaaaaadaaaeaddkaabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaa
aaaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaaogbkbaaaabaaaaaaboaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaabaaaaaabgaaaaabdiaaaaak
pccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaklkkckdoklkkckdoklkkckdo
klkkckdodoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 157451
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
uniform vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SunThreshold;
uniform vec4 _SunPosition;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 outColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  float tmpvar_3;
  tmpvar_3 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.y)));
  vec2 tmpvar_4;
  tmpvar_4 = (_SunPosition.xy - xlv_TEXCOORD0);
  float tmpvar_5;
  tmpvar_5 = clamp ((_SunPosition.w - sqrt(
    dot (tmpvar_4, tmpvar_4)
  )), 0.0, 1.0);
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((tmpvar_3 > 0.99)) {
    outColor_1 = vec4((dot (max (
      (tmpvar_2.xyz - _SunThreshold.xyz)
    , vec3(0.0, 0.0, 0.0)), vec3(1.0, 1.0, 1.0)) * tmpvar_5));
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
ConstBuffer "$Globals" 176
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedocfaccidloibkgbbomeffdgkkpdkodcjabaaaaaahmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcieabaaaaeaaaabaagbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedgpligjebalibbimgnfeojjiadombjnojabaaaaaalmadaaaaaeaaaaaa
daaaaaaagmabaaaapiacaaaaemadaaaaebgpgodjdeabaaaadeabaaaaaaacpopp
peaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaakaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaaeoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaloaabaacejappppaaaafdeieefcieabaaaaeaaaabaagbaaaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaai
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
Vector 2 [_SunPosition]
Vector 1 [_SunThreshold]
Vector 0 [_ZBufferParams]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_2_0
def c3, 0, 0.99000001, 1, 0
dcl t0.xy
dcl t1.xy
dcl_2d s0
dcl_2d s1
texld_pp r0, t0, s0
texld r1, t1, s1
add_pp r2.xy, -t1, c2
dp2add_pp r0.w, r2, r2, c3.x
rsq_pp r0.w, r0.w
rcp_pp r0.w, r0.w
add_sat_pp r0.w, -r0.w, c2.w
add_pp r0.xyz, r0, -c1
max_pp r2.xyz, r0, c3.x
dp3_pp r0.x, r2, c3.z
mul_pp r0.x, r0.w, r0.x
mad r0.y, c0.x, r1.x, c0.y
rcp r0.y, r0.y
add r0.y, -r0.y, c3.y
cmp_pp r0, r0.y, c3.x, r0.x
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Vector 96 [_SunThreshold]
Vector 144 [_SunPosition]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedbngomdpkcjeindgjdjgjcfcmpgfogcdoabaaaaaaeeadaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgmacaaaaeaaaaaaajlaaaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaaaaaaaajdcaabaaaaaaaaaaaogbkbaiaebaaaaaaabaaaaaaegiacaaa
aaaaaaaaajaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaa
aaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaaacaaaajbcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
aaaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaa
agaaaaaadeaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaabaaaaaakccaabaaaaaaaaaaajgahbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaalccaabaaaaaaaaaaa
akiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaabkiacaaaabaaaaaaahaaaaaa
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaakehahndpbkaabaaa
aaaaaaaaabaaaaahpccabaaaaaaaaaaaagaabaaaaaaaaaaafgafbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Vector 96 [_SunThreshold]
Vector 144 [_SunPosition]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedjgphllppmoaklfagdojdkehcmdmbfihpabaaaaaaomaeaaaaaeaaaaaa
daaaaaaaneabaaaaeiaeaaaaliaeaaaaebgpgodjjmabaaaajmabaaaaaaacpppp
emabaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaabaaaaaa
aaababaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaabaaabaaaaaaaaaaabaaahaa
abaaacaaaaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaaaakehahndpaaaaiadp
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkaabaaaaacaaaaadiaaaaabllaecaaaaadabaacpiaaaaaoela
aaaioekaecaaaaadaaaaapiaaaaaoeiaabaioekaacaaaaadacaacdiaaaaabllb
abaaoekafkaaaaaeabaaciiaacaaoeiaacaaoeiaadaaaakaahaaaaacabaaciia
abaappiaagaaaaacabaaciiaabaappiaacaaaaadabaadiiaabaappibabaappka
acaaaaadaaaacoiaabaabliaaaaablkbalaaaaadabaachiaaaaabliaadaaaaka
aiaaaaadaaaacciaabaaoeiaadaakkkaafaaaaadaaaacciaabaappiaaaaaffia
aeaaaaaeaaaaabiaacaaaakaaaaaaaiaacaaffkaagaaaaacaaaaabiaaaaaaaia
acaaaaadaaaaabiaaaaaaaibadaaffkafiaaaaaeaaaacpiaaaaaaaiaadaaaaka
aaaaffiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcgmacaaaaeaaaaaaa
jlaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaaaaaaaajdcaabaaaaaaaaaaaogbkbaiaebaaaaaaabaaaaaa
egiacaaaaaaaaaaaajaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaaacaaaaj
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaaaaaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaiaebaaaaaa
aaaaaaaaagaaaaaadeaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabaaaaaakccaabaaaaaaaaaaajgahbaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaalccaabaaa
aaaaaaaaakiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaabkiacaaaabaaaaaa
ahaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaakehahndp
bkaabaaaaaaaaaaaabaaaaahpccabaaaaaaaaaaaagaabaaaaaaaaaaafgafbaaa
aaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 231726
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
uniform sampler2D _Skybox;
uniform vec4 _SunThreshold;
uniform vec4 _SunPosition;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 outColor_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Skybox, xlv_TEXCOORD0);
  vec2 tmpvar_3;
  tmpvar_3 = (_SunPosition.xy - xlv_TEXCOORD0);
  float tmpvar_4;
  tmpvar_4 = clamp ((_SunPosition.w - sqrt(
    dot (tmpvar_3, tmpvar_3)
  )), 0.0, 1.0);
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  float tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_6 = (abs((tmpvar_2.xyz - texture2D (_MainTex, xlv_TEXCOORD0).xyz)) * unity_ColorSpaceLuminance.xyz);
  tmpvar_5 = (((tmpvar_6.x + tmpvar_6.y) + tmpvar_6.z) + ((2.0 * 
    sqrt((tmpvar_6.y * (tmpvar_6.x + tmpvar_6.z)))
  ) * unity_ColorSpaceLuminance.w));
  if ((tmpvar_5 < 0.2)) {
    outColor_1 = vec4((dot (max (
      (tmpvar_2.xyz - _SunThreshold.xyz)
    , vec3(0.0, 0.0, 0.0)), vec3(1.0, 1.0, 1.0)) * tmpvar_4));
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
ConstBuffer "$Globals" 176
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedocfaccidloibkgbbomeffdgkkpdkodcjabaaaaaahmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcieabaaaaeaaaabaagbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedgpligjebalibbimgnfeojjiadombjnojabaaaaaalmadaaaaaeaaaaaa
daaaaaaagmabaaaapiacaaaaemadaaaaebgpgodjdeabaaaadeabaaaaaaacpopp
peaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaakaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaaeoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaloaabaacejappppaaaafdeieefcieabaaaaeaaaabaagbaaaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaai
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
Vector 2 [_SunPosition]
Vector 1 [_SunThreshold]
Vector 0 [unity_ColorSpaceLuminance]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Skybox] 2D 1
"ps_2_0
def c3, 0, 2, -0.200000003, 1
dcl t0.xy
dcl t1.xy
dcl_2d s0
dcl_2d s1
texld r0, t0, s0
texld_pp r1, t1, s1
add r0.xyz, -r0, r1
add_pp r1.xyz, r1, -c1
max_pp r2.xyz, r1, c3.x
dp3_pp r0.w, r2, c3.w
abs_pp r0.xyz, r0
mul_pp r1.xyz, r0, c0
add_pp r0.x, r1.z, r1.x
mul_pp r0.x, r0.x, r1.y
add_pp r0.y, r1.y, r1.x
mad_pp r0.y, r0.z, c0.z, r0.y
rsq_pp r0.x, r0.x
rcp_pp r0.x, r0.x
mul_pp r0.x, r0.x, c0.w
mad_pp r0.x, r0.x, c3.y, r0.y
add r0.x, r0.x, c3.z
add_pp r1.xy, -t1, c2
dp2add_pp r0.y, r1, r1, c3.x
rsq_pp r0.y, r0.y
rcp_pp r0.y, r0.y
add_sat_pp r0.y, -r0.y, c2.w
mul_pp r0.y, r0.y, r0.w
cmp_pp r0, r0.x, c3.x, r0.y
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_Skybox] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Vector 48 [unity_ColorSpaceLuminance]
Vector 96 [_SunThreshold]
Vector 144 [_SunPosition]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkammilgggmlciocblnlgodkoplalpkocabaaaaaaniadaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaadaaaaeaaaaaaamaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaagaaaaaa
deaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabaaaaaakicaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaajhcaabaaaabaaaaaaegacbaia
ibaaaaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaaaaaaaaahdcaabaaaaaaaaaaa
jgafbaaaabaaaaaaagaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackaabaiaibaaaaaa
aaaaaaaackiacaaaaaaaaaaaadaaaaaaakaabaaaaaaaaaaaelaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaapaaaaaiccaabaaaaaaaaaaapgipcaaaaaaaaaaa
adaaaaaafgafbaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
mnmmemdoaaaaaaajgcaabaaaaaaaaaaakgblbaiaebaaaaaaabaaaaaaagibcaaa
aaaaaaaaajaaaaaaapaaaaahccaabaaaaaaaaaaajgafbaaaaaaaaaaajgafbaaa
aaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaacaaaajccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaaabaaaaahpccabaaa
aaaaaaaafgafbaaaaaaaaaaaagaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_Skybox] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Vector 48 [unity_ColorSpaceLuminance]
Vector 96 [_SunThreshold]
Vector 144 [_SunPosition]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedfjdmffneifmbokpppcolammfcbgonmpaabaaaaaaniaeaaaaaeaaaaaa
daaaaaaaoaabaaaadeaeaaaakeaeaaaaebgpgodjkiabaaaakiabaaaaaaacpppp
fiabaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaabaaaaaa
aaababaaaaaaadaaabaaaaaaaaaaaaaaaaaaagaaabaaabaaaaaaaaaaaaaaajaa
abaaacaaaaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaaaamnmmemloaaaaiadp
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkaacaaaaadaaaacdiaaaaabllbacaaoekafkaaaaaeaaaacbia
aaaaoeiaaaaaoeiaadaaaakaahaaaaacaaaacbiaaaaaaaiaagaaaaacaaaacbia
aaaaaaiaacaaaaadaaaadbiaaaaaaaibacaappkaabaaaaacabaaadiaaaaablla
ecaaaaadabaacpiaabaaoeiaabaioekaecaaaaadacaaapiaaaaaoelaaaaioeka
acaaaaadaaaacoiaabaabliaabaablkbalaaaaadadaachiaaaaabliaadaaaaka
aiaaaaadabaaciiaadaaoeiaadaakkkaafaaaaadabaaciiaaaaaaaiaabaappia
acaaaaadaaaaahiaabaaoeiaacaaoeibcdaaaaacaaaachiaaaaaoeiaaiaaaaad
aaaacbiaaaaaoeiaaaaaoekaacaaaaadaaaaabiaaaaaaaiaadaaffkafiaaaaae
aaaacpiaaaaaaaiaadaaaakaabaappiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcemacaaaaeaaaaaaajdaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaaaaaaajdcaabaaaaaaaaaaaogbkbaiaebaaaaaaabaaaaaaegiacaaa
aaaaaaaaajaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaa
aaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaaacaaaajbcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
aaaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaa
agaaaaaadeaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaabaaaaaakccaabaaaaaaaaaaajgahbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaaiocaabaaaaaaaaaaa
agajbaaaabaaaaaaagajbaiaebaaaaaaacaaaaaabaaaaaajccaabaaaaaaaaaaa
jgahbaiaibaaaaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadbaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaamnmmemdoabaaaaahpccabaaaaaaaaaaa
agaabaaaaaaaaaaafgafbaaaaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 300010
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
uniform sampler2D _ColorBuffer;
uniform vec4 _SunColor;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_FragData[0] = (texture2D (_MainTex, xlv_TEXCOORD0) + clamp ((texture2D (_ColorBuffer, xlv_TEXCOORD0) * _SunColor), 0.0, 1.0));
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
ConstBuffer "$Globals" 176
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedocfaccidloibkgbbomeffdgkkpdkodcjabaaaaaahmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcieabaaaaeaaaabaagbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajiccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedgpligjebalibbimgnfeojjiadombjnojabaaaaaalmadaaaaaeaaaaaa
daaaaaaagmabaaaapiacaaaaemadaaaaebgpgodjdeabaaaadeabaaaaaaacpopp
peaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaakaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaaeoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaloaabaacejappppaaaafdeieefcieabaaaaeaaaabaagbaaaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaai
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
Vector 0 [_SunColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ColorBuffer] 2D 1
"ps_2_0
dcl t0.xy
dcl t1.xy
dcl_2d s0
dcl_2d s1
texld_pp r0, t1, s1
texld_pp r1, t0, s0
mul_sat_pp r0, r0, c0
add_pp r0, r0, r1
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ColorBuffer] 2D 1
ConstBuffer "$Globals" 176
Vector 112 [_SunColor]
BindCB  "$Globals" 0
"ps_4_0
eefieceddllpbenlemoiikncdjmafnfcnpanmcmgabaaaaaanmabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaeabaaaaeaaaaaaaebaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadicaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pccabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_ColorBuffer] 2D 1
ConstBuffer "$Globals" 176
Vector 112 [_SunColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedijmlacjmbcebmkgegacdhkhhbpiobemgabaaaaaakeacaaaaaeaaaaaa
daaaaaaapeaaaaaaaaacaaaahaacaaaaebgpgodjlmaaaaaalmaaaaaaaaacpppp
ieaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaahaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaabaaaaacaaaaadia
aaaabllaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadabaacpiaaaaaoela
aaaioekaafaaaaadaaaadpiaaaaaoeiaaaaaoekaacaaaaadaaaacpiaaaaaoeia
abaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcaeabaaaaeaaaaaaa
ebaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadicaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
}
 }
}
Fallback Off
}