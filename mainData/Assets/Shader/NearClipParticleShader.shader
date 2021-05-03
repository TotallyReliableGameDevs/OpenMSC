Shader "Particles/Alpha Blended Near Clip" {
Properties {
 _TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
 _MainTex ("Particle Texture", 2D) = "white" { }
 _InvFade ("Soft Particles Factor", Range(0.01,3)) = 1
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0.01
  ColorMask RGB
  GpuProgramID 23712
Program "vp" {
SubProgram "opengl " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform float _NearClipDistance;
uniform vec4 _MainTex_ST;
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = gl_Color.xyz;
  vec3 x_2;
  x_2 = (_Object2World * gl_Vertex).xyz;
  tmpvar_1.w = (gl_Color.w * float((
    sqrt(dot (x_2, x_2))
   >= _NearClipDistance)));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _TintColor;
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_FragData[0] = (((2.0 * xlv_COLOR) * _TintColor) * texture2D (_MainTex, xlv_TEXCOORD0));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_MainTex_ST]
Float 7 [_NearClipDistance]
"vs_2_0
dcl_position v0
dcl_color v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
sge r0.x, r0.x, c7.x
mul oD0.w, r0.x, v1.w
mad oT0.xy, v2, c8, c8.zwzw
mov oD0.xyz, v1

"
}
SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160
Float 112 [_NearClipDistance]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednkihfpbofplikmaplibanknadkfocfahabaaaaaajaadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefchiacaaaaeaaaabaajoaaaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaabnaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaaabaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaaabaaaaaaakaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160
Float 112 [_NearClipDistance]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpgmakpgkefefkppdepfibcplnfhbmijoabaaaaaadeafaaaaaeaaaaaa
daaaaaaanaabaaaafaaeaaaamaaeaaaaebgpgodjjiabaaaajiabaaaaaaacpopp
emabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaahaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaabaaamaaaeaaahaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
bpaaaaacafaaaciaacaaapjaafaaaaadaaaaahiaaaaaffjaaiaaoekaaeaaaaae
aaaaahiaahaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaajaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaahiaakaaoekaaaaappjaaaaaoeiaaiaaaaadaaaaabia
aaaaoeiaaaaaoeiaahaaaaacaaaaabiaaaaaaaiaagaaaaacaaaaabiaaaaaaaia
anaaaaadaaaaabiaaaaaaaiaabaaaakaafaaaaadaaaaaioaaaaaaaiaabaappja
aeaaaaaeabaaadoaacaaoejaacaaoekaacaaookaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacaaaaahoaabaaoejappppaaaafdeieefchiacaaaaeaaaabaajoaaaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaabnaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaaabaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaaabaaaaaaakaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaa
epfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
gcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform float _NearClipDistance;
uniform vec4 _MainTex_ST;
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_4.xyw;
  tmpvar_2.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  tmpvar_1.xyz = gl_Color.xyz;
  vec3 x_7;
  x_7 = (_Object2World * gl_Vertex).xyz;
  tmpvar_1.w = (gl_Color.w * float((
    sqrt(dot (x_7, x_7))
   >= _NearClipDistance)));
  gl_Position = tmpvar_3;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform vec4 _TintColor;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  tmpvar_1.w = (xlv_COLOR.w * clamp ((_InvFade * 
    ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.w))) - xlv_TEXCOORD2.z)
  ), 0.0, 1.0));
  gl_FragData[0] = (((2.0 * tmpvar_1) * _TintColor) * texture2D (_MainTex, xlv_TEXCOORD0));
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 7 [_Object2World] 3
Matrix 4 [glstate_matrix_modelview0] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_MainTex_ST]
Float 12 [_NearClipDistance]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
"vs_2_0
def c14, 0.5, 0, 0, 0
dcl_position v0
dcl_color v1
dcl_texcoord v2
dp4 oPos.z, c2, v0
dp4 r0.y, c1, v0
mul r0.z, r0.y, c10.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xzw, r0.xywz, c14.x
mov oPos.xyw, r0
mov oT2.w, r0.w
mad oT2.xy, r1.z, c11.zwzw, r1.xwzw
dp4 r0.x, c6, v0
mov oT2.z, -r0.x
dp4 r0.x, c7, v0
dp4 r0.y, c8, v0
dp4 r0.z, c9, v0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
sge r0.x, r0.x, c12.x
mul oD0.w, r0.x, v1.w
mad oT0.xy, v2, c13, c13.zwzw
mov oD0.xyz, v1

"
}
SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160
Float 112 [_NearClipDistance]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmikaeklnjbhognjpfgmmfhpaldiodjekabaaaaaaaaafaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefcnaadaaaaeaaaabaapeaaaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaabnaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaa
abaaaaaackaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egbcbaaaabaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaacaaaaaaegiacaaa
aaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
iccabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaadgaaaaageccabaaaadaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160
Float 112 [_NearClipDistance]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedfahopjgeimifmhkhfdnfhaafdagjodababaaaaaagmahaaaaaeaaaaaa
daaaaaaajiacaaaahaagaaaaoaagaaaaebgpgodjgaacaaaagaacaaaaaaacpopp
aiacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaahaa
acaaabaaaaaaaaaaabaaafaaabaaadaaaaaaaaaaacaaaaaaaiaaaeaaaaaaaaaa
acaaamaaaeaaamaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbaaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaapiaaaaaffjaafaaoeka
aeaaaaaeaaaaapiaaeaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaagaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaadaaaakaafaaaaadabaaaiiaabaaaaiabaaaaakaafaaaaad
abaaafiaaaaapeiabaaaaakaacaaaaadacaaadoaabaakkiaabaaomiaafaaaaad
abaaabiaaaaaffjaajaakkkaaeaaaaaeabaaabiaaiaakkkaaaaaaajaabaaaaia
aeaaaaaeabaaabiaakaakkkaaaaakkjaabaaaaiaaeaaaaaeabaaabiaalaakkka
aaaappjaabaaaaiaabaaaaacacaaaeoaabaaaaibafaaaaadabaaahiaaaaaffja
anaaoekaaeaaaaaeabaaahiaamaaoekaaaaaaajaabaaoeiaaeaaaaaeabaaahia
aoaaoekaaaaakkjaabaaoeiaaeaaaaaeabaaahiaapaaoekaaaaappjaabaaoeia
aiaaaaadabaaabiaabaaoeiaabaaoeiaahaaaaacabaaabiaabaaaaiaagaaaaac
abaaabiaabaaaaiaanaaaaadabaaabiaabaaaaiaabaaaakaafaaaaadaaaaaioa
abaaaaiaabaappjaaeaaaaaeabaaadoaacaaoejaacaaoekaacaaookaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaaioaaaaappiaabaaaaacaaaaahoaabaaoejappppaaaafdeieefcnaadaaaa
eaaaabaapeaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaabnaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaa
akiacaaaaaaaaaaaahaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahiccabaaaabaaaaaackaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaa
aiaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaa
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "SOFTPARTICLES_OFF" }
"!!GLSL
#ifdef VERTEX

uniform mat4 _Object2World;
uniform vec4 unity_FogParams;
uniform float _NearClipDistance;
uniform vec4 _MainTex_ST;
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;
varying float xlv_TEXCOORD1;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_1.xyz = gl_Color.xyz;
  vec3 x_3;
  x_3 = (_Object2World * gl_Vertex).xyz;
  tmpvar_1.w = (gl_Color.w * float((
    sqrt(dot (x_3, x_3))
   >= _NearClipDistance)));
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_2.z)));
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform vec4 _TintColor;
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;
varying float xlv_TEXCOORD1;
void main ()
{
  vec4 col_1;
  vec4 tmpvar_2;
  tmpvar_2 = (((2.0 * xlv_COLOR) * _TintColor) * texture2D (_MainTex, xlv_TEXCOORD0));
  col_1.w = tmpvar_2.w;
  col_1.xyz = mix (unity_FogColor.xyz, tmpvar_2.xyz, vec3(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 9 [_MainTex_ST]
Float 8 [_NearClipDistance]
Vector 7 [unity_FogParams]
"vs_2_0
dcl_position v0
dcl_color v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
dp4 r0.x, c4, v0
dp4 r0.y, c5, v0
dp4 r0.z, c6, v0
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
sge r0.x, r0.x, c8.x
mul oD0.w, r0.x, v1.w
mad oT0.xy, v2, c9, c9.zwzw
dp4 r0.x, c2, v0
mul r0.y, r0.x, c7.y
mov oPos.z, r0.x
exp oT1.x, -r0.y
mov oD0.xyz, v1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160
Float 112 [_NearClipDistance]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0
eefiecedmpelegkgefhinbokjaagkapacpolflniabaaaaaabaaeaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaaealaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefcoaacaaaaeaaaabaaliaaaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaabaaaaaaafjaaaaaeegiocaaa
acaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadeccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaageccabaaaacaaaaaa
akaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaabnaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaaabaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaaabaaaaaaakaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FOG_EXP" "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160
Float 112 [_NearClipDistance]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityFog" 2
"vs_4_0_level_9_1
eefiecedfncjhflbhkocppgfdohfelaahdpdbpahabaaaaaanmafaaaaaeaaaaaa
daaaaaaapiabaaaaoaaeaaaafaafaaaaebgpgodjmaabaaaamaabaaaaaaacpopp
giabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaahaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaabaaamaaaeaaahaaaaaaaaaa
acaaabaaabaaalaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaahia
aaaaffjaaiaaoekaaeaaaaaeaaaaahiaahaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiaajaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiaakaaoekaaaaappja
aaaaoeiaaiaaaaadaaaaabiaaaaaoeiaaaaaoeiaahaaaaacaaaaabiaaaaaaaia
agaaaaacaaaaabiaaaaaaaiaanaaaaadaaaaabiaaaaaaaiaabaaaakaafaaaaad
aaaaaioaaaaaaaiaabaappjaaeaaaaaeabaaadoaacaaoejaacaaoekaacaaooka
afaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
agaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaakkiaalaaffkaaoaaaaac
abaaaeoaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacaaaaahoaabaaoejappppaaaafdeieefcoaacaaaa
eaaaabaaliaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaabaaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadeccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaacaaaaaa
abaaaaaabjaaaaageccabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabnaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahiccabaaaabaaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
hccabaaaabaaaaaaegbcbaaaabaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaaealaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
uniform vec4 unity_FogParams;
uniform float _NearClipDistance;
uniform vec4 _MainTex_ST;
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  tmpvar_2.xyw = o_4.xyw;
  tmpvar_2.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  tmpvar_1.xyz = gl_Color.xyz;
  vec3 x_7;
  x_7 = (_Object2World * gl_Vertex).xyz;
  tmpvar_1.w = (gl_Color.w * float((
    sqrt(dot (x_7, x_7))
   >= _NearClipDistance)));
  gl_Position = tmpvar_3;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform vec4 _TintColor;
uniform sampler2D _CameraDepthTexture;
uniform float _InvFade;
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;
varying float xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  vec4 col_2;
  tmpvar_1.w = (xlv_COLOR.w * clamp ((_InvFade * 
    ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.w))) - xlv_TEXCOORD2.z)
  ), 0.0, 1.0));
  vec4 tmpvar_3;
  tmpvar_3 = (((2.0 * tmpvar_1) * _TintColor) * texture2D (_MainTex, xlv_TEXCOORD0));
  col_2.w = tmpvar_3.w;
  col_2.xyz = mix (unity_FogColor.xyz, tmpvar_3.xyz, vec3(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 7 [_Object2World] 3
Matrix 4 [glstate_matrix_modelview0] 3
Matrix 0 [glstate_matrix_mvp]
Vector 14 [_MainTex_ST]
Float 13 [_NearClipDistance]
Vector 10 [_ProjectionParams]
Vector 11 [_ScreenParams]
Vector 12 [unity_FogParams]
"vs_2_0
def c15, 0.5, 0, 0, 0
dcl_position v0
dcl_color v1
dcl_texcoord v2
dp4 r0.y, c1, v0
mul r1.x, r0.y, c10.x
mul r1.w, r1.x, c15.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c15.x
mad oT2.xy, r1.z, c11.zwzw, r1.xwzw
dp4 r1.x, c6, v0
mov oT2.z, -r1.x
dp4 r1.x, c7, v0
dp4 r1.y, c8, v0
dp4 r1.z, c9, v0
dp3 r1.x, r1, r1
rsq r1.x, r1.x
rcp r1.x, r1.x
sge r1.x, r1.x, c13.x
mul oD0.w, r1.x, v1.w
mad oT0.xy, v2, c14, c14.zwzw
dp4 r0.z, c2, v0
mul r1.x, r0.z, c12.y
mov oPos, r0
mov oT2.w, r0.w
exp oT1.x, -r1.x
mov oD0.xyz, v1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160
Float 112 [_NearClipDistance]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0
eefiecednmlggnpipbhlomgmkheeapimahfcmammabaaaaaagmafaaaaadaaaaaa
cmaaaaaajmaaaaaaeaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaajcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaaealaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcceaeaaaaeaaaabaaajabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaa
fjaaaaaeegiocaaaadaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
eccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaaaaaaaaaaaahaaaaaaabaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaaabaaaaaaakaabaaaabaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadiaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaag
eccabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaah
dccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 160
Float 112 [_NearClipDistance]
Vector 128 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0_level_9_1
eefiecedmjmhmebelglbmcnbckeiijembbdmhifpabaaaaaaaaaiaaaaaeaaaaaa
daaaaaaamaacaaaaomagaaaafmahaaaaebgpgodjiiacaaaaiiacaaaaaaacpopp
ceacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaahaa
acaaabaaaaaaaaaaabaaafaaabaaadaaaaaaaaaaacaaaaaaaiaaaeaaaaaaaaaa
acaaamaaaeaaamaaaaaaaaaaadaaabaaabaabaaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbbaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjaafaaaaad
aaaaapiaaaaaffjaafaaoekaaeaaaaaeaaaaapiaaeaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaagaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaahaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaadaaaakaafaaaaadabaaaiia
abaaaaiabbaaaakaafaaaaadabaaafiaaaaapeiabbaaaakaacaaaaadacaaadoa
abaakkiaabaaomiaafaaaaadabaaabiaaaaaffjaajaakkkaaeaaaaaeabaaabia
aiaakkkaaaaaaajaabaaaaiaaeaaaaaeabaaabiaakaakkkaaaaakkjaabaaaaia
aeaaaaaeabaaabiaalaakkkaaaaappjaabaaaaiaabaaaaacacaaaeoaabaaaaib
afaaaaadabaaahiaaaaaffjaanaaoekaaeaaaaaeabaaahiaamaaoekaaaaaaaja
abaaoeiaaeaaaaaeabaaahiaaoaaoekaaaaakkjaabaaoeiaaeaaaaaeabaaahia
apaaoekaaaaappjaabaaoeiaaiaaaaadabaaabiaabaaoeiaabaaoeiaahaaaaac
abaaabiaabaaaaiaagaaaaacabaaabiaabaaaaiaanaaaaadabaaabiaabaaaaia
abaaaakaafaaaaadaaaaaioaabaaaaiaabaappjaaeaaaaaeabaaadoaacaaoeja
acaaoekaacaaookaafaaaaadabaaabiaaaaakkiabaaaffkaaoaaaaacabaaaeoa
abaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacacaaaioaaaaappiaabaaaaacaaaaahoaabaaoejappppaaaa
fdeieefcceaeaaaaeaaaabaaajabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaa
fjaaaaaeegiocaaaadaaaaaaacaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
eccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaaaaaaaaaaaahaaaaaaabaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaahiccabaaaabaaaaaaakaabaaaabaaaaaa
dkbabaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaadiaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaag
eccabaaaacaaaaaackaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaah
dccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaajcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaaealaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_OFF" }
Vector 0 [_TintColor]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl v0
dcl t0.xy
dcl_2d s0
texld r0, t0, s0
mul r1, v0, c0
add r1, r1, r1
mul_pp r0, r0, r1
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 96 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedoahgkenbdekcbaipiifgmgoofcddacpcabaaaaaalmabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoaaaaaaaeaaaaaaa
diaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegbobaaaabaaaaaaegbobaaaabaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
pccabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 96 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmkfebaojlhlahiapkcocgcggllhcbiaeabaaaaaaheacaaaaaeaaaaaa
daaaaaaaoeaaaaaammabaaaaeaacaaaaebgpgodjkmaaaaaakmaaaaaaaaacpppp
hiaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaadlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapiaabaaoela
aaaioekaafaaaaadabaaapiaaaaaoelaaaaaoekaacaaaaadabaaapiaabaaoeia
abaaoeiaafaaaaadaaaacpiaaaaaoeiaabaaoeiaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcoaaaaaaaeaaaaaaadiaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaaaaaaahpcaabaaaaaaaaaaaegbobaaaabaaaaaa
egbobaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_ON" }
Float 2 [_InvFade]
Vector 1 [_TintColor]
Vector 0 [_ZBufferParams]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_2_0
def c3, 2, 0, 0, 0
dcl v0
dcl t0.xy
dcl t2
dcl_2d s0
dcl_2d s1
texldp r0, t2, s1
texld r1, t0, s0
mad r0.x, c0.z, r0.x, c0.w
rcp r0.x, r0.x
add r0.x, r0.x, -t2.z
mul_sat r0.x, r0.x, c2.x
mul_pp r0.x, r0.x, v0.w
mul r0.x, r0.x, c3.x
mul r0.w, r0.x, c1.w
mov r2.xyz, v0
mul r2.xyz, r2, c1
mul r0.xyz, r2, c3.x
mul_pp r0, r1, r0
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 96 [_TintColor]
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecednkglmfopomhioiaibpkmakminbolnlhbabaaaaaabaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbmacaaaaeaaaaaaaihaaaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackbabaiaebaaaaaaadaaaaaa
dicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaa
diaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
hcaabaaaaaaaaaaaegbcbaaaabaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 96 [_TintColor]
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedcbmedfalkjgoncohcipjohnhcgkehhfgabaaaaaalmaeaaaaaeaaaaaa
daaaaaaaniabaaaapmadaaaaiiaeaaaaebgpgodjkaabaaaakaabaaaaaaacpppp
faabaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaabaaaaaa
aaababaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaabaaabaaaaaaaaaaabaaahaa
abaaacaaaaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaaeaaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaac
aaaaaaiaacaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
agaaaaacaaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaecaaaaad
aaaaapiaaaaaoeiaabaioekaecaaaaadabaaapiaabaaoelaaaaioekaaeaaaaae
aaaaabiaacaakkkaaaaaaaiaacaappkaagaaaaacaaaaabiaaaaaaaiaacaaaaad
aaaaabiaaaaaaaiaacaakklbafaaaaadaaaabbiaaaaaaaiaabaaaakaafaaaaad
aaaacbiaaaaaaaiaaaaapplaafaaaaadaaaaabiaaaaaaaiaadaaaakaafaaaaad
aaaaaiiaaaaaaaiaaaaappkaabaaaaacacaaahiaaaaaoelaafaaaaadacaaahia
acaaoeiaaaaaoekaafaaaaadaaaaahiaacaaoeiaadaaaakaafaaaaadaaaacpia
abaaoeiaaaaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbmacaaaa
eaaaaaaaihaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaa
aaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaa
ahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckbabaiaebaaaaaaadaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaajaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaafhcaabaaaaaaaaaaaegbcbaaaabaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaah
pccabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "SOFTPARTICLES_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_OFF" }
Vector 1 [_TintColor]
Vector 0 [unity_FogColor]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl v0
dcl t0.xy
dcl t1.x
dcl_2d s0
texld r0, t0, s0
mov_sat r1.w, t1.x
mul r2, v0, c1
add r2, r2, r2
mad r0.xyz, r2, r0, -c0
mul_pp r2.w, r0.w, r2.w
mad_pp r2.xyz, r1.w, r0, c0
mov_pp oC0, r2

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 96 [_TintColor]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecednmcjmnkfnccjoafjjhljpnbnhfhbpiahabaaaaaagmacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefchiabaaaaeaaaaaaafoaaaaaafjaaaaae
egiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadecbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaadgcaaaafbcaabaaaaaaaaaaackbabaaa
acaaaaaaaaaaaaahpcaabaaaabaaaaaaegbobaaaabaaaaaaegbobaaaabaaaaaa
diaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaagaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaalocaabaaaaaaaaaaaagajbaaaabaaaaaaagajbaaaacaaaaaa
agijcaiaebaaaaaaabaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaacaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaakhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FOG_EXP" "SOFTPARTICLES_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 96 [_TintColor]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0_level_9_1
eefiecedajbbinnoalljpfnlgbeabjdikooojpgjabaaaaaageadaaaaaeaaaaaa
daaaaaaaceabaaaakeacaaaadaadaaaaebgpgodjomaaaaaaomaaaaaaaaacpppp
kmaaaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaagaaabaaaaaaaaaaaaaaabaaaaaaabaaabaaaaaaaaaaaaacppppbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaabaaaaacabaabiiaabaakklaafaaaaad
acaaapiaaaaaoelaaaaaoekaacaaaaadacaaapiaacaaoeiaacaaoeiaaeaaaaae
aaaaahiaacaaoeiaaaaaoeiaabaaoekbafaaaaadacaaciiaaaaappiaacaappia
aeaaaaaeacaachiaabaappiaaaaaoeiaabaaoekaabaaaaacaaaicpiaacaaoeia
ppppaaaafdeieefchiabaaaaeaaaaaaafoaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadecbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaadgcaaaafbcaabaaaaaaaaaaackbabaaaacaaaaaaaaaaaaah
pcaabaaaabaaaaaaegbobaaaabaaaaaaegbobaaaabaaaaaadiaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaal
ocaabaaaaaaaaaaaagajbaaaabaaaaaaagajbaaaacaaaaaaagijcaiaebaaaaaa
abaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaa
acaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakhccabaaa
aaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
doaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
Float 3 [_InvFade]
Vector 2 [_TintColor]
Vector 0 [_ZBufferParams]
Vector 1 [unity_FogColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_2_0
def c4, 2, 0, 0, 0
dcl v0
dcl t0.xy
dcl t1.x
dcl t2
dcl_2d s0
dcl_2d s1
texldp r0, t2, s1
texld r1, t0, s0
mad r0.x, c0.z, r0.x, c0.w
rcp r0.x, r0.x
add r0.x, r0.x, -t2.z
mul_sat r0.x, r0.x, c3.x
mul_pp r0.x, r0.x, v0.w
mul r0.x, r0.x, c4.x
mul r0.x, r0.x, c2.w
mul_pp r0.w, r1.w, r0.x
mov r2.xyz, v0
mul r2.xyz, r2, c2
mul r2.xyz, r2, c4.x
mad r1.xyz, r2, r1, -c1
mov_sat r1.w, t1.x
mad_pp r0.xyz, r1.w, r1, c1
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 96 [_TintColor]
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0
eefiecediommoiejolpdaipopdaippofpifnfjfpabaaaaaamaadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaaeaeaaaajcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcleacaaaaeaaaaaaaknaaaaaafjaaaaaeegiocaaaaaaaaaaa
akaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadecbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaackbabaiaebaaaaaaadaaaaaadicaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaajaaaaaadiaaaaahicaabaaaaaaaaaaa
akaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhcaabaaaaaaaaaaaegbcbaaa
abaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaagaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
egiccaiaebaaaaaaacaaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
dgcaaaaficaabaaaaaaaaaaackbabaaaacaaaaaadcaaaaakhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "FOG_EXP" "SOFTPARTICLES_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 160
Vector 96 [_TintColor]
Float 144 [_InvFade]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0_level_9_1
eefiecedclmccipfkobibhhdpnafonmdamijbckaabaaaaaakmafaaaaaeaaaaaa
daaaaaaabiacaaaaneaeaaaahiafaaaaebgpgodjoaabaaaaoaabaaaaaaacpppp
ieabaaaafmaaaaaaaeaacmaaaaaafmaaaaaafmaaacaaceaaaaaafmaaabaaaaaa
aaababaaaaaaagaaabaaaaaaaaaaaaaaaaaaajaaabaaabaaaaaaaaaaabaaahaa
abaaacaaaaaaaaaaacaaaaaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapka
aaaaaaeaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaacaapplaafaaaaadaaaaadia
aaaappiaacaaoelaecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaadabaaapia
abaaoelaaaaioekaaeaaaaaeaaaaabiaacaakkkaaaaaaaiaacaappkaagaaaaac
aaaaabiaaaaaaaiaacaaaaadaaaaabiaaaaaaaiaacaakklbafaaaaadaaaabbia
aaaaaaiaabaaaakaafaaaaadaaaacbiaaaaaaaiaaaaapplaafaaaaadaaaaabia
aaaaaaiaaeaaaakaafaaaaadaaaaabiaaaaaaaiaaaaappkaafaaaaadaaaaciia
abaappiaaaaaaaiaabaaaaacacaaahiaaaaaoelaafaaaaadacaaahiaacaaoeia
aaaaoekaafaaaaadacaaahiaacaaoeiaaeaaaakaaeaaaaaeabaaahiaacaaoeia
abaaoeiaadaaoekbabaaaaacabaabiiaabaakklaaeaaaaaeaaaachiaabaappia
abaaoeiaadaaoekaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcleacaaaa
eaaaaaaaknaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadecbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaa
ckiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaa
aoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackbabaia
ebaaaaaaadaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaajaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhcaabaaaaaaaaaaaegbcbaaaabaaaaaaaaaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaacaaaaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaa
ckbabaaaacaaaaaadcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaadoaaaaabejfdeheojmaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaajcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
aeaeaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
}