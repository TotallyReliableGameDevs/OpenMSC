Shader "Hidden/DLAA" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 60294
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
  vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_2;
  tmpvar_2.xyz = tmpvar_1.xyz;
  tmpvar_2.w = dot ((4.0 * abs(
    ((((texture2D (_MainTex, 
      (xlv_TEXCOORD0 - _MainTex_TexelSize.xy)
    ) + texture2D (_MainTex, 
      (xlv_TEXCOORD0 + (vec2(1.0, -1.0) * _MainTex_TexelSize.xy))
    )) + texture2D (_MainTex, (xlv_TEXCOORD0 + 
      (vec2(-1.0, 1.0) * _MainTex_TexelSize.xy)
    ))) + texture2D (_MainTex, (xlv_TEXCOORD0 + _MainTex_TexelSize.xy))) - (4.0 * tmpvar_1))
  )).xyz, vec3(0.33, 0.33, 0.33));
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
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 0 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
def c1, 0.330000013, 0, 0, 0
def c2, 1, -1, 1, 4
dcl t0.xy
dcl_2d s0
add r0.xy, t0, -c0
mov r1.xyz, c2
mad r2.xy, c0, r1, t0
mad r1.xy, c0, r1.yzxw, t0
add r3.xy, t0, c0
texld r0, r0, s0
texld r2, r2, s0
texld r1, r1, s0
texld r3, r3, s0
texld_pp r4, t0, s0
add r0.xyz, r0, r2
add r0.xyz, r1, r0
add r0.xyz, r3, r0
mad r0.xyz, r4, -c2.w, r0
abs r0.xyz, r0
mul r0.xyz, r0, c2.w
dp3_pp r4.w, r0, c1.x
mov_pp oC0, r4

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 96 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjlilcehclpnnahgblejpglghpmenpjdjabaaaaaadeadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheacaaaa
eaaaaaaajnaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaajdcaabaaaaaaaaaaa
egbabaaaabaaaaaaegiacaiaebaaaaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaan
pcaabaaaabaaaaaaegiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaaiadpaaaaialp
aaaaialpaaaaiadpegbebaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaidcaabaaaabaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaanhcaabaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaa
egacbaaaaaaaaaaadgaaaaafhccabaaaaaaaaaaaegacbaaaabaaaaaadiaaaaal
hcaabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaaaceaaaaaaaaaiaeaaaaaiaea
aaaaiaeaaaaaaaaabaaaaaakiccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
mdpfkidomdpfkidomdpfkidoaaaaaaaadoaaaaab"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 72943
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
  vec4 clr_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_3;
  vec2 cse_4;
  cse_4 = (vec2(1.5, 0.0) * _MainTex_TexelSize.xy);
  vec2 cse_5;
  cse_5 = (vec2(-1.5, 0.0) * _MainTex_TexelSize.xy);
  tmpvar_3 = (2.0 * (texture2D (_MainTex, (xlv_TEXCOORD0 + cse_5)) + texture2D (_MainTex, (xlv_TEXCOORD0 + cse_4))));
  vec4 tmpvar_6;
  vec2 cse_7;
  cse_7 = (vec2(0.0, 1.5) * _MainTex_TexelSize.xy);
  vec2 cse_8;
  cse_8 = (vec2(0.0, -1.5) * _MainTex_TexelSize.xy);
  tmpvar_6 = (2.0 * (texture2D (_MainTex, (xlv_TEXCOORD0 + cse_8)) + texture2D (_MainTex, (xlv_TEXCOORD0 + cse_7))));
  vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_3 + (2.0 * tmpvar_2)) / 6.0);
  vec4 tmpvar_10;
  tmpvar_10 = ((tmpvar_6 + (2.0 * tmpvar_2)) / 6.0);
  vec4 tmpvar_11;
  tmpvar_11 = mix (mix (tmpvar_2, tmpvar_9, vec4(clamp (
    (((3.0 * dot (
      (abs((tmpvar_6 - (4.0 * tmpvar_2))) / 4.0)
    .xyz, vec3(0.33, 0.33, 0.33))) - 0.1) / dot (tmpvar_9.xyz, vec3(0.33, 0.33, 0.33)))
  , 0.0, 1.0))), tmpvar_10, vec4(clamp ((
    ((3.0 * dot ((
      abs((tmpvar_3 - (4.0 * tmpvar_2)))
     / 4.0).xyz, vec3(0.33, 0.33, 0.33))) - 0.1)
   / 
    dot (tmpvar_10.xyz, vec3(0.33, 0.33, 0.33))
  ), 0.0, 1.0)));
  clr_1 = tmpvar_11;
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, (xlv_TEXCOORD0 + cse_4));
  vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(3.5, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(5.5, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(7.5, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, (xlv_TEXCOORD0 + cse_5));
  vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(-3.5, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(-5.5, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(-7.5, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, (xlv_TEXCOORD0 + cse_7));
  vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, 3.5) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, 5.5) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, 7.5) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MainTex, (xlv_TEXCOORD0 + cse_8));
  vec4 tmpvar_25;
  tmpvar_25 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, -3.5) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, -5.5) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, -7.5) * _MainTex_TexelSize.xy)));
  float tmpvar_28;
  tmpvar_28 = clamp (((
    ((((
      ((((tmpvar_12.w + tmpvar_13.w) + tmpvar_14.w) + tmpvar_15.w) + tmpvar_16.w)
     + tmpvar_17.w) + tmpvar_18.w) + tmpvar_19.w) / 8.0)
   * 2.0) - 1.0), 0.0, 1.0);
  float tmpvar_29;
  tmpvar_29 = clamp (((
    ((((
      ((((tmpvar_20.w + tmpvar_21.w) + tmpvar_22.w) + tmpvar_23.w) + tmpvar_24.w)
     + tmpvar_25.w) + tmpvar_26.w) + tmpvar_27.w) / 8.0)
   * 2.0) - 1.0), 0.0, 1.0);
  vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(-1.0, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_31;
  tmpvar_31 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(1.0, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_32;
  tmpvar_32 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, -1.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_33;
  tmpvar_33 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, 1.0) * _MainTex_TexelSize.xy)));
  if (((tmpvar_28 > 0.0) || (tmpvar_29 > 0.0))) {
    float tmpvar_34;
    tmpvar_34 = dot (((
      ((((
        ((tmpvar_12 + tmpvar_13) + tmpvar_14)
       + tmpvar_15) + tmpvar_16) + tmpvar_17) + tmpvar_18)
     + tmpvar_19) / 8.0).xyz, vec3(0.33, 0.33, 0.33));
    float tmpvar_35;
    tmpvar_35 = dot (((
      ((((
        ((tmpvar_20 + tmpvar_21) + tmpvar_22)
       + tmpvar_23) + tmpvar_24) + tmpvar_25) + tmpvar_26)
     + tmpvar_27) / 8.0).xyz, vec3(0.33, 0.33, 0.33));
    float tmpvar_36;
    tmpvar_36 = dot (tmpvar_2.xyz, vec3(0.33, 0.33, 0.33));
    float tmpvar_37;
    tmpvar_37 = dot (tmpvar_30.xyz, vec3(0.33, 0.33, 0.33));
    float tmpvar_38;
    tmpvar_38 = dot (tmpvar_31.xyz, vec3(0.33, 0.33, 0.33));
    float tmpvar_39;
    tmpvar_39 = dot (tmpvar_32.xyz, vec3(0.33, 0.33, 0.33));
    float tmpvar_40;
    tmpvar_40 = dot (tmpvar_33.xyz, vec3(0.33, 0.33, 0.33));
    float tmpvar_41;
    if ((tmpvar_36 == tmpvar_39)) {
      tmpvar_41 = 0.0;
    } else {
      tmpvar_41 = clamp (((tmpvar_34 - tmpvar_39) / (tmpvar_36 - tmpvar_39)), 0.0, 1.0);
    };
    float tmpvar_42;
    if ((tmpvar_36 == tmpvar_40)) {
      tmpvar_42 = 0.0;
    } else {
      tmpvar_42 = clamp ((1.0 + (
        (tmpvar_34 - tmpvar_36)
       / 
        (tmpvar_36 - tmpvar_40)
      )), 0.0, 1.0);
    };
    float tmpvar_43;
    if ((tmpvar_36 == tmpvar_37)) {
      tmpvar_43 = 0.0;
    } else {
      tmpvar_43 = clamp (((tmpvar_35 - tmpvar_37) / (tmpvar_36 - tmpvar_37)), 0.0, 1.0);
    };
    float tmpvar_44;
    if ((tmpvar_36 == tmpvar_38)) {
      tmpvar_44 = 0.0;
    } else {
      tmpvar_44 = clamp ((1.0 + (
        (tmpvar_35 - tmpvar_36)
       / 
        (tmpvar_36 - tmpvar_38)
      )), 0.0, 1.0);
    };
    clr_1 = mix (mix (tmpvar_11, mix (tmpvar_31, 
      mix (tmpvar_30, tmpvar_2, vec4(tmpvar_43))
    , vec4(tmpvar_44)), vec4(tmpvar_29)), mix (tmpvar_33, mix (tmpvar_32, tmpvar_2, vec4(tmpvar_41)), vec4(tmpvar_42)), vec4(tmpvar_28));
  };
  gl_FragData[0] = clr_1;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_texcoord v1
dcl_position o0
dcl_texcoord o1.xy
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mov o1.xy, v1

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
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 0 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
def c1, 0.25, 2, 0.166666672, 0.330000013
def c2, 3, -0.100000001, 0.125, 1
def c3, 0.25, -1, 0, 1
def c4, -5.5, 0, -7.5, 0
def c5, 7.5, 0, -3.5, 0
def c6, 3.5, 0, 5.5, 1
def c7, -1.5, 0, 1.5, 4
dcl_texcoord v0.xy
dcl_2d s0
mov r0.xy, c0
mad r1, r0.xyxy, c6.yxyz, v0.xyxy
texld r2, r1.zwzw, s0
texld r1, r1, s0
mad r3, r0.xyxy, c7.yxyz, v0.xyxy
texld r4, r3.zwzw, s0
texld r3, r3, s0
add r1, r1.wxyz, r4.wxyz
add r4, r4, r3
add r1, r2.wxyz, r1
mad r2, r0.xyxy, c5.yxyz, v0.xyxy
texld r5, r2, s0
texld r2, r2.zwzw, s0
add r1, r1, r5.wxyz
add r1, r3.wxyz, r1
add r1, r2.wxyz, r1
mad r2, r0.xyxy, c4.yxyz, v0.xyxy
texld r3, r2, s0
texld r2, r2.zwzw, s0
add r1, r1, r3.wxyz
add r1, r2.wxyz, r1
mad_sat r0.z, r1.x, c3.x, c3.y
mul r1.xyz, r1.yzww, c2.z
dp3 r0.w, r1, c1.w
add r1.xyz, r4, r4
texld r2, v0, s0
mad r1.xyz, r2, -c7.w, r1
mul r1.xyz, r1_abs, c1.x
dp3 r1.x, r1, c1.w
mad r1.x, r1.x, c2.x, c2.y
mad r3, r0.xyxy, c7.xyzy, v0.xyxy
texld r5, r3, s0
texld r3, r3.zwzw, s0
add r6, r3, r5
add r7, r2, r2
mad r8, r6, c1.y, r7
add r1.yzw, r6.xxyz, r6.xxyz
mad r1.yzw, r2.xxyz, -c7.w, r1
mul r1.yzw, r1_abs, c1.x
dp3 r1.y, r1.yzww, c1.w
mad r1.y, r1.y, c2.x, c2.y
mad r4, r4, c1.y, r7
mul r6.xyz, r8, c1.z
mad r7, r8, c1.z, -r2
dp3 r1.z, r6, c1.w
rcp r1.z, r1.z
mul_sat r1.x, r1.z, r1.x
mad r6, r1.x, r7, r2
mad r7, r4, c1.z, -r6
mul r1.xzw, r4.xyyz, c1.z
dp3 r1.x, r1.xzww, c1.w
rcp r1.x, r1.x
mul_sat r1.x, r1.x, r1.y
mad r1, r1.x, r7, r6
mad r4, r0.xyxy, c3.yzwz, v0.xyxy
texld r6, r4, s0
texld r4, r4.zwzw, s0
dp3 r7.x, r6, c1.w
add r7.y, r0.w, -r7.x
dp3 r7.z, r2, c1.w
add r7.x, -r7.x, r7.z
rcp r7.w, r7.x
mul_sat r7.y, r7.w, r7.y
cmp r7.x, -r7_abs.x, c7.y, r7.y
lrp r8, r7.x, r2, r6
add r0.w, r0.w, -r7.z
dp3 r6.x, r4, c1.w
add r6.x, -r6.x, r7.z
rcp r6.y, r6.x
mad_sat r0.w, r0.w, r6.y, c2.w
cmp r0.w, -r6_abs.x, c7.y, r0.w
lrp r6, r0.w, r8, r4
lrp r4, r0.z, r6, r1
mad r6, r0.xyxy, c6.xyzy, v0.xyxy
texld r8, r6, s0
texld r6, r6.zwzw, s0
add r3, r3.wxyz, r8.wxyz
add r3, r6.wxyz, r3
mad r6, r0.xyxy, c5.xyzy, v0.xyxy
texld r8, r6, s0
texld r6, r6.zwzw, s0
add r3, r3, r8.wxyz
add r3, r5.wxyz, r3
add r3, r6.wxyz, r3
mad r5, r0.xyxy, c4.xyzy, v0.xyxy
texld r6, r5, s0
texld r5, r5.zwzw, s0
add r3, r3, r6.wxyz
add r3, r5.wxyz, r3
mad_sat r0.w, r3.x, c3.x, c3.y
mul r3.xyz, r3.yzww, c2.z
dp3 r3.x, r3, c1.w
mad r5, r0.xyxy, c3.zyzw, v0.xyxy
texld r6, r5, s0
texld r5, r5.zwzw, s0
dp3 r0.x, r6, c1.w
add r0.y, -r0.x, r3.x
add r3.x, -r7.z, r3.x
add r0.x, -r0.x, r7.z
rcp r3.y, r0.x
mul_sat r0.y, r0.y, r3.y
cmp r0.x, -r0_abs.x, c7.y, r0.y
lrp r8, r0.x, r2, r6
dp3 r0.x, r5, c1.w
add r0.x, -r0.x, r7.z
rcp r0.y, r0.x
mad_sat r0.y, r3.x, r0.y, c2.w
cmp r0.x, -r0_abs.x, c7.y, r0.y
lrp r2, r0.x, r8, r5
lrp_pp r3, r0.w, r2, r4
cmp r0.xz, -r0.wyzw, c6.y, c6.w
add r0.x, r0.z, r0.x
cmp_pp oC0, -r0.x, r1, r3

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 96 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmmlkkfehkioelkbdchikpfjmjpebbkbdabaaaaaanabbaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbabbaaaa
eaaaaaaaeeaeaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacakaaaaaadcaaaaanpcaabaaaaaaaaaaa
egiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaamalpaaaaaaaaaaaamadp
egbebaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaanhcaabaaaadaaaaaaegacbaiaebaaaaaa
aeaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaiaeaaaaaaaaaegacbaaaadaaaaaa
diaaaaalhcaabaaaadaaaaaaegacbaiaibaaaaaaadaaaaaaaceaaaaaaaaaiado
aaaaiadoaaaaiadoaaaaaaaabaaaaaakbcaabaaaadaaaaaaegacbaaaadaaaaaa
aceaaaaamdpfkidomdpfkidomdpfkidoaaaaaaaadcaaaaajbcaabaaaadaaaaaa
akaabaaaadaaaaaaabeaaaaaaaaaeaeaabeaaaaamnmmmmlndcaaaaanpcaabaaa
afaaaaaaegiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaamalpaaaaaaaaaaaamadp
aaaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaa
afaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaahaaaaaa
egaobaaaafaaaaaaegaobaaaagaaaaaaaaaaaaahpcaabaaaaiaaaaaaegaobaaa
aeaaaaaaegaobaaaaeaaaaaadcaaaaampcaabaaaajaaaaaaegaobaaaahaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegaobaaaaiaaaaaaaaaaaaah
ocaabaaaadaaaaaaagajbaaaahaaaaaaagajbaaaahaaaaaadcaaaaanocaabaaa
adaaaaaaagajbaiaebaaaaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaiaeaaaaaiaea
aaaaiaeafgaobaaaadaaaaaadiaaaaalocaabaaaadaaaaaafgaobaiaibaaaaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaiadoaaaaiadoaaaaiadobaaaaaakccaabaaa
adaaaaaajgahbaaaadaaaaaaaceaaaaamdpfkidomdpfkidomdpfkidoaaaaaaaa
dcaaaaajccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaeaeaabeaaaaa
mnmmmmlndcaaaaampcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaeaegaobaaaaiaaaaaadiaaaaakhcaabaaaahaaaaaa
egacbaaaajaaaaaaaceaaaaaklkkckdoklkkckdoklkkckdoaaaaaaaadcaaaaan
pcaabaaaaiaaaaaaegaobaaaajaaaaaaaceaaaaaklkkckdoklkkckdoklkkckdo
klkkckdoegaobaiaebaaaaaaaeaaaaaabaaaaaakecaabaaaadaaaaaaegacbaaa
ahaaaaaaaceaaaaamdpfkidomdpfkidomdpfkidoaaaaaaaaaocaaaahbcaabaaa
adaaaaaaakaabaaaadaaaaaackaabaaaadaaaaaadcaaaaajpcaabaaaahaaaaaa
agaabaaaadaaaaaaegaobaaaaiaaaaaaegaobaaaaeaaaaaadcaaaaanpcaabaaa
aiaaaaaaegaobaaaacaaaaaaaceaaaaaklkkckdoklkkckdoklkkckdoklkkckdo
egaobaiaebaaaaaaahaaaaaadiaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaa
aceaaaaaklkkckdoklkkckdoklkkckdoaaaaaaaabaaaaaakbcaabaaaacaaaaaa
egacbaaaacaaaaaaaceaaaaamdpfkidomdpfkidomdpfkidoaaaaaaaaaocaaaah
bcaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaacaaaaaadcaaaaajpcaabaaa
acaaaaaaagaabaaaacaaaaaaegaobaaaaiaaaaaaegaobaaaahaaaaaadcaaaaan
pcaabaaaadaaaaaaegiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaagaea
aaaaaaaaaaaalaeaegbebaaaabaaaaaaefaaaaajpcaabaaaahaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
aaaaaaaadgajbaaaaaaaaaaadgajbaaaahaaaaaaaaaaaaahpcaabaaaaaaaaaaa
dgajbaaaadaaaaaaegaobaaaaaaaaaaadcaaaaanpcaabaaaadaaaaaaegiecaaa
aaaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaapaeaaaaaaaaaaaaagamaegbebaaa
abaaaaaaefaaaaajpcaabaaaahaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
dgajbaaaahaaaaaaaaaaaaahpcaabaaaaaaaaaaadgajbaaaabaaaaaaegaobaaa
aaaaaaaaaaaaaaahpcaabaaaaaaaaaaadgajbaaaadaaaaaaegaobaaaaaaaaaaa
dcaaaaanpcaabaaaabaaaaaaegiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaaaaaa
aaaalamaaaaaaaaaaaaapamaegbebaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaadgajbaaaadaaaaaaaaaaaaahpcaabaaa
aaaaaaaadgajbaaaabaaaaaaegaobaaaaaaaaaaadiaaaaakocaabaaaaaaaaaaa
fgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaadoaaaaaadoaaaaaadodccaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadoabeaaaaaaaaaialp
baaaaaakccaabaaaaaaaaaaajgahbaaaaaaaaaaaaceaaaaamdpfkidomdpfkido
mdpfkidoaaaaaaaadcaaaaanpcaabaaaabaaaaaaegiecaaaaaaaaaaaagaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaiadpaaaaaaaaegbebaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaabaaaaaakecaabaaaaaaaaaaaegacbaaaadaaaaaaaceaaaaamdpfkido
mdpfkidomdpfkidoaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaaaaaaaaabaaaaaakbcaabaaaahaaaaaaegacbaaaaeaaaaaa
aceaaaaamdpfkidomdpfkidomdpfkidoaaaaaaaaaaaaaaaiccaabaaaahaaaaaa
ckaabaiaebaaaaaaaaaaaaaaakaabaaaahaaaaaabiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaahaaaaaaaocaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaahaaaaaadhaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaipcaabaaaaiaaaaaaegaobaia
ebaaaaaaadaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaakgakbaaa
aaaaaaaaegaobaaaaiaaaaaaegaobaaaadaaaaaaaaaaaaaipcaabaaaadaaaaaa
egaobaiaebaaaaaaabaaaaaaegaobaaaadaaaaaaaaaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaahaaaaaabaaaaaakecaabaaaaaaaaaaa
egacbaaaabaaaaaaaceaaaaamdpfkidomdpfkidomdpfkidoaaaaaaaaaaaaaaai
icaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaahaaaaaabiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaahaaaaaaaoaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaaaacaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaiadpdhaaaaajccaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajpcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaiaebaaaaaaacaaaaaaegaobaaaabaaaaaadcaaaaajpcaabaaa
abaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadbaaaaah
bcaabaaaaaaaaaaaabeaaaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaanpcaabaaa
adaaaaaaegiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaagaeaaaaaaaaaaaaalaea
aaaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaaaiaaaaaaegaabaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaafaaaaaa
dgajbaaaafaaaaaadgajbaaaaiaaaaaaaaaaaaahpcaabaaaadaaaaaadgajbaaa
adaaaaaaegaobaaaafaaaaaadcaaaaanpcaabaaaafaaaaaaegiecaaaaaaaaaaa
agaaaaaaaceaaaaaaaaapaeaaaaaaaaaaaaagamaaaaaaaaaegbebaaaabaaaaaa
efaaaaajpcaabaaaaiaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaadgajbaaa
aiaaaaaaaaaaaaahpcaabaaaadaaaaaadgajbaaaagaaaaaaegaobaaaadaaaaaa
aaaaaaahpcaabaaaadaaaaaadgajbaaaafaaaaaaegaobaaaadaaaaaadcaaaaan
pcaabaaaafaaaaaaegiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaalamaaaaaaaaa
aaaapamaaaaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
afaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
adaaaaaaegaobaaaadaaaaaadgajbaaaagaaaaaaaaaaaaahpcaabaaaadaaaaaa
dgajbaaaafaaaaaaegaobaaaadaaaaaadiaaaaakocaabaaaaaaaaaaafgaobaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaadoaaaaaadoaaaaaadodccaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiadoabeaaaaaaaaaialpbaaaaaak
ccaabaaaaaaaaaaajgahbaaaaaaaaaaaaceaaaaamdpfkidomdpfkidomdpfkido
aaaaaaaadcaaaaanpcaabaaaafaaaaaaegiecaaaaaaaaaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaaaaaaaaaiadpegbebaaaabaaaaaaefaaaaajpcaabaaa
agaaaaaaegaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
baaaaaakecaabaaaaaaaaaaaegacbaaaagaaaaaaaceaaaaamdpfkidomdpfkido
mdpfkidoaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaiaebaaaaaaahaaaaaa
bkaabaaaaaaaaaaaaaaaaaaiccaabaaaadaaaaaackaabaiaebaaaaaaaaaaaaaa
akaabaaaahaaaaaabiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
ahaaaaaaaocaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaadaaaaaa
dhaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaaipcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaiaebaaaaaa
agaaaaaadcaaaaajpcaabaaaaeaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaa
egaobaaaagaaaaaaaaaaaaaipcaabaaaaeaaaaaaegaobaiaebaaaaaaafaaaaaa
egaobaaaaeaaaaaabaaaaaakecaabaaaaaaaaaaaegacbaaaafaaaaaaaceaaaaa
mdpfkidomdpfkidomdpfkidoaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaakaabaaaahaaaaaabiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaahaaaaaaaoaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaacaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdhaaaaajccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaajpcaabaaaaeaaaaaafgafbaaaaaaaaaaaegaobaaa
aeaaaaaaegaobaaaafaaaaaaaaaaaaaipcaabaaaaeaaaaaaegaobaiaebaaaaaa
abaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaaadaaaaaa
egaobaaaaeaaaaaaegaobaaaabaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaa
aaaaaaaaakaabaaaadaaaaaadmaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadhaaaaajpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaaegaobaaaacaaaaaadoaaaaab"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 180491
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
  vec4 clr_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(-1.0, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(1.0, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, -1.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, 1.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_7;
  vec2 cse_8;
  cse_8 = (vec2(1.5, 0.0) * _MainTex_TexelSize.xy);
  vec2 cse_9;
  cse_9 = (vec2(-1.5, 0.0) * _MainTex_TexelSize.xy);
  tmpvar_7 = (((2.0 * 
    (texture2D (_MainTex, (xlv_TEXCOORD0 + cse_9)) + texture2D (_MainTex, (xlv_TEXCOORD0 + cse_8)))
  ) + (2.0 * tmpvar_2)) / 6.0);
  vec4 tmpvar_10;
  vec2 cse_11;
  cse_11 = (vec2(0.0, 1.5) * _MainTex_TexelSize.xy);
  vec2 cse_12;
  cse_12 = (vec2(0.0, -1.5) * _MainTex_TexelSize.xy);
  tmpvar_10 = (((2.0 * 
    (texture2D (_MainTex, (xlv_TEXCOORD0 + cse_12)) + texture2D (_MainTex, (xlv_TEXCOORD0 + cse_11)))
  ) + (2.0 * tmpvar_2)) / 6.0);
  vec4 tmpvar_13;
  tmpvar_13 = mix (mix (tmpvar_2, tmpvar_7, vec4(clamp (
    (((3.0 * dot (
      (abs(((tmpvar_5 + tmpvar_6) - (2.0 * tmpvar_2))) / 2.0)
    .xyz, vec3(0.33, 0.33, 0.33))) - 0.1) / dot (tmpvar_7.xyz, vec3(0.33, 0.33, 0.33)))
  , 0.0, 1.0))), tmpvar_10, vec4((clamp (
    (((3.0 * dot (
      (abs(((tmpvar_3 + tmpvar_4) - (2.0 * tmpvar_2))) / 2.0)
    .xyz, vec3(0.33, 0.33, 0.33))) - 0.1) / dot (tmpvar_10.xyz, vec3(0.33, 0.33, 0.33)))
  , 0.0, 1.0) * 0.5)));
  clr_1 = tmpvar_13;
  vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, (xlv_TEXCOORD0 + cse_8));
  vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(3.5, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(5.5, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(7.5, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, (xlv_TEXCOORD0 + cse_9));
  vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(-3.5, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(-5.5, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(-7.5, 0.0) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, (xlv_TEXCOORD0 + cse_11));
  vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, 3.5) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_24;
  tmpvar_24 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, 5.5) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_25;
  tmpvar_25 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, 7.5) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, (xlv_TEXCOORD0 + cse_12));
  vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, -3.5) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, -5.5) * _MainTex_TexelSize.xy)));
  vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, (xlv_TEXCOORD0 + (vec2(0.0, -7.5) * _MainTex_TexelSize.xy)));
  float tmpvar_30;
  tmpvar_30 = clamp (((
    ((((
      ((((tmpvar_14.w + tmpvar_15.w) + tmpvar_16.w) + tmpvar_17.w) + tmpvar_18.w)
     + tmpvar_19.w) + tmpvar_20.w) + tmpvar_21.w) / 8.0)
   * 2.0) - 1.0), 0.0, 1.0);
  float tmpvar_31;
  tmpvar_31 = clamp (((
    ((((
      ((((tmpvar_22.w + tmpvar_23.w) + tmpvar_24.w) + tmpvar_25.w) + tmpvar_26.w)
     + tmpvar_27.w) + tmpvar_28.w) + tmpvar_29.w) / 8.0)
   * 2.0) - 1.0), 0.0, 1.0);
  float tmpvar_32;
  tmpvar_32 = abs((tmpvar_30 - tmpvar_31));
  if ((tmpvar_32 > 0.2)) {
    float tmpvar_33;
    tmpvar_33 = dot (((
      ((((
        ((tmpvar_14 + tmpvar_15) + tmpvar_16)
       + tmpvar_17) + tmpvar_18) + tmpvar_19) + tmpvar_20)
     + tmpvar_21) / 8.0).xyz, vec3(0.33, 0.33, 0.33));
    float tmpvar_34;
    tmpvar_34 = dot (((
      ((((
        ((tmpvar_22 + tmpvar_23) + tmpvar_24)
       + tmpvar_25) + tmpvar_26) + tmpvar_27) + tmpvar_28)
     + tmpvar_29) / 8.0).xyz, vec3(0.33, 0.33, 0.33));
    float tmpvar_35;
    tmpvar_35 = dot (tmpvar_2.xyz, vec3(0.33, 0.33, 0.33));
    float tmpvar_36;
    tmpvar_36 = dot (tmpvar_3.xyz, vec3(0.33, 0.33, 0.33));
    float tmpvar_37;
    tmpvar_37 = dot (tmpvar_4.xyz, vec3(0.33, 0.33, 0.33));
    float tmpvar_38;
    tmpvar_38 = dot (tmpvar_5.xyz, vec3(0.33, 0.33, 0.33));
    float tmpvar_39;
    tmpvar_39 = dot (tmpvar_6.xyz, vec3(0.33, 0.33, 0.33));
    float tmpvar_40;
    if ((tmpvar_35 == tmpvar_38)) {
      tmpvar_40 = 0.0;
    } else {
      tmpvar_40 = clamp (((tmpvar_33 - tmpvar_38) / (tmpvar_35 - tmpvar_38)), 0.0, 1.0);
    };
    float tmpvar_41;
    if ((tmpvar_35 == tmpvar_39)) {
      tmpvar_41 = 0.0;
    } else {
      tmpvar_41 = clamp ((1.0 + (
        (tmpvar_33 - tmpvar_35)
       / 
        (tmpvar_35 - tmpvar_39)
      )), 0.0, 1.0);
    };
    float tmpvar_42;
    if ((tmpvar_35 == tmpvar_36)) {
      tmpvar_42 = 0.0;
    } else {
      tmpvar_42 = clamp (((tmpvar_34 - tmpvar_36) / (tmpvar_35 - tmpvar_36)), 0.0, 1.0);
    };
    float tmpvar_43;
    if ((tmpvar_35 == tmpvar_37)) {
      tmpvar_43 = 0.0;
    } else {
      tmpvar_43 = clamp ((1.0 + (
        (tmpvar_34 - tmpvar_35)
       / 
        (tmpvar_35 - tmpvar_37)
      )), 0.0, 1.0);
    };
    clr_1 = mix (mix (tmpvar_13, mix (tmpvar_4, 
      mix (tmpvar_3, tmpvar_2, vec4(tmpvar_42))
    , vec4(tmpvar_43)), vec4(tmpvar_31)), mix (tmpvar_6, mix (tmpvar_5, tmpvar_2, vec4(tmpvar_40)), vec4(tmpvar_41)), vec4(tmpvar_30));
  };
  gl_FragData[0] = clr_1;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_texcoord v1
dcl_position o0
dcl_texcoord o1.xy
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mov o1.xy, v1

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
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 0 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
def c1, -1, 0, 1, 0.5
def c2, 0.166666672, 0.330000013, 3, -0.100000001
def c3, 7.5, 0, -3.5, 0.200000003
def c4, 3.5, 0, 5.5, 0.125
def c5, 0.25, -1, 0, 0
def c6, -5.5, 0, -7.5, 0
def c7, -1.5, 0, 1.5, 2
dcl_texcoord v0.xy
dcl_2d s0
mov r0.xy, c0
mad r1, r0.xyxy, c4.yxyz, v0.xyxy
texld r2, r1.zwzw, s0
texld r1, r1, s0
mad r3, r0.xyxy, c7.yxyz, v0.xyxy
texld r4, r3.zwzw, s0
texld r3, r3, s0
add r1, r1.wxyz, r4.wxyz
add r4, r4, r3
add r1, r2.wxyz, r1
mad r2, r0.xyxy, c3.yxyz, v0.xyxy
texld r5, r2, s0
texld r2, r2.zwzw, s0
add r1, r1, r5.wxyz
add r1, r3.wxyz, r1
add r1, r2.wxyz, r1
mad r2, r0.xyxy, c6.yxyz, v0.xyxy
texld r3, r2, s0
texld r2, r2.zwzw, s0
add r1, r1, r3.wxyz
add r1, r2.wxyz, r1
mad_sat r0.z, r1.x, c5.x, c5.y
mul r1.xyz, r1.yzww, c4.w
dp3 r0.w, r1, c2.y
mad r1, r0.xyxy, c1.xyzy, v0.xyxy
texld r2, r1, s0
texld r1, r1.zwzw, s0
dp3 r3.x, r2, c2.y
add r3.y, r0.w, -r3.x
texld r5, v0, s0
dp3 r3.z, r5, c2.y
add r3.x, -r3.x, r3.z
rcp r3.w, r3.x
mul_sat r3.y, r3.w, r3.y
cmp r3.x, -r3_abs.x, c7.y, r3.y
lrp r6, r3.x, r5, r2
add r2.xyz, r1, r2
mad r2.xyz, r5, -c7.w, r2
mul r2.xyz, r2_abs, c1.w
dp3 r2.x, r2, c2.y
mad r2.x, r2.x, c2.z, c2.w
add r0.w, r0.w, -r3.z
dp3 r2.y, r1, c2.y
add r2.y, -r2.y, r3.z
rcp r2.z, r2.y
mad_sat r0.w, r0.w, r2.z, c1.z
cmp r0.w, -r2_abs.y, c7.y, r0.w
lrp r7, r0.w, r6, r1
mad r1, r0.xyxy, c7.xyzy, v0.xyxy
texld r6, r1, s0
texld r1, r1.zwzw, s0
add r8, r1, r6
add r9, r5, r5
mad r8, r8, c7.w, r9
mad r4, r4, c7.w, r9
mul r2.yzw, r8.xxyz, c2.x
mad r8, r8, c2.x, -r5
dp3 r0.w, r2.yzww, c2.y
rcp r0.w, r0.w
mad r9, r0.xyxy, c1.yxyz, v0.xyxy
texld r10, r9, s0
texld r9, r9.zwzw, s0
add r2.yzw, r9.xxyz, r10.xxyz
mad r2.yzw, r5.xxyz, -c7.w, r2
mul r2.yzw, r2_abs, c1.w
dp3 r2.y, r2.yzww, c2.y
mad r2.y, r2.y, c2.z, c2.w
mul_sat r0.w, r0.w, r2.y
mad r8, r0.w, r8, r5
mad r11, r4, c2.x, -r8
mul r2.yzw, r4.xxyz, c2.x
dp3 r0.w, r2.yzww, c2.y
rcp r0.w, r0.w
mul_sat r0.w, r0.w, r2.x
mul r0.w, r0.w, c1.w
mad r2, r0.w, r11, r8
lrp r4, r0.z, r7, r2
mad r7, r0.xyxy, c4.xyzy, v0.xyxy
texld r8, r7, s0
texld r7, r7.zwzw, s0
add r1, r1.wxyz, r8.wxyz
add r1, r7.wxyz, r1
mad r7, r0.xyxy, c3.xyzy, v0.xyxy
texld r8, r7, s0
texld r7, r7.zwzw, s0
add r1, r1, r8.wxyz
add r1, r6.wxyz, r1
add r1, r7.wxyz, r1
mad r6, r0.xyxy, c6.xyzy, v0.xyxy
texld r7, r6, s0
texld r6, r6.zwzw, s0
add r1, r1, r7.wxyz
add r1, r6.wxyz, r1
mad_sat r0.x, r1.x, c5.x, c5.y
mul r1.xyz, r1.yzww, c4.w
dp3 r0.y, r1, c2.y
dp3 r0.w, r10, c2.y
add r1.x, -r0.w, r0.y
add r0.y, -r3.z, r0.y
add r0.w, -r0.w, r3.z
rcp r1.y, r0.w
mul_sat r1.x, r1.y, r1.x
cmp r0.w, -r0_abs.w, c7.y, r1.x
lrp r1, r0.w, r5, r10
dp3 r0.w, r9, c2.y
add r0.w, -r0.w, r3.z
rcp r3.x, r0.w
mad_sat r0.y, r0.y, r3.x, c1.z
cmp r0.y, -r0_abs.w, c7.y, r0.y
lrp r3, r0.y, r1, r9
lrp_pp r1, r0.x, r3, r4
add r0.x, -r0.z, r0.x
add r0.x, -r0_abs.x, c3.w
cmp_pp oC0, r0.x, r2, r1

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 96 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefieceddefmklaefommapimmhfidlnbockajpdpabaaaaaanibbaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbibbaaaa
eaaaaaaaegaeaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacalaaaaaadcaaaaanpcaabaaaaaaaaaaa
egiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaagaeaaaaaaaaaaaaalaea
egbebaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaanpcaabaaaacaaaaaaegiecaaa
aaaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaamalpaaaaaaaaaaaamadpegbebaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaadgajbaaaaaaaaaaa
dgajbaaaadaaaaaaaaaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
acaaaaaaaaaaaaahpcaabaaaaaaaaaaadgajbaaaabaaaaaaegaobaaaaaaaaaaa
dcaaaaanpcaabaaaabaaaaaaegiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaaaaaa
aaaapaeaaaaaaaaaaaaagamaegbebaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaadgajbaaaaeaaaaaaaaaaaaahpcaabaaa
aaaaaaaadgajbaaaacaaaaaaegaobaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaa
dgajbaaaabaaaaaaegaobaaaaaaaaaaadcaaaaanpcaabaaaabaaaaaaegiecaaa
aaaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaalamaaaaaaaaaaaaapamaegbebaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
dgajbaaaacaaaaaaaaaaaaahpcaabaaaaaaaaaaadgajbaaaabaaaaaaegaobaaa
aaaaaaaadiaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaadoaaaaaadoaaaaaadodccaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadoabeaaaaaaaaaialpbaaaaaakccaabaaaaaaaaaaajgahbaaa
aaaaaaaaaceaaaaamdpfkidomdpfkidomdpfkidoaaaaaaaadcaaaaanpcaabaaa
abaaaaaaegiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaiadp
aaaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaakecaabaaaaaaaaaaa
egacbaaaacaaaaaaaceaaaaamdpfkidomdpfkidomdpfkidoaaaaaaaaaaaaaaai
icaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
baaaaaakbcaabaaaafaaaaaaegacbaaaaeaaaaaaaceaaaaamdpfkidomdpfkido
mdpfkidoaaaaaaaaaaaaaaaiccaabaaaafaaaaaackaabaiaebaaaaaaaaaaaaaa
akaabaaaafaaaaaabiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
afaaaaaaaocaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaafaaaaaa
dhaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaaipcaabaaaagaaaaaaegaobaiaebaaaaaaacaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaagaaaaaakgakbaaaaaaaaaaaegaobaaaagaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadcaaaaanhcaabaaaacaaaaaaegacbaiaebaaaaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaacaaaaaadiaaaaalhcaabaaa
acaaaaaaegacbaiaibaaaaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaabaaaaaakecaabaaaaaaaaaaaegacbaaaacaaaaaaaceaaaaamdpfkido
mdpfkidomdpfkidoaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaeaeaabeaaaaamnmmmmlnaaaaaaaipcaabaaaacaaaaaaegaobaia
ebaaaaaaabaaaaaaegaobaaaagaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaiaebaaaaaaafaaaaaabaaaaaakicaabaaaaaaaaaaaegacbaaa
abaaaaaaaceaaaaamdpfkidomdpfkidomdpfkidoaaaaaaaaaaaaaaaiccaabaaa
afaaaaaadkaabaiaebaaaaaaaaaaaaaaakaabaaaafaaaaaabiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaafaaaaaaaoaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaafaaaaaaaacaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdhaaaaajccaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajpcaabaaaabaaaaaafgafbaaa
aaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaaeaaaaaaegaobaaaaeaaaaaadcaaaaampcaabaaaadaaaaaaegaobaaa
adaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaeaegaobaaaacaaaaaa
diaaaaakocaabaaaafaaaaaaagajbaaaadaaaaaaaceaaaaaaaaaaaaaklkkckdo
klkkckdoklkkckdobaaaaaakccaabaaaaaaaaaaajgahbaaaafaaaaaaaceaaaaa
mdpfkidomdpfkidomdpfkidoaaaaaaaaaocaaaahccaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaadpdcaaaaanpcaabaaaagaaaaaaegiecaaaaaaaaaaaagaaaaaa
aceaaaaaaaaamalpaaaaaaaaaaaamadpaaaaaaaaegbebaaaabaaaaaaefaaaaaj
pcaabaaaahaaaaaaegaabaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaagaaaaaaogakbaaaagaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaaiaaaaaaegaobaaaagaaaaaaegaobaaaahaaaaaa
dcaaaaampcaabaaaacaaaaaaegaobaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaeaegaobaaaacaaaaaadcaaaaanpcaabaaaaiaaaaaaegaobaaa
acaaaaaaaceaaaaaklkkckdoklkkckdoklkkckdoklkkckdoegaobaiaebaaaaaa
aeaaaaaadiaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaklkkckdo
klkkckdoklkkckdoaaaaaaaabaaaaaakecaabaaaaaaaaaaaegacbaaaacaaaaaa
aceaaaaamdpfkidomdpfkidomdpfkidoaaaaaaaadcaaaaanpcaabaaaacaaaaaa
egiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaiadp
egbebaaaabaaaaaaefaaaaajpcaabaaaajaaaaaaegaabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahocaabaaaafaaaaaaagajbaaa
acaaaaaaagajbaaaajaaaaaadcaaaaanocaabaaaafaaaaaaagajbaiaebaaaaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaaaaaaeafgaobaaaafaaaaaa
diaaaaalocaabaaaafaaaaaafgaobaiaibaaaaaaafaaaaaaaceaaaaaaaaaaaaa
aaaaaadpaaaaaadpaaaaaadpbaaaaaakicaabaaaaaaaaaaajgahbaaaafaaaaaa
aceaaaaamdpfkidomdpfkidomdpfkidoaaaaaaaadcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaeaeaabeaaaaamnmmmmlnaocaaaahecaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajpcaabaaaaiaaaaaa
kgakbaaaaaaaaaaaegaobaaaaiaaaaaaegaobaaaaeaaaaaaaaaaaaaipcaabaaa
aeaaaaaaegaobaaaaeaaaaaaegaobaiaebaaaaaaajaaaaaadcaaaaanpcaabaaa
adaaaaaaegaobaaaadaaaaaaaceaaaaaklkkckdoklkkckdoklkkckdoklkkckdo
egaobaiaebaaaaaaaiaaaaaadcaaaaajpcaabaaaadaaaaaafgafbaaaaaaaaaaa
egaobaaaadaaaaaaegaobaaaaiaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaiaebaaaaaaadaaaaaadcaaaaajpcaabaaaabaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadcaaaaanpcaabaaaaiaaaaaa
egiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaagaeaaaaaaaaaaaaalaeaaaaaaaaa
egbebaaaabaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaaiaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaiaaaaaaogakbaaaaiaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaagaaaaaadgajbaaa
agaaaaaadgajbaaaakaaaaaaaaaaaaahpcaabaaaagaaaaaadgajbaaaaiaaaaaa
egaobaaaagaaaaaadcaaaaanpcaabaaaaiaaaaaaegiecaaaaaaaaaaaagaaaaaa
aceaaaaaaaaapaeaaaaaaaaaaaaagamaaaaaaaaaegbebaaaabaaaaaaefaaaaaj
pcaabaaaakaaaaaaegaabaaaaiaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaaiaaaaaaogakbaaaaiaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaagaaaaaaegaobaaaagaaaaaadgajbaaaakaaaaaa
aaaaaaahpcaabaaaagaaaaaadgajbaaaahaaaaaaegaobaaaagaaaaaaaaaaaaah
pcaabaaaagaaaaaadgajbaaaaiaaaaaaegaobaaaagaaaaaadcaaaaanpcaabaaa
ahaaaaaaegiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaalamaaaaaaaaaaaaapama
aaaaaaaaegbebaaaabaaaaaaefaaaaajpcaabaaaaiaaaaaaegaabaaaahaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaahaaaaaaogakbaaa
ahaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaagaaaaaa
egaobaaaagaaaaaadgajbaaaaiaaaaaaaaaaaaahpcaabaaaagaaaaaadgajbaaa
ahaaaaaaegaobaaaagaaaaaadiaaaaakocaabaaaaaaaaaaafgaobaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaaadoaaaaaadoaaaaaadodccaaaajccaabaaaafaaaaaa
akaabaaaagaaaaaaabeaaaaaaaaaiadoabeaaaaaaaaaialpbaaaaaakccaabaaa
aaaaaaaajgahbaaaaaaaaaaaaceaaaaamdpfkidomdpfkidomdpfkidoaaaaaaaa
baaaaaakecaabaaaaaaaaaaaegacbaaaajaaaaaaaceaaaaamdpfkidomdpfkido
mdpfkidoaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaaakaabaiaebaaaaaaafaaaaaa
bkaabaaaaaaaaaaaaaaaaaaiecaabaaaafaaaaaackaabaiaebaaaaaaaaaaaaaa
akaabaaaafaaaaaabiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
afaaaaaaaocaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaafaaaaaa
dhaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajpcaabaaaaeaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaa
egaobaaaajaaaaaaaaaaaaaipcaabaaaaeaaaaaaegaobaiaebaaaaaaacaaaaaa
egaobaaaaeaaaaaabaaaaaakecaabaaaaaaaaaaaegacbaaaacaaaaaaaceaaaaa
mdpfkidomdpfkidomdpfkidoaaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaakaabaaaafaaaaaabiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaafaaaaaaaoaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaacaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdhaaaaajccaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaajpcaabaaaacaaaaaafgafbaaaaaaaaaaaegaobaaa
aeaaaaaaegaobaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaafgafbaaaafaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaabkaabaaaafaaaaaadbaaaaaibcaabaaaaaaaaaaaabeaaaaa
mnmmemdoakaabaiaibaaaaaaaaaaaaaadhaaaaajpccabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadoaaaaab"
}
}
 }
}
Fallback Off
}