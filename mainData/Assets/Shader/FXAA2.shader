Shader "Hidden/FXAA II" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 55512
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform vec4 _MainTex_TexelSize;
varying vec4 xlv_TEXCOORD0;
void main ()
{
  vec4 posPos_1;
  posPos_1.xy = (((
    (gl_MultiTexCoord0.xy * 2.0)
   - 1.0) * 0.5) + 0.5);
  posPos_1.zw = (posPos_1.xy - (_MainTex_TexelSize.xy * 0.75));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = posPos_1;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec4 _MainTex_TexelSize;
uniform sampler2D _MainTex;
varying vec4 xlv_TEXCOORD0;
void main ()
{
  vec3 tmpvar_1;
  vec2 dir_2;
  vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (xlv_TEXCOORD0.zw + (vec2(1.0, 0.0) * _MainTex_TexelSize.xy));
  vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = (xlv_TEXCOORD0.zw + (vec2(0.0, 1.0) * _MainTex_TexelSize.xy));
  vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = (xlv_TEXCOORD0.zw + _MainTex_TexelSize.xy);
  float tmpvar_6;
  tmpvar_6 = dot (texture2DLod (_MainTex, xlv_TEXCOORD0.zw, 0.0).xyz, vec3(0.299, 0.587, 0.114));
  float tmpvar_7;
  tmpvar_7 = dot (texture2DLod (_MainTex, tmpvar_3.xy, 0.0).xyz, vec3(0.299, 0.587, 0.114));
  float tmpvar_8;
  tmpvar_8 = dot (texture2DLod (_MainTex, tmpvar_4.xy, 0.0).xyz, vec3(0.299, 0.587, 0.114));
  float tmpvar_9;
  tmpvar_9 = dot (texture2DLod (_MainTex, tmpvar_5.xy, 0.0).xyz, vec3(0.299, 0.587, 0.114));
  float tmpvar_10;
  tmpvar_10 = dot (texture2DLod (_MainTex, xlv_TEXCOORD0.xy, 0.0).xyz, vec3(0.299, 0.587, 0.114));
  float tmpvar_11;
  tmpvar_11 = min (tmpvar_10, min (min (tmpvar_6, tmpvar_7), min (tmpvar_8, tmpvar_9)));
  float tmpvar_12;
  tmpvar_12 = max (tmpvar_10, max (max (tmpvar_6, tmpvar_7), max (tmpvar_8, tmpvar_9)));
  dir_2.x = ((tmpvar_8 + tmpvar_9) - (tmpvar_6 + tmpvar_7));
  dir_2.y = ((tmpvar_6 + tmpvar_8) - (tmpvar_7 + tmpvar_9));
  vec2 tmpvar_13;
  tmpvar_13 = (min (vec2(8.0, 8.0), max (vec2(-8.0, -8.0), 
    (dir_2 * (1.0/((min (
      abs(dir_2.x)
    , 
      abs(dir_2.y)
    ) + max (
      ((((tmpvar_6 + tmpvar_7) + tmpvar_8) + tmpvar_9) * 0.03125)
    , 0.0078125)))))
  )) * _MainTex_TexelSize.xy);
  dir_2 = tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = (xlv_TEXCOORD0.xy + (tmpvar_13 * -0.1666667));
  vec4 tmpvar_15;
  tmpvar_15.zw = vec2(0.0, 0.0);
  tmpvar_15.xy = (xlv_TEXCOORD0.xy + (tmpvar_13 * 0.1666667));
  vec3 tmpvar_16;
  tmpvar_16 = (0.5 * (texture2DLod (_MainTex, tmpvar_14.xy, 0.0).xyz + texture2DLod (_MainTex, tmpvar_15.xy, 0.0).xyz));
  vec4 tmpvar_17;
  tmpvar_17.zw = vec2(0.0, 0.0);
  tmpvar_17.xy = (xlv_TEXCOORD0.xy + (tmpvar_13 * -0.5));
  vec4 tmpvar_18;
  tmpvar_18.zw = vec2(0.0, 0.0);
  tmpvar_18.xy = (xlv_TEXCOORD0.xy + (tmpvar_13 * 0.5));
  vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_16 * 0.5) + (0.25 * (texture2DLod (_MainTex, tmpvar_17.xy, 0.0).xyz + texture2DLod (_MainTex, tmpvar_18.xy, 0.0).xyz)));
  float tmpvar_20;
  tmpvar_20 = dot (tmpvar_19, vec3(0.299, 0.587, 0.114));
  if (((tmpvar_20 < tmpvar_11) || (tmpvar_20 > tmpvar_12))) {
    tmpvar_1 = tmpvar_16;
  } else {
    tmpvar_1 = tmpvar_19;
  };
  vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = tmpvar_1;
  gl_FragData[0] = tmpvar_21;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_3_0
def c5, 2, -1, 0.5, 0.75
dcl_position v0
dcl_texcoord v1
dcl_position o0
dcl_texcoord o1
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad r0.xy, v1, c5.x, c5.y
mad r0.xy, r0, c5.z, c5.z
mov r0.w, c5.w
mad o1.zw, c4.xyxy, -r0.w, r0.xyxy
mov o1.xy, v1

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 112
Vector 96 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddeehmahafidiplchmhaccbnbejjmjjhbabaaaaaakeacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcmeabaaaa
eaaaabaahbaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaap
dcaabaaaaaaaaaaaegbabaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadcaaaaapdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaomccabaaaabaaaaaa
agiecaiaebaaaaaaaaaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaeadp
aaaaeadpagaebaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
doaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 0 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
def c1, 0.298999995, 0.587000012, 0.114, -8
def c2, 1, 0, 0.03125, 0.0078125
def c3, -0.166666672, 0.166666672, 0.5, -0.5
def c4, 0.25, 0, 0, 0
dcl_texcoord v0
dcl_2d s0
mul r0, c2.xxyy, v0.zwzz
texldl r0, r0, s0
dp3 r0.x, r0, c1
mov r1.xy, c2
mad r1, c0.xyxy, r1.xyyx, v0.zwzw
mul r2, r1.xyxx, c2.xxyy
mul r1, r1.zwxx, c2.xxyy
texldl r1, r1, s0
dp3 r0.y, r1, c1
texldl r1, r2, s0
dp3 r0.z, r1, c1
add r0.w, r0.z, r0.x
add r1.xy, c0, v0.zwzw
mov r1.zw, c2.y
texldl r1, r1, s0
dp3 r1.x, r1, c1
add r1.y, r0.y, r1.x
add r1.y, r0.w, -r1.y
add r0.w, r0.y, r0.w
add r0.w, r1.x, r0.w
mul r0.w, r0.w, c2.z
max r1.z, r0.w, c2.w
mov r2.xz, -r1.y
cmp r0.w, r2.z, r2.z, r1.y
add r1.y, r0.z, r1.x
add r1.w, r0.y, r0.x
add r2.yw, -r1.y, r1.w
min r1.y, r2_abs.w, r0.w
add r0.w, r1.z, r1.y
rcp r0.w, r0.w
mul r3, r0.w, r2
mad r2, r2.zwzw, -r0.w, c1.w
cmp r2, r2, c1.w, r3
add r3, -r2.zwzw, -c1.w
cmp r2, r3, r2, -c1.w
mul r2, r2, c0.xyxy
mad r3, r2, c3.wwzz, v0.xyxy
mad r2, r2.zwzw, c3.xxyy, v0.xyxy
mul r4, r3.xyxx, c2.xxyy
mul r3, r3.zwxx, c2.xxyy
texldl r3, r3, s0
texldl r4, r4, s0
add r1.yzw, r3.xxyz, r4.xxyz
mul r1.yzw, r1, c4.x
mul r3, r2.xyxx, c2.xxyy
mul r2, r2.zwxx, c2.xxyy
texldl r2, r2, s0
texldl r3, r3, s0
add r2.xyz, r2, r3
mad r1.yzw, r2.xxyz, c4.x, r1
mul r2.xyz, r2, c3.z
dp3 r0.w, r1.yzww, c1
min r2.w, r1.x, r0.y
max r3.x, r0.y, r1.x
min r1.x, r0.z, r0.x
max r3.y, r0.x, r0.z
max r0.x, r3.y, r3.x
min r0.y, r2.w, r1.x
mul r3, c2.xxyy, v0.xyzz
texldl r3, r3, s0
dp3 r0.z, r3, c1
min r1.x, r0.y, r0.z
max r2.w, r0.z, r0.x
add r0.x, -r0.w, r2.w
add r0.y, r0.w, -r1.x
cmp r0.xy, r0, c2.y, c2.x
add r0.x, r0.x, r0.y
cmp oC0.xyz, -r0.x, r1.yzww, r2
mov oC0.w, c2.y

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 96 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedoomnldopbelmlocmcdppgidipbjccgnnabaaaaaahmaiaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclmahaaaa
eaaaaaaaopabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadcaaaaanpcaabaaaaaaaaaaa
egiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaiadp
ogbobaaaabaaaaaaeiaaaaalpcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaaaaaaaaa
ogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaakbcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaabaaaaaakccaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaaimcaabaaaaaaaaaaakgbobaaa
abaaaaaaagiecaaaaaaaaaaaagaaaaaaeiaaaaalpcaabaaaabaaaaaaogakbaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaak
ecaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdn
aaaaaaaaaaaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
eiaaaaalpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaabaaaaaakbcaabaaaabaaaaaaegacbaaaabaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaaaaaaaahccaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaaikcaabaaaacaaaaaapgapbaia
ebaaaaaaaaaaaaaafgafbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaabaaaaaaaaaaaaahccaabaaaabaaaaaackaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaaiccaabaaaabaaaaaadkaabaaaaaaaaaaabkaabaia
ebaaaaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadndeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadmddaaaaajecaabaaa
abaaaaaadkaabaiaibaaaaaaacaaaaaabkaabaiaibaaaaaaabaaaaaadgaaaaag
fcaabaaaacaaaaaafgafbaiaebaaaaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackaabaaaabaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaapgapbaaaaaaaaaaaegaobaaaacaaaaaadeaaaaakpcaabaaaacaaaaaa
egaobaaaacaaaaaaaceaaaaaaaaaaambaaaaaambaaaaaambaaaaaambddaaaaak
pcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaaebaaaaaaebaaaaaaeb
aaaaaaebdiaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegiecaaaaaaaaaaa
agaaaaaadcaaaaampcaabaaaadaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaadpaaaaaadpegbebaaaabaaaaaadcaaaaampcaabaaaacaaaaaa
ogaobaaaacaaaaaaaceaaaaaklkkckloklkkckloklkkckdoklkkckdoegbebaaa
abaaaaaaeiaaaaalpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaadaaaaaaogakbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
ocaabaaaabaaaaaaagajbaaaadaaaaaaagajbaaaaeaaaaaadiaaaaakocaabaaa
abaaaaaafgaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadoaaaaiadoaaaaiado
eiaaaaalpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaacaaaaaaogakbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadcaaaaamocaabaaaabaaaaaa
agajbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaiadoaaaaiadoaaaaiadofgaobaaa
abaaaaaadiaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaabaaaaaakicaabaaaaaaaaaaajgahbaaaabaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaaddaaaaahicaabaaaacaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaaddaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
abaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaadkaabaaaacaaaaaackaabaaaaaaaaaaaeiaaaaal
pcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaabaaaaaakecaabaaaaaaaaaaaegacbaaaadaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaddaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaahdcaabaaaaaaaaaaamgaabaaaaaaaaaaahgapbaaa
aaaaaaaadmaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
dhaaaaajhccabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaajgahbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
}
 }
}
Fallback Off
}