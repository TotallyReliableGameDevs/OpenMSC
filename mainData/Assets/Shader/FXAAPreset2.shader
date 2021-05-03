Shader "Hidden/FXAA Preset 2" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 26581
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
#extension GL_ARB_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform vec4 _MainTex_TexelSize;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 rcpFrame_1;
  rcpFrame_1 = _MainTex_TexelSize.xy;
  vec3 tmpvar_2;
  bool doneP_4;
  bool doneN_5;
  float lumaEndP_6;
  float lumaEndN_7;
  vec2 offNP_8;
  vec2 posP_9;
  vec2 posN_10;
  float gradientN_11;
  float lengthSign_12;
  float lumaS_13;
  float lumaN_14;
  vec4 tmpvar_15;
  tmpvar_15.zw = vec2(0.0, 0.0);
  tmpvar_15.xy = (xlv_TEXCOORD0 + (vec2(0.0, -1.0) * _MainTex_TexelSize.xy));
  vec4 tmpvar_16;
  tmpvar_16 = texture2DLod (_MainTex, tmpvar_15.xy, 0.0);
  vec4 tmpvar_17;
  tmpvar_17.zw = vec2(0.0, 0.0);
  tmpvar_17.xy = (xlv_TEXCOORD0 + (vec2(-1.0, 0.0) * _MainTex_TexelSize.xy));
  vec4 tmpvar_18;
  tmpvar_18 = texture2DLod (_MainTex, tmpvar_17.xy, 0.0);
  vec4 tmpvar_19;
  tmpvar_19 = texture2DLod (_MainTex, xlv_TEXCOORD0, 0.0);
  vec4 tmpvar_20;
  tmpvar_20.zw = vec2(0.0, 0.0);
  tmpvar_20.xy = (xlv_TEXCOORD0 + (vec2(1.0, 0.0) * _MainTex_TexelSize.xy));
  vec4 tmpvar_21;
  tmpvar_21 = texture2DLod (_MainTex, tmpvar_20.xy, 0.0);
  vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = (xlv_TEXCOORD0 + (vec2(0.0, 1.0) * _MainTex_TexelSize.xy));
  vec4 tmpvar_23;
  tmpvar_23 = texture2DLod (_MainTex, tmpvar_22.xy, 0.0);
  float tmpvar_24;
  tmpvar_24 = ((tmpvar_16.y * 1.963211) + tmpvar_16.x);
  lumaN_14 = tmpvar_24;
  float tmpvar_25;
  tmpvar_25 = ((tmpvar_18.y * 1.963211) + tmpvar_18.x);
  float tmpvar_26;
  tmpvar_26 = ((tmpvar_19.y * 1.963211) + tmpvar_19.x);
  float tmpvar_27;
  tmpvar_27 = ((tmpvar_21.y * 1.963211) + tmpvar_21.x);
  float tmpvar_28;
  tmpvar_28 = ((tmpvar_23.y * 1.963211) + tmpvar_23.x);
  lumaS_13 = tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = max (tmpvar_26, max (max (tmpvar_24, tmpvar_25), max (tmpvar_28, tmpvar_27)));
  float tmpvar_30;
  tmpvar_30 = (tmpvar_29 - min (tmpvar_26, min (
    min (tmpvar_24, tmpvar_25)
  , 
    min (tmpvar_28, tmpvar_27)
  )));
  float tmpvar_31;
  tmpvar_31 = max (0.04166667, (tmpvar_29 * 0.125));
  if ((tmpvar_30 < tmpvar_31)) {
    tmpvar_2 = tmpvar_19.xyz;
  } else {
    float tmpvar_32;
    tmpvar_32 = min (0.75, (max (0.0, 
      ((abs((
        ((((tmpvar_24 + tmpvar_25) + tmpvar_27) + tmpvar_28) * 0.25)
       - tmpvar_26)) / tmpvar_30) - 0.25)
    ) * 1.333333));
    vec4 tmpvar_33;
    tmpvar_33.zw = vec2(0.0, 0.0);
    tmpvar_33.xy = (xlv_TEXCOORD0 - _MainTex_TexelSize.xy);
    vec4 tmpvar_34;
    tmpvar_34 = texture2DLod (_MainTex, tmpvar_33.xy, 0.0);
    vec4 tmpvar_35;
    tmpvar_35.zw = vec2(0.0, 0.0);
    tmpvar_35.xy = (xlv_TEXCOORD0 + (vec2(1.0, -1.0) * _MainTex_TexelSize.xy));
    vec4 tmpvar_36;
    tmpvar_36 = texture2DLod (_MainTex, tmpvar_35.xy, 0.0);
    vec4 tmpvar_37;
    tmpvar_37.zw = vec2(0.0, 0.0);
    tmpvar_37.xy = (xlv_TEXCOORD0 + (vec2(-1.0, 1.0) * _MainTex_TexelSize.xy));
    vec4 tmpvar_38;
    tmpvar_38 = texture2DLod (_MainTex, tmpvar_37.xy, 0.0);
    vec4 tmpvar_39;
    tmpvar_39.zw = vec2(0.0, 0.0);
    tmpvar_39.xy = (xlv_TEXCOORD0 + _MainTex_TexelSize.xy);
    vec4 tmpvar_40;
    tmpvar_40 = texture2DLod (_MainTex, tmpvar_39.xy, 0.0);
    vec3 tmpvar_41;
    tmpvar_41 = (((
      (((tmpvar_16.xyz + tmpvar_18.xyz) + tmpvar_19.xyz) + tmpvar_21.xyz)
     + tmpvar_23.xyz) + (
      ((tmpvar_34.xyz + tmpvar_36.xyz) + tmpvar_38.xyz)
     + tmpvar_40.xyz)) * vec3(0.1111111, 0.1111111, 0.1111111));
    float tmpvar_42;
    tmpvar_42 = ((tmpvar_34.y * 1.963211) + tmpvar_34.x);
    float tmpvar_43;
    tmpvar_43 = ((tmpvar_36.y * 1.963211) + tmpvar_36.x);
    float tmpvar_44;
    tmpvar_44 = ((tmpvar_38.y * 1.963211) + tmpvar_38.x);
    float tmpvar_45;
    tmpvar_45 = ((tmpvar_40.y * 1.963211) + tmpvar_40.x);
    bool tmpvar_46;
    tmpvar_46 = (((
      abs((((0.25 * tmpvar_42) + (-0.5 * tmpvar_25)) + (0.25 * tmpvar_44)))
     + 
      abs((((0.5 * tmpvar_24) - tmpvar_26) + (0.5 * tmpvar_28)))
    ) + abs(
      (((0.25 * tmpvar_43) + (-0.5 * tmpvar_27)) + (0.25 * tmpvar_45))
    )) >= ((
      abs((((0.25 * tmpvar_42) + (-0.5 * tmpvar_24)) + (0.25 * tmpvar_43)))
     + 
      abs((((0.5 * tmpvar_25) - tmpvar_26) + (0.5 * tmpvar_27)))
    ) + abs(
      (((0.25 * tmpvar_44) + (-0.5 * tmpvar_28)) + (0.25 * tmpvar_45))
    )));
    float tmpvar_47;
    if (tmpvar_46) {
      tmpvar_47 = -(_MainTex_TexelSize.y);
    } else {
      tmpvar_47 = -(_MainTex_TexelSize.x);
    };
    lengthSign_12 = tmpvar_47;
    if (!(tmpvar_46)) {
      lumaN_14 = tmpvar_25;
    };
    if (!(tmpvar_46)) {
      lumaS_13 = tmpvar_27;
    };
    float tmpvar_48;
    tmpvar_48 = abs((lumaN_14 - tmpvar_26));
    gradientN_11 = tmpvar_48;
    float tmpvar_49;
    tmpvar_49 = abs((lumaS_13 - tmpvar_26));
    lumaN_14 = ((lumaN_14 + tmpvar_26) * 0.5);
    float tmpvar_50;
    tmpvar_50 = ((lumaS_13 + tmpvar_26) * 0.5);
    lumaS_13 = tmpvar_50;
    bool tmpvar_51;
    tmpvar_51 = (tmpvar_48 >= tmpvar_49);
    if (!(tmpvar_51)) {
      lumaN_14 = tmpvar_50;
    };
    if (!(tmpvar_51)) {
      gradientN_11 = tmpvar_49;
    };
    if (!(tmpvar_51)) {
      lengthSign_12 = -(tmpvar_47);
    };
    float tmpvar_52;
    if (tmpvar_46) {
      tmpvar_52 = 0.0;
    } else {
      tmpvar_52 = (lengthSign_12 * 0.5);
    };
    posN_10.x = (xlv_TEXCOORD0.x + tmpvar_52);
    float tmpvar_53;
    if (tmpvar_46) {
      tmpvar_53 = (lengthSign_12 * 0.5);
    } else {
      tmpvar_53 = 0.0;
    };
    posN_10.y = (xlv_TEXCOORD0.y + tmpvar_53);
    gradientN_11 = (gradientN_11 * 0.25);
    posP_9 = posN_10;
    vec2 tmpvar_54;
    if (tmpvar_46) {
      vec2 tmpvar_55;
      tmpvar_55.y = 0.0;
      tmpvar_55.x = rcpFrame_1.x;
      tmpvar_54 = tmpvar_55;
    } else {
      vec2 tmpvar_56;
      tmpvar_56.x = 0.0;
      tmpvar_56.y = rcpFrame_1.y;
      tmpvar_54 = tmpvar_56;
    };
    lumaEndN_7 = lumaN_14;
    lumaEndP_6 = lumaN_14;
    doneN_5 = bool(0);
    doneP_4 = bool(0);
    posN_10 = (posN_10 + (tmpvar_54 * vec2(-1.5, -1.5)));
    posP_9 = (posP_9 + (tmpvar_54 * vec2(1.5, 1.5)));
    offNP_8 = (tmpvar_54 * vec2(2.0, 2.0));
    for (int i_3 = 0; i_3 < 8; i_3++) {
      if (!(doneN_5)) {
        vec4 tmpvar_57;
        tmpvar_57 = texture2DGradARB (_MainTex, posN_10, offNP_8, offNP_8);
        lumaEndN_7 = ((tmpvar_57.y * 1.963211) + tmpvar_57.x);
      };
      if (!(doneP_4)) {
        vec4 tmpvar_58;
        tmpvar_58 = texture2DGradARB (_MainTex, posP_9, offNP_8, offNP_8);
        lumaEndP_6 = ((tmpvar_58.y * 1.963211) + tmpvar_58.x);
      };
      bool tmpvar_59;
      if (doneN_5) {
        tmpvar_59 = bool(1);
      } else {
        tmpvar_59 = (abs((lumaEndN_7 - lumaN_14)) >= gradientN_11);
      };
      doneN_5 = tmpvar_59;
      bool tmpvar_60;
      if (doneP_4) {
        tmpvar_60 = bool(1);
      } else {
        tmpvar_60 = (abs((lumaEndP_6 - lumaN_14)) >= gradientN_11);
      };
      doneP_4 = tmpvar_60;
      if ((tmpvar_59 && tmpvar_60)) {
        break;
      };
      if (!(tmpvar_59)) {
        posN_10 = (posN_10 - offNP_8);
      };
      if (!(tmpvar_60)) {
        posP_9 = (posP_9 + offNP_8);
      };
    };
    float tmpvar_61;
    if (tmpvar_46) {
      tmpvar_61 = (xlv_TEXCOORD0.x - posN_10.x);
    } else {
      tmpvar_61 = (xlv_TEXCOORD0.y - posN_10.y);
    };
    float tmpvar_62;
    if (tmpvar_46) {
      tmpvar_62 = (posP_9.x - xlv_TEXCOORD0.x);
    } else {
      tmpvar_62 = (posP_9.y - xlv_TEXCOORD0.y);
    };
    bool tmpvar_63;
    tmpvar_63 = (tmpvar_61 < tmpvar_62);
    float tmpvar_64;
    if (tmpvar_63) {
      tmpvar_64 = lumaEndN_7;
    } else {
      tmpvar_64 = lumaEndP_6;
    };
    lumaEndN_7 = tmpvar_64;
    if ((((tmpvar_26 - lumaN_14) < 0.0) == ((tmpvar_64 - lumaN_14) < 0.0))) {
      lengthSign_12 = 0.0;
    };
    float tmpvar_65;
    tmpvar_65 = (tmpvar_62 + tmpvar_61);
    float tmpvar_66;
    if (tmpvar_63) {
      tmpvar_66 = tmpvar_61;
    } else {
      tmpvar_66 = tmpvar_62;
    };
    float tmpvar_67;
    tmpvar_67 = ((0.5 + (tmpvar_66 * 
      (-1.0 / tmpvar_65)
    )) * lengthSign_12);
    float tmpvar_68;
    if (tmpvar_46) {
      tmpvar_68 = 0.0;
    } else {
      tmpvar_68 = tmpvar_67;
    };
    float tmpvar_69;
    if (tmpvar_46) {
      tmpvar_69 = tmpvar_67;
    } else {
      tmpvar_69 = 0.0;
    };
    vec2 tmpvar_70;
    tmpvar_70.x = (xlv_TEXCOORD0.x + tmpvar_68);
    tmpvar_70.y = (xlv_TEXCOORD0.y + tmpvar_69);
    vec4 tmpvar_71;
    tmpvar_71 = texture2DLod (_MainTex, tmpvar_70, 0.0);
    vec3 tmpvar_72;
    tmpvar_72.x = -(tmpvar_32);
    tmpvar_72.y = -(tmpvar_32);
    tmpvar_72.z = -(tmpvar_32);
    tmpvar_2 = ((tmpvar_72 * tmpvar_71.xyz) + ((tmpvar_41 * vec3(tmpvar_32)) + tmpvar_71.xyz));
  };
  vec4 tmpvar_73;
  tmpvar_73.w = 0.0;
  tmpvar_73.xyz = tmpvar_2;
  gl_FragData[0] = tmpvar_73;
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
def c1, 0, -1, 1, 1.9632107
def c2, 0.125, -0.0416666679, 0.25, -0.25
def c3, 1.33333337, 0.75, -0.5, 0.5
def c4, 0.111111112, 0, 0, 0
def c5, -1.5, 1.5, 0, 2
defi i0, 8, 0, 0, 0
dcl_texcoord v0.xy
dcl_2d s0
mov r0.xyz, c1
mad r1, c0.xyxy, r0.xyyx, v0.xyxy
mul r2, r1.xyxx, c1.zzxx
texldl r2, r2, s0
mul r1, r1.zwxx, c1.zzxx
texldl r1, r1, s0
mul r3, c1.zzxx, v0.xyxx
texldl r3, r3, s0
mad r4, c0.xyxy, r0.zxxz, v0.xyxy
mul r5, r4.xyxx, c1.zzxx
texldl r5, r5, s0
mul r4, r4.zwxx, c1.zzxx
texldl r4, r4, s0
mad r0.w, r2.y, c1.w, r2.x
mad r1.w, r1.y, c1.w, r1.x
mad r2.w, r3.y, c1.w, r3.x
mad r3.w, r5.y, c1.w, r5.x
mad r4.w, r4.y, c1.w, r4.x
min r5.w, r1.w, r0.w
min r6.x, r3.w, r4.w
min r7.x, r6.x, r5.w
min r5.w, r7.x, r2.w
max r6.x, r0.w, r1.w
max r6.y, r4.w, r3.w
max r7.x, r6.x, r6.y
max r6.x, r2.w, r7.x
add r5.w, -r5.w, r6.x
mul r6.x, r6.x, c2.x
min r7.x, -r6.x, c2.y
if_lt r5.w, -r7.x
else
add r1.xyz, r1, r2
add r1.xyz, r3, r1
add r1.xyz, r5, r1
add r1.xyz, r4, r1
add r2.x, r0.w, r1.w
add r2.x, r3.w, r2.x
add r2.x, r4.w, r2.x
mad r2.x, r2.x, c2.z, -r2.w
rcp r2.y, r5.w
mad r2.x, r2_abs.x, r2.y, c2.w
mul r2.y, r2.x, c3.x
cmp r2.x, r2.x, r2.y, c1.x
min r4.x, r2.x, c3.y
add r5.xy, -c0, v0
mov r5.zw, c1.x
texldl r5, r5, s0
mad r6, c0.xyxy, r0.zyyz, v0.xyxy
mul r7, r6.xyxx, c1.zzxx
texldl r7, r7, s0
mul r6, r6.zwxx, c1.zzxx
texldl r6, r6, s0
add r8.xy, c0, v0
mov r8.zw, c1.x
texldl r8, r8, s0
add r2.xyz, r5, r7
add r2.xyz, r6, r2
add r2.xyz, r8, r2
add r1.xyz, r1, r2
mul r1.xyz, r4.x, r1
mad r0.y, r5.y, c1.w, r5.x
mad r2.x, r7.y, c1.w, r7.x
mad r2.y, r6.y, c1.w, r6.x
mad r2.z, r8.y, c1.w, r8.x
mul r4.y, r0.w, c3.z
mad r4.y, r0.y, c2.z, r4.y
mad r4.y, r2.x, c2.z, r4.y
mul r4.z, r1.w, c3.z
mad r5.x, r1.w, c3.w, -r2.w
mul r5.y, r3.w, c3.z
mad r5.x, r3.w, c3.w, r5.x
add r4.y, r4_abs.y, r5_abs.x
mul r5.x, r4.w, c3.z
mad r5.x, r2.y, c2.z, r5.x
mad r5.x, r2.z, c2.z, r5.x
add r4.y, r4.y, r5_abs.x
mad r0.y, r0.y, c2.z, r4.z
mad r0.y, r2.y, c2.z, r0.y
mad r2.y, r0.w, c3.w, -r2.w
mad r2.y, r4.w, c3.w, r2.y
add r0.y, r0_abs.y, r2_abs.y
mad r2.x, r2.x, c2.z, r5.y
mad r2.x, r2.z, c2.z, r2.x
add r0.y, r0.y, r2_abs.x
add r0.y, -r4.y, r0.y
cmp r2.x, r0.y, -c0.y, -c0.x
cmp r0.w, r0.y, r0.w, r1.w
cmp r1.w, r0.y, r4.w, r3.w
add r2.y, -r2.w, r0.w
add r2.z, -r2.w, r1.w
add r0.w, r2.w, r0.w
mul r0.w, r0.w, c3.w
add r1.w, r2.w, r1.w
mul r1.w, r1.w, c3.w
add r3.w, -r2_abs.z, r2_abs.y
cmp r0.w, r3.w, r0.w, r1.w
max r1.w, r2_abs.y, r2_abs.z
cmp r2.x, r3.w, r2.x, -r2.x
mul r2.y, r2.x, c3.w
cmp r2.z, r0.y, c1.x, r2.y
cmp r2.y, r0.y, r2.y, c1.x
add r5.xy, r2.zyzw, v0
mul r6, r0.zxxz, c0.xxxy
cmp r0.xz, r0.y, r6.xyyw, r6.zyww
mad r5, r0.xzxz, c5.xxyy, r5.xyxy
add r2.yz, r0.xxzw, r0.xxzw
mov r4.yz, r5.xxyw
mov r6.xy, r5.zwzw
mov r3.w, r0.w
mov r4.w, r0.w
mov r6.zw, c1.x
rep i0
if_ne r6.z, -r6.z
mov r7.x, r3.w
else
texldd r8, r4.yzzw, s0, r2.yzzw, r2.yzzw
mad r7.x, r8.y, c1.w, r8.x
endif
if_ne r6.w, -r6.w
mov r7.y, r4.w
else
texldd r8, r6, s0, r2.yzzw, r2.yzzw
mad r7.y, r8.y, c1.w, r8.x
endif
add r7.zw, -r0.w, r7.xyxy
mad r7.z, r1.w, -c2.z, r7_abs.z
cmp r7.z, r7.z, c1.z, c1.x
mad r7.w, r1.w, -c2.z, r7_abs.w
cmp r7.w, r7.w, c1.z, c1.x
add r7.zw, r6, r7
cmp r6.zw, -r7, c1.x, c1.z
mul r8.x, r6.w, r6.z
if_ne r8.x, -r8.x
mov r3.w, r7.x
mov r4.w, r7.y
break_ne c1.z, -c1.z
endif
mad r8.xy, r0.xzzw, -c5.w, r4.yzzw
cmp r4.yz, -r7.z, r8.xxyw, r4
mad r8.xy, r0.xzzw, c5.w, r6
cmp r6.xy, -r7.w, r8, r6
mov r3.w, r7.x
mov r4.w, r7.y
endrep
add r0.xz, -r4.yyzw, v0.xyyw
cmp r0.x, r0.y, r0.x, r0.z
add r2.yz, r6.xxyw, -v0.xxyw
cmp r0.z, r0.y, r2.y, r2.z
add r1.w, -r0.z, r0.x
cmp r1.w, r1.w, r4.w, r3.w
add r2.y, -r0.w, r2.w
cmp r2.y, r2.y, c1.x, c1.z
add r0.w, -r0.w, r1.w
cmp r0.w, r0.w, -c1.x, -c1.z
add r0.w, r0.w, r2.y
cmp r0.w, -r0_abs.w, c1.x, r2.x
add r1.w, r0.x, r0.z
min r2.x, r0.z, r0.x
rcp r0.x, r1.w
mad r0.x, r2.x, -r0.x, c3.w
mul r0.x, r0.w, r0.x
cmp r0.z, r0.y, c1.x, r0.x
cmp r0.x, r0.y, r0.x, c1.x
add r2.xy, r0.zxzw, v0
mov r2.zw, c1.x
texldl r0, r2, s0
mad r1.xyz, r1, c4.x, r0
mad r3.xyz, -r4.x, r0, r1
endif
mov oC0.xyz, r3
mov oC0.w, c1.x

"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 96 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecededjnknonegacfbfckanhoanpgbkppcnhabaaaaaakibeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoibdaaaa
eaaaaaaapkaeaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacajaaaaaadcaaaaanpcaabaaaaaaaaaaa
egiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaa
egbebaaaabaaaaaaeiaaaaalpcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaaaaaaaaa
ogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
eiaaaaalpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaadcaaaaanpcaabaaaadaaaaaaegiecaaaaaaaaaaa
agaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaiadpegbebaaaabaaaaaa
eiaaaaalpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaajicaabaaa
aaaaaaaabkaabaaaabaaaaaaabeaaaaahnekpldpakaabaaaabaaaaaadcaaaaaj
icaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaahnekpldpakaabaaaaaaaaaaa
dcaaaaajicaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaahnekpldpakaabaaa
acaaaaaadcaaaaajicaabaaaadaaaaaabkaabaaaaeaaaaaaabeaaaaahnekpldp
akaabaaaaeaaaaaadcaaaaajicaabaaaaeaaaaaabkaabaaaadaaaaaaabeaaaaa
hnekpldpakaabaaaadaaaaaaddaaaaahbcaabaaaafaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaaddaaaaahccaabaaaafaaaaaadkaabaaaadaaaaaadkaabaaa
aeaaaaaaddaaaaahbcaabaaaafaaaaaabkaabaaaafaaaaaaakaabaaaafaaaaaa
ddaaaaahbcaabaaaafaaaaaadkaabaaaacaaaaaaakaabaaaafaaaaaadeaaaaah
ccaabaaaafaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadeaaaaahecaabaaa
afaaaaaadkaabaaaadaaaaaadkaabaaaaeaaaaaadeaaaaahccaabaaaafaaaaaa
ckaabaaaafaaaaaabkaabaaaafaaaaaadeaaaaahccaabaaaafaaaaaadkaabaaa
acaaaaaabkaabaaaafaaaaaaaaaaaaaibcaabaaaafaaaaaaakaabaiaebaaaaaa
afaaaaaabkaabaaaafaaaaaadiaaaaahccaabaaaafaaaaaabkaabaaaafaaaaaa
abeaaaaaaaaaaadodeaaaaahccaabaaaafaaaaaabkaabaaaafaaaaaaabeaaaaa
klkkckdnbnaaaaahccaabaaaafaaaaaaakaabaaaafaaaaaabkaabaaaafaaaaaa
bpaaaeadbkaabaaaafaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaahbcaabaaa
abaaaaaadkaabaaaadaaaaaaakaabaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaa
dkaabaaaaeaaaaaaakaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadodkaabaiaebaaaaaaacaaaaaaaoaaaaaibcaabaaa
abaaaaaaakaabaiaibaaaaaaabaaaaaaakaabaaaafaaaaaaaaaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaialodeaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaklkkkkdpddaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaeadpaaaaaaajgcaabaaaabaaaaaaagbbbaaaabaaaaaaagibcaia
ebaaaaaaaaaaaaaaagaaaaaaeiaaaaalpcaabaaaafaaaaaajgafbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaanpcaabaaa
agaaaaaaegiecaaaaaaaaaaaagaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaialp
aaaaiadpegbebaaaabaaaaaaeiaaaaalpcaabaaaahaaaaaaegaabaaaagaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaa
agaaaaaaogakbaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaaigcaabaaaabaaaaaaagbbbaaaabaaaaaaagibcaaaaaaaaaaa
agaaaaaaeiaaaaalpcaabaaaaiaaaaaajgafbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
afaaaaaaegacbaaaahaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaagaaaaaa
egacbaaaadaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaaiaaaaaaegacbaaa
adaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaadcaaaaaj
ccaabaaaabaaaaaabkaabaaaafaaaaaaabeaaaaahnekpldpakaabaaaafaaaaaa
dcaaaaajecaabaaaabaaaaaabkaabaaaahaaaaaaabeaaaaahnekpldpakaabaaa
ahaaaaaadcaaaaajbcaabaaaadaaaaaabkaabaaaagaaaaaaabeaaaaahnekpldp
akaabaaaagaaaaaadcaaaaajccaabaaaadaaaaaabkaabaaaaiaaaaaaabeaaaaa
hnekpldpakaabaaaaiaaaaaadiaaaaahecaabaaaadaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaalpdcaaaaajecaabaaaadaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaiadockaabaaaadaaaaaadcaaaaajecaabaaaadaaaaaackaabaaaabaaaaaa
abeaaaaaaaaaiadockaabaaaadaaaaaadiaaaaahbcaabaaaaeaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaalpdcaaaaakccaabaaaaeaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaadpdkaabaiaebaaaaaaacaaaaaadiaaaaahecaabaaaaeaaaaaa
dkaabaaaadaaaaaaabeaaaaaaaaaaalpdcaaaaajccaabaaaaeaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaaadpbkaabaaaaeaaaaaaaaaaaaajecaabaaaadaaaaaa
ckaabaiaibaaaaaaadaaaaaabkaabaiaibaaaaaaaeaaaaaadiaaaaahccaabaaa
aeaaaaaadkaabaaaaeaaaaaaabeaaaaaaaaaaalpdcaaaaajccaabaaaaeaaaaaa
akaabaaaadaaaaaaabeaaaaaaaaaiadobkaabaaaaeaaaaaadcaaaaajccaabaaa
aeaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaiadobkaabaaaaeaaaaaaaaaaaaai
ecaabaaaadaaaaaackaabaaaadaaaaaabkaabaiaibaaaaaaaeaaaaaadcaaaaaj
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaiadoakaabaaaaeaaaaaa
dcaaaaajccaabaaaabaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiadobkaabaaa
abaaaaaadcaaaaakbcaabaaaadaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadp
dkaabaiaebaaaaaaacaaaaaadcaaaaajbcaabaaaadaaaaaadkaabaaaaeaaaaaa
abeaaaaaaaaaaadpakaabaaaadaaaaaaaaaaaaajccaabaaaabaaaaaabkaabaia
ibaaaaaaabaaaaaaakaabaiaibaaaaaaadaaaaaadcaaaaajecaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaiadockaabaaaaeaaaaaadcaaaaajecaabaaa
abaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaiadockaabaaaabaaaaaaaaaaaaai
ccaabaaaabaaaaaackaabaiaibaaaaaaabaaaaaabkaabaaaabaaaaaabnaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaadaaaaaadhaaaaanecaabaaa
abaaaaaabkaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaagaaaaaaakiacaia
ebaaaaaaaaaaaaaaagaaaaaadhaaaaajicaabaaaaaaaaaaabkaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadhaaaaajicaabaaaabaaaaaabkaabaaa
abaaaaaadkaabaaaaeaaaaaadkaabaaaadaaaaaaaaaaaaaibcaabaaaadaaaaaa
dkaabaiaebaaaaaaacaaaaaadkaabaaaaaaaaaaaaaaaaaaiccaabaaaadaaaaaa
dkaabaiaebaaaaaaacaaaaaadkaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaadpaaaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaa
dkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaadpbnaaaaajecaabaaaadaaaaaaakaabaiaibaaaaaaadaaaaaabkaabaia
ibaaaaaaadaaaaaadhaaaaajicaabaaaaaaaaaaackaabaaaadaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaadhaaaaalicaabaaaabaaaaaackaabaaaadaaaaaa
akaabaiaibaaaaaaadaaaaaabkaabaiaibaaaaaaadaaaaaadhaaaaakecaabaaa
abaaaaaackaabaaaadaaaaaackaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaa
diaaaaahbcaabaaaadaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaadpdhaaaaaj
ccaabaaaadaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaakaabaaaadaaaaaa
abaaaaahbcaabaaaadaaaaaabkaabaaaabaaaaaaakaabaaaadaaaaaaaaaaaaah
dcaabaaaaeaaaaaabgafbaaaadaaaaaaegbabaaaabaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadodgaaaaaigcaabaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaagjcaabaaaadaaaaaa
agiecaaaaaaaaaaaagaaaaaadhaaaaajdcaabaaaadaaaaaafgafbaaaabaaaaaa
egaabaaaadaaaaaaogakbaaaadaaaaaadcaaaaampcaabaaaaeaaaaaaegaebaaa
adaaaaaaaceaaaaaaaaamalpaaaamalpaaaamadpaaaamadpegaebaaaaeaaaaaa
aaaaaaahmcaabaaaadaaaaaaagaebaaaadaaaaaaagaebaaaadaaaaaadgaaaaaf
pcaabaaaafaaaaaaegaobaaaaeaaaaaadgaaaaafdcaabaaaagaaaaaapgapbaaa
aaaaaaaadgaaaaaimcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaafbcaabaaaahaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaah
ccaabaaaahaaaaaaakaabaaaahaaaaaaabeaaaaaaiaaaaaaadaaaeadbkaabaaa
ahaaaaaabpaaaaadckaabaaaagaaaaaaejaaaaanpcaabaaaaiaaaaaaegaabaaa
afaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaogakbaaaadaaaaaaogakbaaa
adaaaaaadcaaaaajccaabaaaahaaaaaabkaabaaaaiaaaaaaabeaaaaahnekpldp
akaabaaaaiaaaaaabcaaaaabdgaaaaafccaabaaaahaaaaaaakaabaaaagaaaaaa
bfaaaaabbpaaaaaddkaabaaaagaaaaaaejaaaaanpcaabaaaaiaaaaaaogakbaaa
afaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaogakbaaaadaaaaaaogakbaaa
adaaaaaadcaaaaajecaabaaaahaaaaaabkaabaaaaiaaaaaaabeaaaaahnekpldp
akaabaaaaiaaaaaabcaaaaabdgaaaaafecaabaaaahaaaaaabkaabaaaagaaaaaa
bfaaaaabaaaaaaaiicaabaaaahaaaaaadkaabaiaebaaaaaaaaaaaaaabkaabaaa
ahaaaaaabnaaaaaiicaabaaaahaaaaaadkaabaiaibaaaaaaahaaaaaadkaabaaa
abaaaaaadmaaaaahecaabaaaagaaaaaackaabaaaagaaaaaadkaabaaaahaaaaaa
aaaaaaaiicaabaaaahaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaaaahaaaaaa
bnaaaaaiicaabaaaahaaaaaadkaabaiaibaaaaaaahaaaaaadkaabaaaabaaaaaa
dmaaaaahicaabaaaagaaaaaadkaabaaaagaaaaaadkaabaaaahaaaaaaabaaaaah
icaabaaaahaaaaaadkaabaaaagaaaaaackaabaaaagaaaaaabpaaaeaddkaabaaa
ahaaaaaadgaaaaafdcaabaaaagaaaaaajgafbaaaahaaaaaaacaaaaabbfaaaaab
dcaaaaandcaabaaaaiaaaaaaegaabaiaebaaaaaaadaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaegaabaaaafaaaaaadhaaaaajdcaabaaaafaaaaaa
kgakbaaaagaaaaaaegaabaaaafaaaaaaegaabaaaaiaaaaaadcaaaaamdcaabaaa
aiaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
ogakbaaaafaaaaaadhaaaaajmcaabaaaafaaaaaapgapbaaaagaaaaaakgaobaaa
afaaaaaaagaebaaaaiaaaaaaboaaaaahbcaabaaaahaaaaaaakaabaaaahaaaaaa
abeaaaaaabaaaaaadgaaaaafdcaabaaaagaaaaaajgafbaaaahaaaaaabgaaaaab
aaaaaaaidcaabaaaadaaaaaaegaabaiaebaaaaaaafaaaaaaegbabaaaabaaaaaa
dhaaaaajicaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaadaaaaaabkaabaaa
adaaaaaaaaaaaaaidcaabaaaadaaaaaaogakbaaaafaaaaaaegbabaiaebaaaaaa
abaaaaaadhaaaaajbcaabaaaadaaaaaabkaabaaaabaaaaaaakaabaaaadaaaaaa
bkaabaaaadaaaaaadbaaaaahccaabaaaadaaaaaadkaabaaaabaaaaaaakaabaaa
adaaaaaadhaaaaajecaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaagaaaaaa
bkaabaaaagaaaaaaaaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaacaaaaaadbaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaaa
adaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
caaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaadhaaaaaj
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaackaabaaaabaaaaaa
aaaaaaahecaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaadaaaaaadhaaaaaj
icaabaaaabaaaaaabkaabaaaadaaaaaadkaabaaaabaaaaaaakaabaaaadaaaaaa
aoaaaaahecaabaaaabaaaaaaabeaaaaaaaaaialpckaabaaaabaaaaaadcaaaaaj
ecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaadp
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaadhaaaaaj
ecaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaahbcaabaaaadaaaaaackaabaaaabaaaaaaakbabaaaabaaaaaaabaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaaaaaaaaahccaabaaa
adaaaaaadkaabaaaaaaaaaaabkbabaaaabaaaaaaeiaaaaalpcaabaaaadaaaaaa
egaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaadjiooddndjiooddn
djiooddnaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaagaabaia
ebaaaaaaabaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabfaaaaabdgaaaaaf
hccabaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}
}
 }
}
Fallback "Hidden/FXAA II"
}