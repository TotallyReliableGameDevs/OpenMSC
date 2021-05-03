Shader "Custom/windshield2" {
Properties {
 _MainTex ("Src Texture", 2D) = "white" { }
 _Dry ("Dry Color", Color) = (1,1,1,1)
 _Wet ("Wet Color", Color) = (1,1,1,1)
 _AlphaDist ("AlphaDist", Float) = 1
 _DryingSpeed ("DryingSpeed", Float) = 0.01
 _FrontUV ("FrontUV", Vector) = (0,0,1,0.4)
 _SideUV ("SideUV", Vector) = (0,0.4,1,0.7)
 _RearUV ("RearUV", Vector) = (0,0.7,1,1)
 _FrontFlow ("FrontFlow", Vector) = (0,-10,0,0)
 _SideFlow ("SideFlow", Vector) = (0,-10,0,0)
 _RearFlow ("RearFlow", Vector) = (0,-10,0,0)
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 61597
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_ST;
uniform vec4 _Dry;
varying vec4 xlv_COLOR;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_COLOR = (gl_Color * _Dry);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform vec4 _Dry;
uniform vec4 _Wet;
uniform float _DryingSpeed;
uniform vec4 _FrontUV;
uniform vec4 _SideUV;
uniform vec4 _RearUV;
uniform vec4 _FrontFlow;
uniform vec4 _SideFlow;
uniform vec4 _RearFlow;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 uv_1;
  float drying_2;
  drying_2 = _DryingSpeed;
  uv_1 = vec2(0.0, 0.0);
  if ((((
    (xlv_TEXCOORD0.x > _FrontUV.x)
   && 
    (xlv_TEXCOORD0.y > _FrontUV.y)
  ) && (xlv_TEXCOORD0.x < _FrontUV.z)) && (xlv_TEXCOORD0.y < _FrontUV.w))) {
    uv_1 = (xlv_TEXCOORD0 - (_FrontFlow / 1000.0).xy);
  } else {
    if ((((
      (xlv_TEXCOORD0.x > _SideUV.x)
     && 
      (xlv_TEXCOORD0.y > _SideUV.y)
    ) && (xlv_TEXCOORD0.x < _SideUV.z)) && (xlv_TEXCOORD0.y < _SideUV.w))) {
      uv_1 = (xlv_TEXCOORD0 - (_SideFlow / 1000.0).xy);
    } else {
      if ((((
        (xlv_TEXCOORD0.x > _RearUV.x)
       && 
        (xlv_TEXCOORD0.y > _RearUV.y)
      ) && (xlv_TEXCOORD0.x < _RearUV.z)) && (xlv_TEXCOORD0.y < _RearUV.w))) {
        uv_1 = (xlv_TEXCOORD0 - (_RearFlow / 1000.0).xy);
      } else {
        uv_1 = xlv_TEXCOORD0;
      };
    };
  };
  if ((((
    (uv_1.x < 0.01)
   || 
    (uv_1.x > 0.99)
  ) || (uv_1.y < 0.01)) || (uv_1.y > 0.99))) {
    uv_1 = xlv_TEXCOORD0;
    drying_2 = (_DryingSpeed * 100.0);
  };
  gl_FragData[0] = mix (_Dry, _Wet, vec4(clamp ((texture2D (_MainTex, uv_1).w - drying_2), 0.0, 1.0)));
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 5 [_Dry]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position v0
dcl_color v1
dcl_texcoord v2
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mul oD0, v1, c5
mad oT0.xy, v2, c4, c4.zwzw

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 96 [_MainTex_ST]
Vector 112 [_Dry]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedbneoghhopifngljhialdmbpjcmnnckpdabaaaaaahmacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcgeabaaaaeaaaabaafjaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Vector 96 [_MainTex_ST]
Vector 112 [_Dry]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedmkeebejpijpmlfenjddbpokggiodggnhabaaaaaaieadaaaaaeaaaaaa
daaaaaaadeabaaaakaacaaaabaadaaaaebgpgodjpmaaaaaapmaaaaaaaaacpopp
lmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaagaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaacaaoekaaeaaaaaeabaaadoaacaaoejaabaaoeka
abaaookaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaaeaaaaapiaadaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcgeabaaaaeaaaabaa
fjaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
dcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaa
abaaaaaaegiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 0 [_Dry]
Float 2 [_DryingSpeed]
Vector 6 [_FrontFlow]
Vector 3 [_FrontUV]
Vector 8 [_RearFlow]
Vector 5 [_RearUV]
Vector 7 [_SideFlow]
Vector 4 [_SideUV]
Vector 1 [_Wet]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c9, 0.00100000005, -0, -1, 0
def c10, -0.00999999978, 0.99000001, 100, 0
dcl t0.xy
dcl_2d s0
add r0.w, t0.y, -c5.w
cmp r0.x, r0.w, c9.y, c9.z
add r0.y, t0.x, -c5.z
cmp r0.x, r0.y, c9.w, r0.x
add r0.y, -t0.y, c5.y
cmp r0.x, r0.y, c9.w, r0.x
add r0.y, -t0.x, c5.x
cmp r0.x, r0.y, c9.w, r0.x
mov r1.w, c9.x
mad r0.yz, c8.zxyw, -r1.w, t0.zxyw
cmp r0.yz, r0.x, t0.zxyw, r0
add r0.x, t0.y, -c4.w
cmp r0.x, r0.x, c9.y, c9.z
add r0.w, t0.x, -c4.z
cmp r0.x, r0.w, c9.w, r0.x
add r0.w, -t0.y, c4.y
cmp r0.x, r0.w, c9.w, r0.x
add r0.w, -t0.x, c4.x
cmp r0.x, r0.w, c9.w, r0.x
mad r1.yz, c7.zxyw, -r1.w, t0.zxyw
cmp r0.yz, r0.x, r0, r1
add r0.x, t0.y, -c3.w
cmp r0.x, r0.x, c9.y, c9.z
add r0.w, t0.x, -c3.z
cmp r0.x, r0.w, c9.w, r0.x
add r0.w, -t0.y, c3.y
cmp r0.x, r0.w, c9.w, r0.x
add r0.w, -t0.x, c3.x
cmp r0.x, r0.w, c9.w, r0.x
mad r1.yz, c6.zxyw, -r1.w, t0.zxyw
cmp r0.yz, r0.x, r0, r1
add r0.w, r0.y, c10.x
cmp r0.w, r0.w, -c9.y, -c9.z
add r1.x, -r0.y, c10.y
cmp r1.x, r1.x, -c9.y, -c9.z
add r0.w, r0.w, r1.x
cmp r0.w, -r0.w, -c9.y, -c9.z
add r1.x, r0.z, c10.x
cmp r1.x, r1.x, -c9.y, -c9.z
add r0.w, r0.w, r1.x
cmp r0.w, -r0.w, -c9.y, -c9.z
add r1.x, -r0.z, c10.y
cmp r1.x, r1.x, -c9.y, -c9.z
add r0.w, r0.w, r1.x
mov r0.x, c2.x
mov r1.z, c10.z
mul r1.x, r1.z, c2.x
mov r1.yz, t0.zxyw
cmp r0.xyz, -r0.w, r0, r1
mov r1.xy, r0.yzxw
texld r1, r1, s0
add_sat r0.x, -r0.x, r1.w
mov r1, c0
add r1, -r1, c1
mad_pp r0, r0.x, r1, c0
mov_pp oC0, r0

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 256
Vector 112 [_Dry]
Vector 128 [_Wet]
Float 144 [_DryingSpeed]
Vector 160 [_FrontUV]
Vector 176 [_SideUV]
Vector 192 [_RearUV]
Vector 208 [_FrontFlow]
Vector 224 [_SideFlow]
Vector 240 [_RearFlow]
BindCB  "$Globals" 0
"ps_4_0
eefiecedphphmnhiopcocecfbbklgnhfchjapdodabaaaaaakmafaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaaeaaaaeaaaaaaa
deabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaadbaaaaaidcaabaaaaaaaaaaaegiacaaa
aaaaaaaaamaaaaaaegbabaaaacaaaaaaabaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadbaaaaaigcaabaaaaaaaaaaaagbbbaaaacaaaaaa
kgilcaaaaaaaaaaaamaaaaaaabaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaaabaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaaogcaabaaaaaaaaaaaagibcaiaebaaaaaaaaaaaaaaapaaaaaa
aceaaaaaaaaaaaaagpbciddkgpbciddkaaaaaaaaagbbbaaaacaaaaaadhaaaaaj
dcaabaaaaaaaaaaaagaabaaaaaaaaaaajgafbaaaaaaaaaaaegbabaaaacaaaaaa
dbaaaaaimcaabaaaaaaaaaaaagiecaaaaaaaaaaaalaaaaaaagbebaaaacaaaaaa
abaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaai
dcaabaaaabaaaaaaegbabaaaacaaaaaaogikcaaaaaaaaaaaalaaaaaaabaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaaabaaaaahecaabaaa
aaaaaaaabkaabaaaabaaaaaackaabaaaaaaaaaaadcaaaaaodcaabaaaabaaaaaa
egiacaiaebaaaaaaaaaaaaaaaoaaaaaaaceaaaaagpbciddkgpbciddkaaaaaaaa
aaaaaaaaegbabaaaacaaaaaadhaaaaajdcaabaaaaaaaaaaakgakbaaaaaaaaaaa
egaabaaaabaaaaaaegaabaaaaaaaaaaadbaaaaaimcaabaaaaaaaaaaaagiecaaa
aaaaaaaaakaaaaaaagbebaaaacaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaaidcaabaaaabaaaaaaegbabaaaacaaaaaa
ogikcaaaaaaaaaaaakaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaabaaaaaaabaaaaahecaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaa
aaaaaaaadcaaaaaodcaabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaaanaaaaaa
aceaaaaagpbciddkgpbciddkaaaaaaaaaaaaaaaaegbabaaaacaaaaaadhaaaaaj
gcaabaaaaaaaaaaakgakbaaaaaaaaaaaagabbaaaabaaaaaaagabbaaaaaaaaaaa
dbaaaaakdcaabaaaabaaaaaajgafbaaaaaaaaaaaaceaaaaaaknhcddmaknhcddm
aaaaaaaaaaaaaaaadbaaaaakmcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
kehahndpkehahndpfgajbaaaaaaaaaaadmaaaaahicaabaaaaaaaaaaackaabaaa
abaaaaaaakaabaaaabaaaaaadmaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaa
dkaabaaaaaaaaaaadmaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaaakiacaaaaaaaaaaaajaaaaaaabeaaaaa
aaaamiecdgaaaaafgcaabaaaabaaaaaaagbbbaaaacaaaaaadgaaaaagbcaabaaa
aaaaaaaaakiacaaaaaaaaaaaajaaaaaadhaaaaajhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
jgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaacaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaakpcaabaaa
abaaaaaaegiocaiaebaaaaaaaaaaaaaaahaaaaaaegiocaaaaaaaaaaaaiaaaaaa
dcaaaaakpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegiocaaa
aaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 256
Vector 112 [_Dry]
Vector 128 [_Wet]
Float 144 [_DryingSpeed]
Vector 160 [_FrontUV]
Vector 176 [_SideUV]
Vector 192 [_RearUV]
Vector 208 [_FrontFlow]
Vector 224 [_SideFlow]
Vector 240 [_RearFlow]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecednkgmhggkhaljcojdbgefmgiojfobcekiabaaaaaaaiakaaaaaeaaaaaa
daaaaaaaiiaeaaaagaajaaaaneajaaaaebgpgodjfaaeaaaafaaeaaaaaaacpppp
bmaeaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaahaaajaaaaaaaaaaaaaaaaacppppfbaaaaafajaaapkagpbciddkaaaaaaia
aaaaialpaaaaaaaafbaaaaafakaaapkaaknhcdlmkehahndpaaaamiecaaaaaaaa
bpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaajaaaaiapkaacaaaaadaaaaaiia
abaafflaafaappkbfiaaaaaeaaaaabiaaaaappiaajaaffkaajaakkkaacaaaaad
aaaaaciaabaaaalaafaakkkbfiaaaaaeaaaaabiaaaaaffiaajaappkaaaaaaaia
acaaaaadaaaaaciaabaafflbafaaffkafiaaaaaeaaaaabiaaaaaffiaajaappka
aaaaaaiaacaaaaadaaaaaciaabaaaalbafaaaakafiaaaaaeaaaaabiaaaaaffia
ajaappkaaaaaaaiaabaaaaacabaaaiiaajaaaakaaeaaaaaeaaaaagiaaiaancka
abaappibabaanclafiaaaaaeaaaaagiaaaaaaaiaabaanclaaaaaoeiaacaaaaad
aaaaabiaabaafflaaeaappkbfiaaaaaeaaaaabiaaaaaaaiaajaaffkaajaakkka
acaaaaadaaaaaiiaabaaaalaaeaakkkbfiaaaaaeaaaaabiaaaaappiaajaappka
aaaaaaiaacaaaaadaaaaaiiaabaafflbaeaaffkafiaaaaaeaaaaabiaaaaappia
ajaappkaaaaaaaiaacaaaaadaaaaaiiaabaaaalbaeaaaakafiaaaaaeaaaaabia
aaaappiaajaappkaaaaaaaiaaeaaaaaeabaaagiaahaanckaabaappibabaancla
fiaaaaaeaaaaagiaaaaaaaiaaaaaoeiaabaaoeiaacaaaaadaaaaabiaabaaffla
adaappkbfiaaaaaeaaaaabiaaaaaaaiaajaaffkaajaakkkaacaaaaadaaaaaiia
abaaaalaadaakkkbfiaaaaaeaaaaabiaaaaappiaajaappkaaaaaaaiaacaaaaad
aaaaaiiaabaafflbadaaffkafiaaaaaeaaaaabiaaaaappiaajaappkaaaaaaaia
acaaaaadaaaaaiiaabaaaalbadaaaakafiaaaaaeaaaaabiaaaaappiaajaappka
aaaaaaiaaeaaaaaeabaaagiaagaanckaabaappibabaanclafiaaaaaeaaaaagia
aaaaaaiaaaaaoeiaabaaoeiaacaaaaadaaaaaiiaaaaaffiaakaaaakafiaaaaae
aaaaaiiaaaaappiaajaaffkbajaakkkbacaaaaadabaaabiaaaaaffibakaaffka
fiaaaaaeabaaabiaabaaaaiaajaaffkbajaakkkbacaaaaadaaaaaiiaaaaappia
abaaaaiafiaaaaaeaaaaaiiaaaaappibajaaffkbajaakkkbacaaaaadabaaabia
aaaakkiaakaaaakafiaaaaaeabaaabiaabaaaaiaajaaffkbajaakkkbacaaaaad
aaaaaiiaaaaappiaabaaaaiafiaaaaaeaaaaaiiaaaaappibajaaffkbajaakkkb
acaaaaadabaaabiaaaaakkibakaaffkafiaaaaaeabaaabiaabaaaaiaajaaffkb
ajaakkkbacaaaaadaaaaaiiaaaaappiaabaaaaiaabaaaaacaaaaabiaacaaaaka
abaaaaacabaaaeiaakaakkkaafaaaaadabaaabiaabaakkiaacaaaakaabaaaaac
abaaagiaabaanclafiaaaaaeaaaaahiaaaaappibaaaaoeiaabaaoeiaabaaaaac
abaaadiaaaaamjiaecaaaaadabaaapiaabaaoeiaaaaioekaacaaaaadaaaabbia
aaaaaaibabaappiaabaaaaacabaaapiaaaaaoekaacaaaaadabaaapiaabaaoeib
abaaoekaaeaaaaaeaaaacpiaaaaaaaiaabaaoeiaaaaaoekaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcnaaeaaaaeaaaaaaadeabaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaadbaaaaaidcaabaaaaaaaaaaaegiacaaaaaaaaaaaamaaaaaaegbabaaa
acaaaaaaabaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dbaaaaaigcaabaaaaaaaaaaaagbbbaaaacaaaaaakgilcaaaaaaaaaaaamaaaaaa
abaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaabaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaogcaabaaa
aaaaaaaaagibcaiaebaaaaaaaaaaaaaaapaaaaaaaceaaaaaaaaaaaaagpbciddk
gpbciddkaaaaaaaaagbbbaaaacaaaaaadhaaaaajdcaabaaaaaaaaaaaagaabaaa
aaaaaaaajgafbaaaaaaaaaaaegbabaaaacaaaaaadbaaaaaimcaabaaaaaaaaaaa
agiecaaaaaaaaaaaalaaaaaaagbebaaaacaaaaaaabaaaaahecaabaaaaaaaaaaa
dkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaaidcaabaaaabaaaaaaegbabaaa
acaaaaaaogikcaaaaaaaaaaaalaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaabaaaaaaabaaaaahecaabaaaaaaaaaaabkaabaaaabaaaaaa
ckaabaaaaaaaaaaadcaaaaaodcaabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaa
aoaaaaaaaceaaaaagpbciddkgpbciddkaaaaaaaaaaaaaaaaegbabaaaacaaaaaa
dhaaaaajdcaabaaaaaaaaaaakgakbaaaaaaaaaaaegaabaaaabaaaaaaegaabaaa
aaaaaaaadbaaaaaimcaabaaaaaaaaaaaagiecaaaaaaaaaaaakaaaaaaagbebaaa
acaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
dbaaaaaidcaabaaaabaaaaaaegbabaaaacaaaaaaogikcaaaaaaaaaaaakaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaaabaaaaah
ecaabaaaaaaaaaaabkaabaaaabaaaaaackaabaaaaaaaaaaadcaaaaaodcaabaaa
abaaaaaaegiacaiaebaaaaaaaaaaaaaaanaaaaaaaceaaaaagpbciddkgpbciddk
aaaaaaaaaaaaaaaaegbabaaaacaaaaaadhaaaaajgcaabaaaaaaaaaaakgakbaaa
aaaaaaaaagabbaaaabaaaaaaagabbaaaaaaaaaaadbaaaaakdcaabaaaabaaaaaa
jgafbaaaaaaaaaaaaceaaaaaaknhcddmaknhcddmaaaaaaaaaaaaaaaadbaaaaak
mcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaakehahndpkehahndpfgajbaaa
aaaaaaaadmaaaaahicaabaaaaaaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaa
dmaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaadmaaaaah
icaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaajaaaaaaabeaaaaaaaaamiecdgaaaaafgcaabaaa
abaaaaaaagbbbaaaacaaaaaadgaaaaagbcaabaaaaaaaaaaaakiacaaaaaaaaaaa
ajaaaaaadhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaacaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaaaaaaaaakpcaabaaaabaaaaaaegiocaiaebaaaaaa
aaaaaaaaahaaaaaaegiocaaaaaaaaaaaaiaaaaaadcaaaaakpccabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaadoaaaaab
ejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
gcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
}
}