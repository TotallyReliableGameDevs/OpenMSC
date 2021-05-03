Shader "Hidden/GlobalFog" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "black" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  GpuProgramID 60615
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform mat4 _FrustumCornersWS;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec4 tmpvar_2;
  tmpvar_2.xyw = gl_Vertex.xyw;
  vec4 tmpvar_3;
  tmpvar_2.z = 0.1;
  int i_4;
  i_4 = int(gl_Vertex.z);
  vec4 v_5;
  v_5.x = _FrustumCornersWS[0][i_4];
  v_5.y = _FrustumCornersWS[1][i_4];
  v_5.z = _FrustumCornersWS[2][i_4];
  v_5.w = _FrustumCornersWS[3][i_4];
  tmpvar_3.xyz = v_5.xyz;
  tmpvar_3.w = gl_Vertex.z;
  gl_Position = (gl_ModelViewProjectionMatrix * tmpvar_2);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _HeightParams;
uniform vec4 _DistanceParams;
uniform ivec4 _SceneFogMode;
uniform vec4 _SceneFogParams;
uniform vec4 _CameraWS;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  float fogFac_1;
  float g_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD1);
  float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)));
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD2);
  g_2 = _DistanceParams.x;
  float dist_7;
  if ((_SceneFogMode.y == 1)) {
    dist_7 = sqrt(dot (tmpvar_6.xyz, tmpvar_6.xyz));
  } else {
    dist_7 = (tmpvar_5 * _ProjectionParams.z);
  };
  float tmpvar_8;
  tmpvar_8 = (dist_7 - _ProjectionParams.y);
  dist_7 = tmpvar_8;
  g_2 = (_DistanceParams.x + tmpvar_8);
  vec3 tmpvar_9;
  tmpvar_9 = (_HeightParams.w * tmpvar_6.xyz);
  float tmpvar_10;
  tmpvar_10 = ((_CameraWS.xyz + tmpvar_6.xyz).y - _HeightParams.x);
  float tmpvar_11;
  tmpvar_11 = min (((1.0 - 
    (2.0 * _HeightParams.z)
  ) * tmpvar_10), 0.0);
  g_2 = (g_2 + (-(
    sqrt(dot (tmpvar_9, tmpvar_9))
  ) * (
    (_HeightParams.z * (tmpvar_10 + _HeightParams.y))
   - 
    ((tmpvar_11 * tmpvar_11) / abs((tmpvar_6.y + 1e-05)))
  )));
  float tmpvar_12;
  tmpvar_12 = max (0.0, g_2);
  float fogFac_13;
  fogFac_13 = 0.0;
  if ((_SceneFogMode.x == 1)) {
    fogFac_13 = ((tmpvar_12 * _SceneFogParams.z) + _SceneFogParams.w);
  };
  if ((_SceneFogMode.x == 2)) {
    fogFac_13 = exp2(-((_SceneFogParams.y * tmpvar_12)));
  };
  if ((_SceneFogMode.x == 3)) {
    float tmpvar_14;
    tmpvar_14 = (_SceneFogParams.x * tmpvar_12);
    fogFac_13 = exp2((-(tmpvar_14) * tmpvar_14));
  };
  fogFac_1 = clamp (fogFac_13, 0.0, 1.0);
  if ((tmpvar_4.x >= 0.999999)) {
    fogFac_1 = 1.0;
  };
  gl_FragData[0] = mix (unity_FogColor, tmpvar_3, vec4(fogFac_1));
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 4 [_FrustumCornersWS]
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_MainTex_TexelSize]
"vs_2_0
def c9, 1, 0, 0.100000001, -2
dcl_position v0
dcl_texcoord v1
mad r0, v0.xyxw, c9.xxyx, c9.yyzy
dp4 oPos.x, c0, r0
dp4 oPos.y, c1, r0
dp4 oPos.z, c2, r0
dp4 oPos.w, c3, r0
mov r0.y, c9.y
slt r0.x, c8.y, r0.y
mad r0.y, v1.y, c9.w, c9.x
mad oT0.y, r0.x, r0.y, v1.y
mov oT0.x, v1.x
mov oT1.xy, v1
slt r0.x, v0.z, -v0.z
frc r0.y, v0.z
add r0.z, -r0.y, v0.z
slt r0.y, -r0.y, r0.y
mad r0.x, r0.x, r0.y, r0.z
mova a0.x, r0.x
mov oT2.xyz, c4[a0.x]
mov oT2.w, v0.z

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Matrix 176 [_FrustumCornersWS]
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedbpjmkiaepkjlaajdeanbgemggnehdfdfabaaaaaaiiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefchiacaaaaeaaaabaajoaaaaaadfbiaaaabcaaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadp
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaan
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaaaceaaaaamnmmmmdnmnmmmmdn
mnmmmmdnmnmmmmdnegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaa
aaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaa
abaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaaf
nccabaaaabaaaaaaagbebaaaabaaaaaadgaaaaaficcabaaaacaaaaaackbabaaa
aaaaaaaablaaaaafbcaabaaaaaaaaaaackbabaaaaaaaaaaabbaaaaajbccabaaa
acaaaaaaegiocaaaaaaaaaaaalaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaaj
cccabaaaacaaaaaaegiocaaaaaaaaaaaamaaaaaaegjojaaaakaabaaaaaaaaaaa
bbaaaaajeccabaaaacaaaaaaegiocaaaaaaaaaaaanaaaaaaegjojaaaakaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Matrix 176 [_FrustumCornersWS]
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedmmkomcencckgffbnnknplmikaanbblggabaaaaaanmafaaaaaeaaaaaa
daaaaaaaiaacaaaaaaafaaaafeafaaaaebgpgodjeiacaaaaeiacaaaaaaacpopp
aiacaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaakaa
aeaaagaaaaaaaaaaabaaaaaaaeaaakaaaaaaaaaaaaaaafaaaaacpoppfbaaaaaf
aeaaapkamnmmmmdnaaaaaamaaaaaiadpaaaaaaaafbaaaaafaaaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaafbaaaaafabaaapkaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaafbaaaaafacaaapkaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaafbaaaaaf
adaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaaciaagaaffkaamaaaaadaaaaabia
aaaaffiaaaaappkaaeaaaaaeaaaaaciaabaaffjaaeaaffkaaeaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaamaaaaadaaaaabiaaaaakkjaaaaakkjb
bdaaaaacaaaaaciaaaaakkjaacaaaaadaaaaaeiaaaaaffibaaaakkjaamaaaaad
aaaaaciaaaaaffibaaaaffiaaeaaaaaeaaaaabiaaaaaaaiaaaaaffiaaaaakkia
coaaaaacaaaaablaaaaaaaiaabaaaaadaaaaapiaaacaoekaaaaaaalaajaaaaad
abaaaboaahaaoekaaaaaoeiaajaaaaadabaaacoaaiaaoekaaaaaoeiaajaaaaad
abaaaeoaajaaoekaaaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaae
aaaaapiaakaaoekaaaaaaajaaaaaoeiaabaaaaacabaaabiaaeaaaakaaeaaaaae
aaaaapiaamaaoekaabaaaaiaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaafaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaanoaabaabejaabaaaaacabaaaioaaaaakkjappppaaaa
fdeieefchiacaaaaeaaaabaajoaaaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaanpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnmnmmmmdn
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaa
aaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaafnccabaaaabaaaaaa
agbebaaaabaaaaaadgaaaaaficcabaaaacaaaaaackbabaaaaaaaaaaablaaaaaf
bcaabaaaaaaaaaaackbabaaaaaaaaaaabbaaaaajbccabaaaacaaaaaaegiocaaa
aaaaaaaaalaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaajcccabaaaacaaaaaa
egiocaaaaaaaaaaaamaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaajeccabaaa
acaaaaaaegiocaaaaaaaaaaaanaaaaaaegjojaaaakaabaaaaaaaaaaadoaaaaab
ejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
faepfdejfeejepeoaafeeffiedepepfceeaaklklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 7 [_CameraWS]
Vector 4 [_DistanceParams]
Vector 3 [_HeightParams]
Vector 0 [_ProjectionParams]
Vector 5 [_SceneFogMode]
Vector 6 [_SceneFogParams]
Vector 1 [_ZBufferParams]
Vector 2 [unity_FogColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_2_0
def c8, -1, 2, 1, 0
def c9, 9.99999975e-006, -3, -0.999998987, 0
dcl t0.xy
dcl t1.xy
dcl t2.xyz
dcl_2d s0
dcl_2d s1
texld r0, t1, s1
texld_pp r1, t0, s0
mov r2.xyz, c8
mad r0.y, c3.z, -r2.y, r2.z
mad r0.z, c1.x, r0.x, c1.y
add r0.x, r0.x, c9.z
rcp r0.z, r0.z
mad r0.w, r0.z, t2.y, c7.y
add r0.w, r0.w, -c3.x
mul r0.y, r0.w, r0.y
add r0.w, r0.w, c3.y
min r2.z, r0.y, c8.w
mul r0.y, r2.z, r2.z
mad r2.z, r0.z, t2.y, c9.x
abs r2.z, r2.z
rcp r2.z, r2.z
mul r0.y, r0.y, r2.z
mad r0.y, c3.z, r0.w, -r0.y
mul r0.w, r0.z, c0.z
mul r3.xyz, r0.z, t2
dp3 r3.w, r3, r3
mul r3.xyz, r3, c3.w
dp3 r0.z, r3, r3
rsq r0.z, r0.z
rcp r0.z, r0.z
rsq r2.z, r3.w
rcp r2.z, r2.z
add r2.w, r2.x, c5.y
mul r2.w, r2.w, r2.w
cmp r0.w, -r2.w, r2.z, r0.w
add r0.w, r0.w, -c0.y
add r0.w, r0.w, c4.x
mad r0.y, -r0.z, r0.y, r0.w
max r2.z, r0.y, c8.w
mad_pp r2.w, r2.z, c6.z, c6.w
add r0.y, r2.x, c5.x
mul r0.y, r0.y, r0.y
cmp_pp r0.y, -r0.y, r2.w, c8.w
mul r0.zw, r2.z, c6.wzyx
mul r0.w, r0.w, -r0.w
exp_pp r0.w, r0.w
exp_pp r0.z, -r0.z
add r2.x, -r2.y, c5.x
mul r2.x, r2.x, r2.x
cmp_pp r0.y, -r2.x, r0.z, r0.y
mov r2.x, c5.x
add r0.z, r2.x, c9.y
mul r0.z, r0.z, r0.z
cmp_sat_pp r0.y, -r0.z, r0.w, r0.y
cmp_pp r0.x, r0.x, c8.z, r0.y
lrp_pp r2, r0.x, r1, c2
mov_pp oC0, r2

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 256
Vector 96 [_HeightParams]
Vector 112 [_DistanceParams]
VectorInt 128 [_SceneFogMode] 4
Vector 144 [_SceneFogParams]
Vector 240 [_CameraWS]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0
eefieceddolijdbfjglpgfofflapdkigimoenmjaabaaaaaalaagaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmaafaaaaeaaaaaaahaabaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadcaaaaalbcaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaagaaaaaaabeaaaaaaaaaaaeaabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaalccaabaaaaaaaaaaaakiacaaaabaaaaaaahaaaaaa
akaabaaaabaaaaaabkiacaaaabaaaaaaahaaaaaabnaaaaahecaabaaaaaaaaaaa
akaabaaaabaaaaaaabeaaaaaoppphpdpaoaaaaakccaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaadcaaaaakicaabaaa
aaaaaaaabkaabaaaaaaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaaapaaaaaa
aaaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
agaaaaaadiaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaagaaaaaa
ddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaabkaabaaaaaaaaaaabkbabaaaacaaaaaaabeaaaaakmmfchdhaoaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaibaaaaaaabaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaadkaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaa
abaaaaaaafaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegbcbaaa
acaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaacaaaaaalpcaabaaaacaaaaaabgiacaaaaaaaaaaaaiaaaaaaaceaaaaa
abaaaaaaabaaaaaaacaaaaaaadaaaaaadhaaaaajccaabaaaaaaaaaaaakaabaaa
acaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkiacaiaebaaaaaaabaaaaaaafaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaiaebaaaaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaal
ccaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaajaaaaaadkiacaaa
aaaaaaaaajaaaaaadiaaaaaijcaabaaaaaaaaaaaagaabaaaaaaaaaaafgibcaaa
aaaaaaaaajaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
acaaaaaabjaaaaagbcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaajbcaabaaaaaaaaaaackaabaaa
acaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadhcaaaajbcaabaaaaaaaaaaa
dkaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaadhaaaaajbcaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpakaabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaiaebaaaaaaacaaaaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
egiocaaaacaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 256
Vector 96 [_HeightParams]
Vector 112 [_DistanceParams]
VectorInt 128 [_SceneFogMode] 4
Vector 144 [_SceneFogParams]
Vector 240 [_CameraWS]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0_level_9_1
eefiecedodpkjephllkboiljipejijghdnigfloeabaaaaaapeakaaaaaeaaaaaa
daaaaaaahaaeaaaadiakaaaamaakaaaaebgpgodjdiaeaaaadiaeaaaaaaacpppp
liadaaaaiaaaaaaaahaacmaaaaaaiaaaaaaaiaaaacaaceaaaaaaiaaaaaaaaaaa
abababaaaaaaagaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaaacacacacaaaaajaa
abaaadaaaaaaaaaaaaaaapaaabaaaeaaaaaaaaaaabaaafaaabaaafaaaaaaaaaa
abaaahaaabaaagaaaaaaaaaaacaaaaaaabaaahaaaaaaaaaaaaacppppfbaaaaaf
aiaaapkaaaaaialpaaaaaaeaaaaaiadpaaaaaaaafbaaaaafajaaapkakmmfchdh
aaaaeamaoppphplpaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaabaaaaac
aaaaahiaaiaaoekaaeaaaaaeaaaaaeiaaaaakkkaaaaaffibaaaakkiaabaaaaac
abaaadiaaaaabllaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadacaacpia
aaaaoelaaaaioekaaeaaaaaeaaaaaiiaagaaaakaabaaaaiaagaaffkaacaaaaad
abaaabiaabaaaaiaajaakkkaagaaaaacaaaaaiiaaaaappiaaeaaaaaeabaaacia
aaaappiaabaafflaaeaaffkaacaaaaadabaaaciaabaaffiaaaaaaakbafaaaaad
aaaaaeiaaaaakkiaabaaffiaacaaaaadabaaaciaabaaffiaaaaaffkaakaaaaad
abaaaeiaaaaakkiaaiaappkaafaaaaadaaaaaeiaabaakkiaabaakkiaaeaaaaae
abaaaeiaaaaappiaabaafflaajaaaakacdaaaaacabaaaeiaabaakkiaagaaaaac
abaaaeiaabaakkiaafaaaaadaaaaaeiaaaaakkiaabaakkiaaeaaaaaeaaaaaeia
aaaakkkaabaaffiaaaaakkibafaaaaadabaaaciaaaaappiaafaakkkaafaaaaad
adaaahiaaaaappiaabaaoelaaiaaaaadaaaaaiiaadaaoeiaadaaoeiaafaaaaad
adaaahiaadaaoeiaaaaappkaaiaaaaadabaaaeiaadaaoeiaadaaoeiaahaaaaac
abaaaeiaabaakkiaagaaaaacabaaaeiaabaakkiaahaaaaacaaaaaiiaaaaappia
agaaaaacaaaaaiiaaaaappiaacaaaaadabaaaiiaaaaaaaiaacaaffkaafaaaaad
abaaaiiaabaappiaabaappiafiaaaaaeaaaaaiiaabaappibaaaappiaabaaffia
acaaaaadaaaaaiiaaaaappiaafaaffkbacaaaaadaaaaaiiaaaaappiaabaaaaka
aeaaaaaeaaaaaeiaabaakkibaaaakkiaaaaappiaalaaaaadabaaaciaaaaakkia
aiaappkaaeaaaaaeaaaaceiaabaaffiaadaakkkaadaappkaacaaaaadaaaaabia
aaaaaaiaacaaaakaafaaaaadaaaaabiaaaaaaaiaaaaaaaiafiaaaaaeaaaacbia
aaaaaaibaaaakkiaaiaappkaafaaaaadaaaaamiaabaaffiaadaablkaafaaaaad
aaaaaiiaaaaappiaaaaappibaoaaaaacaaaaciiaaaaappiaaoaaaaacaaaaceia
aaaakkibacaaaaadaaaaaciaaaaaffibacaaaakaafaaaaadaaaaaciaaaaaffia
aaaaffiafiaaaaaeaaaacbiaaaaaffibaaaakkiaaaaaaaiaabaaaaacadaaabia
acaaaakaacaaaaadaaaaaciaadaaaaiaajaaffkaafaaaaadaaaaaciaaaaaffia
aaaaffiafiaaaaaeaaaadbiaaaaaffibaaaappiaaaaaaaiafiaaaaaeaaaacbia
abaaaaiaaiaakkkaaaaaaaiabcaaaaaeabaacpiaaaaaaaiaacaaoeiaahaaoeka
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcmaafaaaaeaaaaaaahaabaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaagaaaaaaabeaaaaa
aaaaaaeaabeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaalccaabaaaaaaaaaaaakiacaaa
abaaaaaaahaaaaaaakaabaaaabaaaaaabkiacaaaabaaaaaaahaaaaaabnaaaaah
ecaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaoppphpdpaoaaaaakccaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaa
dcaaaaakicaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaacaaaaaabkiacaaa
aaaaaaaaapaaaaaaaaaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaagaaaaaadiaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaa
aaaaaaaaagaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaabkaabaaaaaaaaaaabkbabaaaacaaaaaaabeaaaaa
kmmfchdhaoaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaibaaaaaa
abaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaadkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaabkaabaaa
aaaaaaaackiacaaaabaaaaaaafaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaa
aaaaaaaaegbcbaaaacaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
aaaaaaaaagaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaelaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaacaaaaaalpcaabaaaacaaaaaabgiacaaaaaaaaaaa
aiaaaaaaaceaaaaaabaaaaaaabaaaaaaacaaaaaaadaaaaaadhaaaaajccaabaaa
aaaaaaaaakaabaaaacaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkiacaiaebaaaaaaabaaaaaaafaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaadcaaaaalccaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaa
ajaaaaaadkiacaaaaaaaaaaaajaaaaaadiaaaaaijcaabaaaaaaaaaaaagaabaaa
aaaaaaaafgibcaaaaaaaaaaaajaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaacaaaaaabjaaaaagbcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaajbcaabaaa
aaaaaaaackaabaaaacaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadhcaaaaj
bcaabaaaaaaaaaaadkaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dhaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaia
ebaaaaaaacaaaaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaabaaaaaaamamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  GpuProgramID 66620
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform mat4 _FrustumCornersWS;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec4 tmpvar_2;
  tmpvar_2.xyw = gl_Vertex.xyw;
  vec4 tmpvar_3;
  tmpvar_2.z = 0.1;
  int i_4;
  i_4 = int(gl_Vertex.z);
  vec4 v_5;
  v_5.x = _FrustumCornersWS[0][i_4];
  v_5.y = _FrustumCornersWS[1][i_4];
  v_5.z = _FrustumCornersWS[2][i_4];
  v_5.w = _FrustumCornersWS[3][i_4];
  tmpvar_3.xyz = v_5.xyz;
  tmpvar_3.w = gl_Vertex.z;
  gl_Position = (gl_ModelViewProjectionMatrix * tmpvar_2);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ProjectionParams;
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _DistanceParams;
uniform ivec4 _SceneFogMode;
uniform vec4 _SceneFogParams;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  float fogFac_1;
  float g_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD1);
  float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)));
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD2);
  g_2 = _DistanceParams.x;
  float dist_7;
  if ((_SceneFogMode.y == 1)) {
    dist_7 = sqrt(dot (tmpvar_6.xyz, tmpvar_6.xyz));
  } else {
    dist_7 = (tmpvar_5 * _ProjectionParams.z);
  };
  float tmpvar_8;
  tmpvar_8 = (dist_7 - _ProjectionParams.y);
  dist_7 = tmpvar_8;
  g_2 = (_DistanceParams.x + tmpvar_8);
  float tmpvar_9;
  tmpvar_9 = max (0.0, g_2);
  float fogFac_10;
  fogFac_10 = 0.0;
  if ((_SceneFogMode.x == 1)) {
    fogFac_10 = ((tmpvar_9 * _SceneFogParams.z) + _SceneFogParams.w);
  };
  if ((_SceneFogMode.x == 2)) {
    fogFac_10 = exp2(-((_SceneFogParams.y * tmpvar_9)));
  };
  if ((_SceneFogMode.x == 3)) {
    float tmpvar_11;
    tmpvar_11 = (_SceneFogParams.x * tmpvar_9);
    fogFac_10 = exp2((-(tmpvar_11) * tmpvar_11));
  };
  fogFac_1 = clamp (fogFac_10, 0.0, 1.0);
  if ((tmpvar_4.x >= 0.999999)) {
    fogFac_1 = 1.0;
  };
  gl_FragData[0] = mix (unity_FogColor, tmpvar_3, vec4(fogFac_1));
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 4 [_FrustumCornersWS]
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_MainTex_TexelSize]
"vs_2_0
def c9, 1, 0, 0.100000001, -2
dcl_position v0
dcl_texcoord v1
mad r0, v0.xyxw, c9.xxyx, c9.yyzy
dp4 oPos.x, c0, r0
dp4 oPos.y, c1, r0
dp4 oPos.z, c2, r0
dp4 oPos.w, c3, r0
mov r0.y, c9.y
slt r0.x, c8.y, r0.y
mad r0.y, v1.y, c9.w, c9.x
mad oT0.y, r0.x, r0.y, v1.y
mov oT0.x, v1.x
mov oT1.xy, v1
slt r0.x, v0.z, -v0.z
frc r0.y, v0.z
add r0.z, -r0.y, v0.z
slt r0.y, -r0.y, r0.y
mad r0.x, r0.x, r0.y, r0.z
mova a0.x, r0.x
mov oT2.xyz, c4[a0.x]
mov oT2.w, v0.z

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Matrix 176 [_FrustumCornersWS]
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedbpjmkiaepkjlaajdeanbgemggnehdfdfabaaaaaaiiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefchiacaaaaeaaaabaajoaaaaaadfbiaaaabcaaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadp
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaan
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaaaceaaaaamnmmmmdnmnmmmmdn
mnmmmmdnmnmmmmdnegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaa
aaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaa
abaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaaf
nccabaaaabaaaaaaagbebaaaabaaaaaadgaaaaaficcabaaaacaaaaaackbabaaa
aaaaaaaablaaaaafbcaabaaaaaaaaaaackbabaaaaaaaaaaabbaaaaajbccabaaa
acaaaaaaegiocaaaaaaaaaaaalaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaaj
cccabaaaacaaaaaaegiocaaaaaaaaaaaamaaaaaaegjojaaaakaabaaaaaaaaaaa
bbaaaaajeccabaaaacaaaaaaegiocaaaaaaaaaaaanaaaaaaegjojaaaakaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Matrix 176 [_FrustumCornersWS]
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedmmkomcencckgffbnnknplmikaanbblggabaaaaaanmafaaaaaeaaaaaa
daaaaaaaiaacaaaaaaafaaaafeafaaaaebgpgodjeiacaaaaeiacaaaaaaacpopp
aiacaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaakaa
aeaaagaaaaaaaaaaabaaaaaaaeaaakaaaaaaaaaaaaaaafaaaaacpoppfbaaaaaf
aeaaapkamnmmmmdnaaaaaamaaaaaiadpaaaaaaaafbaaaaafaaaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaafbaaaaafabaaapkaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaafbaaaaafacaaapkaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaafbaaaaaf
adaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaaciaagaaffkaamaaaaadaaaaabia
aaaaffiaaaaappkaaeaaaaaeaaaaaciaabaaffjaaeaaffkaaeaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaamaaaaadaaaaabiaaaaakkjaaaaakkjb
bdaaaaacaaaaaciaaaaakkjaacaaaaadaaaaaeiaaaaaffibaaaakkjaamaaaaad
aaaaaciaaaaaffibaaaaffiaaeaaaaaeaaaaabiaaaaaaaiaaaaaffiaaaaakkia
coaaaaacaaaaablaaaaaaaiaabaaaaadaaaaapiaaacaoekaaaaaaalaajaaaaad
abaaaboaahaaoekaaaaaoeiaajaaaaadabaaacoaaiaaoekaaaaaoeiaajaaaaad
abaaaeoaajaaoekaaaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaae
aaaaapiaakaaoekaaaaaaajaaaaaoeiaabaaaaacabaaabiaaeaaaakaaeaaaaae
aaaaapiaamaaoekaabaaaaiaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaafaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaanoaabaabejaabaaaaacabaaaioaaaaakkjappppaaaa
fdeieefchiacaaaaeaaaabaajoaaaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaanpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnmnmmmmdn
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaa
aaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaafnccabaaaabaaaaaa
agbebaaaabaaaaaadgaaaaaficcabaaaacaaaaaackbabaaaaaaaaaaablaaaaaf
bcaabaaaaaaaaaaackbabaaaaaaaaaaabbaaaaajbccabaaaacaaaaaaegiocaaa
aaaaaaaaalaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaajcccabaaaacaaaaaa
egiocaaaaaaaaaaaamaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaajeccabaaa
acaaaaaaegiocaaaaaaaaaaaanaaaaaaegjojaaaakaabaaaaaaaaaaadoaaaaab
ejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
faepfdejfeejepeoaafeeffiedepepfceeaaklklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 3 [_DistanceParams]
Vector 0 [_ProjectionParams]
Vector 4 [_SceneFogMode]
Vector 5 [_SceneFogParams]
Vector 1 [_ZBufferParams]
Vector 2 [unity_FogColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_2_0
def c6, -1, 0, -2, -3
def c7, -0.999998987, 0, 0, 0
dcl t0.xy
dcl t1.xy
dcl t2.xyz
dcl_2d s0
dcl_2d s1
texld r0, t1, s1
texld_pp r1, t0, s0
mov r2.xzw, c6
add r0.y, r2.x, c4.y
mul r0.y, r0.y, r0.y
mad r0.z, c1.x, r0.x, c1.y
add r0.x, r0.x, c7.x
rcp r0.z, r0.z
mul r3.xyz, r0.z, t2
mul r3.w, r0.z, c0.z
dp3 r0.z, r3, r3
rsq r0.z, r0.z
rcp r0.z, r0.z
cmp r0.y, -r0.y, r0.z, r3.w
add r0.y, r0.y, -c0.y
add r0.y, r0.y, c3.x
max r2.y, r0.y, c6.y
mad_pp r0.y, r2.y, c5.z, c5.w
add r0.z, r2.x, c4.x
mul r0.z, r0.z, r0.z
cmp_pp r0.y, -r0.z, r0.y, c6.y
mul r0.zw, r2.y, c5.wzyx
mul r0.w, r0.w, -r0.w
exp_pp r0.w, r0.w
exp_pp r0.z, -r0.z
add r2.x, r2.z, c4.x
mul r2.x, r2.x, r2.x
cmp_pp r0.y, -r2.x, r0.z, r0.y
add r0.z, r2.w, c4.x
mul r0.z, r0.z, r0.z
cmp_sat_pp r0.y, -r0.z, r0.w, r0.y
cmp_pp r0.x, r0.x, -c6.x, r0.y
lrp_pp r2, r0.x, r1, c2
mov_pp oC0, r2

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 256
Vector 112 [_DistanceParams]
VectorInt 128 [_SceneFogMode] 4
Vector 144 [_SceneFogParams]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0
eefiecedllabjiodmobghfllpooeiebfcgbajapaabaaaaaanmaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcomadaaaaeaaaaaaaplaaaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
ccaabaaaaaaaaaaaakiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaabkiacaaa
abaaaaaaahaaaaaabnaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
oppphpdpaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaa
egbcbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaa
abaaaaaaafaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaacaaaaaalpcaabaaa
abaaaaaabgiacaaaaaaaaaaaaiaaaaaaaceaaaaaabaaaaaaabaaaaaaacaaaaaa
adaaaaaadhaaaaajccaabaaaaaaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaabkiacaia
ebaaaaaaabaaaaaaafaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaahaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadcaaaaalecaabaaaaaaaaaaabkaabaaaaaaaaaaackiacaaa
aaaaaaaaajaaaaaadkiacaaaaaaaaaaaajaaaaaadiaaaaaikcaabaaaaaaaaaaa
fgafbaaaaaaaaaaafgibcaaaaaaaaaaaajaaaaaaabaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaabaaaaaabjaaaaagccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaaj
ccaabaaaaaaaaaaackaabaaaabaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
dhcaaaajccaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaabkaabaaa
aaaaaaaadhaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
bkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaa
egiocaiaebaaaaaaacaaaaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 256
Vector 112 [_DistanceParams]
VectorInt 128 [_SceneFogMode] 4
Vector 144 [_SceneFogParams]
ConstBuffer "UnityPerCamera" 144
Vector 80 [_ProjectionParams]
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0_level_9_1
eefiecedlbhhmgapkmmifppohckohopkjmnfpbhaabaaaaaaaeaiaaaaaeaaaaaa
daaaaaaafeadaaaaeiahaaaanaahaaaaebgpgodjbmadaaaabmadaaaaaaacpppp
kiacaaaaheaaaaaaagaacmaaaaaaheaaaaaaheaaacaaceaaaaaaheaaaaaaaaaa
abababaaaaaaahaaabaaaaaaaaaaaaaaaaaaaiaaabaaabaaacacacacaaaaajaa
abaaacaaaaaaaaaaabaaafaaabaaadaaaaaaaaaaabaaahaaabaaaeaaaaaaaaaa
acaaaaaaabaaafaaaaaaaaaaaaacppppfbaaaaafagaaapkaaaaaialpaaaaaaaa
aaaaaamaaaaaeamafbaaaaafahaaapkaoppphplpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkaabaaaaacaaaaaniaagaaoekaacaaaaad
aaaaaciaaaaaaaiaabaaffkaafaaaaadaaaaaciaaaaaffiaaaaaffiaabaaaaac
abaaadiaaaaabllaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadacaacpia
aaaaoelaaaaioekaaeaaaaaeabaaaciaaeaaaakaabaaaaiaaeaaffkaacaaaaad
abaaabiaabaaaaiaahaaaakaagaaaaacabaaaciaabaaffiaafaaaaadadaaahia
abaaffiaabaaoelaafaaaaadadaaaiiaabaaffiaadaakkkaaiaaaaadabaaacia
adaaoeiaadaaoeiaahaaaaacabaaaciaabaaffiaagaaaaacabaaaciaabaaffia
fiaaaaaeaaaaaciaaaaaffibabaaffiaadaappiaacaaaaadaaaaaciaaaaaffia
adaaffkbacaaaaadaaaaaciaaaaaffiaaaaaaakaalaaaaadabaaaciaaaaaffia
agaaffkaaeaaaaaeaaaacciaabaaffiaacaakkkaacaappkaacaaaaadaaaaabia
aaaaaaiaabaaaakaafaaaaadaaaaabiaaaaaaaiaaaaaaaiafiaaaaaeaaaacbia
aaaaaaibaaaaffiaagaaffkaafaaaaadaaaaaciaabaaffiaacaaffkaafaaaaad
abaaaciaabaaffiaacaaaakaafaaaaadabaaaciaabaaffiaabaaffibaoaaaaac
abaacciaabaaffiaaoaaaaacaaaacciaaaaaffibacaaaaadaaaaaeiaaaaakkia
abaaaakaafaaaaadaaaaaeiaaaaakkiaaaaakkiafiaaaaaeaaaacbiaaaaakkib
aaaaffiaaaaaaaiaacaaaaadaaaaaciaaaaappiaabaaaakaafaaaaadaaaaacia
aaaaffiaaaaaffiafiaaaaaeaaaadbiaaaaaffibabaaffiaaaaaaaiafiaaaaae
aaaacbiaabaaaaiaagaaaakbaaaaaaiabcaaaaaeabaacpiaaaaaaaiaacaaoeia
afaaoekaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcomadaaaaeaaaaaaa
plaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
aiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaalccaabaaaaaaaaaaaakiacaaaabaaaaaaahaaaaaa
akaabaaaaaaaaaaabkiacaaaabaaaaaaahaaaaaabnaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaoppphpdpaoaaaaakccaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaafgafbaaaaaaaaaaaegbcbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackiacaaaabaaaaaaafaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaacaaaaaalpcaabaaaabaaaaaabgiacaaaaaaaaaaaaiaaaaaaaceaaaaa
abaaaaaaabaaaaaaacaaaaaaadaaaaaadhaaaaajccaabaaaaaaaaaaaakaabaaa
abaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkiacaiaebaaaaaaabaaaaaaafaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaalecaabaaaaaaaaaaa
bkaabaaaaaaaaaaackiacaaaaaaaaaaaajaaaaaadkiacaaaaaaaaaaaajaaaaaa
diaaaaaikcaabaaaaaaaaaaafgafbaaaaaaaaaaafgibcaaaaaaaaaaaajaaaaaa
abaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaabjaaaaag
ccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadhaaaaajccaabaaaaaaaaaaackaabaaaabaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadhcaaaajccaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpbkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajpcaabaaa
abaaaaaaegaobaaaabaaaaaaegiocaiaebaaaaaaacaaaaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegiocaaaacaaaaaa
aaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamamaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfaepfdejfe
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
  Fog { Mode Off }
  GpuProgramID 189873
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform mat4 _FrustumCornersWS;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = gl_MultiTexCoord0.xy;
  vec4 tmpvar_2;
  tmpvar_2.xyw = gl_Vertex.xyw;
  vec4 tmpvar_3;
  tmpvar_2.z = 0.1;
  int i_4;
  i_4 = int(gl_Vertex.z);
  vec4 v_5;
  v_5.x = _FrustumCornersWS[0][i_4];
  v_5.y = _FrustumCornersWS[1][i_4];
  v_5.z = _FrustumCornersWS[2][i_4];
  v_5.w = _FrustumCornersWS[3][i_4];
  tmpvar_3.xyz = v_5.xyz;
  tmpvar_3.w = gl_Vertex.z;
  gl_Position = (gl_ModelViewProjectionMatrix * tmpvar_2);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _HeightParams;
uniform vec4 _DistanceParams;
uniform ivec4 _SceneFogMode;
uniform vec4 _SceneFogParams;
uniform vec4 _CameraWS;
varying vec2 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  float fogFac_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD1);
  vec4 tmpvar_4;
  tmpvar_4 = ((1.0/((
    (_ZBufferParams.x * tmpvar_3.x)
   + _ZBufferParams.y))) * xlv_TEXCOORD2);
  vec3 tmpvar_5;
  tmpvar_5 = (_HeightParams.w * tmpvar_4.xyz);
  float tmpvar_6;
  tmpvar_6 = ((_CameraWS.xyz + tmpvar_4.xyz).y - _HeightParams.x);
  float tmpvar_7;
  tmpvar_7 = min (((1.0 - 
    (2.0 * _HeightParams.z)
  ) * tmpvar_6), 0.0);
  float tmpvar_8;
  tmpvar_8 = max (0.0, (_DistanceParams.x + (
    -(sqrt(dot (tmpvar_5, tmpvar_5)))
   * 
    ((_HeightParams.z * (tmpvar_6 + _HeightParams.y)) - ((tmpvar_7 * tmpvar_7) / abs((tmpvar_4.y + 1e-05))))
  )));
  float fogFac_9;
  fogFac_9 = 0.0;
  if ((_SceneFogMode.x == 1)) {
    fogFac_9 = ((tmpvar_8 * _SceneFogParams.z) + _SceneFogParams.w);
  };
  if ((_SceneFogMode.x == 2)) {
    fogFac_9 = exp2(-((_SceneFogParams.y * tmpvar_8)));
  };
  if ((_SceneFogMode.x == 3)) {
    float tmpvar_10;
    tmpvar_10 = (_SceneFogParams.x * tmpvar_8);
    fogFac_9 = exp2((-(tmpvar_10) * tmpvar_10));
  };
  fogFac_1 = clamp (fogFac_9, 0.0, 1.0);
  if ((tmpvar_3.x >= 0.999999)) {
    fogFac_1 = 1.0;
  };
  gl_FragData[0] = mix (unity_FogColor, tmpvar_2, vec4(fogFac_1));
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 4 [_FrustumCornersWS]
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_MainTex_TexelSize]
"vs_2_0
def c9, 1, 0, 0.100000001, -2
dcl_position v0
dcl_texcoord v1
mad r0, v0.xyxw, c9.xxyx, c9.yyzy
dp4 oPos.x, c0, r0
dp4 oPos.y, c1, r0
dp4 oPos.z, c2, r0
dp4 oPos.w, c3, r0
mov r0.y, c9.y
slt r0.x, c8.y, r0.y
mad r0.y, v1.y, c9.w, c9.x
mad oT0.y, r0.x, r0.y, v1.y
mov oT0.x, v1.x
mov oT1.xy, v1
slt r0.x, v0.z, -v0.z
frc r0.y, v0.z
add r0.z, -r0.y, v0.z
slt r0.y, -r0.y, r0.y
mad r0.x, r0.x, r0.y, r0.z
mova a0.x, r0.x
mov oT2.xyz, c4[a0.x]
mov oT2.w, v0.z

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Matrix 176 [_FrustumCornersWS]
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedbpjmkiaepkjlaajdeanbgemggnehdfdfabaaaaaaiiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefchiacaaaaeaaaabaajoaaaaaadfbiaaaabcaaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadp
fjaaaaaeegiocaaaaaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaan
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaaaceaaaaamnmmmmdnmnmmmmdn
mnmmmmdnmnmmmmdnegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaa
aaaaaaaabkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaa
abaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaaf
nccabaaaabaaaaaaagbebaaaabaaaaaadgaaaaaficcabaaaacaaaaaackbabaaa
aaaaaaaablaaaaafbcaabaaaaaaaaaaackbabaaaaaaaaaaabbaaaaajbccabaaa
acaaaaaaegiocaaaaaaaaaaaalaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaaj
cccabaaaacaaaaaaegiocaaaaaaaaaaaamaaaaaaegjojaaaakaabaaaaaaaaaaa
bbaaaaajeccabaaaacaaaaaaegiocaaaaaaaaaaaanaaaaaaegjojaaaakaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 256
Matrix 176 [_FrustumCornersWS]
Vector 160 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedmmkomcencckgffbnnknplmikaanbblggabaaaaaanmafaaaaaeaaaaaa
daaaaaaaiaacaaaaaaafaaaafeafaaaaebgpgodjeiacaaaaeiacaaaaaaacpopp
aiacaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaakaa
aeaaagaaaaaaaaaaabaaaaaaaeaaakaaaaaaaaaaaaaaafaaaaacpoppfbaaaaaf
aeaaapkamnmmmmdnaaaaaamaaaaaiadpaaaaaaaafbaaaaafaaaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaafbaaaaafabaaapkaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaafbaaaaafacaaapkaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaafbaaaaaf
adaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaaciaagaaffkaamaaaaadaaaaabia
aaaaffiaaaaappkaaeaaaaaeaaaaaciaabaaffjaaeaaffkaaeaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaamaaaaadaaaaabiaaaaakkjaaaaakkjb
bdaaaaacaaaaaciaaaaakkjaacaaaaadaaaaaeiaaaaaffibaaaakkjaamaaaaad
aaaaaciaaaaaffibaaaaffiaaeaaaaaeaaaaabiaaaaaaaiaaaaaffiaaaaakkia
coaaaaacaaaaablaaaaaaaiaabaaaaadaaaaapiaaacaoekaaaaaaalaajaaaaad
abaaaboaahaaoekaaaaaoeiaajaaaaadabaaacoaaiaaoekaaaaaoeiaajaaaaad
abaaaeoaajaaoekaaaaaoeiaafaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaae
aaaaapiaakaaoekaaaaaaajaaaaaoeiaabaaaaacabaaabiaaeaaaakaaeaaaaae
aaaaapiaamaaoekaabaaaaiaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaafaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaanoaabaabejaabaaaaacabaaaioaaaaakkjappppaaaa
fdeieefchiacaaaaeaaaabaajoaaaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaanpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnmnmmmmdn
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaa
aaaaaaaaakaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaafnccabaaaabaaaaaa
agbebaaaabaaaaaadgaaaaaficcabaaaacaaaaaackbabaaaaaaaaaaablaaaaaf
bcaabaaaaaaaaaaackbabaaaaaaaaaaabbaaaaajbccabaaaacaaaaaaegiocaaa
aaaaaaaaalaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaajcccabaaaacaaaaaa
egiocaaaaaaaaaaaamaaaaaaegjojaaaakaabaaaaaaaaaaabbaaaaajeccabaaa
acaaaaaaegiocaaaaaaaaaaaanaaaaaaegjojaaaakaabaaaaaaaaaaadoaaaaab
ejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
faepfdejfeejepeoaafeeffiedepepfceeaaklklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 6 [_CameraWS]
Vector 3 [_DistanceParams]
Vector 2 [_HeightParams]
Vector 4 [_SceneFogMode]
Vector 5 [_SceneFogParams]
Vector 0 [_ZBufferParams]
Vector 1 [unity_FogColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_2_0
def c7, 2, 1, 0, 9.99999975e-006
def c8, -3, -0.999998987, 0, 0
dcl t0.xy
dcl t1.xy
dcl t2.xyz
dcl_2d s0
dcl_2d s1
texld r0, t1, s1
texld_pp r1, t0, s0
mov r2.xy, c7
mad r0.y, c2.z, -r2.x, r2.y
mad r0.z, c0.x, r0.x, c0.y
add r0.x, r0.x, c8.y
rcp r0.z, r0.z
mad r0.w, r0.z, t2.y, c6.y
add r0.w, r0.w, -c2.x
mul r0.y, r0.w, r0.y
add r0.w, r0.w, c2.y
min r2.z, r0.y, c7.z
mul r0.y, r2.z, r2.z
mad r2.z, r0.z, t2.y, c7.w
mul r3.xyz, r0.z, t2
mul r3.xyz, r3, c2.w
dp3 r2.w, r3, r3
rsq r2.w, r2.w
rcp r2.w, r2.w
abs r0.z, r2.z
rcp r0.z, r0.z
mul r0.y, r0.z, r0.y
mad r0.y, c2.z, r0.w, -r0.y
mad r0.y, -r2.w, r0.y, c3.x
max r2.z, r0.y, c7.z
mad_pp r2.w, r2.z, c5.z, c5.w
add r0.y, -r2.y, c4.x
mul r0.y, r0.y, r0.y
cmp_pp r0.y, -r0.y, r2.w, c7.z
mul r0.zw, r2.z, c5.wzyx
mul r0.w, r0.w, -r0.w
exp_pp r0.w, r0.w
exp_pp r0.z, -r0.z
add r2.x, -r2.x, c4.x
mul r2.x, r2.x, r2.x
cmp_pp r0.y, -r2.x, r0.z, r0.y
mov r2.x, c4.x
add r0.z, r2.x, c8.x
mul r0.z, r0.z, r0.z
cmp_sat_pp r0.y, -r0.z, r0.w, r0.y
cmp_pp r0.x, r0.x, c7.y, r0.y
lrp_pp r2, r0.x, r1, c1
mov_pp oC0, r2

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 256
Vector 96 [_HeightParams]
Vector 112 [_DistanceParams]
VectorInt 128 [_SceneFogMode] 4
Vector 144 [_SceneFogParams]
Vector 240 [_CameraWS]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0
eefiecedmilokbokkboijiggdhklhminfffbkollabaaaaaapmafaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcamafaaaaeaaaaaaaedabaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaadcaaaaalbcaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaagaaaaaaabeaaaaaaaaaaaeaabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaalccaabaaaaaaaaaaaakiacaaaabaaaaaaahaaaaaa
akaabaaaabaaaaaabkiacaaaabaaaaaaahaaaaaabnaaaaahecaabaaaaaaaaaaa
akaabaaaabaaaaaaabeaaaaaoppphpdpaoaaaaakccaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaadcaaaaakicaabaaa
aaaaaaaabkaabaaaaaaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaaapaaaaaa
aaaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
agaaaaaadiaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaagaaaaaa
ddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaabkaabaaaaaaaaaaabkbabaaaacaaaaaaabeaaaaakmmfchdhdiaaaaah
ocaabaaaabaaaaaafgafbaaaaaaaaaaaagbjbaaaacaaaaaadiaaaaaiocaabaaa
abaaaaaafgaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaabaaaaaahccaabaaa
aaaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaoaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaia
ibaaaaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaa
dkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaai
kcaabaaaaaaaaaaaagaabaaaaaaaaaaafgibcaaaaaaaaaaaajaaaaaadcaaaaal
bcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaajaaaaaadkiacaaa
aaaaaaaaajaaaaaabjaaaaagccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaacaaaaaalhcaabaaaabaaaaaa
agiacaaaaaaaaaaaaiaaaaaaaceaaaaaabaaaaaaacaaaaaaadaaaaaaaaaaaaaa
abaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaaj
bcaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dhcaaaajbcaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaadhaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
akaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaajpcaabaaaabaaaaaaegaobaaaabaaaaaa
egiocaiaebaaaaaaacaaaaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 256
Vector 96 [_HeightParams]
Vector 112 [_DistanceParams]
VectorInt 128 [_SceneFogMode] 4
Vector 144 [_SceneFogParams]
Vector 240 [_CameraWS]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0_level_9_1
eefiecedmagngcphlmackpgdajgphhdmahgkbidgabaaaaaaiiajaaaaaeaaaaaa
daaaaaaaliadaaaammaiaaaafeajaaaaebgpgodjiaadaaaaiaadaaaaaaacpppp
amadaaaaheaaaaaaagaacmaaaaaaheaaaaaaheaaacaaceaaaaaaheaaaaaaaaaa
abababaaaaaaagaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaaacacacacaaaaajaa
abaaadaaaaaaaaaaaaaaapaaabaaaeaaaaaaaaaaabaaahaaabaaafaaaaaaaaaa
acaaaaaaabaaagaaaaaaaaaaaaacppppfbaaaaafahaaapkaaaaaaaeaaaaaiadp
aaaaaaaakmmfchdhfbaaaaafaiaaapkaaaaaeamaoppphplpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkaabaaaaacaaaaadiaahaaoekaaeaaaaae
aaaaaeiaaaaakkkaaaaaaaibaaaaffiaabaaaaacabaaadiaaaaabllaecaaaaad
abaaapiaabaaoeiaabaioekaecaaaaadacaacpiaaaaaoelaaaaioekaaeaaaaae
aaaaaiiaafaaaakaabaaaaiaafaaffkaacaaaaadabaaabiaabaaaaiaaiaaffka
agaaaaacaaaaaiiaaaaappiaaeaaaaaeabaaaciaaaaappiaabaafflaaeaaffka
acaaaaadabaaaciaabaaffiaaaaaaakbafaaaaadaaaaaeiaaaaakkiaabaaffia
acaaaaadabaaaciaabaaffiaaaaaffkaakaaaaadabaaaeiaaaaakkiaahaakkka
afaaaaadaaaaaeiaabaakkiaabaakkiaaeaaaaaeabaaaeiaaaaappiaabaaffla
ahaappkaafaaaaadadaaahiaaaaappiaabaaoelaafaaaaadadaaahiaadaaoeia
aaaappkaaiaaaaadaaaaaiiaadaaoeiaadaaoeiaahaaaaacaaaaaiiaaaaappia
agaaaaacaaaaaiiaaaaappiacdaaaaacabaaaeiaabaakkiaagaaaaacabaaaeia
abaakkiaafaaaaadaaaaaeiaaaaakkiaabaakkiaaeaaaaaeaaaaaeiaaaaakkka
abaaffiaaaaakkibaeaaaaaeaaaaaeiaaaaappibaaaakkiaabaaaakaalaaaaad
abaaaciaaaaakkiaahaakkkaaeaaaaaeaaaaceiaabaaffiaadaakkkaadaappka
acaaaaadaaaaadiaaaaaoeibacaaaakaafaaaaadaaaaadiaaaaaoeiaaaaaoeia
fiaaaaaeaaaacciaaaaaffibaaaakkiaahaakkkaafaaaaadaaaaamiaabaaffia
adaablkaafaaaaadaaaaaiiaaaaappiaaaaappibaoaaaaacaaaaciiaaaaappia
aoaaaaacaaaaceiaaaaakkibfiaaaaaeaaaacbiaaaaaaaibaaaakkiaaaaaffia
abaaaaacadaaabiaacaaaakaacaaaaadaaaaaciaadaaaaiaaiaaaakaafaaaaad
aaaaaciaaaaaffiaaaaaffiafiaaaaaeaaaadbiaaaaaffibaaaappiaaaaaaaia
fiaaaaaeaaaacbiaabaaaaiaahaaffkaaaaaaaiabcaaaaaeabaacpiaaaaaaaia
acaaoeiaagaaoekaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcamafaaaa
eaaaaaaaedabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
mcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
agaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaalccaabaaa
aaaaaaaaakiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaabkiacaaaabaaaaaa
ahaaaaaabnaaaaahecaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaoppphpdp
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
acaaaaaabkiacaaaaaaaaaaaapaaaaaaaaaaaaajicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaahbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaagaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaaaaaaaaabkbabaaa
acaaaaaaabeaaaaakmmfchdhdiaaaaahocaabaaaabaaaaaafgafbaaaaaaaaaaa
agbjbaaaacaaaaaadiaaaaaiocaabaaaabaaaaaafgaobaaaabaaaaaapgipcaaa
aaaaaaaaagaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaiaibaaaaaaabaaaaaadcaaaaalbcaabaaa
aaaaaaaackiacaaaaaaaaaaaagaaaaaadkaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadcaaaaalbcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaahaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaaikcaabaaaaaaaaaaaagaabaaaaaaaaaaa
fgibcaaaaaaaaaaaajaaaaaadcaaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaajaaaaaadkiacaaaaaaaaaaaajaaaaaabjaaaaagccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaacaaaaaalhcaabaaaabaaaaaaagiacaaaaaaaaaaaaiaaaaaaaceaaaaa
abaaaaaaacaaaaaaadaaaaaaaaaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaabaaaaaadhaaaaajbcaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadhcaaaajbcaabaaaaaaaaaaackaabaaa
abaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaadhaaaaajbcaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpakaabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaj
pcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaiaebaaaaaaacaaaaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegiocaaa
acaaaaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}