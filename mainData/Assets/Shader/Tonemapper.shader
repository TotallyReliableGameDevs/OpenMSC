Shader "Hidden/Tonemapper" {
Properties {
 _MainTex ("", 2D) = "black" { }
 _SmallTex ("", 2D) = "grey" { }
 _Curve ("", 2D) = "black" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 14459
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
uniform sampler2D _SmallTex;
uniform vec4 _HdrParams;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.w = tmpvar_2.w;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2.xyz * unity_ColorSpaceLuminance.xyz);
  float tmpvar_4;
  tmpvar_4 = max (1e-06, ((
    (tmpvar_3.x + tmpvar_3.y)
   + tmpvar_3.z) + (
    (2.0 * sqrt((tmpvar_3.y * (tmpvar_3.x + tmpvar_3.z))))
   * unity_ColorSpaceLuminance.w)));
  float tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * _HdrParams.z) / (0.001 + texture2D (_SmallTex, xlv_TEXCOORD0).x));
  color_1.xyz = (tmpvar_2.xyz * ((
    (tmpvar_5 * (1.0 + (tmpvar_5 / _HdrParams.w)))
   / 
    (1.0 + tmpvar_5)
  ) / tmpvar_4));
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
Vector 1 [_HdrParams]
Vector 0 [unity_ColorSpaceLuminance]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SmallTex] 2D 1
"ps_2_0
def c2, 2, 9.99999997e-007, 0.00100000005, 1
dcl t0.xy
dcl_2d s0
dcl_2d s1
texld r0, t0, s0
texld r1, t0, s1
mul_pp r1.yzw, r0.wzyx, c0.wzyx
add_pp r1.y, r1.y, r1.w
mul_pp r1.y, r1.y, r1.z
add_pp r1.z, r1.z, r1.w
mad_pp r1.z, r0.z, c0.z, r1.z
rsq_pp r1.y, r1.y
rcp_pp r1.y, r1.y
mul_pp r1.y, r1.y, c0.w
mad_pp r1.y, r1.y, c2.x, r1.z
max r2.w, c2.y, r1.y
mul r1.y, r2.w, c1.z
rcp r1.z, r2.w
add r1.x, r1.x, c2.z
rcp r1.x, r1.x
mul r1.w, r1.x, r1.y
mad r1.x, r1.y, r1.x, c2.w
rcp r1.x, r1.x
rcp r1.y, c1.w
mad r1.y, r1.w, r1.y, c2.w
mul r1.y, r1.y, r1.w
mul r1.x, r1.x, r1.y
mul r1.x, r1.z, r1.x
mul r0.xyz, r0, r1.x
mov oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_SmallTex] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 48 [unity_ColorSpaceLuminance]
Vector 96 [_HdrParams]
BindCB  "$Globals" 0
"ps_4_0
eefieceddnoffjgmenanobieklggdenfdffmlcghabaaaaaajmadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmacaaaa
eaaaaaaalhaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaagpbciddkefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaiocaabaaaaaaaaaaa
agajbaaaabaaaaaaagijcaaaaaaaaaaaadaaaaaaaaaaaaahkcaabaaaaaaaaaaa
kgaobaaaaaaaaaaafgafbaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaackaabaaaabaaaaaa
ckiacaaaaaaaaaaaadaaaaaabkaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaapaaaaaiecaabaaaaaaaaaaapgipcaaaaaaaaaaaadaaaaaa
kgakbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaalndhigdf
diaaaaaiecaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaa
aoaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaaoaaaaai
ecaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaaaaaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaahbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaaaoaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_SmallTex] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 48 [unity_ColorSpaceLuminance]
Vector 96 [_HdrParams]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedohcbfamnejhjoonhblllmiddimfbnakiabaaaaaajeaeaaaaaeaaaaaa
daaaaaaaneabaaaaaiaeaaaagaaeaaaaebgpgodjjmabaaaajmabaaaaaaacpppp
fiabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaabaaaaaa
aaababaaaaaaadaaabaaaaaaaaaaaaaaaaaaagaaabaaabaaaaaaaaaaaaacpppp
fbaaaaafacaaapkalndhigdfgpbciddkaaaaiadpaaaaaaaabpaaaaacaaaaaaia
aaaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaaaaaoelaabaioekaecaaaaadabaaapiaaaaaoelaaaaioekaagaaaaac
aaaaaciaabaappkaacaaaaadaaaaabiaaaaaaaiaacaaffkaagaaaaacaaaaabia
aaaaaaiaaiaaaaadaaaaceiaabaaoeiaaaaaoekaalaaaaadacaaaiiaacaaaaka
aaaakkiaafaaaaadaaaaaeiaacaappiaabaakkkaagaaaaacaaaaaiiaacaappia
afaaaaadacaaabiaaaaaaaiaaaaakkiaaeaaaaaeaaaaabiaaaaakkiaaaaaaaia
acaakkkaagaaaaacaaaaabiaaaaaaaiaaeaaaaaeaaaaaciaacaaaaiaaaaaffia
acaakkkaafaaaaadaaaaaciaaaaaffiaacaaaaiaafaaaaadaaaaabiaaaaaaaia
aaaaffiaafaaaaadaaaaabiaaaaappiaaaaaaaiaafaaaaadabaaahiaaaaaaaia
abaaoeiaabaaaaacaaaiapiaabaaoeiappppaaaafdeieefccmacaaaaeaaaaaaa
ilaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaagpbciddkefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaabaaaaaaiccaabaaaaaaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaalndhigdfdiaaaaaiecaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaagaaaaaaaoaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaaaaaaaaaaoaaaaaiecaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaa
aaaaaaaaagaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaaoaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
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
  GpuProgramID 112276
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
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, (xlv_TEXCOORD0 - _MainTex_TexelSize.xy)).xyz * unity_ColorSpaceLuminance.xyz);
  vec3 tmpvar_2;
  tmpvar_2 = (texture2D (_MainTex, (xlv_TEXCOORD0 + _MainTex_TexelSize.xy)).xyz * unity_ColorSpaceLuminance.xyz);
  vec3 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, (xlv_TEXCOORD0 + (_MainTex_TexelSize.xy * vec2(-1.0, 1.0)))).xyz * unity_ColorSpaceLuminance.xyz);
  vec3 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, (xlv_TEXCOORD0 + (_MainTex_TexelSize.xy * vec2(1.0, -1.0)))).xyz * unity_ColorSpaceLuminance.xyz);
  float tmpvar_5;
  tmpvar_5 = (((
    (log(((
      ((tmpvar_1.x + tmpvar_1.y) + tmpvar_1.z)
     + 
      ((2.0 * sqrt((tmpvar_1.y * 
        (tmpvar_1.x + tmpvar_1.z)
      ))) * unity_ColorSpaceLuminance.w)
    ) + 0.0001)) + log(((
      ((tmpvar_2.x + tmpvar_2.y) + tmpvar_2.z)
     + 
      ((2.0 * sqrt((tmpvar_2.y * 
        (tmpvar_2.x + tmpvar_2.z)
      ))) * unity_ColorSpaceLuminance.w)
    ) + 0.0001)))
   + 
    log((((
      (tmpvar_3.x + tmpvar_3.y)
     + tmpvar_3.z) + (
      (2.0 * sqrt((tmpvar_3.y * (tmpvar_3.x + tmpvar_3.z))))
     * unity_ColorSpaceLuminance.w)) + 0.0001))
  ) + log(
    ((((tmpvar_4.x + tmpvar_4.y) + tmpvar_4.z) + ((2.0 * 
      sqrt((tmpvar_4.y * (tmpvar_4.x + tmpvar_4.z)))
    ) * unity_ColorSpaceLuminance.w)) + 0.0001)
  )) / 4.0);
  vec4 tmpvar_6;
  tmpvar_6.x = tmpvar_5;
  tmpvar_6.y = tmpvar_5;
  tmpvar_6.z = tmpvar_5;
  tmpvar_6.w = tmpvar_5;
  gl_FragData[0] = tmpvar_6;
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
Vector 1 [_MainTex_TexelSize]
Vector 0 [unity_ColorSpaceLuminance]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c2, -1, 1, -1, 0
def c3, 2, 9.99999975e-005, 0.693147182, 0.25
dcl t0.xy
dcl_2d s0
add r0.xy, t0, c1
add r1.xy, t0, -c1
mov r2.xy, c1
mad r3.xy, r2, c2, t0
mad r2.xy, r2, c2.yzxw, t0
texld_pp r0, r0, s0
texld_pp r1, r1, s0
texld_pp r3, r3, s0
texld_pp r2, r2, s0
mul_pp r4.xyz, r0, c0
add_pp r1.w, r4.z, r4.x
mul_pp r1.w, r1.w, r4.y
add_pp r2.w, r4.y, r4.x
mad_pp r2.w, r0.z, c0.z, r2.w
rsq_pp r1.w, r1.w
rcp_pp r1.w, r1.w
mul_pp r1.w, r1.w, c0.w
mad_pp r1.w, r1.w, c3.x, r2.w
add r1.w, r1.w, c3.y
log r1.w, r1.w
mul r1.w, r1.w, c3.z
mul_pp r0.xyz, r1, c0
add_pp r2.w, r0.z, r0.x
mul_pp r2.w, r0.y, r2.w
add_pp r3.w, r0.y, r0.x
mad_pp r3.w, r1.z, c0.z, r3.w
rsq_pp r2.w, r2.w
rcp_pp r2.w, r2.w
mul_pp r2.w, r2.w, c0.w
mad_pp r2.w, r2.w, c3.x, r3.w
add r2.w, r2.w, c3.y
log r2.w, r2.w
mad r2.w, r2.w, c3.z, r1.w
mul_pp r0.xyz, r3, c0
add_pp r0.z, r0.z, r0.x
mul_pp r0.z, r0.z, r0.y
add_pp r0.x, r0.y, r0.x
mad_pp r0.x, r3.z, c0.z, r0.x
rsq_pp r0.y, r0.z
rcp_pp r0.y, r0.y
mul_pp r0.y, r0.y, c0.w
mad_pp r0.x, r0.y, c3.x, r0.x
add r0.x, r0.x, c3.y
log r0.x, r0.x
mad r2.w, r0.x, c3.z, r2.w
mul_pp r0.xyz, r2, c0
add_pp r0.z, r0.z, r0.x
mul_pp r0.z, r0.z, r0.y
add_pp r0.x, r0.y, r0.x
mad_pp r0.x, r2.z, c0.z, r0.x
rsq_pp r0.y, r0.z
rcp_pp r0.y, r0.y
mul_pp r0.y, r0.y, c0.w
mad_pp r0.x, r0.y, c3.x, r0.x
add r0.x, r0.x, c3.y
log r0.x, r0.x
mad r0.x, r0.x, c3.z, r2.w
mul r0, r0.x, c3.w
mov oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 48 [unity_ColorSpaceLuminance]
Vector 128 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpmkfiikmmfeimoejkekgccgmklbbdiimabaaaaaanaagaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbaagaaaa
eaaaaaaaieabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaaidcaabaaaaaaaaaaa
egbabaaaabaaaaaaegiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaailcaabaaa
aaaaaaaaegaibaaaaaaaaaaaegiicaaaaaaaaaaaadaaaaaaaaaaaaahjcaabaaa
aaaaaaaafganbaaaaaaaaaaaagaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaaa
aaaaaaaackiacaaaaaaaaaaaadaaaaaaakaabaaaaaaaaaaaelaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaapaaaaaiccaabaaaaaaaaaaapgipcaaaaaaaaaaa
adaaaaaafgafbaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
bhlhnbdicpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaabihcdbdpaaaaaaajgcaabaaaaaaaaaaa
agbbbaaaabaaaaaaagibcaiaebaaaaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaa
abaaaaaajgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
ocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaadaaaaaaaaaaaaah
kcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaaaaaaaaadiaaaaahecaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaa
ckaabaaaabaaaaaackiacaaaaaaaaaaaadaaaaaabkaabaaaaaaaaaaaelaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaaapaaaaaiecaabaaaaaaaaaaapgipcaaa
aaaaaaaaadaaaaaakgakbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaabhlhnbdicpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaabihcdbdpakaabaaaaaaaaaaa
dcaaaaanpcaabaaaabaaaaaaegiecaaaaaaaaaaaaiaaaaaaaceaaaaaaaaaialp
aaaaiadpaaaaiadpaaaaialpegbebaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
ocaabaaaaaaaaaaaagajbaaaacaaaaaaagijcaaaaaaaaaaaadaaaaaaaaaaaaah
kcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaaaaaaaaadiaaaaahecaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaa
ckaabaaaacaaaaaackiacaaaaaaaaaaaadaaaaaabkaabaaaaaaaaaaaelaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaaapaaaaaiecaabaaaaaaaaaaapgipcaaa
aaaaaaaaadaaaaaakgakbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaabhlhnbdicpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaabihcdbdpakaabaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaadaaaaaa
aaaaaaahkcaabaaaaaaaaaaakgaobaaaaaaaaaaafgafbaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakccaabaaa
aaaaaaaackaabaaaabaaaaaackiacaaaaaaaaaaaadaaaaaabkaabaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaapaaaaaiecaabaaaaaaaaaaa
pgipcaaaaaaaaaaaadaaaaaakgakbaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaabhlhnbdicpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaabihcdbdpakaabaaa
aaaaaaaadiaaaaakpccabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiado
aaaaiadoaaaaiadoaaaaiadodoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 48 [unity_ColorSpaceLuminance]
Vector 128 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedhdahodleninfpafmneppbejcdnialihnabaaaaaafiagaaaaaeaaaaaa
daaaaaaaheacaaaammafaaaaceagaaaaebgpgodjdmacaaaadmacaaaaaaacpppp
pmabaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaadaaabaaaaaaaaaaaaaaaaaaaiaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkabhlhnbdibihcdbdpaaaaiadpaaaaialpfbaaaaafadaaapkaaaaaiado
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaja
aaaiapkaacaaaaadaaaaadiaaaaaoelaabaaoekaacaaaaadabaaadiaaaaaoela
abaaoekbabaaaaacaaaaamiaacaaoekaaeaaaaaeacaaadiaabaaoekaaaaablia
aaaaoelaaeaaaaaeadaaadiaabaaoekaaaaablibaaaaoelaecaaaaadaaaacpia
aaaaoeiaaaaioekaecaaaaadabaacpiaabaaoeiaaaaioekaecaaaaadacaacpia
acaaoeiaaaaioekaecaaaaadadaacpiaadaaoeiaaaaioekaaiaaaaadabaaciia
aaaaoeiaaaaaoekaacaaaaadabaaaiiaabaappiaacaaaakaapaaaaacabaaaiia
abaappiaafaaaaadabaaaiiaabaappiaacaaffkaaiaaaaadacaaciiaabaaoeia
aaaaoekaacaaaaadacaaaiiaacaappiaacaaaakaapaaaaacacaaaiiaacaappia
aeaaaaaeacaaaiiaacaappiaacaaffkaabaappiaaiaaaaadadaaciiaacaaoeia
aaaaoekaacaaaaadadaaaiiaadaappiaacaaaakaapaaaaacadaaaiiaadaappia
aeaaaaaeadaaaiiaadaappiaacaaffkaacaappiaaiaaaaadaaaacbiaadaaoeia
aaaaoekaacaaaaadaaaaabiaaaaaaaiaacaaaakaapaaaaacaaaaabiaaaaaaaia
aeaaaaaeaaaaabiaaaaaaaiaacaaffkaadaappiaafaaaaadaaaaapiaaaaaaaia
adaaaakaabaaaaacaaaiapiaaaaaoeiappppaaaafdeieefcfaadaaaaeaaaaaaa
neaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaaidcaabaaaaaaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaabhlhnbdicpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaabihcdbdp
aaaaaaajgcaabaaaaaaaaaaaagbbbaaaabaaaaaaagibcaiaebaaaaaaaaaaaaaa
aiaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaabaaaaaaiccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaadaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
bhlhnbdicpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaabihcdbdpakaabaaaaaaaaaaadcaaaaan
pcaabaaaabaaaaaaegiecaaaaaaaaaaaaiaaaaaaaceaaaaaaaaaialpaaaaiadp
aaaaiadpaaaaialpegbebaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaaiccaabaaa
aaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaaaaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaabhlhnbdicpaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabaaaaaaiecaabaaaaaaaaaaaegacbaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
bhlhnbdicpaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaabihcdbdpakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaabihcdbdpakaabaaaaaaaaaaa
diaaaaakpccabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiado
aaaaiadoaaaaiadodoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  GpuProgramID 150674
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
uniform float _AdaptionSpeed;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = exp(((
    ((texture2D (_MainTex, (xlv_TEXCOORD0 - _MainTex_TexelSize.xy)).xy + texture2D (_MainTex, (xlv_TEXCOORD0 + _MainTex_TexelSize.xy)).xy) + texture2D (_MainTex, (xlv_TEXCOORD0 + (_MainTex_TexelSize.xy * vec2(1.0, -1.0)))).xy)
   + texture2D (_MainTex, 
    (xlv_TEXCOORD0 + (_MainTex_TexelSize.xy * vec2(-1.0, 1.0)))
  ).xy) / 4.0));
  vec4 tmpvar_2;
  tmpvar_2.xy = tmpvar_1;
  tmpvar_2.z = tmpvar_1.x;
  tmpvar_2.w = clamp ((0.0125 * _AdaptionSpeed), 0.0, 1.0);
  gl_FragData[0] = tmpvar_2;
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
Float 1 [_AdaptionSpeed]
Vector 0 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c2, 1, -1, 1, 0.360673755
def c3, 0.0125000002, 0, 0, 0
dcl t0.xy
dcl_2d s0
add r0.xy, t0, -c0
add r1.xy, t0, c0
mov r2.xy, c0
mad r3.xy, r2, c2, t0
mad r2.xy, r2, c2.yzxw, t0
texld r0, r0, s0
texld r1, r1, s0
texld r3, r3, s0
texld r2, r2, s0
add r0.xy, r0, r1
add r0.xy, r3, r0
add r0.xy, r2, r0
mul r0.xy, r0, c2.w
exp r1.xz, r0.x
exp r1.y, r0.y
mov r0.x, c1.x
mul_sat r1.w, r0.x, c3.x
mov oC0, r1

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 128 [_MainTex_TexelSize]
Float 144 [_AdaptionSpeed]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjekhbfohocnedgblhincmpnofkganafiabaaaaaanaacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaa
eaaaaaaaieaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajdcaabaaaaaaaaaaa
egbabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaai
mcaabaaaaaaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaaiaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaan
pcaabaaaabaaaaaaegiecaaaaaaaaaaaaiaaaaaaaceaaaaaaaaaiadpaaaaialp
aaaaialpaaaaiadpegbebaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegaabaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egaabaaaabaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaadlkklidodlkklidodlkklidoaaaaaaaabjaaaaafhccabaaa
aaaaaaaaegacbaaaaaaaaaaadicaaaaiiccabaaaaaaaaaaaakiacaaaaaaaaaaa
ajaaaaaaabeaaaaamnmmemdmdoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 128 [_MainTex_TexelSize]
Float 144 [_AdaptionSpeed]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedgckmbniabbndjmbijoddkmbebmanbmdeabaaaaaaheaeaaaaaeaaaaaa
daaaaaaanaabaaaaoiadaaaaeaaeaaaaebgpgodjjiabaaaajiabaaaaaaacpppp
geabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaaiaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaiadpaaaaialp
aaaaiadpdlkklidofbaaaaafadaaapkamnmmemdmaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapkaacaaaaadaaaaadia
aaaaoelaaaaaoekbacaaaaadabaaadiaaaaaoelaaaaaoekaabaaaaacacaaadia
aaaaoekaaeaaaaaeadaaadiaacaaoeiaacaaoekaaaaaoelaaeaaaaaeacaaadia
acaaoeiaacaamjkaaaaaoelaecaaaaadaaaaapiaaaaaoeiaaaaioekaecaaaaad
abaaapiaabaaoeiaaaaioekaecaaaaadadaaapiaadaaoeiaaaaioekaecaaaaad
acaaapiaacaaoeiaaaaioekaacaaaaadaaaaadiaaaaaoeiaabaaoeiaacaaaaad
aaaaadiaadaaoeiaaaaaoeiaacaaaaadaaaaadiaacaaoeiaaaaaoeiaafaaaaad
aaaaadiaaaaaoeiaacaappkaaoaaaaacabaaafiaaaaaaaiaaoaaaaacabaaacia
aaaaffiaabaaaaacaaaaabiaabaaaakaafaaaaadabaabiiaaaaaaaiaadaaaaka
abaaaaacaaaiapiaabaaoeiappppaaaafdeieefcbaacaaaaeaaaaaaaieaaaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaaaaaaajdcaabaaaaaaaaaaaegbabaaaabaaaaaa
egiacaiaebaaaaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaimcaabaaaaaaaaaaa
agbebaaaabaaaaaaagiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaanpcaabaaaabaaaaaa
egiecaaaaaaaaaaaaiaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaialpaaaaiadp
egbebaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegaabaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegaabaaaabaaaaaa
egacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
dlkklidodlkklidodlkklidoaaaaaaaabjaaaaafhccabaaaaaaaaaaaegacbaaa
aaaaaaaadicaaaaiiccabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaabeaaaaa
mnmmemdmdoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
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
  GpuProgramID 208094
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
uniform float _AdaptionSpeed;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = exp(((
    ((texture2D (_MainTex, (xlv_TEXCOORD0 - _MainTex_TexelSize.xy)).xy + texture2D (_MainTex, (xlv_TEXCOORD0 + _MainTex_TexelSize.xy)).xy) + texture2D (_MainTex, (xlv_TEXCOORD0 + (_MainTex_TexelSize.xy * vec2(1.0, -1.0)))).xy)
   + texture2D (_MainTex, 
    (xlv_TEXCOORD0 + (_MainTex_TexelSize.xy * vec2(-1.0, 1.0)))
  ).xy) / 4.0));
  vec4 tmpvar_2;
  tmpvar_2.xy = tmpvar_1;
  tmpvar_2.z = tmpvar_1.x;
  tmpvar_2.w = clamp ((0.0125 * _AdaptionSpeed), 0.0, 1.0);
  gl_FragData[0] = tmpvar_2;
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
Float 1 [_AdaptionSpeed]
Vector 0 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c2, 1, -1, 1, 0.360673755
def c3, 0.0125000002, 0, 0, 0
dcl t0.xy
dcl_2d s0
add r0.xy, t0, -c0
add r1.xy, t0, c0
mov r2.xy, c0
mad r3.xy, r2, c2, t0
mad r2.xy, r2, c2.yzxw, t0
texld r0, r0, s0
texld r1, r1, s0
texld r3, r3, s0
texld r2, r2, s0
add r0.xy, r0, r1
add r0.xy, r3, r0
add r0.xy, r2, r0
mul r0.xy, r0, c2.w
exp r1.xz, r0.x
exp r1.y, r0.y
mov r0.x, c1.x
mul_sat r1.w, r0.x, c3.x
mov oC0, r1

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 128 [_MainTex_TexelSize]
Float 144 [_AdaptionSpeed]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjekhbfohocnedgblhincmpnofkganafiabaaaaaanaacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaa
eaaaaaaaieaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajdcaabaaaaaaaaaaa
egbabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaai
mcaabaaaaaaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaaiaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaan
pcaabaaaabaaaaaaegiecaaaaaaaaaaaaiaaaaaaaceaaaaaaaaaiadpaaaaialp
aaaaialpaaaaiadpegbebaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegaabaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egaabaaaabaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaadlkklidodlkklidodlkklidoaaaaaaaabjaaaaafhccabaaa
aaaaaaaaegacbaaaaaaaaaaadicaaaaiiccabaaaaaaaaaaaakiacaaaaaaaaaaa
ajaaaaaaabeaaaaamnmmemdmdoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 128 [_MainTex_TexelSize]
Float 144 [_AdaptionSpeed]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedgckmbniabbndjmbijoddkmbebmanbmdeabaaaaaaheaeaaaaaeaaaaaa
daaaaaaanaabaaaaoiadaaaaeaaeaaaaebgpgodjjiabaaaajiabaaaaaaacpppp
geabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaaiaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaiadpaaaaialp
aaaaiadpdlkklidofbaaaaafadaaapkamnmmemdmaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapkaacaaaaadaaaaadia
aaaaoelaaaaaoekbacaaaaadabaaadiaaaaaoelaaaaaoekaabaaaaacacaaadia
aaaaoekaaeaaaaaeadaaadiaacaaoeiaacaaoekaaaaaoelaaeaaaaaeacaaadia
acaaoeiaacaamjkaaaaaoelaecaaaaadaaaaapiaaaaaoeiaaaaioekaecaaaaad
abaaapiaabaaoeiaaaaioekaecaaaaadadaaapiaadaaoeiaaaaioekaecaaaaad
acaaapiaacaaoeiaaaaioekaacaaaaadaaaaadiaaaaaoeiaabaaoeiaacaaaaad
aaaaadiaadaaoeiaaaaaoeiaacaaaaadaaaaadiaacaaoeiaaaaaoeiaafaaaaad
aaaaadiaaaaaoeiaacaappkaaoaaaaacabaaafiaaaaaaaiaaoaaaaacabaaacia
aaaaffiaabaaaaacaaaaabiaabaaaakaafaaaaadabaabiiaaaaaaaiaadaaaaka
abaaaaacaaaiapiaabaaoeiappppaaaafdeieefcbaacaaaaeaaaaaaaieaaaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaaaaaaajdcaabaaaaaaaaaaaegbabaaaabaaaaaa
egiacaiaebaaaaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaimcaabaaaaaaaaaaa
agbebaaaabaaaaaaagiecaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaanpcaabaaaabaaaaaa
egiecaaaaaaaaaaaaiaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaialpaaaaiadp
egbebaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegaabaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegaabaaaabaaaaaa
egacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
dlkklidodlkklidodlkklidoaaaaaaaabjaaaaafhccabaaaaaaaaaaaegacbaaa
aaaaaaaadicaaaaiiccabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaaabeaaaaa
mnmmemdmdoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
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
  GpuProgramID 278430
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
uniform sampler2D _Curve;
uniform float _RangeScale;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec3 cie_1;
  vec4 color_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_3.w;
  vec3 Yxy_4;
  vec3 tmpvar_5;
  tmpvar_5 = (mat3(0.5141364, 0.265068, 0.0241188, 0.3238786, 0.6702343, 0.1228178, 0.1603638, 0.06409157, 0.8444266) * tmpvar_3.xyz);
  Yxy_4.x = tmpvar_5.y;
  Yxy_4.yz = (tmpvar_5.xy / dot (vec3(1.0, 1.0, 1.0), tmpvar_5));
  cie_1.yz = Yxy_4.yz;
  vec2 tmpvar_6;
  tmpvar_6.y = 0.5;
  tmpvar_6.x = (tmpvar_5.y * _RangeScale);
  cie_1.x = texture2D (_Curve, tmpvar_6).x;
  vec3 XYZ_7;
  XYZ_7.x = ((cie_1.x * Yxy_4.y) / Yxy_4.z);
  XYZ_7.y = cie_1.x;
  XYZ_7.z = ((cie_1.x * (
    (1.0 - Yxy_4.y)
   - Yxy_4.z)) / Yxy_4.z);
  color_2.xyz = (mat3(2.5651, -1.0217, 0.0753, -1.1665, 1.9777, -0.2543, -0.3986, 0.0439, 1.1892) * XYZ_7);
  gl_FragData[0] = color_2;
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
Float 0 [_RangeScale]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Curve] 2D 1
"ps_2_0
def c1, 0.514136374, 0.323878586, 0.160363764, 1
def c2, 0.265067995, 0.670234263, 0.0640915707, 0.5
def c3, 0.0241187997, 0.122817799, 0.844426632, 0
def c4, 2.56509995, -1.16649997, -0.398600012, 0
def c5, -1.02170002, 1.9777, 0.0439000018, 0
def c6, 0.0753000006, -0.254299998, 1.18920004, 0
dcl t0.xy
dcl_2d s0
dcl_2d s1
texld r0, t0, s0
dp3 r1.z, c3, r0
dp3 r1.y, c2, r0
mul r2.x, r1.y, c0.x
dp3 r1.x, c1, r0
dp3 r1.z, c1.w, r1
rcp r1.z, r1.z
mad r1.w, r1.x, -r1.z, c1.w
mul r2.zw, r1.z, r1.wzyx
mad r1.x, r1.y, -r1.z, r1.w
mov r2.y, c2.w
texld r3, r2, s1
mul r1.x, r1.x, r3.x
rcp r1.y, r2.z
mul r1.z, r2.w, r3.x
mov r2.y, r3.x
mul r2.x, r1.y, r1.z
mul r2.z, r1.y, r1.x
dp3 r0.x, c4, r2
dp3 r0.y, c5, r2
dp3 r0.z, c6, r2
mov oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Curve] 2D 1
ConstBuffer "$Globals" 160
Float 152 [_RangeScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedcjonfnlnnoohidfppogmogoaolngpgnoabaaaaaahaadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclaacaaaa
eaaaaaaakmaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaakecaabaaaabaaaaaa
aceaaaaamkjemfdmogihpldnficmfidpaaaaaaaaegacbaaaaaaaaaaabaaaaaak
bcaabaaaabaaaaaaaceaaaaahbjoaddpgkndkfdoggdgcedoaaaaaaaaegacbaaa
aaaaaaaabaaaaaakccaabaaaabaaaaaaaceaaaaapolgihdohjjecldphbeciddn
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
baaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
egacbaaaabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegaabaaaabaaaaaaagaabaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaabaaaaaackiacaaaaaaaaaaa
ajaaaaaaaaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaadgaaaaafccaabaaaabaaaaaaabeaaaaaaaaaaadpefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaabghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaah
fcaabaaaaaaaaaaaagacbaaaaaaaaaaafgafbaaaabaaaaaaaoaaaaahfcaabaaa
abaaaaaaagacbaaaaaaaaaaafgafbaaaaaaaaaaabaaaaaakbccabaaaaaaaaaaa
aceaaaaajjckceeanpepjflpenbfmmloaaaaaaaaegacbaaaabaaaaaabaaaaaak
cccabaaaaaaaaaaaaceaaaaabbmhiclpegcfpndphnnadddnaaaaaaaaegacbaaa
abaaaaaabaaaaaakeccabaaaaaaaaaaaaceaaaaaoddgjkdnjmddiclolfdhjidp
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Curve] 2D 1
ConstBuffer "$Globals" 160
Float 152 [_RangeScale]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmmfpdcjdlbomancigkaajdkffeeodkllabaaaaaameafaaaaaeaaaaaa
daaaaaaaiaacaaaadiafaaaajaafaaaaebgpgodjeiacaaaaeiacaaaaaaacpppp
baacaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaajaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkapolgihdo
hjjecldphbeciddnaaaaaadpfbaaaaafacaaapkahbjoaddpgkndkfdoggdgcedo
aaaaiadpfbaaaaafadaaapkamkjemfdmogihpldnficmfidpaaaaaaaafbaaaaaf
aeaaapkajjckceeanpepjflpenbfmmloaaaaaaaafbaaaaafafaaapkabbmhiclp
egcfpndphnnadddnaaaaaaaafbaaaaafagaaapkaoddgjkdnjmddiclolfdhjidp
aaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkaecaaaaadaaaaapiaaaaaoelaaaaioekaaiaaaaadabaaaeia
adaaoekaaaaaoeiaaiaaaaadabaaaciaabaaoekaaaaaoeiaafaaaaadacaaabia
abaaffiaaaaakkkaaiaaaaadabaaabiaacaaoekaaaaaoeiaaiaaaaadabaaaeia
acaappkaabaaoeiaagaaaaacabaaaeiaabaakkiaaeaaaaaeabaaaiiaabaaaaia
abaakkibacaappkaafaaaaadacaaamiaabaakkiaabaabliaaeaaaaaeabaaabia
abaaffiaabaakkibabaappiaabaaaaacacaaaciaabaappkaecaaaaadadaaapia
acaaoeiaabaioekaafaaaaadabaaabiaabaaaaiaadaaaaiaagaaaaacabaaacia
acaakkiaafaaaaadabaaaeiaacaappiaadaaaaiaabaaaaacacaaaciaadaaaaia
afaaaaadacaaabiaabaaffiaabaakkiaafaaaaadacaaaeiaabaaffiaabaaaaia
aiaaaaadaaaaabiaaeaaoekaacaaoeiaaiaaaaadaaaaaciaafaaoekaacaaoeia
aiaaaaadaaaaaeiaagaaoekaacaaoeiaabaaaaacaaaiapiaaaaaoeiappppaaaa
fdeieefclaacaaaaeaaaaaaakmaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaak
ecaabaaaabaaaaaaaceaaaaamkjemfdmogihpldnficmfidpaaaaaaaaegacbaaa
aaaaaaaabaaaaaakbcaabaaaabaaaaaaaceaaaaahbjoaddpgkndkfdoggdgcedo
aaaaaaaaegacbaaaaaaaaaaabaaaaaakccaabaaaabaaaaaaaceaaaaapolgihdo
hjjecldphbeciddnaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaabaaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaegacbaaaabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegaabaaa
abaaaaaaagaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaabaaaaaa
ckiacaaaaaaaaaaaajaaaaaaaaaaaaaiecaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaadgaaaaafccaabaaaabaaaaaaabeaaaaaaaaaaadp
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaabghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaahfcaabaaaaaaaaaaaagacbaaaaaaaaaaafgafbaaaabaaaaaa
aoaaaaahfcaabaaaabaaaaaaagacbaaaaaaaaaaafgafbaaaaaaaaaaabaaaaaak
bccabaaaaaaaaaaaaceaaaaajjckceeanpepjflpenbfmmloaaaaaaaaegacbaaa
abaaaaaabaaaaaakcccabaaaaaaaaaaaaceaaaaabbmhiclpegcfpndphnnadddn
aaaaaaaaegacbaaaabaaaaaabaaaaaakeccabaaaaaaaaaaaaceaaaaaoddgjkdn
jmddiclolfdhjidpaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheofaaaaaaa
acaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
eeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 334458
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
uniform float _ExposureAdjustment;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (2.0 * (texture2D (_MainTex, xlv_TEXCOORD0).xyz * _ExposureAdjustment));
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (((
    ((tmpvar_1 * ((0.15 * tmpvar_1) + 0.05)) + 0.004)
   / 
    ((tmpvar_1 * ((0.15 * tmpvar_1) + 0.5)) + 0.06)
  ) - 0.06666666) * vec3(1.379064, 1.379064, 1.379064));
  gl_FragData[0] = tmpvar_2;
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
Float 0 [_ExposureAdjustment]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c1, 0.300000012, 0.0500000007, 0.00400000019, 0.5
def c2, 0.0599999987, -0.0666666701, 1.37906432, 1
dcl t0.xy
dcl_2d s0
texld r0, t0, s0
mul r0.xyz, r0, c0.x
mad r1.xyz, r0, c1.x, c1.y
add r2.xyz, r0, r0
mad r0.xyz, r0, c1.x, c1.w
mad r0.xyz, r2, r0, c2.x
mad r1.xyz, r2, r1, c1.z
rcp r2.x, r0.x
rcp r2.y, r0.y
rcp r2.z, r0.z
mad r0.xyz, r1, r2, c2.y
mul r0.xyz, r0, c2.z
mov r0.w, c2.w
mov oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Float 148 [_ExposureAdjustment]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhojnodjhknamjgkomilcccficmgmnclgabaaaaaanaacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaa
eaaaaaaaieaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaaajaaaaaadcaaaaaphcaabaaa
abaaaaaaegacbaaaaaaaaaaaaceaaaaajkjjjjdojkjjjjdojkjjjjdoaaaaaaaa
aceaaaaamnmmemdnmnmmemdnmnmmemdnaaaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaajkjjjjdojkjjjjdojkjjjjdoaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaaaceaaaaaipmchfdnipmchfdnipmchfdnaaaaaaaadcaaaaam
hcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaceaaaaagpbciddl
gpbciddlgpbciddlaaaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
ijiiiilnijiiiilnijiiiilnaaaaaaaadiaaaaakhccabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaacoifladpcoifladpcoifladpaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Float 148 [_ExposureAdjustment]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjnneogenclebojbdkfdeffnbnpkeoaaeabaaaaaaeaaeaaaaaeaaaaaa
daaaaaaajmabaaaaleadaaaaamaeaaaaebgpgodjgeabaaaageabaaaaaaacpppp
daabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaajaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkajkjjjjdomnmmemdn
gpbciddlaaaaaadpfbaaaaafacaaapkaipmchfdnijiiiilncoifladpaaaaiadp
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
aaaaoelaaaaioekaafaaaaadaaaaahiaaaaaoeiaaaaaffkaaeaaaaaeabaaahia
aaaaoeiaabaaaakaabaaffkaacaaaaadacaaahiaaaaaoeiaaaaaoeiaaeaaaaae
aaaaahiaaaaaoeiaabaaaakaabaappkaaeaaaaaeaaaaahiaacaaoeiaaaaaoeia
acaaaakaaeaaaaaeabaaahiaacaaoeiaabaaoeiaabaakkkaagaaaaacacaaabia
aaaaaaiaagaaaaacacaaaciaaaaaffiaagaaaaacacaaaeiaaaaakkiaaeaaaaae
aaaaahiaabaaoeiaacaaoeiaacaaffkaafaaaaadaaaaahiaaaaaoeiaacaakkka
abaaaaacaaaaaiiaacaappkaabaaaaacaaaiapiaaaaaoeiappppaaaafdeieefc
baacaaaaeaaaaaaaieaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaaajaaaaaadcaaaaap
hcaabaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaajkjjjjdojkjjjjdojkjjjjdo
aaaaaaaaaceaaaaamnmmemdnmnmmemdnmnmmemdnaaaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaajkjjjjdojkjjjjdojkjjjjdoaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaaaceaaaaaipmchfdnipmchfdnipmchfdnaaaaaaaa
dcaaaaamhcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaceaaaaa
gpbciddlgpbciddlgpbciddlaaaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaijiiiilnijiiiilnijiiiilnaaaaaaaadiaaaaakhccabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaacoifladpcoifladpcoifladpaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 402672
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
uniform float _ExposureAdjustment;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  float tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_1.xyz * unity_ColorSpaceLuminance.xyz);
  tmpvar_2 = (((tmpvar_3.x + tmpvar_3.y) + tmpvar_3.z) + ((2.0 * 
    sqrt((tmpvar_3.y * (tmpvar_3.x + tmpvar_3.z)))
  ) * unity_ColorSpaceLuminance.w));
  float tmpvar_4;
  tmpvar_4 = (tmpvar_2 * _ExposureAdjustment);
  vec4 tmpvar_5;
  tmpvar_5.xyz = ((tmpvar_1.xyz * (tmpvar_4 / 
    (1.0 + tmpvar_4)
  )) / tmpvar_2);
  tmpvar_5.w = tmpvar_1.w;
  gl_FragData[0] = tmpvar_5;
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
Float 1 [_ExposureAdjustment]
Vector 0 [unity_ColorSpaceLuminance]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c2, 2, 1, 0, 0
dcl t0.xy
dcl_2d s0
texld r0, t0, s0
mul_pp r1.xyz, r0, c0
add_pp r1.z, r1.z, r1.x
mul_pp r1.z, r1.z, r1.y
add_pp r1.x, r1.y, r1.x
mad_pp r1.x, r0.z, c0.z, r1.x
rsq_pp r1.y, r1.z
rcp_pp r1.y, r1.y
mul_pp r1.y, r1.y, c0.w
mad_pp r1.x, r1.y, c2.x, r1.x
mov r2.w, c1.x
mad r1.y, r1.x, r2.w, c2.y
rcp r1.y, r1.y
mul r1.z, r1.x, c1.x
rcp r1.x, r1.x
mul r1.y, r1.y, r1.z
mul r1.yzw, r0.wzyx, r1.y
mul r0.xyz, r1.x, r1.wzyx
mov oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 48 [unity_ColorSpaceLuminance]
Float 148 [_ExposureAdjustment]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmpoodknahfimocbjlocekkndiljdbdobabaaaaaalmacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpmabaaaa
eaaaaaaahpaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaaaaaaaaahfcaabaaa
abaaaaaafgagbaaaabaaaaaaagaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
ckaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackaabaaa
aaaaaaaackiacaaaaaaaaaaaadaaaaaaakaabaaaabaaaaaaelaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaapaaaaaiccaabaaaabaaaaaapgipcaaaaaaaaaaa
adaaaaaafgafbaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaa
aaaaaaaaajaaaaaadcaaaaakecaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaa
aaaaaaaaajaaaaaaabeaaaaaaaaaiadpaoaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaackaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgafbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 48 [unity_ColorSpaceLuminance]
Float 148 [_ExposureAdjustment]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmpioeknaamddjbakckoffjgdfgegolgmabaaaaaadeadaaaaaeaaaaaa
daaaaaaafeabaaaakiacaaaaaaadaaaaebgpgodjbmabaaaabmabaaaaaaacpppp
nmaaaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaadaaabaaaaaaaaaaaaaaaaaaajaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadla
bpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapiaaaaaoelaaaaioekaaiaaaaad
abaaciiaaaaaoeiaaaaaoekaabaaaaacabaaaciaabaaffkaaeaaaaaeabaaabia
abaappiaabaaffiaacaaaakaagaaaaacabaaabiaabaaaaiaafaaaaadabaaacia
abaappiaabaaffkaagaaaaacabaaaeiaabaappiaafaaaaadabaaabiaabaaaaia
abaaffiaafaaaaadacaaahiaaaaaoeiaabaaaaiaafaaaaadaaaaahiaabaakkia
acaaoeiaabaaaaacaaaiapiaaaaaoeiappppaaaafdeieefcemabaaaaeaaaaaaa
fdaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaaibcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaaabaaaaaa
akaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaadcaaaaakecaabaaaabaaaaaa
akaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaaabeaaaaaaaaaiadpaoaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaafgafbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaaaoaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaaa
abaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
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
  GpuProgramID 488489
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
uniform float _ExposureAdjustment;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = max (vec4(0.0, 0.0, 0.0, 0.0), ((texture2D (_MainTex, xlv_TEXCOORD0) * _ExposureAdjustment) - 0.004));
  vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 * (
    (6.2 * tmpvar_1)
   + 0.5)) / ((tmpvar_1 * 
    ((6.2 * tmpvar_1) + 1.7)
  ) + 0.06));
  gl_FragData[0] = (tmpvar_2 * tmpvar_2);
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
Float 0 [_ExposureAdjustment]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c1, -0.00400000019, 0, 6.19999981, 0.5
def c2, 6.19999981, 1.70000005, 0.0599999987, 0
dcl t0.xy
dcl_2d s0
texld r0, t0, s0
mov r1.w, c1.x
mad r0, r0, c0.x, r1.w
max r1, r0, c1.y
mad r0, r1, c1.z, c1.w
mul r0, r0, r1
mad r2, r1, c2.x, c2.y
mad r1, r1, r2, c2.z
rcp r2.x, r1.x
rcp r2.y, r1.y
rcp r2.z, r1.z
rcp r2.w, r1.w
mul r0, r0, r2
mul r0, r0, r0
mov oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Float 148 [_ExposureAdjustment]
BindCB  "$Globals" 0
"ps_4_0
eefiecedeompgeonehbaoebllppjfhdmcfbfdegeabaaaaaajeacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcneabaaaa
eaaaaaaahfaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaanpcaabaaa
aaaaaaaaegaobaaaaaaaaaaafgifcaaaaaaaaaaaajaaaaaaaceaaaaagpbcidll
gpbcidllgpbcidllgpbcidlldeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadcaaaaappcaabaaaabaaaaaa
egaobaaaaaaaaaaaaceaaaaaggggmgeaggggmgeaggggmgeaggggmgeaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaadpdiaaaaahpcaabaaaabaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaaacaaaaaaegaobaaaaaaaaaaa
aceaaaaaggggmgeaggggmgeaggggmgeaggggmgeaaceaaaaajkjjnjdpjkjjnjdp
jkjjnjdpjkjjnjdpdcaaaaampcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
acaaaaaaaceaaaaaipmchfdnipmchfdnipmchfdnipmchfdnaoaaaaahpcaabaaa
aaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Float 148 [_ExposureAdjustment]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecednpiooiedmjlbfeafcgbghhchgnphhilfabaaaaaaamaeaaaaaeaaaaaa
daaaaaaakeabaaaaiaadaaaaniadaaaaebgpgodjgmabaaaagmabaaaaaaacpppp
diabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaajaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkagpbcidllaaaaaaaa
ggggmgeaaaaaaadpfbaaaaafacaaapkaggggmgeajkjjnjdpipmchfdnaaaaaaaa
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
aaaaoelaaaaioekaabaaaaacabaaaiiaabaaaakaaeaaaaaeaaaaapiaaaaaoeia
aaaaffkaabaappiaalaaaaadabaaapiaaaaaoeiaabaaffkaaeaaaaaeaaaaapia
abaaoeiaabaakkkaabaappkaafaaaaadaaaaapiaaaaaoeiaabaaoeiaaeaaaaae
acaaapiaabaaoeiaacaaaakaacaaffkaaeaaaaaeabaaapiaabaaoeiaacaaoeia
acaakkkaagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffiaagaaaaac
acaaaeiaabaakkiaagaaaaacacaaaiiaabaappiaafaaaaadaaaaapiaaaaaoeia
acaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaoeiaabaaaaacaaaiapiaaaaaoeia
ppppaaaafdeieefcneabaaaaeaaaaaaahfaaaaaafjaaaaaeegiocaaaaaaaaaaa
akaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaanpcaabaaaaaaaaaaaegaobaaaaaaaaaaafgifcaaaaaaaaaaa
ajaaaaaaaceaaaaagpbcidllgpbcidllgpbcidllgpbcidlldeaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dcaaaaappcaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaaggggmgeaggggmgea
ggggmgeaggggmgeaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaadpdiaaaaah
pcaabaaaabaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadcaaaaappcaabaaa
acaaaaaaegaobaaaaaaaaaaaaceaaaaaggggmgeaggggmgeaggggmgeaggggmgea
aceaaaaajkjjnjdpjkjjnjdpjkjjnjdpjkjjnjdpdcaaaaampcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaacaaaaaaaceaaaaaipmchfdnipmchfdnipmchfdn
ipmchfdnaoaaaaahpcaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
diaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadoaaaaab
ejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
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
  GpuProgramID 536939
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
uniform float _ExposureAdjustment;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_FragData[0] = (1.0 - exp2((
    -(_ExposureAdjustment)
   * texture2D (_MainTex, xlv_TEXCOORD0))));
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
Float 0 [_ExposureAdjustment]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c1, 1, 0, 0, 0
dcl t0.xy
dcl_2d s0
texld r0, t0, s0
mul r0, r0, -c0.x
exp r1.x, r0.x
exp r1.y, r0.y
exp r1.z, r0.z
exp r1.w, r0.w
add r0, -r1, c1.x
mov oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Float 148 [_ExposureAdjustment]
BindCB  "$Globals" 0
"ps_4_0
eefiecedicegkldlghiccanocaafpnkddfcnhiidabaaaaaakaabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoaaaaaaa
eaaaaaaadiaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaajpcaabaaa
aaaaaaaaegaobaaaaaaaaaaafgifcaiaebaaaaaaaaaaaaaaajaaaaaabjaaaaaf
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaalpccabaaaaaaaaaaaegaobaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdoaaaaab
"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Float 148 [_ExposureAdjustment]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedhkaihgfkokbanphakcepohlhlilagmnoabaaaaaaieacaaaaaeaaaaaa
daaaaaaabaabaaaapiabaaaafaacaaaaebgpgodjniaaaaaaniaaaaaaaaacpppp
keaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaajaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaaaaaoelaaaaioekaafaaaaadaaaaapiaaaaaoeiaaaaaffkb
aoaaaaacabaaabiaaaaaaaiaaoaaaaacabaaaciaaaaaffiaaoaaaaacabaaaeia
aaaakkiaaoaaaaacabaaaiiaaaaappiaacaaaaadaaaaapiaabaaoeibabaaaaka
abaaaaacaaaiapiaaaaaoeiappppaaaafdeieefcoaaaaaaaeaaaaaaadiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaajpcaabaaaaaaaaaaaegaobaaa
aaaaaaaafgifcaiaebaaaaaaaaaaaaaaajaaaaaabjaaaaafpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaaaaaaalpccabaaaaaaaaaaaegaobaiaebaaaaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdoaaaaabejfdeheofaaaaaaa
acaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
eeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 651262
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
  vec4 average_1;
  vec4 tmpvar_2;
  vec4 cse_3;
  cse_3 = (_MainTex_TexelSize * 0.5);
  tmpvar_2 = texture2D (_MainTex, (xlv_TEXCOORD0 + cse_3.xy));
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, (xlv_TEXCOORD0 - cse_3.xy));
  vec4 tmpvar_5;
  vec2 cse_6;
  cse_6 = (_MainTex_TexelSize.xy * vec2(0.5, -0.5));
  tmpvar_5 = texture2D (_MainTex, (xlv_TEXCOORD0 + cse_6));
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, (xlv_TEXCOORD0 - cse_6));
  average_1.xzw = (((
    (tmpvar_2 + tmpvar_4)
   + tmpvar_5) + tmpvar_7) / 4.0).xzw;
  average_1.y = max (max (tmpvar_2.y, tmpvar_4.y), max (tmpvar_5.y, tmpvar_7.y));
  gl_FragData[0] = average_1;
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
texld r1, r1, s0
texld r2, r2, s0
texld r3, r3, s0
texld r0, r0, s0
add r4.x, r1.x, r2.x
add r4.y, r1.z, r2.z
add r4.z, r1.w, r2.w
max r4.w, r1.y, r2.y
add r1.x, r3.x, r4.x
add r1.y, r3.z, r4.y
add r1.z, r3.w, r4.z
add r2.x, r0.x, r1.x
add r2.y, r0.z, r1.y
add r2.z, r0.w, r1.z
max r2.w, r3.y, r0.y
max r0.y, r4.w, r2.w
mul r0.x, r2.x, c1.z
mul r0.z, r2.y, c1.z
mul r0.w, r2.z, c1.z
mov oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 128 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedagjiboignifgidchfnajgpobhcmboimfabaaaaaaoeacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcceacaaaa
eaaaaaaaijaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadcaaaaanpcaabaaaaaaaaaaa
egiecaaaaaaaaaaaaiaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaalp
egbebaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaopcaabaaaacaaaaaaegiecaia
ebaaaaaaaaaaaaaaaiaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaalp
egbebaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahncaabaaaabaaaaaaagaobaaa
abaaaaaaagaobaaaadaaaaaadeaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaadaaaaaaaaaaaaahncaabaaaaaaaaaaaagaobaaaaaaaaaaaagaobaaa
abaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaa
aaaaaaahncaabaaaaaaaaaaaagaobaaaacaaaaaaagaobaaaaaaaaaaadiaaaaak
nccabaaaaaaaaaaaagaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaaaaaaaaaiado
aaaaiadodeaaaaahcccabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 128 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjhnlkgjaekghjecoejpiomnjgepfplgdabaaaaaapeaeaaaaaeaaaaaa
daaaaaaadmacaaaagiaeaaaamaaeaaaaebgpgodjaeacaaaaaeacaaaaaaacpppp
naabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaaiaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadpaaaaaalp
aaaaiadoaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
abaaaaacaaaaadiaabaaoekaaeaaaaaeabaaadiaaaaaoekaaaaaaaiaaaaaoela
aeaaaaaeacaaadiaaaaaoekaaaaaaaibaaaaoelaaeaaaaaeadaaadiaaaaaoeka
aaaaoeiaaaaaoelaaeaaaaaeaaaaadiaaaaaoekaaaaaoeibaaaaoelaecaaaaad
abaaapiaabaaoeiaaaaioekaecaaaaadacaaapiaacaaoeiaaaaioekaecaaaaad
adaaapiaadaaoeiaaaaioekaecaaaaadaaaaapiaaaaaoeiaaaaioekaacaaaaad
aeaaabiaabaaaaiaacaaaaiaacaaaaadaeaaaciaabaakkiaacaakkiaacaaaaad
aeaaaeiaabaappiaacaappiaalaaaaadaeaaaiiaabaaffiaacaaffiaacaaaaad
abaaabiaadaaaaiaaeaaaaiaacaaaaadabaaaciaadaakkiaaeaaffiaacaaaaad
abaaaeiaadaappiaaeaakkiaacaaaaadacaaabiaaaaaaaiaabaaaaiaacaaaaad
acaaaciaaaaakkiaabaaffiaacaaaaadacaaaeiaaaaappiaabaakkiaalaaaaad
acaaaiiaadaaffiaaaaaffiaalaaaaadaaaaaciaaeaappiaacaappiaafaaaaad
aaaaabiaacaaaaiaabaakkkaafaaaaadaaaaaeiaacaaffiaabaakkkaafaaaaad
aaaaaiiaacaakkiaabaakkkaabaaaaacaaaiapiaaaaaoeiappppaaaafdeieefc
ceacaaaaeaaaaaaaijaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadcaaaaanpcaabaaa
aaaaaaaaegiecaaaaaaaaaaaaiaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaalpegbebaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaopcaabaaaacaaaaaa
egiecaiaebaaaaaaaaaaaaaaaiaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaalpegbebaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahncaabaaaabaaaaaa
agaobaaaabaaaaaaagaobaaaadaaaaaadeaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaabkaabaaaadaaaaaaaaaaaaahncaabaaaaaaaaaaaagaobaaaaaaaaaaa
agaobaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
acaaaaaaaaaaaaahncaabaaaaaaaaaaaagaobaaaacaaaaaaagaobaaaaaaaaaaa
diaaaaaknccabaaaaaaaaaaaagaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaaaaa
aaaaiadoaaaaiadodeaaaaahcccabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
abaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
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
  GpuProgramID 657391
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
uniform sampler2D _SmallTex;
uniform vec4 _HdrParams;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 color_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_SmallTex, xlv_TEXCOORD0);
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.w = tmpvar_3.w;
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xyz * unity_ColorSpaceLuminance.xyz);
  float tmpvar_5;
  tmpvar_5 = max (1e-06, ((
    (tmpvar_4.x + tmpvar_4.y)
   + tmpvar_4.z) + (
    (2.0 * sqrt((tmpvar_4.y * (tmpvar_4.x + tmpvar_4.z))))
   * unity_ColorSpaceLuminance.w)));
  float tmpvar_6;
  tmpvar_6 = ((tmpvar_5 * _HdrParams.z) / (0.001 + tmpvar_2.x));
  color_1.xyz = (tmpvar_3.xyz * ((
    (tmpvar_6 * (1.0 + (tmpvar_6 / (tmpvar_2.y * tmpvar_2.y))))
   / 
    (1.0 + tmpvar_6)
  ) / tmpvar_5));
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
Vector 1 [_HdrParams]
Vector 0 [unity_ColorSpaceLuminance]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SmallTex] 2D 1
"ps_2_0
def c2, 2, 9.99999997e-007, 0.00100000005, 1
dcl t0.xy
dcl_2d s0
dcl_2d s1
texld r0, t0, s0
texld r1, t0, s1
mul_pp r2.xyz, r0, c0
add_pp r1.z, r2.z, r2.x
mul_pp r1.z, r1.z, r2.y
add_pp r1.w, r2.y, r2.x
mad_pp r1.w, r0.z, c0.z, r1.w
rsq_pp r1.z, r1.z
rcp_pp r1.z, r1.z
mul_pp r1.z, r1.z, c0.w
mad_pp r1.z, r1.z, c2.x, r1.w
max r2.x, c2.y, r1.z
mul r1.z, r2.x, c1.z
rcp r1.w, r2.x
add r1.x, r1.x, c2.z
mul r1.y, r1.y, r1.y
rcp r1.y, r1.y
rcp r1.x, r1.x
mul r2.x, r1.x, r1.z
mad r1.x, r1.z, r1.x, c2.w
rcp r1.x, r1.x
mad r1.y, r2.x, r1.y, c2.w
mul r1.y, r1.y, r2.x
mul r1.x, r1.x, r1.y
mul r1.x, r1.w, r1.x
mul r0.xyz, r0, r1.x
mov oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_SmallTex] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 48 [unity_ColorSpaceLuminance]
Vector 96 [_HdrParams]
BindCB  "$Globals" 0
"ps_4_0
eefieceddcnkgnhcpinlklpdiohemnbcnflpnmhlabaaaaaaleadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeacaaaa
eaaaaaaalnaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaaaaaaaaahfcaabaaaabaaaaaa
fgagbaaaabaaaaaaagaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaackaabaaaaaaaaaaa
ckiacaaaaaaaaaaaadaaaaaaakaabaaaabaaaaaaelaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaaapaaaaaiccaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaa
fgafbaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaalndhigdf
diaaaaaiccaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaagaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaaaaaaaahecaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaagpbciddk
diaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaaaoaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaaaoaaaaahecaabaaa
abaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaabkaabaaaabaaaaaaaaaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiadpaoaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaa
abaaaaaaaoaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_SmallTex] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 48 [unity_ColorSpaceLuminance]
Vector 96 [_HdrParams]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedacgkdllkbplodadeonilahjjbjmbejfdabaaaaaalmaeaaaaaeaaaaaa
daaaaaaaoeabaaaadaaeaaaaiiaeaaaaebgpgodjkmabaaaakmabaaaaaaacpppp
giabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaabaaaaaa
aaababaaaaaaadaaabaaaaaaaaaaaaaaaaaaagaaabaaabaaaaaaaaaaaaacpppp
fbaaaaafacaaapkalndhigdfgpbciddkaaaaiadpaaaaaaaabpaaaaacaaaaaaia
aaaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaaaaaoelaabaioekaecaaaaadabaaapiaaaaaoelaaaaioekaafaaaaad
aaaaaciaaaaaffiaaaaaffiaacaaaaadaaaaabiaaaaaaaiaacaaffkaagaaaaac
aaaaabiaaaaaaaiaagaaaaacaaaaaciaaaaaffiaaiaaaaadaaaaceiaabaaoeia
aaaaoekaalaaaaadacaaaiiaacaaaakaaaaakkiaafaaaaadaaaaaeiaacaappia
abaakkkaagaaaaacaaaaaiiaacaappiaafaaaaadacaaabiaaaaaaaiaaaaakkia
aeaaaaaeaaaaabiaaaaakkiaaaaaaaiaacaakkkaagaaaaacaaaaabiaaaaaaaia
aeaaaaaeaaaaaciaacaaaaiaaaaaffiaacaakkkaafaaaaadaaaaaciaaaaaffia
acaaaaiaafaaaaadaaaaabiaaaaaaaiaaaaaffiaafaaaaadaaaaabiaaaaappia
aaaaaaiaafaaaaadabaaahiaaaaaaaiaabaaoeiaabaaaaacaaaiapiaabaaoeia
ppppaaaafdeieefceeacaaaaeaaaaaaajbaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaagpbciddkefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaabaaaaaai
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaadeaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaalndhigdfdiaaaaaiicaabaaa
aaaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaaaoaaaaahbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaaoaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiadpaoaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
aoaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hccabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}