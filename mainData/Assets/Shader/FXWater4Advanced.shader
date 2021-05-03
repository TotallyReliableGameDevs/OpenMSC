Shader "FX/Water4" {
Properties {
 _ReflectionTex ("Internal reflection", 2D) = "white" { }
 _MainTex ("Fallback texture", 2D) = "black" { }
 _ShoreTex ("Shore & Foam texture ", 2D) = "black" { }
 _BumpMap ("Normals ", 2D) = "bump" { }
 _DistortParams ("Distortions (Bump waves, Reflection, Fresnel power, Fresnel bias)", Vector) = (1,1,2,1.15)
 _InvFadeParemeter ("Auto blend parameter (Edge, Shore, Distance scale)", Vector) = (0.15,0.15,0.5,1)
 _AnimationTiling ("Animation Tiling (Displacement)", Vector) = (2.2,2.2,-1.1,-1.1)
 _AnimationDirection ("Animation Direction (displacement)", Vector) = (1,1,1,1)
 _BumpTiling ("Bump Tiling", Vector) = (1,1,-2,3)
 _BumpDirection ("Bump Direction & Speed", Vector) = (1,1,-1,1)
 _FresnelScale ("FresnelScale", Range(0.15,4)) = 0.75
 _BaseColor ("Base color", Color) = (0.54,0.95,0.99,0.5)
 _ReflectionColor ("Reflection color", Color) = (0.54,0.95,0.99,0.5)
 _SpecularColor ("Specular color", Color) = (0.72,0.72,0.72,1)
 _WorldLightDir ("Specular light direction", Vector) = (0,0.1,-0.5,0)
 _Shininess ("Shininess", Range(2,500)) = 200
 _Foam ("Foam (intensity, cutoff)", Vector) = (0.1,0.375,0,0)
 _GerstnerIntensity ("Per vertex displacement", Float) = 1
 _GAmplitude ("Wave Amplitude", Vector) = (0.3,0.35,0.25,0.25)
 _GFrequency ("Wave Frequency", Vector) = (1.3,1.35,1.25,1.25)
 _GSteepness ("Wave Steepness", Vector) = (1,1,1,1)
 _GSpeed ("Wave Speed", Vector) = (1.2,1.375,1.1,1.5)
 _GDirectionAB ("Wave Direction", Vector) = (0.3,0.85,0.85,0.25)
 _GDirectionCD ("Wave Direction", Vector) = (0.1,0.9,0.5,0.5)
}
SubShader { 
 LOD 500
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 GrabPass {
  "_RefractionTex"
 }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask RGB
  GpuProgramID 57149
Program "vp" {
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_5;
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_7;
  tmpvar_7 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_8;
  tmpvar_8.x = dot (_GDirectionAB.xy, tmpvar_4.xz);
  tmpvar_8.y = dot (_GDirectionAB.zw, tmpvar_4.xz);
  tmpvar_8.z = dot (_GDirectionCD.xy, tmpvar_4.xz);
  tmpvar_8.w = dot (_GDirectionCD.zw, tmpvar_4.xz);
  vec4 tmpvar_9;
  tmpvar_9 = (_GFrequency * tmpvar_8);
  vec4 cse_10;
  cse_10 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_11;
  tmpvar_11 = cos((tmpvar_9 + cse_10));
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_6.xz;
  tmpvar_12.zw = tmpvar_7.xz;
  offsets_5.x = dot (tmpvar_11, tmpvar_12);
  vec4 tmpvar_13;
  tmpvar_13.xy = tmpvar_6.yw;
  tmpvar_13.zw = tmpvar_7.yw;
  offsets_5.z = dot (tmpvar_11, tmpvar_13);
  offsets_5.y = dot (sin((tmpvar_9 + cse_10)), _GAmplitude);
  vec2 xzVtx_14;
  xzVtx_14 = (tmpvar_4.xz + offsets_5.xz);
  vec3 nrml_15;
  nrml_15.y = 2.0;
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_17;
  tmpvar_17 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_18;
  tmpvar_18.x = dot (_GDirectionAB.xy, xzVtx_14);
  tmpvar_18.y = dot (_GDirectionAB.zw, xzVtx_14);
  tmpvar_18.z = dot (_GDirectionCD.xy, xzVtx_14);
  tmpvar_18.w = dot (_GDirectionCD.zw, xzVtx_14);
  vec4 tmpvar_19;
  tmpvar_19 = cos(((_GFrequency * tmpvar_18) + cse_10));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_16.xz;
  tmpvar_20.zw = tmpvar_17.xz;
  nrml_15.x = -(dot (tmpvar_19, tmpvar_20));
  vec4 tmpvar_21;
  tmpvar_21.xy = tmpvar_16.yw;
  tmpvar_21.zw = tmpvar_17.yw;
  nrml_15.z = -(dot (tmpvar_19, tmpvar_21));
  nrml_15.xz = (nrml_15.xz * _GerstnerIntensity);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(nrml_15);
  nrml_15 = tmpvar_22;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_5);
  tmpvar_3.xyz = (tmpvar_4 - _WorldSpaceCameraPos);
  vec4 tmpvar_23;
  tmpvar_23 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 grabPassPos_24;
  vec4 o_25;
  vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_23 * 0.5);
  vec2 tmpvar_27;
  tmpvar_27.x = tmpvar_26.x;
  tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
  o_25.xy = (tmpvar_27 + tmpvar_26.w);
  o_25.zw = tmpvar_23.zw;
  grabPassPos_24.xy = ((tmpvar_23.xy + tmpvar_23.w) * 0.5);
  grabPassPos_24.zw = tmpvar_23.zw;
  tmpvar_2.xyz = tmpvar_22;
  tmpvar_3.w = clamp (offsets_5.y, 0.0, 1.0);
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_23;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_25;
  xlv_TEXCOORD4 = grabPassPos_24;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec4 edgeBlendFactors_2;
  vec4 rtRefractions_3;
  vec3 worldNormal_4;
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_5 + normal_6) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_4 = tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.xy = ((tmpvar_7.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD4 + tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_3 = texture2DProj (_RefractionTex, tmpvar_10);
  vec4 tmpvar_12;
  tmpvar_12 = texture2DProj (_ReflectionTex, (xlv_TEXCOORD3 + tmpvar_9));
  float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_10).x) + _ZBufferParams.w)));
  if ((tmpvar_13 < xlv_TEXCOORD3.z)) {
    rtRefractions_3 = tmpvar_11;
  };
  vec4 tmpvar_14;
  tmpvar_14 = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0);
  edgeBlendFactors_2.xzw = tmpvar_14.xzw;
  edgeBlendFactors_2.y = (1.0 - tmpvar_14.y);
  worldNormal_4.xz = (tmpvar_7.xz * _FresnelScale);
  vec4 tmpvar_15;
  tmpvar_15 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_16;
  coords_16 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (rtRefractions_3, tmpvar_15, tmpvar_15.wwww)
  , 
    mix (tmpvar_12, _ReflectionColor, _ReflectionColor.wwww)
  , vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_8)
      , worldNormal_4), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_7, 
      -(normalize((_WorldLightDir.xyz + tmpvar_8)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_16.xy) * texture2D (_ShoreTex, coords_16.zw)) - 0.125)
  .xyz * _Foam.x) * (edgeBlendFactors_2.y + 
    clamp ((xlv_TEXCOORD1.w - _Foam.y), 0.0, 1.0)
  )));
  baseColor_1.w = edgeBlendFactors_2.x;
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, 0.159154937, 0.5, 6.28318548, -3.14159274
def c21, 1, 0.159154937, 0.25, 2
def c22, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c20.x, c20.y
mad r3, r3, c21.y, c21.z
frc r3, r3
mad r3, r3, c20.z, c20.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c20.z, c20.w
mul r4, r4, r4
mad r5, r4, c22.x, c22.y
mad r5, r4, r5, c22.z
mad r5, r4, r5, c22.w
mad r5, r4, r5, -c20.y
mad r4, r4, r5, c21.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c20.x, c20.y
frc r1, r1
mad r1, r1, c20.z, c20.w
mul r1, r1, r1
mad r4, r1, c22.x, c22.y
mad r4, r1, r4, c22.z
mad r4, r1, r4, c22.w
mad r4, r1, r4, -c20.y
mad r1, r1, r4, c21.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c21.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c22.x, c22.y
mad r1, r3, r1, c22.z
mad r1, r3, r1, c22.w
mad r1, r3, r1, -c20.y
mad r1, r3, r1, c21.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov_sat o2.w, r6.y
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.z, c3, r1
mul r2.xz, r0, c20.y
dp4 r0.y, c1, r1
dp4 r1.z, c2, r1
mul r2.y, r0.y, c9.x
mul r2.w, r2.y, c20.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r0.w, -r0.y
mov r1.xyw, r0.xyzz
add r0.xy, r0.z, r0.xwzw
mul o5.xy, r0, c20.y
mov o0, r1
mov o1.w, c21.x
mov o4.zw, r1
mov o5.zw, r1

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbnaflgpdfndjmepbgmpfjdclodhaddjbabaaaaaafeakaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
haaiaaaaeaaaabaabmacaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaaabaaaaaa
egiacaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaaabaaaaaa
ogikcaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaaabaaaaaa
egiacaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaaabaaaaaa
ogikcaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
enaaaaahpcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaaeaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
aeaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaabbaaaaaiccaabaaaaeaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaaeaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaadaaaaaaigaabaaa
aaaaaaaaigaabaaaaeaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadgcaaaaficcabaaaacaaaaaabkaabaaa
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaaabaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaa
abaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgakbaaaabaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaaibcaabaaaaeaaaaaaegiacaaa
aaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiccaabaaaaeaaaaaaogikcaaa
aaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiecaabaaaaeaaaaaaegiacaaa
aaaaaaaabhaaaaaaegaabaaaadaaaaaaapaaaaaiicaabaaaaeaaaaaaogikcaaa
aaaaaaaabhaaaaaaegaabaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaaenaaaaagaanaaaaa
pcaabaaaacaaaaaaegaobaaaacaaaaaadiaaaaajpcaabaaaadaaaaaaegiocaaa
aaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaaipcaabaaaaeaaaaaa
egaebaaaadaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaaipcaabaaaadaaaaaa
kgapbaaaadaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaafdcaabaaaafaaaaaa
ogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaaadaaaaaadgaaaaaf
mcaabaaaaeaaaaaafganbaaaadaaaaaabbaaaaahicaabaaaabaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaafaaaaaadgaaaaagbcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
dgaaaaagecaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaaifcaabaaa
acaaaaaaagacbaaaacaaaaaaagiacaaaaaaaaaaaagaaaaaadgaaaaafccaabaaa
acaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaa
igiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaacaaaaaaigiicaaaacaaaaaa
amaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
igiicaaaacaaaaaaaoaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaa
diaaaaakdccabaaaafaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_5;
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_7;
  tmpvar_7 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_8;
  tmpvar_8.x = dot (_GDirectionAB.xy, tmpvar_4.xz);
  tmpvar_8.y = dot (_GDirectionAB.zw, tmpvar_4.xz);
  tmpvar_8.z = dot (_GDirectionCD.xy, tmpvar_4.xz);
  tmpvar_8.w = dot (_GDirectionCD.zw, tmpvar_4.xz);
  vec4 tmpvar_9;
  tmpvar_9 = (_GFrequency * tmpvar_8);
  vec4 cse_10;
  cse_10 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_11;
  tmpvar_11 = cos((tmpvar_9 + cse_10));
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_6.xz;
  tmpvar_12.zw = tmpvar_7.xz;
  offsets_5.x = dot (tmpvar_11, tmpvar_12);
  vec4 tmpvar_13;
  tmpvar_13.xy = tmpvar_6.yw;
  tmpvar_13.zw = tmpvar_7.yw;
  offsets_5.z = dot (tmpvar_11, tmpvar_13);
  offsets_5.y = dot (sin((tmpvar_9 + cse_10)), _GAmplitude);
  vec2 xzVtx_14;
  xzVtx_14 = (tmpvar_4.xz + offsets_5.xz);
  vec3 nrml_15;
  nrml_15.y = 2.0;
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_17;
  tmpvar_17 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_18;
  tmpvar_18.x = dot (_GDirectionAB.xy, xzVtx_14);
  tmpvar_18.y = dot (_GDirectionAB.zw, xzVtx_14);
  tmpvar_18.z = dot (_GDirectionCD.xy, xzVtx_14);
  tmpvar_18.w = dot (_GDirectionCD.zw, xzVtx_14);
  vec4 tmpvar_19;
  tmpvar_19 = cos(((_GFrequency * tmpvar_18) + cse_10));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_16.xz;
  tmpvar_20.zw = tmpvar_17.xz;
  nrml_15.x = -(dot (tmpvar_19, tmpvar_20));
  vec4 tmpvar_21;
  tmpvar_21.xy = tmpvar_16.yw;
  tmpvar_21.zw = tmpvar_17.yw;
  nrml_15.z = -(dot (tmpvar_19, tmpvar_21));
  nrml_15.xz = (nrml_15.xz * _GerstnerIntensity);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(nrml_15);
  nrml_15 = tmpvar_22;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_5);
  tmpvar_3.xyz = (tmpvar_4 - _WorldSpaceCameraPos);
  vec4 tmpvar_23;
  tmpvar_23 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 grabPassPos_24;
  vec4 o_25;
  vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_23 * 0.5);
  vec2 tmpvar_27;
  tmpvar_27.x = tmpvar_26.x;
  tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
  o_25.xy = (tmpvar_27 + tmpvar_26.w);
  o_25.zw = tmpvar_23.zw;
  grabPassPos_24.xy = ((tmpvar_23.xy + tmpvar_23.w) * 0.5);
  grabPassPos_24.zw = tmpvar_23.zw;
  tmpvar_2.xyz = tmpvar_22;
  tmpvar_3.w = clamp (offsets_5.y, 0.0, 1.0);
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_23;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_25;
  xlv_TEXCOORD4 = grabPassPos_24;
  xlv_TEXCOORD5 = tmpvar_23.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 baseColor_1;
  vec4 edgeBlendFactors_2;
  vec4 rtRefractions_3;
  vec3 worldNormal_4;
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_5 + normal_6) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_4 = tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.xy = ((tmpvar_7.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD4 + tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_3 = texture2DProj (_RefractionTex, tmpvar_10);
  vec4 tmpvar_12;
  tmpvar_12 = texture2DProj (_ReflectionTex, (xlv_TEXCOORD3 + tmpvar_9));
  float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_10).x) + _ZBufferParams.w)));
  if ((tmpvar_13 < xlv_TEXCOORD3.z)) {
    rtRefractions_3 = tmpvar_11;
  };
  vec4 tmpvar_14;
  tmpvar_14 = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0);
  edgeBlendFactors_2.xzw = tmpvar_14.xzw;
  edgeBlendFactors_2.y = (1.0 - tmpvar_14.y);
  worldNormal_4.xz = (tmpvar_7.xz * _FresnelScale);
  vec4 tmpvar_15;
  tmpvar_15 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_16;
  coords_16 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (rtRefractions_3, tmpvar_15, tmpvar_15.wwww)
  , 
    mix (tmpvar_12, _ReflectionColor, _ReflectionColor.wwww)
  , vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_8)
      , worldNormal_4), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_7, 
      -(normalize((_WorldLightDir.xyz + tmpvar_8)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_16.xy) * texture2D (_ShoreTex, coords_16.zw)) - 0.125)
  .xyz * _Foam.x) * (edgeBlendFactors_2.y + 
    clamp ((xlv_TEXCOORD1.w - _Foam.y), 0.0, 1.0)
  )));
  baseColor_1.w = edgeBlendFactors_2.x;
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, 0.159154937, 0.5, 6.28318548, -3.14159274
def c21, 1, 0.159154937, 0.25, 2
def c22, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.x
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c20.x, c20.y
mad r3, r3, c21.y, c21.z
frc r3, r3
mad r3, r3, c20.z, c20.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c20.z, c20.w
mul r4, r4, r4
mad r5, r4, c22.x, c22.y
mad r5, r4, r5, c22.z
mad r5, r4, r5, c22.w
mad r5, r4, r5, -c20.y
mad r4, r4, r5, c21.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c20.x, c20.y
frc r1, r1
mad r1, r1, c20.z, c20.w
mul r1, r1, r1
mad r4, r1, c22.x, c22.y
mad r4, r1, r4, c22.z
mad r4, r1, r4, c22.w
mad r4, r1, r4, -c20.y
mad r1, r1, r4, c21.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c21.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c22.x, c22.y
mad r1, r3, r1, c22.z
mad r1, r3, r1, c22.w
mad r1, r3, r1, -c20.y
mad r1, r3, r1, c21.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov_sat o2.w, r6.y
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.z, c3, r1
mul r2.xz, r0, c20.y
dp4 r0.y, c1, r1
dp4 r1.z, c2, r1
mul r2.y, r0.y, c9.x
mul r2.w, r2.y, c20.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r0.w, -r0.y
mov r1.xyw, r0.xyzz
add r0.xy, r0.z, r0.xwzw
mul o5.xy, r0, c20.y
mov o0, r1
mov o6.x, r1.z
mov o1.w, c21.x
mov o4.zw, r1
mov o5.zw, r1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddlielamobklhihmfhdnppamaejponlmaabaaaaaaimakaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaabaoaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjaaiaaaaeaaaabaa
ceacaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaadbccabaaaagaaaaaagiaaaaacahaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaa
abaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaa
abaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaa
abaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaa
abaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaenaaaaahpcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaa
diaaaaajpcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaa
beaaaaaadiaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaa
bgaaaaaadiaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaa
bhaaaaaadgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaa
agaaaaaaagaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaa
bbaaaaahecaabaaaaeaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaah
bcaabaaaaeaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaabbaaaaaiccaabaaa
aeaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaaeaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaadaaaaaa
igaabaaaaaaaaaaaigaabaaaaeaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadgcaaaaficcabaaaacaaaaaa
bkaabaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaaabaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agaabaaaabaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgakbaaaabaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaaibcaabaaaaeaaaaaa
egiacaaaaaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiccaabaaaaeaaaaaa
ogikcaaaaaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiecaabaaaaeaaaaaa
egiacaaaaaaaaaaabhaaaaaaegaabaaaadaaaaaaapaaaaaiicaabaaaaeaaaaaa
ogikcaaaaaaaaaaabhaaaaaaegaabaaaadaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaaenaaaaag
aanaaaaapcaabaaaacaaaaaaegaobaaaacaaaaaadiaaaaajpcaabaaaadaaaaaa
egiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaaipcaabaaa
aeaaaaaaegaebaaaadaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaaipcaabaaa
adaaaaaakgapbaaaadaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaafdcaabaaa
afaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaaadaaaaaa
dgaaaaafmcaabaaaaeaaaaaafganbaaaadaaaaaabbaaaaahicaabaaaabaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaadgaaaaagecaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaai
fcaabaaaacaaaaaaagacbaaaacaaaaaaagiacaaaaaaaaaaaagaaaaaadgaaaaaf
ccaabaaaacaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaf
iccabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaipcaabaaaacaaaaaafgafbaaa
abaaaaaaigiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaacaaaaaaigiicaaa
acaaaaaaamaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaaigiicaaaacaaaaaaaoaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaa
egiocaaaaaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaibcaabaaaabaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaa
aeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaafmccabaaaaeaaaaaa
kgaobaaaaaaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaadcaaaaam
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaa
aaaaaaaapgapbaaaaaaaaaaadgaaaaafbccabaaaagaaaaaackaabaaaaaaaaaaa
diaaaaakdccabaaaafaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_5;
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_7;
  tmpvar_7 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_8;
  tmpvar_8.x = dot (_GDirectionAB.xy, tmpvar_4.xz);
  tmpvar_8.y = dot (_GDirectionAB.zw, tmpvar_4.xz);
  tmpvar_8.z = dot (_GDirectionCD.xy, tmpvar_4.xz);
  tmpvar_8.w = dot (_GDirectionCD.zw, tmpvar_4.xz);
  vec4 tmpvar_9;
  tmpvar_9 = (_GFrequency * tmpvar_8);
  vec4 cse_10;
  cse_10 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_11;
  tmpvar_11 = cos((tmpvar_9 + cse_10));
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_6.xz;
  tmpvar_12.zw = tmpvar_7.xz;
  offsets_5.x = dot (tmpvar_11, tmpvar_12);
  vec4 tmpvar_13;
  tmpvar_13.xy = tmpvar_6.yw;
  tmpvar_13.zw = tmpvar_7.yw;
  offsets_5.z = dot (tmpvar_11, tmpvar_13);
  offsets_5.y = dot (sin((tmpvar_9 + cse_10)), _GAmplitude);
  vec2 xzVtx_14;
  xzVtx_14 = (tmpvar_4.xz + offsets_5.xz);
  vec3 nrml_15;
  nrml_15.y = 2.0;
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_17;
  tmpvar_17 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_18;
  tmpvar_18.x = dot (_GDirectionAB.xy, xzVtx_14);
  tmpvar_18.y = dot (_GDirectionAB.zw, xzVtx_14);
  tmpvar_18.z = dot (_GDirectionCD.xy, xzVtx_14);
  tmpvar_18.w = dot (_GDirectionCD.zw, xzVtx_14);
  vec4 tmpvar_19;
  tmpvar_19 = cos(((_GFrequency * tmpvar_18) + cse_10));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_16.xz;
  tmpvar_20.zw = tmpvar_17.xz;
  nrml_15.x = -(dot (tmpvar_19, tmpvar_20));
  vec4 tmpvar_21;
  tmpvar_21.xy = tmpvar_16.yw;
  tmpvar_21.zw = tmpvar_17.yw;
  nrml_15.z = -(dot (tmpvar_19, tmpvar_21));
  nrml_15.xz = (nrml_15.xz * _GerstnerIntensity);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(nrml_15);
  nrml_15 = tmpvar_22;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_5);
  tmpvar_3.xyz = (tmpvar_4 - _WorldSpaceCameraPos);
  vec4 tmpvar_23;
  tmpvar_23 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 grabPassPos_24;
  vec4 o_25;
  vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_23 * 0.5);
  vec2 tmpvar_27;
  tmpvar_27.x = tmpvar_26.x;
  tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
  o_25.xy = (tmpvar_27 + tmpvar_26.w);
  o_25.zw = tmpvar_23.zw;
  grabPassPos_24.xy = ((tmpvar_23.xy + tmpvar_23.w) * 0.5);
  grabPassPos_24.zw = tmpvar_23.zw;
  tmpvar_2.xyz = tmpvar_22;
  tmpvar_3.w = clamp (offsets_5.y, 0.0, 1.0);
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_23;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_25;
  xlv_TEXCOORD4 = grabPassPos_24;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec4 edgeBlendFactors_2;
  vec4 rtRefractions_3;
  vec3 worldNormal_4;
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_5 + normal_6) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_4 = tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.xy = ((tmpvar_7.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD4 + tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_3 = texture2DProj (_RefractionTex, tmpvar_10);
  float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_10).x) + _ZBufferParams.w)));
  if ((tmpvar_12 < xlv_TEXCOORD3.z)) {
    rtRefractions_3 = tmpvar_11;
  };
  vec4 tmpvar_13;
  tmpvar_13 = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0);
  edgeBlendFactors_2.xzw = tmpvar_13.xzw;
  edgeBlendFactors_2.y = (1.0 - tmpvar_13.y);
  worldNormal_4.xz = (tmpvar_7.xz * _FresnelScale);
  vec4 tmpvar_14;
  tmpvar_14 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_15;
  coords_15 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (rtRefractions_3, tmpvar_14, tmpvar_14.wwww)
  , _ReflectionColor, vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_8)
      , worldNormal_4), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_7, 
      -(normalize((_WorldLightDir.xyz + tmpvar_8)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_15.xy) * texture2D (_ShoreTex, coords_15.zw)) - 0.125)
  .xyz * _Foam.x) * (edgeBlendFactors_2.y + 
    clamp ((xlv_TEXCOORD1.w - _Foam.y), 0.0, 1.0)
  )));
  baseColor_1.w = edgeBlendFactors_2.x;
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, 0.159154937, 0.5, 6.28318548, -3.14159274
def c21, 1, 0.159154937, 0.25, 2
def c22, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c20.x, c20.y
mad r3, r3, c21.y, c21.z
frc r3, r3
mad r3, r3, c20.z, c20.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c20.z, c20.w
mul r4, r4, r4
mad r5, r4, c22.x, c22.y
mad r5, r4, r5, c22.z
mad r5, r4, r5, c22.w
mad r5, r4, r5, -c20.y
mad r4, r4, r5, c21.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c20.x, c20.y
frc r1, r1
mad r1, r1, c20.z, c20.w
mul r1, r1, r1
mad r4, r1, c22.x, c22.y
mad r4, r1, r4, c22.z
mad r4, r1, r4, c22.w
mad r4, r1, r4, -c20.y
mad r1, r1, r4, c21.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c21.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c22.x, c22.y
mad r1, r3, r1, c22.z
mad r1, r3, r1, c22.w
mad r1, r3, r1, -c20.y
mad r1, r3, r1, c21.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov_sat o2.w, r6.y
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.z, c3, r1
mul r2.xz, r0, c20.y
dp4 r0.y, c1, r1
dp4 r1.z, c2, r1
mul r2.y, r0.y, c9.x
mul r2.w, r2.y, c20.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r0.w, -r0.y
mov r1.xyw, r0.xyzz
add r0.xy, r0.z, r0.xwzw
mul o5.xy, r0, c20.y
mov o0, r1
mov o1.w, c21.x
mov o4.zw, r1
mov o5.zw, r1

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbnaflgpdfndjmepbgmpfjdclodhaddjbabaaaaaafeakaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
haaiaaaaeaaaabaabmacaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaaabaaaaaa
egiacaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaaabaaaaaa
ogikcaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaaabaaaaaa
egiacaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaaabaaaaaa
ogikcaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
enaaaaahpcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaaeaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
aeaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaabbaaaaaiccaabaaaaeaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaaeaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaadaaaaaaigaabaaa
aaaaaaaaigaabaaaaeaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadgcaaaaficcabaaaacaaaaaabkaabaaa
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaaabaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaa
abaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgakbaaaabaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaaibcaabaaaaeaaaaaaegiacaaa
aaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiccaabaaaaeaaaaaaogikcaaa
aaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiecaabaaaaeaaaaaaegiacaaa
aaaaaaaabhaaaaaaegaabaaaadaaaaaaapaaaaaiicaabaaaaeaaaaaaogikcaaa
aaaaaaaabhaaaaaaegaabaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaaenaaaaagaanaaaaa
pcaabaaaacaaaaaaegaobaaaacaaaaaadiaaaaajpcaabaaaadaaaaaaegiocaaa
aaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaaipcaabaaaaeaaaaaa
egaebaaaadaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaaipcaabaaaadaaaaaa
kgapbaaaadaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaafdcaabaaaafaaaaaa
ogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaaadaaaaaadgaaaaaf
mcaabaaaaeaaaaaafganbaaaadaaaaaabbaaaaahicaabaaaabaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaafaaaaaadgaaaaagbcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
dgaaaaagecaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaaifcaabaaa
acaaaaaaagacbaaaacaaaaaaagiacaaaaaaaaaaaagaaaaaadgaaaaafccaabaaa
acaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaa
igiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaacaaaaaaigiicaaaacaaaaaa
amaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
igiicaaaacaaaaaaaoaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaa
diaaaaakdccabaaaafaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_5;
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_7;
  tmpvar_7 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_8;
  tmpvar_8.x = dot (_GDirectionAB.xy, tmpvar_4.xz);
  tmpvar_8.y = dot (_GDirectionAB.zw, tmpvar_4.xz);
  tmpvar_8.z = dot (_GDirectionCD.xy, tmpvar_4.xz);
  tmpvar_8.w = dot (_GDirectionCD.zw, tmpvar_4.xz);
  vec4 tmpvar_9;
  tmpvar_9 = (_GFrequency * tmpvar_8);
  vec4 cse_10;
  cse_10 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_11;
  tmpvar_11 = cos((tmpvar_9 + cse_10));
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_6.xz;
  tmpvar_12.zw = tmpvar_7.xz;
  offsets_5.x = dot (tmpvar_11, tmpvar_12);
  vec4 tmpvar_13;
  tmpvar_13.xy = tmpvar_6.yw;
  tmpvar_13.zw = tmpvar_7.yw;
  offsets_5.z = dot (tmpvar_11, tmpvar_13);
  offsets_5.y = dot (sin((tmpvar_9 + cse_10)), _GAmplitude);
  vec2 xzVtx_14;
  xzVtx_14 = (tmpvar_4.xz + offsets_5.xz);
  vec3 nrml_15;
  nrml_15.y = 2.0;
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_17;
  tmpvar_17 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_18;
  tmpvar_18.x = dot (_GDirectionAB.xy, xzVtx_14);
  tmpvar_18.y = dot (_GDirectionAB.zw, xzVtx_14);
  tmpvar_18.z = dot (_GDirectionCD.xy, xzVtx_14);
  tmpvar_18.w = dot (_GDirectionCD.zw, xzVtx_14);
  vec4 tmpvar_19;
  tmpvar_19 = cos(((_GFrequency * tmpvar_18) + cse_10));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_16.xz;
  tmpvar_20.zw = tmpvar_17.xz;
  nrml_15.x = -(dot (tmpvar_19, tmpvar_20));
  vec4 tmpvar_21;
  tmpvar_21.xy = tmpvar_16.yw;
  tmpvar_21.zw = tmpvar_17.yw;
  nrml_15.z = -(dot (tmpvar_19, tmpvar_21));
  nrml_15.xz = (nrml_15.xz * _GerstnerIntensity);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(nrml_15);
  nrml_15 = tmpvar_22;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_5);
  tmpvar_3.xyz = (tmpvar_4 - _WorldSpaceCameraPos);
  vec4 tmpvar_23;
  tmpvar_23 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 grabPassPos_24;
  vec4 o_25;
  vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_23 * 0.5);
  vec2 tmpvar_27;
  tmpvar_27.x = tmpvar_26.x;
  tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
  o_25.xy = (tmpvar_27 + tmpvar_26.w);
  o_25.zw = tmpvar_23.zw;
  grabPassPos_24.xy = ((tmpvar_23.xy + tmpvar_23.w) * 0.5);
  grabPassPos_24.zw = tmpvar_23.zw;
  tmpvar_2.xyz = tmpvar_22;
  tmpvar_3.w = clamp (offsets_5.y, 0.0, 1.0);
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_23;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_25;
  xlv_TEXCOORD4 = grabPassPos_24;
  xlv_TEXCOORD5 = tmpvar_23.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 baseColor_1;
  vec4 edgeBlendFactors_2;
  vec4 rtRefractions_3;
  vec3 worldNormal_4;
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_5 + normal_6) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_4 = tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.xy = ((tmpvar_7.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD4 + tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_3 = texture2DProj (_RefractionTex, tmpvar_10);
  float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_10).x) + _ZBufferParams.w)));
  if ((tmpvar_12 < xlv_TEXCOORD3.z)) {
    rtRefractions_3 = tmpvar_11;
  };
  vec4 tmpvar_13;
  tmpvar_13 = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0);
  edgeBlendFactors_2.xzw = tmpvar_13.xzw;
  edgeBlendFactors_2.y = (1.0 - tmpvar_13.y);
  worldNormal_4.xz = (tmpvar_7.xz * _FresnelScale);
  vec4 tmpvar_14;
  tmpvar_14 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_15;
  coords_15 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (rtRefractions_3, tmpvar_14, tmpvar_14.wwww)
  , _ReflectionColor, vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_8)
      , worldNormal_4), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_7, 
      -(normalize((_WorldLightDir.xyz + tmpvar_8)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_15.xy) * texture2D (_ShoreTex, coords_15.zw)) - 0.125)
  .xyz * _Foam.x) * (edgeBlendFactors_2.y + 
    clamp ((xlv_TEXCOORD1.w - _Foam.y), 0.0, 1.0)
  )));
  baseColor_1.w = edgeBlendFactors_2.x;
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, 0.159154937, 0.5, 6.28318548, -3.14159274
def c21, 1, 0.159154937, 0.25, 2
def c22, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.x
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c20.x, c20.y
mad r3, r3, c21.y, c21.z
frc r3, r3
mad r3, r3, c20.z, c20.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c20.z, c20.w
mul r4, r4, r4
mad r5, r4, c22.x, c22.y
mad r5, r4, r5, c22.z
mad r5, r4, r5, c22.w
mad r5, r4, r5, -c20.y
mad r4, r4, r5, c21.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c20.x, c20.y
frc r1, r1
mad r1, r1, c20.z, c20.w
mul r1, r1, r1
mad r4, r1, c22.x, c22.y
mad r4, r1, r4, c22.z
mad r4, r1, r4, c22.w
mad r4, r1, r4, -c20.y
mad r1, r1, r4, c21.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c21.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c22.x, c22.y
mad r1, r3, r1, c22.z
mad r1, r3, r1, c22.w
mad r1, r3, r1, -c20.y
mad r1, r3, r1, c21.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov_sat o2.w, r6.y
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.z, c3, r1
mul r2.xz, r0, c20.y
dp4 r0.y, c1, r1
dp4 r1.z, c2, r1
mul r2.y, r0.y, c9.x
mul r2.w, r2.y, c20.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r0.w, -r0.y
mov r1.xyw, r0.xyzz
add r0.xy, r0.z, r0.xwzw
mul o5.xy, r0, c20.y
mov o0, r1
mov o6.x, r1.z
mov o1.w, c21.x
mov o4.zw, r1
mov o5.zw, r1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddlielamobklhihmfhdnppamaejponlmaabaaaaaaimakaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaabaoaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjaaiaaaaeaaaabaa
ceacaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaadbccabaaaagaaaaaagiaaaaacahaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaa
abaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaa
abaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaa
abaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaa
abaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaenaaaaahpcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaa
diaaaaajpcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaa
beaaaaaadiaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaa
bgaaaaaadiaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaa
bhaaaaaadgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaa
agaaaaaaagaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaa
bbaaaaahecaabaaaaeaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaah
bcaabaaaaeaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaabbaaaaaiccaabaaa
aeaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaaeaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaadaaaaaa
igaabaaaaaaaaaaaigaabaaaaeaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadgcaaaaficcabaaaacaaaaaa
bkaabaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaaabaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agaabaaaabaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgakbaaaabaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaaibcaabaaaaeaaaaaa
egiacaaaaaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiccaabaaaaeaaaaaa
ogikcaaaaaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiecaabaaaaeaaaaaa
egiacaaaaaaaaaaabhaaaaaaegaabaaaadaaaaaaapaaaaaiicaabaaaaeaaaaaa
ogikcaaaaaaaaaaabhaaaaaaegaabaaaadaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaaenaaaaag
aanaaaaapcaabaaaacaaaaaaegaobaaaacaaaaaadiaaaaajpcaabaaaadaaaaaa
egiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaaipcaabaaa
aeaaaaaaegaebaaaadaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaaipcaabaaa
adaaaaaakgapbaaaadaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaafdcaabaaa
afaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaaadaaaaaa
dgaaaaafmcaabaaaaeaaaaaafganbaaaadaaaaaabbaaaaahicaabaaaabaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaadgaaaaagecaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaai
fcaabaaaacaaaaaaagacbaaaacaaaaaaagiacaaaaaaaaaaaagaaaaaadgaaaaaf
ccaabaaaacaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaf
iccabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaipcaabaaaacaaaaaafgafbaaa
abaaaaaaigiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaacaaaaaaigiicaaa
acaaaaaaamaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaaigiicaaaacaaaaaaaoaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaa
egiocaaaaaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaibcaabaaaabaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaa
aeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaafmccabaaaaeaaaaaa
kgaobaaaaaaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaadcaaaaam
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaa
aaaaaaaapgapbaaaaaaaaaaadgaaaaafbccabaaaagaaaaaackaabaaaaaaaaaaa
diaaaaakdccabaaaafaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_5;
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_7;
  tmpvar_7 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_8;
  tmpvar_8.x = dot (_GDirectionAB.xy, tmpvar_4.xz);
  tmpvar_8.y = dot (_GDirectionAB.zw, tmpvar_4.xz);
  tmpvar_8.z = dot (_GDirectionCD.xy, tmpvar_4.xz);
  tmpvar_8.w = dot (_GDirectionCD.zw, tmpvar_4.xz);
  vec4 tmpvar_9;
  tmpvar_9 = (_GFrequency * tmpvar_8);
  vec4 cse_10;
  cse_10 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_11;
  tmpvar_11 = cos((tmpvar_9 + cse_10));
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_6.xz;
  tmpvar_12.zw = tmpvar_7.xz;
  offsets_5.x = dot (tmpvar_11, tmpvar_12);
  vec4 tmpvar_13;
  tmpvar_13.xy = tmpvar_6.yw;
  tmpvar_13.zw = tmpvar_7.yw;
  offsets_5.z = dot (tmpvar_11, tmpvar_13);
  offsets_5.y = dot (sin((tmpvar_9 + cse_10)), _GAmplitude);
  vec2 xzVtx_14;
  xzVtx_14 = (tmpvar_4.xz + offsets_5.xz);
  vec3 nrml_15;
  nrml_15.y = 2.0;
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_17;
  tmpvar_17 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_18;
  tmpvar_18.x = dot (_GDirectionAB.xy, xzVtx_14);
  tmpvar_18.y = dot (_GDirectionAB.zw, xzVtx_14);
  tmpvar_18.z = dot (_GDirectionCD.xy, xzVtx_14);
  tmpvar_18.w = dot (_GDirectionCD.zw, xzVtx_14);
  vec4 tmpvar_19;
  tmpvar_19 = cos(((_GFrequency * tmpvar_18) + cse_10));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_16.xz;
  tmpvar_20.zw = tmpvar_17.xz;
  nrml_15.x = -(dot (tmpvar_19, tmpvar_20));
  vec4 tmpvar_21;
  tmpvar_21.xy = tmpvar_16.yw;
  tmpvar_21.zw = tmpvar_17.yw;
  nrml_15.z = -(dot (tmpvar_19, tmpvar_21));
  nrml_15.xz = (nrml_15.xz * _GerstnerIntensity);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(nrml_15);
  nrml_15 = tmpvar_22;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_5);
  tmpvar_3.xyz = (tmpvar_4 - _WorldSpaceCameraPos);
  vec4 tmpvar_23;
  tmpvar_23 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 grabPassPos_24;
  vec4 o_25;
  vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_23 * 0.5);
  vec2 tmpvar_27;
  tmpvar_27.x = tmpvar_26.x;
  tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
  o_25.xy = (tmpvar_27 + tmpvar_26.w);
  o_25.zw = tmpvar_23.zw;
  grabPassPos_24.xy = ((tmpvar_23.xy + tmpvar_23.w) * 0.5);
  grabPassPos_24.zw = tmpvar_23.zw;
  tmpvar_2.xyz = tmpvar_22;
  tmpvar_3.w = clamp (offsets_5.y, 0.0, 1.0);
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_23;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_25;
  xlv_TEXCOORD4 = grabPassPos_24;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  vec4 tmpvar_8;
  tmpvar_8 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_9;
  coords_9 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (texture2DProj (_RefractionTex, (xlv_TEXCOORD4 + tmpvar_7)), tmpvar_8, tmpvar_8.wwww)
  , 
    mix (texture2DProj (_ReflectionTex, (xlv_TEXCOORD3 + tmpvar_7)), _ReflectionColor, _ReflectionColor.wwww)
  , vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_6)
      , worldNormal_2), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_5, 
      -(normalize((_WorldLightDir.xyz + tmpvar_6)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_9.xy) * texture2D (_ShoreTex, coords_9.zw)) - 0.125)
  .xyz * _Foam.x) * clamp (
    (xlv_TEXCOORD1.w - _Foam.y)
  , 0.0, 1.0)));
  baseColor_1.w = 1.0;
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, 0.159154937, 0.5, 6.28318548, -3.14159274
def c21, 1, 0.159154937, 0.25, 2
def c22, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c20.x, c20.y
mad r3, r3, c21.y, c21.z
frc r3, r3
mad r3, r3, c20.z, c20.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c20.z, c20.w
mul r4, r4, r4
mad r5, r4, c22.x, c22.y
mad r5, r4, r5, c22.z
mad r5, r4, r5, c22.w
mad r5, r4, r5, -c20.y
mad r4, r4, r5, c21.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c20.x, c20.y
frc r1, r1
mad r1, r1, c20.z, c20.w
mul r1, r1, r1
mad r4, r1, c22.x, c22.y
mad r4, r1, r4, c22.z
mad r4, r1, r4, c22.w
mad r4, r1, r4, -c20.y
mad r1, r1, r4, c21.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c21.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c22.x, c22.y
mad r1, r3, r1, c22.z
mad r1, r3, r1, c22.w
mad r1, r3, r1, -c20.y
mad r1, r3, r1, c21.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov_sat o2.w, r6.y
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.z, c3, r1
mul r2.xz, r0, c20.y
dp4 r0.y, c1, r1
dp4 r1.z, c2, r1
mul r2.y, r0.y, c9.x
mul r2.w, r2.y, c20.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r0.w, -r0.y
mov r1.xyw, r0.xyzz
add r0.xy, r0.z, r0.xwzw
mul o5.xy, r0, c20.y
mov o0, r1
mov o1.w, c21.x
mov o4.zw, r1
mov o5.zw, r1

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbnaflgpdfndjmepbgmpfjdclodhaddjbabaaaaaafeakaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
haaiaaaaeaaaabaabmacaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaaabaaaaaa
egiacaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaaabaaaaaa
ogikcaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaaabaaaaaa
egiacaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaaabaaaaaa
ogikcaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
enaaaaahpcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaaeaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
aeaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaabbaaaaaiccaabaaaaeaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaaeaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaadaaaaaaigaabaaa
aaaaaaaaigaabaaaaeaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadgcaaaaficcabaaaacaaaaaabkaabaaa
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaaabaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaa
abaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgakbaaaabaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaaibcaabaaaaeaaaaaaegiacaaa
aaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiccaabaaaaeaaaaaaogikcaaa
aaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiecaabaaaaeaaaaaaegiacaaa
aaaaaaaabhaaaaaaegaabaaaadaaaaaaapaaaaaiicaabaaaaeaaaaaaogikcaaa
aaaaaaaabhaaaaaaegaabaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaaenaaaaagaanaaaaa
pcaabaaaacaaaaaaegaobaaaacaaaaaadiaaaaajpcaabaaaadaaaaaaegiocaaa
aaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaaipcaabaaaaeaaaaaa
egaebaaaadaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaaipcaabaaaadaaaaaa
kgapbaaaadaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaafdcaabaaaafaaaaaa
ogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaaadaaaaaadgaaaaaf
mcaabaaaaeaaaaaafganbaaaadaaaaaabbaaaaahicaabaaaabaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaafaaaaaadgaaaaagbcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
dgaaaaagecaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaaifcaabaaa
acaaaaaaagacbaaaacaaaaaaagiacaaaaaaaaaaaagaaaaaadgaaaaafccaabaaa
acaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaa
igiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaacaaaaaaigiicaaaacaaaaaa
amaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
igiicaaaacaaaaaaaoaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaa
diaaaaakdccabaaaafaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_5;
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_7;
  tmpvar_7 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_8;
  tmpvar_8.x = dot (_GDirectionAB.xy, tmpvar_4.xz);
  tmpvar_8.y = dot (_GDirectionAB.zw, tmpvar_4.xz);
  tmpvar_8.z = dot (_GDirectionCD.xy, tmpvar_4.xz);
  tmpvar_8.w = dot (_GDirectionCD.zw, tmpvar_4.xz);
  vec4 tmpvar_9;
  tmpvar_9 = (_GFrequency * tmpvar_8);
  vec4 cse_10;
  cse_10 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_11;
  tmpvar_11 = cos((tmpvar_9 + cse_10));
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_6.xz;
  tmpvar_12.zw = tmpvar_7.xz;
  offsets_5.x = dot (tmpvar_11, tmpvar_12);
  vec4 tmpvar_13;
  tmpvar_13.xy = tmpvar_6.yw;
  tmpvar_13.zw = tmpvar_7.yw;
  offsets_5.z = dot (tmpvar_11, tmpvar_13);
  offsets_5.y = dot (sin((tmpvar_9 + cse_10)), _GAmplitude);
  vec2 xzVtx_14;
  xzVtx_14 = (tmpvar_4.xz + offsets_5.xz);
  vec3 nrml_15;
  nrml_15.y = 2.0;
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_17;
  tmpvar_17 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_18;
  tmpvar_18.x = dot (_GDirectionAB.xy, xzVtx_14);
  tmpvar_18.y = dot (_GDirectionAB.zw, xzVtx_14);
  tmpvar_18.z = dot (_GDirectionCD.xy, xzVtx_14);
  tmpvar_18.w = dot (_GDirectionCD.zw, xzVtx_14);
  vec4 tmpvar_19;
  tmpvar_19 = cos(((_GFrequency * tmpvar_18) + cse_10));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_16.xz;
  tmpvar_20.zw = tmpvar_17.xz;
  nrml_15.x = -(dot (tmpvar_19, tmpvar_20));
  vec4 tmpvar_21;
  tmpvar_21.xy = tmpvar_16.yw;
  tmpvar_21.zw = tmpvar_17.yw;
  nrml_15.z = -(dot (tmpvar_19, tmpvar_21));
  nrml_15.xz = (nrml_15.xz * _GerstnerIntensity);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(nrml_15);
  nrml_15 = tmpvar_22;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_5);
  tmpvar_3.xyz = (tmpvar_4 - _WorldSpaceCameraPos);
  vec4 tmpvar_23;
  tmpvar_23 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 grabPassPos_24;
  vec4 o_25;
  vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_23 * 0.5);
  vec2 tmpvar_27;
  tmpvar_27.x = tmpvar_26.x;
  tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
  o_25.xy = (tmpvar_27 + tmpvar_26.w);
  o_25.zw = tmpvar_23.zw;
  grabPassPos_24.xy = ((tmpvar_23.xy + tmpvar_23.w) * 0.5);
  grabPassPos_24.zw = tmpvar_23.zw;
  tmpvar_2.xyz = tmpvar_22;
  tmpvar_3.w = clamp (offsets_5.y, 0.0, 1.0);
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_23;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_25;
  xlv_TEXCOORD4 = grabPassPos_24;
  xlv_TEXCOORD5 = tmpvar_23.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  vec4 tmpvar_8;
  tmpvar_8 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_9;
  coords_9 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (texture2DProj (_RefractionTex, (xlv_TEXCOORD4 + tmpvar_7)), tmpvar_8, tmpvar_8.wwww)
  , 
    mix (texture2DProj (_ReflectionTex, (xlv_TEXCOORD3 + tmpvar_7)), _ReflectionColor, _ReflectionColor.wwww)
  , vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_6)
      , worldNormal_2), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_5, 
      -(normalize((_WorldLightDir.xyz + tmpvar_6)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_9.xy) * texture2D (_ShoreTex, coords_9.zw)) - 0.125)
  .xyz * _Foam.x) * clamp (
    (xlv_TEXCOORD1.w - _Foam.y)
  , 0.0, 1.0)));
  baseColor_1.w = 1.0;
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, 0.159154937, 0.5, 6.28318548, -3.14159274
def c21, 1, 0.159154937, 0.25, 2
def c22, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.x
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c20.x, c20.y
mad r3, r3, c21.y, c21.z
frc r3, r3
mad r3, r3, c20.z, c20.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c20.z, c20.w
mul r4, r4, r4
mad r5, r4, c22.x, c22.y
mad r5, r4, r5, c22.z
mad r5, r4, r5, c22.w
mad r5, r4, r5, -c20.y
mad r4, r4, r5, c21.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c20.x, c20.y
frc r1, r1
mad r1, r1, c20.z, c20.w
mul r1, r1, r1
mad r4, r1, c22.x, c22.y
mad r4, r1, r4, c22.z
mad r4, r1, r4, c22.w
mad r4, r1, r4, -c20.y
mad r1, r1, r4, c21.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c21.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c22.x, c22.y
mad r1, r3, r1, c22.z
mad r1, r3, r1, c22.w
mad r1, r3, r1, -c20.y
mad r1, r3, r1, c21.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov_sat o2.w, r6.y
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.z, c3, r1
mul r2.xz, r0, c20.y
dp4 r0.y, c1, r1
dp4 r1.z, c2, r1
mul r2.y, r0.y, c9.x
mul r2.w, r2.y, c20.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r0.w, -r0.y
mov r1.xyw, r0.xyzz
add r0.xy, r0.z, r0.xwzw
mul o5.xy, r0, c20.y
mov o0, r1
mov o6.x, r1.z
mov o1.w, c21.x
mov o4.zw, r1
mov o5.zw, r1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddlielamobklhihmfhdnppamaejponlmaabaaaaaaimakaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaabaoaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjaaiaaaaeaaaabaa
ceacaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaadbccabaaaagaaaaaagiaaaaacahaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaa
abaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaa
abaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaa
abaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaa
abaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaenaaaaahpcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaa
diaaaaajpcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaa
beaaaaaadiaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaa
bgaaaaaadiaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaa
bhaaaaaadgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaa
agaaaaaaagaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaa
bbaaaaahecaabaaaaeaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaah
bcaabaaaaeaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaabbaaaaaiccaabaaa
aeaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaaeaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaadaaaaaa
igaabaaaaaaaaaaaigaabaaaaeaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadgcaaaaficcabaaaacaaaaaa
bkaabaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaaabaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agaabaaaabaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgakbaaaabaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaaibcaabaaaaeaaaaaa
egiacaaaaaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiccaabaaaaeaaaaaa
ogikcaaaaaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiecaabaaaaeaaaaaa
egiacaaaaaaaaaaabhaaaaaaegaabaaaadaaaaaaapaaaaaiicaabaaaaeaaaaaa
ogikcaaaaaaaaaaabhaaaaaaegaabaaaadaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaaenaaaaag
aanaaaaapcaabaaaacaaaaaaegaobaaaacaaaaaadiaaaaajpcaabaaaadaaaaaa
egiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaaipcaabaaa
aeaaaaaaegaebaaaadaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaaipcaabaaa
adaaaaaakgapbaaaadaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaafdcaabaaa
afaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaaadaaaaaa
dgaaaaafmcaabaaaaeaaaaaafganbaaaadaaaaaabbaaaaahicaabaaaabaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaadgaaaaagecaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaai
fcaabaaaacaaaaaaagacbaaaacaaaaaaagiacaaaaaaaaaaaagaaaaaadgaaaaaf
ccaabaaaacaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaf
iccabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaipcaabaaaacaaaaaafgafbaaa
abaaaaaaigiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaacaaaaaaigiicaaa
acaaaaaaamaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaaigiicaaaacaaaaaaaoaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaa
egiocaaaaaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaibcaabaaaabaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaa
aeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaafmccabaaaaeaaaaaa
kgaobaaaaaaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaadcaaaaam
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaa
aaaaaaaapgapbaaaaaaaaaaadgaaaaafbccabaaaagaaaaaackaabaaaaaaaaaaa
diaaaaakdccabaaaafaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_5;
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_7;
  tmpvar_7 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_8;
  tmpvar_8.x = dot (_GDirectionAB.xy, tmpvar_4.xz);
  tmpvar_8.y = dot (_GDirectionAB.zw, tmpvar_4.xz);
  tmpvar_8.z = dot (_GDirectionCD.xy, tmpvar_4.xz);
  tmpvar_8.w = dot (_GDirectionCD.zw, tmpvar_4.xz);
  vec4 tmpvar_9;
  tmpvar_9 = (_GFrequency * tmpvar_8);
  vec4 cse_10;
  cse_10 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_11;
  tmpvar_11 = cos((tmpvar_9 + cse_10));
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_6.xz;
  tmpvar_12.zw = tmpvar_7.xz;
  offsets_5.x = dot (tmpvar_11, tmpvar_12);
  vec4 tmpvar_13;
  tmpvar_13.xy = tmpvar_6.yw;
  tmpvar_13.zw = tmpvar_7.yw;
  offsets_5.z = dot (tmpvar_11, tmpvar_13);
  offsets_5.y = dot (sin((tmpvar_9 + cse_10)), _GAmplitude);
  vec2 xzVtx_14;
  xzVtx_14 = (tmpvar_4.xz + offsets_5.xz);
  vec3 nrml_15;
  nrml_15.y = 2.0;
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_17;
  tmpvar_17 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_18;
  tmpvar_18.x = dot (_GDirectionAB.xy, xzVtx_14);
  tmpvar_18.y = dot (_GDirectionAB.zw, xzVtx_14);
  tmpvar_18.z = dot (_GDirectionCD.xy, xzVtx_14);
  tmpvar_18.w = dot (_GDirectionCD.zw, xzVtx_14);
  vec4 tmpvar_19;
  tmpvar_19 = cos(((_GFrequency * tmpvar_18) + cse_10));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_16.xz;
  tmpvar_20.zw = tmpvar_17.xz;
  nrml_15.x = -(dot (tmpvar_19, tmpvar_20));
  vec4 tmpvar_21;
  tmpvar_21.xy = tmpvar_16.yw;
  tmpvar_21.zw = tmpvar_17.yw;
  nrml_15.z = -(dot (tmpvar_19, tmpvar_21));
  nrml_15.xz = (nrml_15.xz * _GerstnerIntensity);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(nrml_15);
  nrml_15 = tmpvar_22;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_5);
  tmpvar_3.xyz = (tmpvar_4 - _WorldSpaceCameraPos);
  vec4 tmpvar_23;
  tmpvar_23 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 grabPassPos_24;
  vec4 o_25;
  vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_23 * 0.5);
  vec2 tmpvar_27;
  tmpvar_27.x = tmpvar_26.x;
  tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
  o_25.xy = (tmpvar_27 + tmpvar_26.w);
  o_25.zw = tmpvar_23.zw;
  grabPassPos_24.xy = ((tmpvar_23.xy + tmpvar_23.w) * 0.5);
  grabPassPos_24.zw = tmpvar_23.zw;
  tmpvar_2.xyz = tmpvar_22;
  tmpvar_3.w = clamp (offsets_5.y, 0.0, 1.0);
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_23;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_25;
  xlv_TEXCOORD4 = grabPassPos_24;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  vec4 tmpvar_8;
  tmpvar_8 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_9;
  coords_9 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (texture2DProj (_RefractionTex, (xlv_TEXCOORD4 + tmpvar_7)), tmpvar_8, tmpvar_8.wwww)
  , _ReflectionColor, vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_6)
      , worldNormal_2), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_5, 
      -(normalize((_WorldLightDir.xyz + tmpvar_6)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_9.xy) * texture2D (_ShoreTex, coords_9.zw)) - 0.125)
  .xyz * _Foam.x) * clamp (
    (xlv_TEXCOORD1.w - _Foam.y)
  , 0.0, 1.0)));
  baseColor_1.w = 1.0;
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, 0.159154937, 0.5, 6.28318548, -3.14159274
def c21, 1, 0.159154937, 0.25, 2
def c22, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c20.x, c20.y
mad r3, r3, c21.y, c21.z
frc r3, r3
mad r3, r3, c20.z, c20.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c20.z, c20.w
mul r4, r4, r4
mad r5, r4, c22.x, c22.y
mad r5, r4, r5, c22.z
mad r5, r4, r5, c22.w
mad r5, r4, r5, -c20.y
mad r4, r4, r5, c21.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c20.x, c20.y
frc r1, r1
mad r1, r1, c20.z, c20.w
mul r1, r1, r1
mad r4, r1, c22.x, c22.y
mad r4, r1, r4, c22.z
mad r4, r1, r4, c22.w
mad r4, r1, r4, -c20.y
mad r1, r1, r4, c21.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c21.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c22.x, c22.y
mad r1, r3, r1, c22.z
mad r1, r3, r1, c22.w
mad r1, r3, r1, -c20.y
mad r1, r3, r1, c21.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov_sat o2.w, r6.y
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.z, c3, r1
mul r2.xz, r0, c20.y
dp4 r0.y, c1, r1
dp4 r1.z, c2, r1
mul r2.y, r0.y, c9.x
mul r2.w, r2.y, c20.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r0.w, -r0.y
mov r1.xyw, r0.xyzz
add r0.xy, r0.z, r0.xwzw
mul o5.xy, r0, c20.y
mov o0, r1
mov o1.w, c21.x
mov o4.zw, r1
mov o5.zw, r1

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedbnaflgpdfndjmepbgmpfjdclodhaddjbabaaaaaafeakaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
haaiaaaaeaaaabaabmacaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaaabaaaaaa
egiacaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaaabaaaaaa
ogikcaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaaabaaaaaa
egiacaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaaabaaaaaa
ogikcaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
enaaaaahpcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaaeaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
aeaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaabbaaaaaiccaabaaaaeaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaaeaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaadaaaaaaigaabaaa
aaaaaaaaigaabaaaaeaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadgcaaaaficcabaaaacaaaaaabkaabaaa
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaaabaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaa
abaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgakbaaaabaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaaibcaabaaaaeaaaaaaegiacaaa
aaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiccaabaaaaeaaaaaaogikcaaa
aaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiecaabaaaaeaaaaaaegiacaaa
aaaaaaaabhaaaaaaegaabaaaadaaaaaaapaaaaaiicaabaaaaeaaaaaaogikcaaa
aaaaaaaabhaaaaaaegaabaaaadaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaaenaaaaagaanaaaaa
pcaabaaaacaaaaaaegaobaaaacaaaaaadiaaaaajpcaabaaaadaaaaaaegiocaaa
aaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaaipcaabaaaaeaaaaaa
egaebaaaadaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaaipcaabaaaadaaaaaa
kgapbaaaadaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaafdcaabaaaafaaaaaa
ogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaaadaaaaaadgaaaaaf
mcaabaaaaeaaaaaafganbaaaadaaaaaabbaaaaahicaabaaaabaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaafaaaaaadgaaaaagbcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
dgaaaaagecaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaaifcaabaaa
acaaaaaaagacbaaaacaaaaaaagiacaaaaaaaaaaaagaaaaaadgaaaaafccaabaaa
acaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaaipcaabaaaacaaaaaafgafbaaaabaaaaaa
igiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaacaaaaaaigiicaaaacaaaaaa
amaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaabaaaaaa
igiicaaaacaaaaaaaoaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaa
diaaaaakdccabaaaafaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  vec3 tmpvar_4;
  tmpvar_4 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_5;
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_7;
  tmpvar_7 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_8;
  tmpvar_8.x = dot (_GDirectionAB.xy, tmpvar_4.xz);
  tmpvar_8.y = dot (_GDirectionAB.zw, tmpvar_4.xz);
  tmpvar_8.z = dot (_GDirectionCD.xy, tmpvar_4.xz);
  tmpvar_8.w = dot (_GDirectionCD.zw, tmpvar_4.xz);
  vec4 tmpvar_9;
  tmpvar_9 = (_GFrequency * tmpvar_8);
  vec4 cse_10;
  cse_10 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_11;
  tmpvar_11 = cos((tmpvar_9 + cse_10));
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_6.xz;
  tmpvar_12.zw = tmpvar_7.xz;
  offsets_5.x = dot (tmpvar_11, tmpvar_12);
  vec4 tmpvar_13;
  tmpvar_13.xy = tmpvar_6.yw;
  tmpvar_13.zw = tmpvar_7.yw;
  offsets_5.z = dot (tmpvar_11, tmpvar_13);
  offsets_5.y = dot (sin((tmpvar_9 + cse_10)), _GAmplitude);
  vec2 xzVtx_14;
  xzVtx_14 = (tmpvar_4.xz + offsets_5.xz);
  vec3 nrml_15;
  nrml_15.y = 2.0;
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_17;
  tmpvar_17 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_18;
  tmpvar_18.x = dot (_GDirectionAB.xy, xzVtx_14);
  tmpvar_18.y = dot (_GDirectionAB.zw, xzVtx_14);
  tmpvar_18.z = dot (_GDirectionCD.xy, xzVtx_14);
  tmpvar_18.w = dot (_GDirectionCD.zw, xzVtx_14);
  vec4 tmpvar_19;
  tmpvar_19 = cos(((_GFrequency * tmpvar_18) + cse_10));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_16.xz;
  tmpvar_20.zw = tmpvar_17.xz;
  nrml_15.x = -(dot (tmpvar_19, tmpvar_20));
  vec4 tmpvar_21;
  tmpvar_21.xy = tmpvar_16.yw;
  tmpvar_21.zw = tmpvar_17.yw;
  nrml_15.z = -(dot (tmpvar_19, tmpvar_21));
  nrml_15.xz = (nrml_15.xz * _GerstnerIntensity);
  vec3 tmpvar_22;
  tmpvar_22 = normalize(nrml_15);
  nrml_15 = tmpvar_22;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_5);
  tmpvar_3.xyz = (tmpvar_4 - _WorldSpaceCameraPos);
  vec4 tmpvar_23;
  tmpvar_23 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 grabPassPos_24;
  vec4 o_25;
  vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_23 * 0.5);
  vec2 tmpvar_27;
  tmpvar_27.x = tmpvar_26.x;
  tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
  o_25.xy = (tmpvar_27 + tmpvar_26.w);
  o_25.zw = tmpvar_23.zw;
  grabPassPos_24.xy = ((tmpvar_23.xy + tmpvar_23.w) * 0.5);
  grabPassPos_24.zw = tmpvar_23.zw;
  tmpvar_2.xyz = tmpvar_22;
  tmpvar_3.w = clamp (offsets_5.y, 0.0, 1.0);
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_23;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_25;
  xlv_TEXCOORD4 = grabPassPos_24;
  xlv_TEXCOORD5 = tmpvar_23.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  vec4 tmpvar_8;
  tmpvar_8 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_9;
  coords_9 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (texture2DProj (_RefractionTex, (xlv_TEXCOORD4 + tmpvar_7)), tmpvar_8, tmpvar_8.wwww)
  , _ReflectionColor, vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_6)
      , worldNormal_2), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_5, 
      -(normalize((_WorldLightDir.xyz + tmpvar_6)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_9.xy) * texture2D (_ShoreTex, coords_9.zw)) - 0.125)
  .xyz * _Foam.x) * clamp (
    (xlv_TEXCOORD1.w - _Foam.y)
  , 0.0, 1.0)));
  baseColor_1.w = 1.0;
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, 0.159154937, 0.5, 6.28318548, -3.14159274
def c21, 1, 0.159154937, 0.25, 2
def c22, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.x
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c20.x, c20.y
mad r3, r3, c21.y, c21.z
frc r3, r3
mad r3, r3, c20.z, c20.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c20.z, c20.w
mul r4, r4, r4
mad r5, r4, c22.x, c22.y
mad r5, r4, r5, c22.z
mad r5, r4, r5, c22.w
mad r5, r4, r5, -c20.y
mad r4, r4, r5, c21.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c20.x, c20.y
frc r1, r1
mad r1, r1, c20.z, c20.w
mul r1, r1, r1
mad r4, r1, c22.x, c22.y
mad r4, r1, r4, c22.z
mad r4, r1, r4, c22.w
mad r4, r1, r4, -c20.y
mad r1, r1, r4, c21.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c21.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c22.x, c22.y
mad r1, r3, r1, c22.z
mad r1, r3, r1, c22.w
mad r1, r3, r1, -c20.y
mad r1, r3, r1, c21.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov_sat o2.w, r6.y
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.z, c3, r1
mul r2.xz, r0, c20.y
dp4 r0.y, c1, r1
dp4 r1.z, c2, r1
mul r2.y, r0.y, c9.x
mul r2.w, r2.y, c20.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r0.w, -r0.y
mov r1.xyw, r0.xyzz
add r0.xy, r0.z, r0.xwzw
mul o5.xy, r0, c20.y
mov o0, r1
mov o6.x, r1.z
mov o1.w, c21.x
mov o4.zw, r1
mov o5.zw, r1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddlielamobklhihmfhdnppamaejponlmaabaaaaaaimakaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaabaoaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjaaiaaaaeaaaabaa
ceacaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaadbccabaaaagaaaaaagiaaaaacahaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaa
abaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaa
abaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaa
abaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaa
abaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaaenaaaaahpcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaa
diaaaaajpcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaa
beaaaaaadiaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaa
bgaaaaaadiaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaa
bhaaaaaadgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaa
agaaaaaaagaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaa
bbaaaaahecaabaaaaeaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaah
bcaabaaaaeaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaabbaaaaaiccaabaaa
aeaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaaeaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaadaaaaaa
igaabaaaaaaaaaaaigaabaaaaeaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadgcaaaaficcabaaaacaaaaaa
bkaabaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaaabaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agaabaaaabaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgakbaaaabaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaaibcaabaaaaeaaaaaa
egiacaaaaaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiccaabaaaaeaaaaaa
ogikcaaaaaaaaaaabgaaaaaaegaabaaaadaaaaaaapaaaaaiecaabaaaaeaaaaaa
egiacaaaaaaaaaaabhaaaaaaegaabaaaadaaaaaaapaaaaaiicaabaaaaeaaaaaa
ogikcaaaaaaaaaaabhaaaaaaegaabaaaadaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaaenaaaaag
aanaaaaapcaabaaaacaaaaaaegaobaaaacaaaaaadiaaaaajpcaabaaaadaaaaaa
egiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaaipcaabaaa
aeaaaaaaegaebaaaadaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaaipcaabaaa
adaaaaaakgapbaaaadaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaafdcaabaaa
afaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaaadaaaaaa
dgaaaaafmcaabaaaaeaaaaaafganbaaaadaaaaaabbaaaaahicaabaaaabaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaadgaaaaagecaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaai
fcaabaaaacaaaaaaagacbaaaacaaaaaaagiacaaaaaaaaaaaagaaaaaadgaaaaaf
ccaabaaaacaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaf
iccabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaipcaabaaaacaaaaaafgafbaaa
abaaaaaaigiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaacaaaaaaigiicaaa
acaaaaaaamaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaa
abaaaaaaigiicaaaacaaaaaaaoaaaaaakgakbaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaakpcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaa
egiocaaaaaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaibcaabaaaabaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaa
aeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaafmccabaaaaeaaaaaa
kgaobaaaaaaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaadcaaaaam
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaa
aaaaaaaapgapbaaaaaaaaaaadgaaaaafbccabaaaagaaaaaackaabaaaaaaaaaaa
diaaaaakdccabaaaafaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec4 cse_3;
  cse_3 = (_Object2World * gl_Vertex);
  tmpvar_2.xyz = (cse_3.xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_5;
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  grabPassPos_5.xy = ((tmpvar_4.xy + tmpvar_4.w) * 0.5);
  grabPassPos_5.zw = tmpvar_4.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_2.w = clamp (0.0, 0.0, 1.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = ((cse_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = grabPassPos_5;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec4 edgeBlendFactors_2;
  vec4 rtRefractions_3;
  vec3 worldNormal_4;
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_5 + normal_6) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_4 = tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.xy = ((tmpvar_7.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD4 + tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_3 = texture2DProj (_RefractionTex, tmpvar_10);
  vec4 tmpvar_12;
  tmpvar_12 = texture2DProj (_ReflectionTex, (xlv_TEXCOORD3 + tmpvar_9));
  float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_10).x) + _ZBufferParams.w)));
  if ((tmpvar_13 < xlv_TEXCOORD3.z)) {
    rtRefractions_3 = tmpvar_11;
  };
  vec4 tmpvar_14;
  tmpvar_14 = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0);
  edgeBlendFactors_2.xzw = tmpvar_14.xzw;
  edgeBlendFactors_2.y = (1.0 - tmpvar_14.y);
  worldNormal_4.xz = (tmpvar_7.xz * _FresnelScale);
  vec4 tmpvar_15;
  tmpvar_15 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_16;
  coords_16 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (rtRefractions_3, tmpvar_15, tmpvar_15.wwww)
  , 
    mix (tmpvar_12, _ReflectionColor, _ReflectionColor.wwww)
  , vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_8)
      , worldNormal_4), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_7, 
      -(normalize((_WorldLightDir.xyz + tmpvar_8)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_16.xy) * texture2D (_ShoreTex, coords_16.zw)) - 0.125)
  .xyz * _Foam.x) * (edgeBlendFactors_2.y + 
    clamp ((xlv_TEXCOORD1.w - _Foam.y), 0.0, 1.0)
  )));
  baseColor_1.w = edgeBlendFactors_2.x;
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
mov r0.z, -r0.y
add r1.xy, r0.w, r0.xzzw
mul o5.xy, r1, c13.x
dp4 r0.z, c2, v0
mov o0, r0
mov o1, c13.yzyz
mov o2.w, c13.y
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedkpddoaihpjefelobgcjhjnhigidlidfoabaaaaaagiafaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
ieadaaaaeaaaabaaobaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaaabeaaaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadp
diaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaakdccabaaaafaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadgaaaaaf
mccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec4 cse_3;
  cse_3 = (_Object2World * gl_Vertex);
  tmpvar_2.xyz = (cse_3.xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_5;
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  grabPassPos_5.xy = ((tmpvar_4.xy + tmpvar_4.w) * 0.5);
  grabPassPos_5.zw = tmpvar_4.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_2.w = clamp (0.0, 0.0, 1.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = ((cse_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = grabPassPos_5;
  xlv_TEXCOORD5 = tmpvar_4.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 baseColor_1;
  vec4 edgeBlendFactors_2;
  vec4 rtRefractions_3;
  vec3 worldNormal_4;
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_5 + normal_6) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_4 = tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.xy = ((tmpvar_7.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD4 + tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_3 = texture2DProj (_RefractionTex, tmpvar_10);
  vec4 tmpvar_12;
  tmpvar_12 = texture2DProj (_ReflectionTex, (xlv_TEXCOORD3 + tmpvar_9));
  float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_10).x) + _ZBufferParams.w)));
  if ((tmpvar_13 < xlv_TEXCOORD3.z)) {
    rtRefractions_3 = tmpvar_11;
  };
  vec4 tmpvar_14;
  tmpvar_14 = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0);
  edgeBlendFactors_2.xzw = tmpvar_14.xzw;
  edgeBlendFactors_2.y = (1.0 - tmpvar_14.y);
  worldNormal_4.xz = (tmpvar_7.xz * _FresnelScale);
  vec4 tmpvar_15;
  tmpvar_15 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_16;
  coords_16 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (rtRefractions_3, tmpvar_15, tmpvar_15.wwww)
  , 
    mix (tmpvar_12, _ReflectionColor, _ReflectionColor.wwww)
  , vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_8)
      , worldNormal_4), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_7, 
      -(normalize((_WorldLightDir.xyz + tmpvar_8)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_16.xy) * texture2D (_ShoreTex, coords_16.zw)) - 0.125)
  .xyz * _Foam.x) * (edgeBlendFactors_2.y + 
    clamp ((xlv_TEXCOORD1.w - _Foam.y), 0.0, 1.0)
  )));
  baseColor_1.w = edgeBlendFactors_2.x;
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.x
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
mov r0.z, -r0.y
add r1.xy, r0.w, r0.xzzw
mul o5.xy, r1, c13.x
dp4 r0.z, c2, v0
mov o0, r0
mov o6.x, r0.z
mov o1, c13.yzyz
mov o2.w, c13.y
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedgaenpjccejmoamoopoiopigljpegpeejabaaaaaakaafaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaabaoaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckeadaaaaeaaaabaa
ojaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaadbccabaaaagaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaa
egiocaaaaaaaaaaabbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaa
abeaaaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaa
dgaaaaafbccabaaaagaaaaaackaabaaaaaaaaaaadiaaaaakdccabaaaafaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec4 cse_3;
  cse_3 = (_Object2World * gl_Vertex);
  tmpvar_2.xyz = (cse_3.xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_5;
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  grabPassPos_5.xy = ((tmpvar_4.xy + tmpvar_4.w) * 0.5);
  grabPassPos_5.zw = tmpvar_4.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_2.w = clamp (0.0, 0.0, 1.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = ((cse_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = grabPassPos_5;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec4 edgeBlendFactors_2;
  vec4 rtRefractions_3;
  vec3 worldNormal_4;
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_5 + normal_6) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_4 = tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.xy = ((tmpvar_7.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD4 + tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_3 = texture2DProj (_RefractionTex, tmpvar_10);
  float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_10).x) + _ZBufferParams.w)));
  if ((tmpvar_12 < xlv_TEXCOORD3.z)) {
    rtRefractions_3 = tmpvar_11;
  };
  vec4 tmpvar_13;
  tmpvar_13 = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0);
  edgeBlendFactors_2.xzw = tmpvar_13.xzw;
  edgeBlendFactors_2.y = (1.0 - tmpvar_13.y);
  worldNormal_4.xz = (tmpvar_7.xz * _FresnelScale);
  vec4 tmpvar_14;
  tmpvar_14 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_15;
  coords_15 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (rtRefractions_3, tmpvar_14, tmpvar_14.wwww)
  , _ReflectionColor, vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_8)
      , worldNormal_4), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_7, 
      -(normalize((_WorldLightDir.xyz + tmpvar_8)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_15.xy) * texture2D (_ShoreTex, coords_15.zw)) - 0.125)
  .xyz * _Foam.x) * (edgeBlendFactors_2.y + 
    clamp ((xlv_TEXCOORD1.w - _Foam.y), 0.0, 1.0)
  )));
  baseColor_1.w = edgeBlendFactors_2.x;
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
mov r0.z, -r0.y
add r1.xy, r0.w, r0.xzzw
mul o5.xy, r1, c13.x
dp4 r0.z, c2, v0
mov o0, r0
mov o1, c13.yzyz
mov o2.w, c13.y
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedkpddoaihpjefelobgcjhjnhigidlidfoabaaaaaagiafaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
ieadaaaaeaaaabaaobaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaaabeaaaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadp
diaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaakdccabaaaafaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadgaaaaaf
mccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec4 cse_3;
  cse_3 = (_Object2World * gl_Vertex);
  tmpvar_2.xyz = (cse_3.xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_5;
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  grabPassPos_5.xy = ((tmpvar_4.xy + tmpvar_4.w) * 0.5);
  grabPassPos_5.zw = tmpvar_4.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_2.w = clamp (0.0, 0.0, 1.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = ((cse_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = grabPassPos_5;
  xlv_TEXCOORD5 = tmpvar_4.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 baseColor_1;
  vec4 edgeBlendFactors_2;
  vec4 rtRefractions_3;
  vec3 worldNormal_4;
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (
    dot (normal_6.xy, normal_6.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_5 + normal_6) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_4 = tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.xy = ((tmpvar_7.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD4 + tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_3 = texture2DProj (_RefractionTex, tmpvar_10);
  float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_10).x) + _ZBufferParams.w)));
  if ((tmpvar_12 < xlv_TEXCOORD3.z)) {
    rtRefractions_3 = tmpvar_11;
  };
  vec4 tmpvar_13;
  tmpvar_13 = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0);
  edgeBlendFactors_2.xzw = tmpvar_13.xzw;
  edgeBlendFactors_2.y = (1.0 - tmpvar_13.y);
  worldNormal_4.xz = (tmpvar_7.xz * _FresnelScale);
  vec4 tmpvar_14;
  tmpvar_14 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_15;
  coords_15 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (rtRefractions_3, tmpvar_14, tmpvar_14.wwww)
  , _ReflectionColor, vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_8)
      , worldNormal_4), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_7, 
      -(normalize((_WorldLightDir.xyz + tmpvar_8)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_15.xy) * texture2D (_ShoreTex, coords_15.zw)) - 0.125)
  .xyz * _Foam.x) * (edgeBlendFactors_2.y + 
    clamp ((xlv_TEXCOORD1.w - _Foam.y), 0.0, 1.0)
  )));
  baseColor_1.w = edgeBlendFactors_2.x;
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.x
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
mov r0.z, -r0.y
add r1.xy, r0.w, r0.xzzw
mul o5.xy, r1, c13.x
dp4 r0.z, c2, v0
mov o0, r0
mov o6.x, r0.z
mov o1, c13.yzyz
mov o2.w, c13.y
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedgaenpjccejmoamoopoiopigljpegpeejabaaaaaakaafaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaabaoaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckeadaaaaeaaaabaa
ojaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaadbccabaaaagaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaa
egiocaaaaaaaaaaabbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaa
abeaaaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaa
dgaaaaafbccabaaaagaaaaaackaabaaaaaaaaaaadiaaaaakdccabaaaafaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec4 cse_3;
  cse_3 = (_Object2World * gl_Vertex);
  tmpvar_2.xyz = (cse_3.xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_5;
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  grabPassPos_5.xy = ((tmpvar_4.xy + tmpvar_4.w) * 0.5);
  grabPassPos_5.zw = tmpvar_4.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_2.w = clamp (0.0, 0.0, 1.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = ((cse_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = grabPassPos_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  vec4 tmpvar_8;
  tmpvar_8 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_9;
  coords_9 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (texture2DProj (_RefractionTex, (xlv_TEXCOORD4 + tmpvar_7)), tmpvar_8, tmpvar_8.wwww)
  , 
    mix (texture2DProj (_ReflectionTex, (xlv_TEXCOORD3 + tmpvar_7)), _ReflectionColor, _ReflectionColor.wwww)
  , vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_6)
      , worldNormal_2), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_5, 
      -(normalize((_WorldLightDir.xyz + tmpvar_6)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_9.xy) * texture2D (_ShoreTex, coords_9.zw)) - 0.125)
  .xyz * _Foam.x) * clamp (
    (xlv_TEXCOORD1.w - _Foam.y)
  , 0.0, 1.0)));
  baseColor_1.w = 1.0;
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
mov r0.z, -r0.y
add r1.xy, r0.w, r0.xzzw
mul o5.xy, r1, c13.x
dp4 r0.z, c2, v0
mov o0, r0
mov o1, c13.yzyz
mov o2.w, c13.y
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedkpddoaihpjefelobgcjhjnhigidlidfoabaaaaaagiafaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
ieadaaaaeaaaabaaobaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaaabeaaaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadp
diaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaakdccabaaaafaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadgaaaaaf
mccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec4 cse_3;
  cse_3 = (_Object2World * gl_Vertex);
  tmpvar_2.xyz = (cse_3.xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_5;
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  grabPassPos_5.xy = ((tmpvar_4.xy + tmpvar_4.w) * 0.5);
  grabPassPos_5.zw = tmpvar_4.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_2.w = clamp (0.0, 0.0, 1.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = ((cse_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = grabPassPos_5;
  xlv_TEXCOORD5 = tmpvar_4.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  vec4 tmpvar_8;
  tmpvar_8 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_9;
  coords_9 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (texture2DProj (_RefractionTex, (xlv_TEXCOORD4 + tmpvar_7)), tmpvar_8, tmpvar_8.wwww)
  , 
    mix (texture2DProj (_ReflectionTex, (xlv_TEXCOORD3 + tmpvar_7)), _ReflectionColor, _ReflectionColor.wwww)
  , vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_6)
      , worldNormal_2), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_5, 
      -(normalize((_WorldLightDir.xyz + tmpvar_6)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_9.xy) * texture2D (_ShoreTex, coords_9.zw)) - 0.125)
  .xyz * _Foam.x) * clamp (
    (xlv_TEXCOORD1.w - _Foam.y)
  , 0.0, 1.0)));
  baseColor_1.w = 1.0;
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.x
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
mov r0.z, -r0.y
add r1.xy, r0.w, r0.xzzw
mul o5.xy, r1, c13.x
dp4 r0.z, c2, v0
mov o0, r0
mov o6.x, r0.z
mov o1, c13.yzyz
mov o2.w, c13.y
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedgaenpjccejmoamoopoiopigljpegpeejabaaaaaakaafaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaabaoaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckeadaaaaeaaaabaa
ojaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaadbccabaaaagaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaa
egiocaaaaaaaaaaabbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaa
abeaaaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaa
dgaaaaafbccabaaaagaaaaaackaabaaaaaaaaaaadiaaaaakdccabaaaafaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec4 cse_3;
  cse_3 = (_Object2World * gl_Vertex);
  tmpvar_2.xyz = (cse_3.xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_5;
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  grabPassPos_5.xy = ((tmpvar_4.xy + tmpvar_4.w) * 0.5);
  grabPassPos_5.zw = tmpvar_4.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_2.w = clamp (0.0, 0.0, 1.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = ((cse_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = grabPassPos_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  vec4 tmpvar_8;
  tmpvar_8 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_9;
  coords_9 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (texture2DProj (_RefractionTex, (xlv_TEXCOORD4 + tmpvar_7)), tmpvar_8, tmpvar_8.wwww)
  , _ReflectionColor, vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_6)
      , worldNormal_2), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_5, 
      -(normalize((_WorldLightDir.xyz + tmpvar_6)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_9.xy) * texture2D (_ShoreTex, coords_9.zw)) - 0.125)
  .xyz * _Foam.x) * clamp (
    (xlv_TEXCOORD1.w - _Foam.y)
  , 0.0, 1.0)));
  baseColor_1.w = 1.0;
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
mov r0.z, -r0.y
add r1.xy, r0.w, r0.xzzw
mul o5.xy, r1, c13.x
dp4 r0.z, c2, v0
mov o0, r0
mov o1, c13.yzyz
mov o2.w, c13.y
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedkpddoaihpjefelobgcjhjnhigidlidfoabaaaaaagiafaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
ieadaaaaeaaaabaaobaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaaabeaaaaa
aaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadp
diaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaakdccabaaaafaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadgaaaaaf
mccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec4 cse_3;
  cse_3 = (_Object2World * gl_Vertex);
  tmpvar_2.xyz = (cse_3.xyz - _WorldSpaceCameraPos);
  vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_5;
  vec4 o_6;
  vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  grabPassPos_5.xy = ((tmpvar_4.xy + tmpvar_4.w) * 0.5);
  grabPassPos_5.zw = tmpvar_4.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_2.w = clamp (0.0, 0.0, 1.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = ((cse_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = grabPassPos_5;
  xlv_TEXCOORD5 = tmpvar_4.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
uniform sampler2D _ShoreTex;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
uniform vec4 _Foam;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1.xyz);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  vec4 tmpvar_8;
  tmpvar_8 = (_BaseColor - ((xlv_TEXCOORD1.w * _InvFadeParemeter.w) * vec4(0.15, 0.03, 0.01, 0.0)));
  vec4 coords_9;
  coords_9 = (xlv_TEXCOORD2 * 2.0);
  baseColor_1.xyz = ((mix (
    mix (texture2DProj (_RefractionTex, (xlv_TEXCOORD4 + tmpvar_7)), tmpvar_8, tmpvar_8.wwww)
  , _ReflectionColor, vec4(
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_6)
      , worldNormal_2), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  )) + (
    max (0.0, pow (max (0.0, dot (tmpvar_5, 
      -(normalize((_WorldLightDir.xyz + tmpvar_6)))
    )), _Shininess))
   * _SpecularColor)).xyz + ((
    ((texture2D (_ShoreTex, coords_9.xy) * texture2D (_ShoreTex, coords_9.zw)) - 0.125)
  .xyz * _Foam.x) * clamp (
    (xlv_TEXCOORD1.w - _Foam.y)
  , 0.0, 1.0)));
  baseColor_1.w = 1.0;
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD5))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6.x
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
mov r0.z, -r0.y
add r1.xy, r0.w, r0.xzzw
mul o5.xy, r1, c13.x
dp4 r0.z, c2, v0
mov o0, r0
mov o6.x, r0.z
mov o1, c13.yzyz
mov o2.w, c13.y
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedgaenpjccejmoamoopoiopigljpegpeejabaaaaaakaafaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaabaoaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefckeadaaaaeaaaabaa
ojaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaadbccabaaaagaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaa
egiocaaaaaaaaaaabbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaa
abeaaaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaa
dgaaaaafbccabaaaagaaaaaackaabaaaaaaaaaaadiaaaaakdccabaaaafaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadoaaaaab
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Vector 2 [_BaseColor]
Vector 7 [_DistortParams]
Vector 9 [_Foam]
Float 8 [_FresnelScale]
Vector 4 [_InvFadeParemeter]
Vector 3 [_ReflectionColor]
Float 5 [_Shininess]
Vector 1 [_SpecularColor]
Vector 6 [_WorldLightDir]
Vector 0 [_ZBufferParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_ShoreTex] 2D 3
SetTexture 4 [_CameraDepthTexture] 2D 4
"ps_3_0
def c10, 2, -1, 0.5, 0
def c11, 10, -0.125, 0, 0
def c12, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c10.x, c10.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c10.x, c10.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mad_pp r0.xyz, r0, c10.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c8.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c6
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c7.y
mul_pp r1.xy, r1, c11.x
max r2.w, r0.w, c10.w
pow r0.w, r2.w, c5.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c10.y
cmp_pp r0.x, r0.x, r0.y, -c10.y
max_pp r2.x, r0.x, c10.w
pow_pp r0.x, r2.x, c7.z
mov r0.y, c10.y
lrp_sat_pp r2.x, r0.x, -r0.y, c7.w
mov r1.zw, c10.w
add_pp r3, r1, v4
add_pp r1, r1.xyww, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c3.w, c3, r1
texldp_pp r1, r3, s4
texldp_pp r3, r3, s2
mad r1.x, c0.z, r1.x, c0.w
rcp r1.x, r1.x
add r1.x, r1.x, -v3.z
texldp_pp r4, v4, s2
cmp_pp r1.xyz, r1.x, r3, r4
mul_pp r1.w, c4.w, v1.w
mov r3, c12
mad_pp r3, r1.w, -r3, c2
lrp_pp r2.yzw, r3.w, r3.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r0, r2.yzww
mad_pp r0.xyz, r0.w, c1, r1
add_pp r1, v2, v2
texld r2, r1, s3
texld r1, r1.zwzw, s3
mad_pp r1.xyz, r2, r1, c11.y
mul r1.xyz, r1, c9.x
texldp_pp r2, v3, s4
mad r0.w, c0.z, r2.x, c0.w
rcp_pp r0.w, r0.w
add r0.w, r0.w, -v3.w
mul_sat_pp r2.xy, r0.w, c4
add_pp r0.w, -r2.y, -c10.y
mov_pp oC0.w, r2.x
add_sat r1.w, -c9.y, v1.w
add r0.w, r0.w, r1.w
mad_pp oC0.xyz, r1, r0.w, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 2
SetTexture 2 [_CameraDepthTexture] 2D 4
SetTexture 3 [_ReflectionTex] 2D 1
SetTexture 4 [_ShoreTex] 2D 3
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcmcnbkbimhjgoghfpocjpmgnhhghcogdabaaaaaammalaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmakaaaa
eaaaaaaaklacaaaafjaaaaaeegiocaaaaaaaaaaabjaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaa
aeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaaphcaabaaaabaaaaaapganbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaapganbaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
diaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaa
aaaaaaaaaoaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaaaaaaaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaidcaabaaaacaaaaaaigaabaaaabaaaaaafgifcaaaaaaaaaaa
aoaaaaaadiaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaaaaaacaeb
aaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaa
aaaaaaahhcaabaaaadaaaaaaegacbaaaacaaaaaaegbdbaaaafaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegbdbaaaaeaaaaaaaoaaaaahdcaabaaa
acaaaaaaegaabaaaacaaaaaakgakbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaaoaaaaahdcaabaaa
adaaaaaaegaabaaaadaaaaaakgakbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaadaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaal
icaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaeaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaackbabaaaaeaaaaaadhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaaiicaabaaaaaaaaaaadkbabaaa
acaaaaaadkiacaaaaaaaaaaaalaaaaaadcaaaaaopcaabaaaadaaaaaapgapbaia
ebaaaaaaaaaaaaaaaceaaaaajkjjbjdoipmcpfdmaknhcddmaaaaaaaaegiocaaa
aaaaaaaaajaaaaaaaaaaaaaihcaabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaadaaaaaaegacbaiaebaaaaaa
acaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaacaaaaaapgipcaaa
aaaaaaaaakaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaifcaabaaa
adaaaaaaagacbaaaabaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaa
adaaaaaabkaabaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaa
afaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
baaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaaegacbaaaadaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaiadpdccaaaakicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaoaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
afaaaaaaegacbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaafaaaaaabaaaaaai
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akiacaaaaaaaaaaaamaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaa
egacbaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaa
adaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaeaaaaaa
aagabaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
aeaaaaaaaagabaaaadaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaloaaaaaaloaaaaaaloaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaabiaaaaaaaoaaaaah
dcaabaaaacaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaadcaaaaal
icaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaiaebaaaaaaaeaaaaaadicaaaaidcaabaaaacaaaaaapgapbaaa
aaaaaaaaegiacaaaaaaaaaaaalaaaaaaaaaaaaaiicaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaaabeaaaaaaaaaiadpdgaaaaaficcabaaaaaaaaaaaakaabaaa
acaaaaaaaacaaaajicaabaaaabaaaaaadkbabaaaacaaaaaabkiacaiaebaaaaaa
aaaaaaaabiaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Vector 4 [_BaseColor]
Vector 9 [_DistortParams]
Vector 11 [_Foam]
Float 10 [_FresnelScale]
Vector 6 [_InvFadeParemeter]
Vector 5 [_ReflectionColor]
Float 7 [_Shininess]
Vector 3 [_SpecularColor]
Vector 8 [_WorldLightDir]
Vector 0 [_ZBufferParams]
Vector 1 [unity_FogColor]
Vector 2 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_ShoreTex] 2D 3
SetTexture 4 [_CameraDepthTexture] 2D 4
"ps_3_0
def c12, 2, -1, 0.5, 0
def c13, 10, -0.125, 0, 0
def c14, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c12.x, c12.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c12.x, c12.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c9.x
mad_pp r0.xyz, r0, c12.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c10.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c8
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c9.y
mul_pp r1.xy, r1, c13.x
max r2.w, r0.w, c12.w
pow r0.w, r2.w, c7.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c12.y
cmp_pp r0.x, r0.x, r0.y, -c12.y
max_pp r2.x, r0.x, c12.w
pow_pp r0.x, r2.x, c9.z
mov r0.y, c12.y
lrp_sat_pp r2.x, r0.x, -r0.y, c9.w
mov r1.zw, c12.w
add_pp r3, r1, v4
add_pp r1, r1.xyww, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c5.w, c5, r1
texldp_pp r1, r3, s4
texldp_pp r3, r3, s2
mad r1.x, c0.z, r1.x, c0.w
rcp r1.x, r1.x
add r1.x, r1.x, -v3.z
texldp_pp r4, v4, s2
cmp_pp r1.xyz, r1.x, r3, r4
mul_pp r1.w, c6.w, v1.w
mov r3, c14
mad_pp r3, r1.w, -r3, c4
lrp_pp r2.yzw, r3.w, r3.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r0, r2.yzww
mad_pp r0.xyz, r0.w, c3, r1
add_pp r1, v2, v2
texld r2, r1, s3
texld r1, r1.zwzw, s3
mad_pp r1.xyz, r2, r1, c13.y
mul r1.xyz, r1, c11.x
texldp_pp r2, v3, s4
mad r0.w, c0.z, r2.x, c0.w
rcp_pp r0.w, r0.w
add r0.w, r0.w, -v3.w
mul_sat_pp r2.xy, r0.w, c6
add_pp r0.w, -r2.y, -c12.y
mov_pp oC0.w, r2.x
add_sat r1.w, -c11.y, v1.w
add r0.w, r0.w, r1.w
mad_pp r0.xyz, r1, r0.w, r0
add r0.xyz, r0, -c1
mul r0.w, c2.y, v5.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 2
SetTexture 2 [_CameraDepthTexture] 2D 4
SetTexture 3 [_ReflectionTex] 2D 1
SetTexture 4 [_ShoreTex] 2D 3
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0
eefiecedkonmobnfkdmonppcaoflhobnejcnmbcbabaaaaaakaamaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ababaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgialaaaaeaaaaaaankacaaaa
fjaaaaaeegiocaaaaaaaaaaabjaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagcbaaaadbcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaap
hcaabaaaabaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaa
acaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaabaaaaaapganbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaam
hcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadp
aaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaidcaabaaa
acaaaaaaigaabaaaabaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaa
acaaaaaaegaabaaaacaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaa
dgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaacaaaaaaegbdbaaaafaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegbdbaaaaeaaaaaaaoaaaaahdcaabaaaacaaaaaaegaabaaaacaaaaaa
kgakbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaaaoaaaaahdcaabaaaadaaaaaaegaabaaaadaaaaaa
kgakbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaa
acaaaaaaaagabaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaalicaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaaeaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackbabaaaaeaaaaaa
dhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
adaaaaaadiaaaaaiicaabaaaaaaaaaaadkbabaaaacaaaaaadkiacaaaaaaaaaaa
alaaaaaadcaaaaaopcaabaaaadaaaaaapgapbaiaebaaaaaaaaaaaaaaaceaaaaa
jkjjbjdoipmcpfdmaknhcddmaaaaaaaaegiocaaaaaaaaaaaajaaaaaaaaaaaaai
hcaabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaapgapbaaaadaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaaaaaaaaaa
akaaaaaadcaaaaakhcaabaaaacaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaa
adaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaa
aaaaaaaaegacbaaaacaaaaaadiaaaaaifcaabaaaadaaaaaaagacbaaaabaaaaaa
agiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaadaaaaaabkaabaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaa
aaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaaafaaaaaaegbcbaaaacaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaa
egacbaiaebaaaaaaaeaaaaaaegacbaaaadaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaa
dkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaa
dcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaaadaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaabaaaaaaeghobaaaaeaaaaaaaagabaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaeaaaaaaaagabaaaadaaaaaa
dcaaaaamhcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaaloaaaaaaloaaaaaaloaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaagiacaaaaaaaaaaabiaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaaeaaaaaadcaaaaalicaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaiaebaaaaaa
aeaaaaaadicaaaaidcaabaaaacaaaaaapgapbaaaaaaaaaaaegiacaaaaaaaaaaa
alaaaaaaaaaaaaaiicaabaaaaaaaaaaabkaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpdgaaaaaficcabaaaaaaaaaaaakaabaaaacaaaaaaaacaaaajicaabaaa
abaaaaaadkbabaaaacaaaaaabkiacaiaebaaaaaaaaaaaaaabiaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaaakbabaaaagaaaaaabkiacaaaacaaaaaaabaaaaaa
bjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Vector 2 [_BaseColor]
Vector 7 [_DistortParams]
Vector 9 [_Foam]
Float 8 [_FresnelScale]
Vector 4 [_InvFadeParemeter]
Vector 3 [_ReflectionColor]
Float 5 [_Shininess]
Vector 1 [_SpecularColor]
Vector 6 [_WorldLightDir]
Vector 0 [_ZBufferParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_ShoreTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
"ps_3_0
def c10, 2, -1, 0.5, 0
def c11, 10, -0.125, 0, 0
def c12, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c10.x, c10.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c10.x, c10.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mad_pp r0.xyz, r0, c10.zwzw, v0
nrm_pp r1.xyz, r0
mul r0.xy, r1.xzzw, c7.y
mul_pp r0.xy, r0, c11.x
mov r0.zw, c10.w
add_pp r0, r0, v4
texldp_pp r2, r0, s3
texldp_pp r0, r0, s1
mad r0.w, c0.z, r2.x, c0.w
rcp r0.w, r0.w
add r0.w, r0.w, -v3.z
texldp_pp r2, v4, s1
cmp_pp r0.xyz, r0.w, r0, r2
mul_pp r0.w, c4.w, v1.w
mov r2, c12
mad_pp r2, r0.w, -r2, c2
lrp_pp r3.xyz, r2.w, r2, r0
mul_pp r0.xz, r1, c8.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r4.xyz, v1, r0.w, c6
nrm_pp r5.xyz, r4
dp3_pp r0.w, r1, -r5
max r1.x, r0.w, c10.w
pow r0.w, r1.x, c5.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c10.y
cmp_pp r0.x, r0.x, r0.y, -c10.y
max_pp r1.x, r0.x, c10.w
pow_pp r0.x, r1.x, c7.z
mov r0.y, c10.y
lrp_sat_pp r1.x, r0.x, -r0.y, c7.w
lrp_pp r0.xyz, r1.x, c3, r3
mad_pp r0.xyz, r0.w, c1, r0
add_pp r1, v2, v2
texld r2, r1, s2
texld r1, r1.zwzw, s2
mad_pp r1.xyz, r2, r1, c11.y
mul r1.xyz, r1, c9.x
texldp_pp r2, v3, s3
mad r0.w, c0.z, r2.x, c0.w
rcp_pp r0.w, r0.w
add r0.w, r0.w, -v3.w
mul_sat_pp r2.xy, r0.w, c4
add_pp r0.w, -r2.y, -c10.y
mov_pp oC0.w, r2.x
add_sat r1.w, -c9.y, v1.w
add r0.w, r0.w, r1.w
mad_pp oC0.xyz, r1, r0.w, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 3
SetTexture 3 [_ShoreTex] 2D 2
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedmejhabjdmlfadeelfbffbenpmgleojpoabaaaaaaamalaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcomajaaaa
eaaaaaaahlacaaaafjaaaaaeegiocaaaaaaaaaaabjaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaaoaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaa
aaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaaacaaaaaapgapbaaa
aaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaadiaaaaai
dcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaa
aaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegbdbaaaafaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaalicaabaaa
abaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaaabaaaaaa
ahaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaabaaaaaadbaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
ckbabaaaaeaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaafaaaaaapgbpbaaa
afaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadhaaaaajhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaaiicaabaaaabaaaaaadkbabaaaacaaaaaa
dkiacaaaaaaaaaaaalaaaaaadcaaaaaopcaabaaaacaaaaaapgapbaiaebaaaaaa
abaaaaaaaceaaaaajkjjbjdoipmcpfdmaknhcddmaaaaaaaaegiocaaaaaaaaaaa
ajaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
acaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaai
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaa
egacbaaaabaaaaaaaaaaaaahpcaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaa
adaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
adaaaaaaaagabaaaacaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaloaaaaaaloaaaaaaloaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaabiaaaaaaaoaaaaah
dcaabaaaacaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaal
icaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaiaebaaaaaaaeaaaaaadicaaaaidcaabaaaacaaaaaapgapbaaa
aaaaaaaaegiacaaaaaaaaaaaalaaaaaaaaaaaaaiicaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaaabeaaaaaaaaaiadpdgaaaaaficcabaaaaaaaaaaaakaabaaa
acaaaaaaaacaaaajicaabaaaabaaaaaadkbabaaaacaaaaaabkiacaiaebaaaaaa
aaaaaaaabiaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Vector 4 [_BaseColor]
Vector 9 [_DistortParams]
Vector 11 [_Foam]
Float 10 [_FresnelScale]
Vector 6 [_InvFadeParemeter]
Vector 5 [_ReflectionColor]
Float 7 [_Shininess]
Vector 3 [_SpecularColor]
Vector 8 [_WorldLightDir]
Vector 0 [_ZBufferParams]
Vector 1 [unity_FogColor]
Vector 2 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_ShoreTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
"ps_3_0
def c12, 2, -1, 0.5, 0
def c13, 10, -0.125, 0, 0
def c14, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c12.x, c12.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c12.x, c12.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c9.x
mad_pp r0.xyz, r0, c12.zwzw, v0
nrm_pp r1.xyz, r0
mul r0.xy, r1.xzzw, c9.y
mul_pp r0.xy, r0, c13.x
mov r0.zw, c12.w
add_pp r0, r0, v4
texldp_pp r2, r0, s3
texldp_pp r0, r0, s1
mad r0.w, c0.z, r2.x, c0.w
rcp r0.w, r0.w
add r0.w, r0.w, -v3.z
texldp_pp r2, v4, s1
cmp_pp r0.xyz, r0.w, r0, r2
mul_pp r0.w, c6.w, v1.w
mov r2, c14
mad_pp r2, r0.w, -r2, c4
lrp_pp r3.xyz, r2.w, r2, r0
mul_pp r0.xz, r1, c10.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r4.xyz, v1, r0.w, c8
nrm_pp r5.xyz, r4
dp3_pp r0.w, r1, -r5
max r1.x, r0.w, c12.w
pow r0.w, r1.x, c7.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c12.y
cmp_pp r0.x, r0.x, r0.y, -c12.y
max_pp r1.x, r0.x, c12.w
pow_pp r0.x, r1.x, c9.z
mov r0.y, c12.y
lrp_sat_pp r1.x, r0.x, -r0.y, c9.w
lrp_pp r0.xyz, r1.x, c5, r3
mad_pp r0.xyz, r0.w, c3, r0
add_pp r1, v2, v2
texld r2, r1, s2
texld r1, r1.zwzw, s2
mad_pp r1.xyz, r2, r1, c13.y
mul r1.xyz, r1, c11.x
texldp_pp r2, v3, s3
mad r0.w, c0.z, r2.x, c0.w
rcp_pp r0.w, r0.w
add r0.w, r0.w, -v3.w
mul_sat_pp r2.xy, r0.w, c6
add_pp r0.w, -r2.y, -c12.y
mov_pp oC0.w, r2.x
add_sat r1.w, -c11.y, v1.w
add r0.w, r0.w, r1.w
mad_pp r0.xyz, r1, r0.w, r0
add r0.xyz, r0, -c1
mul r0.w, c2.y, v5.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 3
SetTexture 3 [_ShoreTex] 2D 2
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0
eefiecedkpipnkoafpjcljddoggchflmmenjcbpkabaaaaaaoaalaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ababaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckiakaaaaeaaaaaaakkacaaaa
fjaaaaaeegiocaaaaaaaaaaabjaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagcbaaaad
bcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
fcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaaf
ccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaak
hcaabaaaadaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaa
anaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaa
abeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaaoaaaaaadiaaaaaidcaabaaaabaaaaaaigaabaaa
aaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaa
abaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaa
abaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egbdbaaaafaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaalicaabaaaabaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaacaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakicaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaabaaaaaa
dbaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaackbabaaaaeaaaaaaaoaaaaah
dcaabaaaacaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadhaaaaaj
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaiicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaaaaaaaaaaaalaaaaaa
dcaaaaaopcaabaaaacaaaaaapgapbaiaebaaaaaaabaaaaaaaceaaaaajkjjbjdo
ipmcpfdmaknhcddmaaaaaaaaegiocaaaaaaaaaaaajaaaaaaaaaaaaaihcaabaaa
acaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaa
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaah
pcaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaaadaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaadaaaaaaaagabaaaacaaaaaa
dcaaaaamhcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaaloaaaaaaloaaaaaaloaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaagiacaaaaaaaaaaabiaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaalicaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaiaebaaaaaa
aeaaaaaadicaaaaidcaabaaaacaaaaaapgapbaaaaaaaaaaaegiacaaaaaaaaaaa
alaaaaaaaaaaaaaiicaabaaaaaaaaaaabkaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpdgaaaaaficcabaaaaaaaaaaaakaabaaaacaaaaaaaacaaaajicaabaaa
abaaaaaadkbabaaaacaaaaaabkiacaiaebaaaaaaaaaaaaaabiaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaaakbabaaaagaaaaaabkiacaaaacaaaaaaabaaaaaa
bjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Vector 1 [_BaseColor]
Vector 6 [_DistortParams]
Vector 8 [_Foam]
Float 7 [_FresnelScale]
Vector 3 [_InvFadeParemeter]
Vector 2 [_ReflectionColor]
Float 4 [_Shininess]
Vector 0 [_SpecularColor]
Vector 5 [_WorldLightDir]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_ShoreTex] 2D 3
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, -0.125, 0, 0
def c11, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c6.x
mad_pp r0.xyz, r0, c9.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c7.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c5
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c6.y
mul_pp r1.xy, r1, c10.x
max r2.w, r0.w, c9.w
pow r0.w, r2.w, c4.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c9.y
cmp_pp r0.x, r0.x, r0.y, -c9.y
max_pp r2.x, r0.x, c9.w
pow_pp r0.x, r2.x, c6.z
mov r0.y, c9.y
lrp_sat_pp r2.x, r0.x, -r0.y, c6.w
mov r1.zw, c9.w
add_pp r3, r1, v4
add_pp r1, r1.xyww, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c2.w, c2, r1
texldp_pp r1, r3, s2
mul_pp r1.w, c3.w, v1.w
mov r3, c11
mad_pp r3, r1.w, -r3, c1
lrp_pp r2.yzw, r3.w, r3.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r0, r2.yzww
mad_pp r0.xyz, r0.w, c0, r1
add_pp r1, v2, v2
texld r2, r1, s3
texld r1, r1.zwzw, s3
mad_pp r1.xyz, r2, r1, c10.y
mul r1.xyz, r1, c8.x
add_sat r0.w, -c8.y, v1.w
mad_pp oC0.xyz, r1, r0.w, r0
mov_pp oC0.w, -c9.y

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 2
SetTexture 2 [_ReflectionTex] 2D 1
SetTexture 3 [_ShoreTex] 2D 3
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlbdgfemdbcmdfdlpjcelpggiancodbkbabaaaaaajiajaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchiaiaaaa
eaaaaaaaboacaaaafjaaaaaeegiocaaaaaaaaaaabjaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagcbaaaadlcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaap
hcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadp
aaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaa
abaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaa
abaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaa
adaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
baaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaoaaaaaadiaaaaaidcaabaaaabaaaaaaigaabaaaaaaaaaaa
fgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegbdbaaa
aeaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaaafaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
aoaaaaahdcaabaaaacaaaaaaegaabaaaacaaaaaakgakbaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaa
aaaaaaajhcaabaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaaaaaaaaaa
akaaaaaadcaaaaakhcaabaaaacaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaadiaaaaaiicaabaaaabaaaaaadkbabaaaacaaaaaa
dkiacaaaaaaaaaaaalaaaaaadcaaaaaopcaabaaaaeaaaaaapgapbaiaebaaaaaa
abaaaaaaaceaaaaajkjjbjdoipmcpfdmaknhcddmaaaaaaaaegiocaaaaaaaaaaa
ajaaaaaaaaaaaaaihcaabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
aeaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaeaaaaaaegacbaaaaeaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaa
abaaaaaaaaaaaaahpcaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaaadaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaaaloaaaaaaloaaaaaaloaaaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaabiaaaaaaaacaaaajicaabaaa
aaaaaaaadkbabaaaacaaaaaabkiacaiaebaaaaaaaaaaaaaabiaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Vector 3 [_BaseColor]
Vector 8 [_DistortParams]
Vector 10 [_Foam]
Float 9 [_FresnelScale]
Vector 5 [_InvFadeParemeter]
Vector 4 [_ReflectionColor]
Float 6 [_Shininess]
Vector 2 [_SpecularColor]
Vector 7 [_WorldLightDir]
Vector 0 [unity_FogColor]
Vector 1 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_ShoreTex] 2D 3
"ps_3_0
def c11, 2, -1, 0.5, 0
def c12, 10, -0.125, 0, 0
def c13, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c11.x, c11.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c11.x, c11.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c8.x
mad_pp r0.xyz, r0, c11.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c9.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c7
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c8.y
mul_pp r1.xy, r1, c12.x
max r2.w, r0.w, c11.w
pow r0.w, r2.w, c6.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c11.y
cmp_pp r0.x, r0.x, r0.y, -c11.y
max_pp r2.x, r0.x, c11.w
pow_pp r0.x, r2.x, c8.z
mov r0.y, c11.y
lrp_sat_pp r2.x, r0.x, -r0.y, c8.w
mov r1.zw, c11.w
add_pp r3, r1, v4
add_pp r1, r1.xyww, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c4.w, c4, r1
texldp_pp r1, r3, s2
mul_pp r1.w, c5.w, v1.w
mov r3, c13
mad_pp r3, r1.w, -r3, c3
lrp_pp r2.yzw, r3.w, r3.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r0, r2.yzww
mad_pp r0.xyz, r0.w, c2, r1
add_pp r1, v2, v2
texld r2, r1, s3
texld r1, r1.zwzw, s3
mad_pp r1.xyz, r2, r1, c12.y
mul r1.xyz, r1, c10.x
add_sat r0.w, -c10.y, v1.w
mad_pp r0.xyz, r1, r0.w, r0
add r0.xyz, r0, -c0
mul r0.w, c1.y, v5.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c0
mov_pp oC0.w, -c11.y

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 2
SetTexture 2 [_ReflectionTex] 2D 1
SetTexture 3 [_ShoreTex] 2D 3
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedglkklfodbgdonjoiafbimimgnabecbhnabaaaaaagmakaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ababaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeajaaaaeaaaaaaaenacaaaa
fjaaaaaeegiocaaaaaaaaaaabjaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaa
gcbaaaadlcbabaaaafaaaaaagcbaaaadbcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaaegbcbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaa
agiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaaacaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaa
dkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaa
aaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaa
diaaaaaidcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaa
diaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaacaebaaaacaeb
aaaaaaaaaaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaabaaaaaaegbdbaaaaeaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegbdbaaaafaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaaoaaaaahdcaabaaaacaaaaaa
egaabaaaacaaaaaakgakbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaaaaaaaajhcaabaaaaeaaaaaa
egacbaiaebaaaaaaacaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
acaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaa
diaaaaaiicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaaaaaaaaaaaalaaaaaa
dcaaaaaopcaabaaaaeaaaaaapgapbaiaebaaaaaaabaaaaaaaceaaaaajkjjbjdo
ipmcpfdmaknhcddmaaaaaaaaegiocaaaaaaaaaaaajaaaaaaaaaaaaaihcaabaaa
aeaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaaeaaaaaadcaaaaajhcaabaaa
abaaaaaapgapbaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaahpcaabaaa
abaaaaaaegbobaaaadaaaaaaegbobaaaadaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaam
hcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaalo
aaaaaaloaaaaaaloaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
agiacaaaaaaaaaaabiaaaaaaaacaaaajicaabaaaaaaaaaaadkbabaaaacaaaaaa
bkiacaiaebaaaaaaaaaaaaaabiaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaaakbabaaaagaaaaaabkiacaaaabaaaaaaabaaaaaabjaaaaagicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Vector 1 [_BaseColor]
Vector 6 [_DistortParams]
Vector 8 [_Foam]
Float 7 [_FresnelScale]
Vector 3 [_InvFadeParemeter]
Vector 2 [_ReflectionColor]
Float 4 [_Shininess]
Vector 0 [_SpecularColor]
Vector 5 [_WorldLightDir]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_ShoreTex] 2D 2
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, -0.125, 0, 0
def c11, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord4 v3
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c6.x
mad_pp r0.xyz, r0, c9.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c7.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c5
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c6.y
mul_pp r1.xy, r1, c10.x
max r2.w, r0.w, c9.w
pow r0.w, r2.w, c4.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c9.y
cmp_pp r0.x, r0.x, r0.y, -c9.y
max_pp r2.x, r0.x, c9.w
pow_pp r0.x, r2.x, c6.z
mov r0.y, c9.y
lrp_sat_pp r2.x, r0.x, -r0.y, c6.w
mov r1.zw, c9.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
mul_pp r0.x, c3.w, v1.w
mov r3, c11
mad_pp r3, r0.x, -r3, c1
lrp_pp r0.xyz, r3.w, r3, r1
lrp_pp r1.xyz, r2.x, c2, r0
mad_pp r0.xyz, r0.w, c0, r1
add_pp r1, v2, v2
texld r2, r1, s2
texld r1, r1.zwzw, s2
mad_pp r1.xyz, r2, r1, c10.y
mul r1.xyz, r1, c8.x
add_sat r0.w, -c8.y, v1.w
mad_pp oC0.xyz, r1, r0.w, r0
mov_pp oC0.w, -c9.y

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_ShoreTex] 2D 2
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
BindCB  "$Globals" 0
"ps_4_0
eefiecedflgfknjijlgimbkonncoghnaldkblpcpabaaaaaammaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmahaaaa
eaaaaaaaolabaaaafjaaaaaeegiocaaaaaaaaaaabjaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaa
pganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
pganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaamhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaaegbcbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaa
aaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaa
acaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaa
aaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaa
abaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaak
icaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
aoaaaaaadiaaaaaidcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaaaaaaaaaa
aoaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaacaeb
aaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaaafaaaaaaaoaaaaah
dcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaai
icaabaaaabaaaaaadkbabaaaacaaaaaadkiacaaaaaaaaaaaalaaaaaadcaaaaao
pcaabaaaacaaaaaapgapbaiaebaaaaaaabaaaaaaaceaaaaajkjjbjdoipmcpfdm
aknhcddmaaaaaaaaegiocaaaaaaaaaaaajaaaaaaaaaaaaaihcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
pgapbaaaacaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaaj
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaahpcaabaaa
abaaaaaaegbobaaaadaaaaaaegbobaaaadaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaam
hcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaalo
aaaaaaloaaaaaaloaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
agiacaaaaaaaaaaabiaaaaaaaacaaaajicaabaaaaaaaaaaadkbabaaaacaaaaaa
bkiacaiaebaaaaaaaaaaaaaabiaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Vector 3 [_BaseColor]
Vector 8 [_DistortParams]
Vector 10 [_Foam]
Float 9 [_FresnelScale]
Vector 5 [_InvFadeParemeter]
Vector 4 [_ReflectionColor]
Float 6 [_Shininess]
Vector 2 [_SpecularColor]
Vector 7 [_WorldLightDir]
Vector 0 [unity_FogColor]
Vector 1 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_ShoreTex] 2D 2
"ps_3_0
def c11, 2, -1, 0.5, 0
def c12, 10, -0.125, 0, 0
def c13, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord4 v3
dcl_texcoord5 v4.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c11.x, c11.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c11.x, c11.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c8.x
mad_pp r0.xyz, r0, c11.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c9.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c7
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c8.y
mul_pp r1.xy, r1, c12.x
max r2.w, r0.w, c11.w
pow r0.w, r2.w, c6.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c11.y
cmp_pp r0.x, r0.x, r0.y, -c11.y
max_pp r2.x, r0.x, c11.w
pow_pp r0.x, r2.x, c8.z
mov r0.y, c11.y
lrp_sat_pp r2.x, r0.x, -r0.y, c8.w
mov r1.zw, c11.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
mul_pp r0.x, c5.w, v1.w
mov r3, c13
mad_pp r3, r0.x, -r3, c3
lrp_pp r0.xyz, r3.w, r3, r1
lrp_pp r1.xyz, r2.x, c4, r0
mad_pp r0.xyz, r0.w, c2, r1
add_pp r1, v2, v2
texld r2, r1, s2
texld r1, r1.zwzw, s2
mad_pp r1.xyz, r2, r1, c12.y
mul r1.xyz, r1, c10.x
add_sat r0.w, -c10.y, v1.w
mad_pp r0.xyz, r1, r0.w, r0
add r0.xyz, r0, -c0
mul r0.w, c1.y, v4.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c0
mov_pp oC0.w, -c11.y

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_ShoreTex] 2D 2
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedkjjbanpbmeekpfgncidoahlhekmgnbaiabaaaaaakaajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ababaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgiaiaaaaeaaaaaaabkacaaaa
fjaaaaaeegiocaaaaaaaaaaabjaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaa
afaaaaaagcbaaaadbcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaaoaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaaaaaaaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaa
apaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaa
acaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaa
egiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaadiaaaaaidcaabaaa
abaaaaaaigaabaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaa
dgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegbdbaaaafaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaa
abaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaaiicaabaaaabaaaaaadkbabaaa
acaaaaaadkiacaaaaaaaaaaaalaaaaaadcaaaaaopcaabaaaacaaaaaapgapbaia
ebaaaaaaabaaaaaaaceaaaaajkjjbjdoipmcpfdmaknhcddmaaaaaaaaegiocaaa
aaaaaaaaajaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaa
abaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaegacbaaaabaaaaaaaaaaaaahpcaabaaaabaaaaaaegbobaaaadaaaaaa
egbobaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaloaaaaaaloaaaaaaloaaaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaabiaaaaaa
aacaaaajicaabaaaaaaaaaaadkbabaaaacaaaaaabkiacaiaebaaaaaaaaaaaaaa
biaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaaakbabaaaagaaaaaa
bkiacaaaabaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
dcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Vector 2 [_BaseColor]
Vector 7 [_DistortParams]
Vector 9 [_Foam]
Float 8 [_FresnelScale]
Vector 4 [_InvFadeParemeter]
Vector 3 [_ReflectionColor]
Float 5 [_Shininess]
Vector 1 [_SpecularColor]
Vector 6 [_WorldLightDir]
Vector 0 [_ZBufferParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_ShoreTex] 2D 3
SetTexture 4 [_CameraDepthTexture] 2D 4
"ps_3_0
def c10, 2, -1, 0.5, 0
def c11, 10, -0.125, 0, 0
def c12, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c10.x, c10.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c10.x, c10.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mad_pp r0.xyz, r0, c10.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c8.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c6
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c7.y
mul_pp r1.xy, r1, c11.x
max r2.w, r0.w, c10.w
pow r0.w, r2.w, c5.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c10.y
cmp_pp r0.x, r0.x, r0.y, -c10.y
max_pp r2.x, r0.x, c10.w
pow_pp r0.x, r2.x, c7.z
mov r0.y, c10.y
lrp_sat_pp r2.x, r0.x, -r0.y, c7.w
mov r1.zw, c10.w
add_pp r3, r1, v4
add_pp r1, r1.xyww, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c3.w, c3, r1
texldp_pp r1, r3, s4
texldp_pp r3, r3, s2
mad r1.x, c0.z, r1.x, c0.w
rcp r1.x, r1.x
add r1.x, r1.x, -v3.z
texldp_pp r4, v4, s2
cmp_pp r1.xyz, r1.x, r3, r4
mul_pp r1.w, c4.w, v1.w
mov r3, c12
mad_pp r3, r1.w, -r3, c2
lrp_pp r2.yzw, r3.w, r3.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r0, r2.yzww
mad_pp r0.xyz, r0.w, c1, r1
add_pp r1, v2, v2
texld r2, r1, s3
texld r1, r1.zwzw, s3
mad_pp r1.xyz, r2, r1, c11.y
mul r1.xyz, r1, c9.x
texldp_pp r2, v3, s4
mad r0.w, c0.z, r2.x, c0.w
rcp_pp r0.w, r0.w
add r0.w, r0.w, -v3.w
mul_sat_pp r2.xy, r0.w, c4
add_pp r0.w, -r2.y, -c10.y
mov_pp oC0.w, r2.x
add_sat r1.w, -c9.y, v1.w
add r0.w, r0.w, r1.w
mad_pp oC0.xyz, r1, r0.w, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 2
SetTexture 2 [_CameraDepthTexture] 2D 4
SetTexture 3 [_ReflectionTex] 2D 1
SetTexture 4 [_ShoreTex] 2D 3
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedcmcnbkbimhjgoghfpocjpmgnhhghcogdabaaaaaammalaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmakaaaa
eaaaaaaaklacaaaafjaaaaaeegiocaaaaaaaaaaabjaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaa
aeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaaphcaabaaaabaaaaaapganbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaapganbaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
diaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaa
aaaaaaaaaoaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaaaaaaaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaidcaabaaaacaaaaaaigaabaaaabaaaaaafgifcaaaaaaaaaaa
aoaaaaaadiaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaaaaaacaeb
aaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaa
aaaaaaahhcaabaaaadaaaaaaegacbaaaacaaaaaaegbdbaaaafaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegbdbaaaaeaaaaaaaoaaaaahdcaabaaa
acaaaaaaegaabaaaacaaaaaakgakbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaaoaaaaahdcaabaaa
adaaaaaaegaabaaaadaaaaaakgakbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaadaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaal
icaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaeaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaackbabaaaaeaaaaaadhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaaiicaabaaaaaaaaaaadkbabaaa
acaaaaaadkiacaaaaaaaaaaaalaaaaaadcaaaaaopcaabaaaadaaaaaapgapbaia
ebaaaaaaaaaaaaaaaceaaaaajkjjbjdoipmcpfdmaknhcddmaaaaaaaaegiocaaa
aaaaaaaaajaaaaaaaaaaaaaihcaabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaadaaaaaaegacbaiaebaaaaaa
acaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaacaaaaaapgipcaaa
aaaaaaaaakaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaifcaabaaa
adaaaaaaagacbaaaabaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaa
adaaaaaabkaabaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaa
afaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
baaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaaegacbaaaadaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaiadpdccaaaakicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaoaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
afaaaaaaegacbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaafaaaaaabaaaaaai
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akiacaaaaaaaaaaaamaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaa
egacbaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaa
adaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaeaaaaaa
aagabaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
aeaaaaaaaagabaaaadaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaloaaaaaaloaaaaaaloaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaabiaaaaaaaoaaaaah
dcaabaaaacaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaadcaaaaal
icaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaiaebaaaaaaaeaaaaaadicaaaaidcaabaaaacaaaaaapgapbaaa
aaaaaaaaegiacaaaaaaaaaaaalaaaaaaaaaaaaaiicaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaaabeaaaaaaaaaiadpdgaaaaaficcabaaaaaaaaaaaakaabaaa
acaaaaaaaacaaaajicaabaaaabaaaaaadkbabaaaacaaaaaabkiacaiaebaaaaaa
aaaaaaaabiaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Vector 4 [_BaseColor]
Vector 9 [_DistortParams]
Vector 11 [_Foam]
Float 10 [_FresnelScale]
Vector 6 [_InvFadeParemeter]
Vector 5 [_ReflectionColor]
Float 7 [_Shininess]
Vector 3 [_SpecularColor]
Vector 8 [_WorldLightDir]
Vector 0 [_ZBufferParams]
Vector 1 [unity_FogColor]
Vector 2 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_ShoreTex] 2D 3
SetTexture 4 [_CameraDepthTexture] 2D 4
"ps_3_0
def c12, 2, -1, 0.5, 0
def c13, 10, -0.125, 0, 0
def c14, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c12.x, c12.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c12.x, c12.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c9.x
mad_pp r0.xyz, r0, c12.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c10.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c8
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c9.y
mul_pp r1.xy, r1, c13.x
max r2.w, r0.w, c12.w
pow r0.w, r2.w, c7.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c12.y
cmp_pp r0.x, r0.x, r0.y, -c12.y
max_pp r2.x, r0.x, c12.w
pow_pp r0.x, r2.x, c9.z
mov r0.y, c12.y
lrp_sat_pp r2.x, r0.x, -r0.y, c9.w
mov r1.zw, c12.w
add_pp r3, r1, v4
add_pp r1, r1.xyww, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c5.w, c5, r1
texldp_pp r1, r3, s4
texldp_pp r3, r3, s2
mad r1.x, c0.z, r1.x, c0.w
rcp r1.x, r1.x
add r1.x, r1.x, -v3.z
texldp_pp r4, v4, s2
cmp_pp r1.xyz, r1.x, r3, r4
mul_pp r1.w, c6.w, v1.w
mov r3, c14
mad_pp r3, r1.w, -r3, c4
lrp_pp r2.yzw, r3.w, r3.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r0, r2.yzww
mad_pp r0.xyz, r0.w, c3, r1
add_pp r1, v2, v2
texld r2, r1, s3
texld r1, r1.zwzw, s3
mad_pp r1.xyz, r2, r1, c13.y
mul r1.xyz, r1, c11.x
texldp_pp r2, v3, s4
mad r0.w, c0.z, r2.x, c0.w
rcp_pp r0.w, r0.w
add r0.w, r0.w, -v3.w
mul_sat_pp r2.xy, r0.w, c6
add_pp r0.w, -r2.y, -c12.y
mov_pp oC0.w, r2.x
add_sat r1.w, -c11.y, v1.w
add r0.w, r0.w, r1.w
mad_pp r0.xyz, r1, r0.w, r0
add r0.xyz, r0, -c1
mul r0.w, c2.y, v5.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 2
SetTexture 2 [_CameraDepthTexture] 2D 4
SetTexture 3 [_ReflectionTex] 2D 1
SetTexture 4 [_ShoreTex] 2D 3
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0
eefiecedkonmobnfkdmonppcaoflhobnejcnmbcbabaaaaaakaamaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ababaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgialaaaaeaaaaaaankacaaaa
fjaaaaaeegiocaaaaaaaaaaabjaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagcbaaaadbcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaap
hcaabaaaabaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaa
acaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaabaaaaaapganbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaam
hcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadp
aaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaidcaabaaa
acaaaaaaigaabaaaabaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaa
acaaaaaaegaabaaaacaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaa
dgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaacaaaaaaegbdbaaaafaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegbdbaaaaeaaaaaaaoaaaaahdcaabaaaacaaaaaaegaabaaaacaaaaaa
kgakbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaabaaaaaaaoaaaaahdcaabaaaadaaaaaaegaabaaaadaaaaaa
kgakbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaa
acaaaaaaaagabaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaalicaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaaeaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackbabaaaaeaaaaaa
dhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
adaaaaaadiaaaaaiicaabaaaaaaaaaaadkbabaaaacaaaaaadkiacaaaaaaaaaaa
alaaaaaadcaaaaaopcaabaaaadaaaaaapgapbaiaebaaaaaaaaaaaaaaaceaaaaa
jkjjbjdoipmcpfdmaknhcddmaaaaaaaaegiocaaaaaaaaaaaajaaaaaaaaaaaaai
hcaabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaapgapbaaaadaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaaaaaaaaaa
akaaaaaadcaaaaakhcaabaaaacaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaa
adaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaa
aaaaaaaaegacbaaaacaaaaaadiaaaaaifcaabaaaadaaaaaaagacbaaaabaaaaaa
agiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaadaaaaaabkaabaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaa
aaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaaafaaaaaaegbcbaaaacaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaa
egacbaiaebaaaaaaaeaaaaaaegacbaaaadaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaa
dkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaa
dcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaaadaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaabaaaaaaeghobaaaaeaaaaaaaagabaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaeaaaaaaaagabaaaadaaaaaa
dcaaaaamhcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaaloaaaaaaloaaaaaaloaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaagiacaaaaaaaaaaabiaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaaeaaaaaadcaaaaalicaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaiaebaaaaaa
aeaaaaaadicaaaaidcaabaaaacaaaaaapgapbaaaaaaaaaaaegiacaaaaaaaaaaa
alaaaaaaaaaaaaaiicaabaaaaaaaaaaabkaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpdgaaaaaficcabaaaaaaaaaaaakaabaaaacaaaaaaaacaaaajicaabaaa
abaaaaaadkbabaaaacaaaaaabkiacaiaebaaaaaaaaaaaaaabiaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaaakbabaaaagaaaaaabkiacaaaacaaaaaaabaaaaaa
bjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Vector 2 [_BaseColor]
Vector 7 [_DistortParams]
Vector 9 [_Foam]
Float 8 [_FresnelScale]
Vector 4 [_InvFadeParemeter]
Vector 3 [_ReflectionColor]
Float 5 [_Shininess]
Vector 1 [_SpecularColor]
Vector 6 [_WorldLightDir]
Vector 0 [_ZBufferParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_ShoreTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
"ps_3_0
def c10, 2, -1, 0.5, 0
def c11, 10, -0.125, 0, 0
def c12, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c10.x, c10.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c10.x, c10.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mad_pp r0.xyz, r0, c10.zwzw, v0
nrm_pp r1.xyz, r0
mul r0.xy, r1.xzzw, c7.y
mul_pp r0.xy, r0, c11.x
mov r0.zw, c10.w
add_pp r0, r0, v4
texldp_pp r2, r0, s3
texldp_pp r0, r0, s1
mad r0.w, c0.z, r2.x, c0.w
rcp r0.w, r0.w
add r0.w, r0.w, -v3.z
texldp_pp r2, v4, s1
cmp_pp r0.xyz, r0.w, r0, r2
mul_pp r0.w, c4.w, v1.w
mov r2, c12
mad_pp r2, r0.w, -r2, c2
lrp_pp r3.xyz, r2.w, r2, r0
mul_pp r0.xz, r1, c8.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r4.xyz, v1, r0.w, c6
nrm_pp r5.xyz, r4
dp3_pp r0.w, r1, -r5
max r1.x, r0.w, c10.w
pow r0.w, r1.x, c5.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c10.y
cmp_pp r0.x, r0.x, r0.y, -c10.y
max_pp r1.x, r0.x, c10.w
pow_pp r0.x, r1.x, c7.z
mov r0.y, c10.y
lrp_sat_pp r1.x, r0.x, -r0.y, c7.w
lrp_pp r0.xyz, r1.x, c3, r3
mad_pp r0.xyz, r0.w, c1, r0
add_pp r1, v2, v2
texld r2, r1, s2
texld r1, r1.zwzw, s2
mad_pp r1.xyz, r2, r1, c11.y
mul r1.xyz, r1, c9.x
texldp_pp r2, v3, s3
mad r0.w, c0.z, r2.x, c0.w
rcp_pp r0.w, r0.w
add r0.w, r0.w, -v3.w
mul_sat_pp r2.xy, r0.w, c4
add_pp r0.w, -r2.y, -c10.y
mov_pp oC0.w, r2.x
add_sat r1.w, -c9.y, v1.w
add r0.w, r0.w, r1.w
mad_pp oC0.xyz, r1, r0.w, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 3
SetTexture 3 [_ShoreTex] 2D 2
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedmejhabjdmlfadeelfbffbenpmgleojpoabaaaaaaamalaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcomajaaaa
eaaaaaaahlacaaaafjaaaaaeegiocaaaaaaaaaaabjaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaaoaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaa
aaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaaacaaaaaapgapbaaa
aaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaadiaaaaai
dcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaa
aaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegbdbaaaafaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaalicaabaaa
abaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaaabaaaaaa
ahaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaabaaaaaadbaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
ckbabaaaaeaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaafaaaaaapgbpbaaa
afaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadhaaaaajhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaaiicaabaaaabaaaaaadkbabaaaacaaaaaa
dkiacaaaaaaaaaaaalaaaaaadcaaaaaopcaabaaaacaaaaaapgapbaiaebaaaaaa
abaaaaaaaceaaaaajkjjbjdoipmcpfdmaknhcddmaaaaaaaaegiocaaaaaaaaaaa
ajaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
acaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaai
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaa
egacbaaaabaaaaaaaaaaaaahpcaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaa
adaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaa
adaaaaaaaagabaaaacaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaloaaaaaaloaaaaaaloaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaabiaaaaaaaoaaaaah
dcaabaaaacaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaal
icaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaiaebaaaaaaaeaaaaaadicaaaaidcaabaaaacaaaaaapgapbaaa
aaaaaaaaegiacaaaaaaaaaaaalaaaaaaaaaaaaaiicaabaaaaaaaaaaabkaabaia
ebaaaaaaacaaaaaaabeaaaaaaaaaiadpdgaaaaaficcabaaaaaaaaaaaakaabaaa
acaaaaaaaacaaaajicaabaaaabaaaaaadkbabaaaacaaaaaabkiacaiaebaaaaaa
aaaaaaaabiaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Vector 4 [_BaseColor]
Vector 9 [_DistortParams]
Vector 11 [_Foam]
Float 10 [_FresnelScale]
Vector 6 [_InvFadeParemeter]
Vector 5 [_ReflectionColor]
Float 7 [_Shininess]
Vector 3 [_SpecularColor]
Vector 8 [_WorldLightDir]
Vector 0 [_ZBufferParams]
Vector 1 [unity_FogColor]
Vector 2 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_ShoreTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
"ps_3_0
def c12, 2, -1, 0.5, 0
def c13, 10, -0.125, 0, 0
def c14, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c12.x, c12.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c12.x, c12.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c9.x
mad_pp r0.xyz, r0, c12.zwzw, v0
nrm_pp r1.xyz, r0
mul r0.xy, r1.xzzw, c9.y
mul_pp r0.xy, r0, c13.x
mov r0.zw, c12.w
add_pp r0, r0, v4
texldp_pp r2, r0, s3
texldp_pp r0, r0, s1
mad r0.w, c0.z, r2.x, c0.w
rcp r0.w, r0.w
add r0.w, r0.w, -v3.z
texldp_pp r2, v4, s1
cmp_pp r0.xyz, r0.w, r0, r2
mul_pp r0.w, c6.w, v1.w
mov r2, c14
mad_pp r2, r0.w, -r2, c4
lrp_pp r3.xyz, r2.w, r2, r0
mul_pp r0.xz, r1, c10.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r4.xyz, v1, r0.w, c8
nrm_pp r5.xyz, r4
dp3_pp r0.w, r1, -r5
max r1.x, r0.w, c12.w
pow r0.w, r1.x, c7.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c12.y
cmp_pp r0.x, r0.x, r0.y, -c12.y
max_pp r1.x, r0.x, c12.w
pow_pp r0.x, r1.x, c9.z
mov r0.y, c12.y
lrp_sat_pp r1.x, r0.x, -r0.y, c9.w
lrp_pp r0.xyz, r1.x, c5, r3
mad_pp r0.xyz, r0.w, c3, r0
add_pp r1, v2, v2
texld r2, r1, s2
texld r1, r1.zwzw, s2
mad_pp r1.xyz, r2, r1, c13.y
mul r1.xyz, r1, c11.x
texldp_pp r2, v3, s3
mad r0.w, c0.z, r2.x, c0.w
rcp_pp r0.w, r0.w
add r0.w, r0.w, -v3.w
mul_sat_pp r2.xy, r0.w, c6
add_pp r0.w, -r2.y, -c12.y
mov_pp oC0.w, r2.x
add_sat r1.w, -c11.y, v1.w
add r0.w, r0.w, r1.w
mad_pp r0.xyz, r1, r0.w, r0
add r0.xyz, r0, -c1
mul r0.w, c2.y, v5.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 3
SetTexture 3 [_ShoreTex] 2D 2
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0
eefiecedkpipnkoafpjcljddoggchflmmenjcbpkabaaaaaaoaalaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ababaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckiakaaaaeaaaaaaakkacaaaa
fjaaaaaeegiocaaaaaaaaaaabjaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagcbaaaad
bcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaa
dcaaaaamhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
fcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaaf
ccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaak
hcaabaaaadaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaa
anaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaa
abeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaaoaaaaaadiaaaaaidcaabaaaabaaaaaaigaabaaa
aaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaa
abaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaa
abaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egbdbaaaafaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaalicaabaaaabaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaacaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakicaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaabaaaaaa
dbaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaackbabaaaaeaaaaaaaoaaaaah
dcaabaaaacaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadhaaaaaj
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaiicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaaaaaaaaaaaalaaaaaa
dcaaaaaopcaabaaaacaaaaaapgapbaiaebaaaaaaabaaaaaaaceaaaaajkjjbjdo
ipmcpfdmaknhcddmaaaaaaaaegiocaaaaaaaaaaaajaaaaaaaaaaaaaihcaabaaa
acaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaa
abaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaa
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaah
pcaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaaadaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaadaaaaaaaagabaaaacaaaaaa
dcaaaaamhcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaaloaaaaaaloaaaaaaloaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaagiacaaaaaaaaaaabiaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaalicaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
icaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaiaebaaaaaa
aeaaaaaadicaaaaidcaabaaaacaaaaaapgapbaaaaaaaaaaaegiacaaaaaaaaaaa
alaaaaaaaaaaaaaiicaabaaaaaaaaaaabkaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpdgaaaaaficcabaaaaaaaaaaaakaabaaaacaaaaaaaacaaaajicaabaaa
abaaaaaadkbabaaaacaaaaaabkiacaiaebaaaaaaaaaaaaaabiaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaaakbabaaaagaaaaaabkiacaaaacaaaaaaabaaaaaa
bjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Vector 1 [_BaseColor]
Vector 6 [_DistortParams]
Vector 8 [_Foam]
Float 7 [_FresnelScale]
Vector 3 [_InvFadeParemeter]
Vector 2 [_ReflectionColor]
Float 4 [_Shininess]
Vector 0 [_SpecularColor]
Vector 5 [_WorldLightDir]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_ShoreTex] 2D 3
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, -0.125, 0, 0
def c11, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c6.x
mad_pp r0.xyz, r0, c9.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c7.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c5
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c6.y
mul_pp r1.xy, r1, c10.x
max r2.w, r0.w, c9.w
pow r0.w, r2.w, c4.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c9.y
cmp_pp r0.x, r0.x, r0.y, -c9.y
max_pp r2.x, r0.x, c9.w
pow_pp r0.x, r2.x, c6.z
mov r0.y, c9.y
lrp_sat_pp r2.x, r0.x, -r0.y, c6.w
mov r1.zw, c9.w
add_pp r3, r1, v4
add_pp r1, r1.xyww, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c2.w, c2, r1
texldp_pp r1, r3, s2
mul_pp r1.w, c3.w, v1.w
mov r3, c11
mad_pp r3, r1.w, -r3, c1
lrp_pp r2.yzw, r3.w, r3.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r0, r2.yzww
mad_pp r0.xyz, r0.w, c0, r1
add_pp r1, v2, v2
texld r2, r1, s3
texld r1, r1.zwzw, s3
mad_pp r1.xyz, r2, r1, c10.y
mul r1.xyz, r1, c8.x
add_sat r0.w, -c8.y, v1.w
mad_pp oC0.xyz, r1, r0.w, r0
mov_pp oC0.w, -c9.y

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 2
SetTexture 2 [_ReflectionTex] 2D 1
SetTexture 3 [_ShoreTex] 2D 3
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlbdgfemdbcmdfdlpjcelpggiancodbkbabaaaaaajiajaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchiaiaaaa
eaaaaaaaboacaaaafjaaaaaeegiocaaaaaaaaaaabjaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagcbaaaadlcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaap
hcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaam
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadp
aaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaa
abaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaa
abaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaa
adaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
baaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaoaaaaaadiaaaaaidcaabaaaabaaaaaaigaabaaaaaaaaaaa
fgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegbdbaaa
aeaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaaafaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
aoaaaaahdcaabaaaacaaaaaaegaabaaaacaaaaaakgakbaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaa
aaaaaaajhcaabaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaaaaaaaaaa
akaaaaaadcaaaaakhcaabaaaacaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaadiaaaaaiicaabaaaabaaaaaadkbabaaaacaaaaaa
dkiacaaaaaaaaaaaalaaaaaadcaaaaaopcaabaaaaeaaaaaapgapbaiaebaaaaaa
abaaaaaaaceaaaaajkjjbjdoipmcpfdmaknhcddmaaaaaaaaegiocaaaaaaaaaaa
ajaaaaaaaaaaaaaihcaabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
aeaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaeaaaaaaegacbaaaaeaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaa
abaaaaaaaaaaaaahpcaabaaaabaaaaaaegbobaaaadaaaaaaegbobaaaadaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaaaloaaaaaaloaaaaaaloaaaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaabiaaaaaaaacaaaajicaabaaa
aaaaaaaadkbabaaaacaaaaaabkiacaiaebaaaaaaaaaaaaaabiaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Vector 3 [_BaseColor]
Vector 8 [_DistortParams]
Vector 10 [_Foam]
Float 9 [_FresnelScale]
Vector 5 [_InvFadeParemeter]
Vector 4 [_ReflectionColor]
Float 6 [_Shininess]
Vector 2 [_SpecularColor]
Vector 7 [_WorldLightDir]
Vector 0 [unity_FogColor]
Vector 1 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_ShoreTex] 2D 3
"ps_3_0
def c11, 2, -1, 0.5, 0
def c12, 10, -0.125, 0, 0
def c13, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c11.x, c11.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c11.x, c11.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c8.x
mad_pp r0.xyz, r0, c11.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c9.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c7
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c8.y
mul_pp r1.xy, r1, c12.x
max r2.w, r0.w, c11.w
pow r0.w, r2.w, c6.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c11.y
cmp_pp r0.x, r0.x, r0.y, -c11.y
max_pp r2.x, r0.x, c11.w
pow_pp r0.x, r2.x, c8.z
mov r0.y, c11.y
lrp_sat_pp r2.x, r0.x, -r0.y, c8.w
mov r1.zw, c11.w
add_pp r3, r1, v4
add_pp r1, r1.xyww, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c4.w, c4, r1
texldp_pp r1, r3, s2
mul_pp r1.w, c5.w, v1.w
mov r3, c13
mad_pp r3, r1.w, -r3, c3
lrp_pp r2.yzw, r3.w, r3.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r0, r2.yzww
mad_pp r0.xyz, r0.w, c2, r1
add_pp r1, v2, v2
texld r2, r1, s3
texld r1, r1.zwzw, s3
mad_pp r1.xyz, r2, r1, c12.y
mul r1.xyz, r1, c10.x
add_sat r0.w, -c10.y, v1.w
mad_pp r0.xyz, r1, r0.w, r0
add r0.xyz, r0, -c0
mul r0.w, c1.y, v5.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c0
mov_pp oC0.w, -c11.y

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 2
SetTexture 2 [_ReflectionTex] 2D 1
SetTexture 3 [_ShoreTex] 2D 3
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedglkklfodbgdonjoiafbimimgnabecbhnabaaaaaagmakaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ababaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeajaaaaeaaaaaaaenacaaaa
fjaaaaaeegiocaaaaaaaaaaabjaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaa
gcbaaaadlcbabaaaafaaaaaagcbaaaadbcbabaaaagaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaaegbcbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaa
agiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaaacaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaa
dkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaa
aaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaa
diaaaaaidcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaa
diaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaacaebaaaacaeb
aaaaaaaaaaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaabaaaaaaegbdbaaaaeaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegbdbaaaafaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaaoaaaaahdcaabaaaacaaaaaa
egaabaaaacaaaaaakgakbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaaaaaaaajhcaabaaaaeaaaaaa
egacbaiaebaaaaaaacaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
acaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaa
diaaaaaiicaabaaaabaaaaaadkbabaaaacaaaaaadkiacaaaaaaaaaaaalaaaaaa
dcaaaaaopcaabaaaaeaaaaaapgapbaiaebaaaaaaabaaaaaaaceaaaaajkjjbjdo
ipmcpfdmaknhcddmaaaaaaaaegiocaaaaaaaaaaaajaaaaaaaaaaaaaihcaabaaa
aeaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaaeaaaaaadcaaaaajhcaabaaa
abaaaaaapgapbaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaahpcaabaaa
abaaaaaaegbobaaaadaaaaaaegbobaaaadaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaam
hcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaalo
aaaaaaloaaaaaaloaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
agiacaaaaaaaaaaabiaaaaaaaacaaaajicaabaaaaaaaaaaadkbabaaaacaaaaaa
bkiacaiaebaaaaaaaaaaaaaabiaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaaakbabaaaagaaaaaabkiacaaaabaaaaaaabaaaaaabjaaaaagicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Vector 1 [_BaseColor]
Vector 6 [_DistortParams]
Vector 8 [_Foam]
Float 7 [_FresnelScale]
Vector 3 [_InvFadeParemeter]
Vector 2 [_ReflectionColor]
Float 4 [_Shininess]
Vector 0 [_SpecularColor]
Vector 5 [_WorldLightDir]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_ShoreTex] 2D 2
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, -0.125, 0, 0
def c11, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord4 v3
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c6.x
mad_pp r0.xyz, r0, c9.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c7.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c5
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c6.y
mul_pp r1.xy, r1, c10.x
max r2.w, r0.w, c9.w
pow r0.w, r2.w, c4.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c9.y
cmp_pp r0.x, r0.x, r0.y, -c9.y
max_pp r2.x, r0.x, c9.w
pow_pp r0.x, r2.x, c6.z
mov r0.y, c9.y
lrp_sat_pp r2.x, r0.x, -r0.y, c6.w
mov r1.zw, c9.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
mul_pp r0.x, c3.w, v1.w
mov r3, c11
mad_pp r3, r0.x, -r3, c1
lrp_pp r0.xyz, r3.w, r3, r1
lrp_pp r1.xyz, r2.x, c2, r0
mad_pp r0.xyz, r0.w, c0, r1
add_pp r1, v2, v2
texld r2, r1, s2
texld r1, r1.zwzw, s2
mad_pp r1.xyz, r2, r1, c10.y
mul r1.xyz, r1, c8.x
add_sat r0.w, -c8.y, v1.w
mad_pp oC0.xyz, r1, r0.w, r0
mov_pp oC0.w, -c9.y

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_ShoreTex] 2D 2
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
BindCB  "$Globals" 0
"ps_4_0
eefiecedflgfknjijlgimbkonncoghnaldkblpcpabaaaaaammaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmahaaaa
eaaaaaaaolabaaaafjaaaaaeegiocaaaaaaaaaaabjaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaa
pganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
pganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaamhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaaegbcbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaa
aaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaa
acaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaa
aaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaa
abaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaak
icaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
aoaaaaaadiaaaaaidcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaaaaaaaaaa
aoaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaacaeb
aaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaaafaaaaaaaoaaaaah
dcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaai
icaabaaaabaaaaaadkbabaaaacaaaaaadkiacaaaaaaaaaaaalaaaaaadcaaaaao
pcaabaaaacaaaaaapgapbaiaebaaaaaaabaaaaaaaceaaaaajkjjbjdoipmcpfdm
aknhcddmaaaaaaaaegiocaaaaaaaaaaaajaaaaaaaaaaaaaihcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
pgapbaaaacaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaaj
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaahpcaabaaa
abaaaaaaegbobaaaadaaaaaaegbobaaaadaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaam
hcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaalo
aaaaaaloaaaaaaloaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
agiacaaaaaaaaaaabiaaaaaaaacaaaajicaabaaaaaaaaaaadkbabaaaacaaaaaa
bkiacaiaebaaaaaaaaaaaaaabiaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Vector 3 [_BaseColor]
Vector 8 [_DistortParams]
Vector 10 [_Foam]
Float 9 [_FresnelScale]
Vector 5 [_InvFadeParemeter]
Vector 4 [_ReflectionColor]
Float 6 [_Shininess]
Vector 2 [_SpecularColor]
Vector 7 [_WorldLightDir]
Vector 0 [unity_FogColor]
Vector 1 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_ShoreTex] 2D 2
"ps_3_0
def c11, 2, -1, 0.5, 0
def c12, 10, -0.125, 0, 0
def c13, 0.150000006, 0.0299999993, 0.00999999978, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord4 v3
dcl_texcoord5 v4.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c11.x, c11.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c11.x, c11.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c8.x
mad_pp r0.xyz, r0, c11.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c9.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c7
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c8.y
mul_pp r1.xy, r1, c12.x
max r2.w, r0.w, c11.w
pow r0.w, r2.w, c6.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c11.y
cmp_pp r0.x, r0.x, r0.y, -c11.y
max_pp r2.x, r0.x, c11.w
pow_pp r0.x, r2.x, c8.z
mov r0.y, c11.y
lrp_sat_pp r2.x, r0.x, -r0.y, c8.w
mov r1.zw, c11.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
mul_pp r0.x, c5.w, v1.w
mov r3, c13
mad_pp r3, r0.x, -r3, c3
lrp_pp r0.xyz, r3.w, r3, r1
lrp_pp r1.xyz, r2.x, c4, r0
mad_pp r0.xyz, r0.w, c2, r1
add_pp r1, v2, v2
texld r2, r1, s2
texld r1, r1.zwzw, s2
mad_pp r1.xyz, r2, r1, c12.y
mul r1.xyz, r1, c10.x
add_sat r0.w, -c10.y, v1.w
mad_pp r0.xyz, r1, r0.w, r0
add r0.xyz, r0, -c0
mul r0.w, c1.y, v4.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c0
mov_pp oC0.w, -c11.y

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_ShoreTex] 2D 2
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
Vector 384 [_Foam]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedkjjbanpbmeekpfgncidoahlhekmgnbaiabaaaaaakaajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ababaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgiaiaaaaeaaaaaaabkacaaaa
fjaaaaaeegiocaaaaaaaaaaabjaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaa
afaaaaaagcbaaaadbcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaaoaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaaaaaaaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaa
apaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaa
acaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaa
egiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaadiaaaaaidcaabaaa
abaaaaaaigaabaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaa
dgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegbdbaaaafaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaa
abaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaaiicaabaaaabaaaaaadkbabaaa
acaaaaaadkiacaaaaaaaaaaaalaaaaaadcaaaaaopcaabaaaacaaaaaapgapbaia
ebaaaaaaabaaaaaaaceaaaaajkjjbjdoipmcpfdmaknhcddmaaaaaaaaegiocaaa
aaaaaaaaajaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaa
abaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaegacbaaaabaaaaaaaaaaaaahpcaabaaaabaaaaaaegbobaaaadaaaaaa
egbobaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaloaaaaaaloaaaaaaloaaaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaabiaaaaaa
aacaaaajicaabaaaaaaaaaaadkbabaaaacaaaaaabkiacaiaebaaaaaaaaaaaaaa
biaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaaakbabaaaagaaaaaa
bkiacaaaabaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
dcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
}
 }
}
SubShader { 
 LOD 300
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask RGB
  GpuProgramID 99646
Program "vp" {
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_4;
  vec4 tmpvar_5;
  tmpvar_5 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_7;
  tmpvar_7.x = dot (_GDirectionAB.xy, tmpvar_3.xz);
  tmpvar_7.y = dot (_GDirectionAB.zw, tmpvar_3.xz);
  tmpvar_7.z = dot (_GDirectionCD.xy, tmpvar_3.xz);
  tmpvar_7.w = dot (_GDirectionCD.zw, tmpvar_3.xz);
  vec4 tmpvar_8;
  tmpvar_8 = (_GFrequency * tmpvar_7);
  vec4 cse_9;
  cse_9 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_10;
  tmpvar_10 = cos((tmpvar_8 + cse_9));
  vec4 tmpvar_11;
  tmpvar_11.xy = tmpvar_5.xz;
  tmpvar_11.zw = tmpvar_6.xz;
  offsets_4.x = dot (tmpvar_10, tmpvar_11);
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_5.yw;
  tmpvar_12.zw = tmpvar_6.yw;
  offsets_4.z = dot (tmpvar_10, tmpvar_12);
  offsets_4.y = dot (sin((tmpvar_8 + cse_9)), _GAmplitude);
  vec2 xzVtx_13;
  xzVtx_13 = (tmpvar_3.xz + offsets_4.xz);
  vec3 nrml_14;
  nrml_14.y = 2.0;
  vec4 tmpvar_15;
  tmpvar_15 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_17;
  tmpvar_17.x = dot (_GDirectionAB.xy, xzVtx_13);
  tmpvar_17.y = dot (_GDirectionAB.zw, xzVtx_13);
  tmpvar_17.z = dot (_GDirectionCD.xy, xzVtx_13);
  tmpvar_17.w = dot (_GDirectionCD.zw, xzVtx_13);
  vec4 tmpvar_18;
  tmpvar_18 = cos(((_GFrequency * tmpvar_17) + cse_9));
  vec4 tmpvar_19;
  tmpvar_19.xy = tmpvar_15.xz;
  tmpvar_19.zw = tmpvar_16.xz;
  nrml_14.x = -(dot (tmpvar_18, tmpvar_19));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_15.yw;
  tmpvar_20.zw = tmpvar_16.yw;
  nrml_14.z = -(dot (tmpvar_18, tmpvar_20));
  nrml_14.xz = (nrml_14.xz * _GerstnerIntensity);
  vec3 tmpvar_21;
  tmpvar_21 = normalize(nrml_14);
  nrml_14 = tmpvar_21;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_4);
  vec4 tmpvar_22;
  tmpvar_22 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 o_23;
  vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_22 * 0.5);
  vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_23;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_8;
  tmpvar_8 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, mix (texture2DProj (_ReflectionTex, 
    (xlv_TEXCOORD3 + tmpvar_7)
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (tmpvar_8 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = (clamp ((_InvFadeParemeter * 
    ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w))) - xlv_TEXCOORD3.z)
  ), 0.0, 1.0).x * clamp ((0.5 + tmpvar_8), 0.0, 1.0));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
def c21, 0.159154937, 0.5, 6.28318548, -3.14159274
def c22, 1, 0.159154937, 0.25, 2
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c21.x, c21.y
mad r3, r3, c22.y, c22.z
frc r3, r3
mad r3, r3, c21.z, c21.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c21.z, c21.w
mul r4, r4, r4
mad r5, r4, c20.x, c20.y
mad r5, r4, r5, c20.z
mad r5, r4, r5, c20.w
mad r5, r4, r5, -c21.y
mad r4, r4, r5, c22.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c21.x, c21.y
frc r1, r1
mad r1, r1, c21.z, c21.w
mul r1, r1, r1
mad r4, r1, c20.x, c20.y
mad r4, r1, r4, c20.z
mad r4, r1, r4, c20.w
mad r4, r1, r4, -c21.y
mad r1, r1, r4, c22.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c22.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c20.x, c20.y
mad r1, r3, r1, c20.z
mad r1, r3, r1, c20.w
mad r1, r3, r1, -c21.y
mad r1, r3, r1, c22.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.w, c3, r1
mul r2.xz, r0.xyww, c21.y
dp4 r0.y, c1, r1
dp4 r0.z, c2, r1
mul r1.x, r0.y, c9.x
mov o0, r0
mov o4.zw, r0
mul r2.w, r1.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhhflnhffmdmplbafolcfljonmmfkjdbjabaaaaaajeajaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcmiahaaaaeaaaabaapcabaaaafjaaaaaeegiocaaaaaaaaaaa
biaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaaabaaaaaaegiacaaa
aaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaaabaaaaaaogikcaaa
aaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaaabaaaaaaegiacaaa
aaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaaabaaaaaaogikcaaa
aaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaa
aaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaenaaaaah
pcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
abaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaajpcaabaaa
aeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaadiaaaaai
pcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaaagaibaaa
aeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaahecaabaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaaabaaaaaa
egaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
abaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaabaaaaaaigaabaaaaaaaaaaa
igaabaaaabaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaaadaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaaibcaabaaa
aeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaaiccaabaaa
aeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaaiecaabaaa
aeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaaapaaaaaiicaabaaa
aeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaa
enaaaaagaanaaaaapcaabaaaabaaaaaaegaobaaaabaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaa
acaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahbcaabaaa
acaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaadgaaaaagecaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaa
diaaaaaifcaabaaaabaaaaaaagacbaaaabaaaaaaagiacaaaaaaaaaaaagaaaaaa
dgaaaaafccaabaaaabaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaipcaabaaaabaaaaaa
fgafbaaaadaaaaaaigiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaa
igiicaaaacaaaaaaamaaaaaaagaabaaaadaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaigiicaaaacaaaaaaaoaaaaaakgakbaaaadaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaa
aaaaaaaaegiocaaaaaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaa
adaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_4;
  vec4 tmpvar_5;
  tmpvar_5 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_7;
  tmpvar_7.x = dot (_GDirectionAB.xy, tmpvar_3.xz);
  tmpvar_7.y = dot (_GDirectionAB.zw, tmpvar_3.xz);
  tmpvar_7.z = dot (_GDirectionCD.xy, tmpvar_3.xz);
  tmpvar_7.w = dot (_GDirectionCD.zw, tmpvar_3.xz);
  vec4 tmpvar_8;
  tmpvar_8 = (_GFrequency * tmpvar_7);
  vec4 cse_9;
  cse_9 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_10;
  tmpvar_10 = cos((tmpvar_8 + cse_9));
  vec4 tmpvar_11;
  tmpvar_11.xy = tmpvar_5.xz;
  tmpvar_11.zw = tmpvar_6.xz;
  offsets_4.x = dot (tmpvar_10, tmpvar_11);
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_5.yw;
  tmpvar_12.zw = tmpvar_6.yw;
  offsets_4.z = dot (tmpvar_10, tmpvar_12);
  offsets_4.y = dot (sin((tmpvar_8 + cse_9)), _GAmplitude);
  vec2 xzVtx_13;
  xzVtx_13 = (tmpvar_3.xz + offsets_4.xz);
  vec3 nrml_14;
  nrml_14.y = 2.0;
  vec4 tmpvar_15;
  tmpvar_15 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_17;
  tmpvar_17.x = dot (_GDirectionAB.xy, xzVtx_13);
  tmpvar_17.y = dot (_GDirectionAB.zw, xzVtx_13);
  tmpvar_17.z = dot (_GDirectionCD.xy, xzVtx_13);
  tmpvar_17.w = dot (_GDirectionCD.zw, xzVtx_13);
  vec4 tmpvar_18;
  tmpvar_18 = cos(((_GFrequency * tmpvar_17) + cse_9));
  vec4 tmpvar_19;
  tmpvar_19.xy = tmpvar_15.xz;
  tmpvar_19.zw = tmpvar_16.xz;
  nrml_14.x = -(dot (tmpvar_18, tmpvar_19));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_15.yw;
  tmpvar_20.zw = tmpvar_16.yw;
  nrml_14.z = -(dot (tmpvar_18, tmpvar_20));
  nrml_14.xz = (nrml_14.xz * _GerstnerIntensity);
  vec3 tmpvar_21;
  tmpvar_21 = normalize(nrml_14);
  nrml_14 = tmpvar_21;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_4);
  vec4 tmpvar_22;
  tmpvar_22 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 o_23;
  vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_22 * 0.5);
  vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_23;
  xlv_TEXCOORD4 = tmpvar_22.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_8;
  tmpvar_8 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, mix (texture2DProj (_ReflectionTex, 
    (xlv_TEXCOORD3 + tmpvar_7)
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (tmpvar_8 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = (clamp ((_InvFadeParemeter * 
    ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w))) - xlv_TEXCOORD3.z)
  ), 0.0, 1.0).x * clamp ((0.5 + tmpvar_8), 0.0, 1.0));
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD4))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
def c21, 0.159154937, 0.5, 6.28318548, -3.14159274
def c22, 1, 0.159154937, 0.25, 2
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.x
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c21.x, c21.y
mad r3, r3, c22.y, c22.z
frc r3, r3
mad r3, r3, c21.z, c21.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c21.z, c21.w
mul r4, r4, r4
mad r5, r4, c20.x, c20.y
mad r5, r4, r5, c20.z
mad r5, r4, r5, c20.w
mad r5, r4, r5, -c21.y
mad r4, r4, r5, c22.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c21.x, c21.y
frc r1, r1
mad r1, r1, c21.z, c21.w
mul r1, r1, r1
mad r4, r1, c20.x, c20.y
mad r4, r1, r4, c20.z
mad r4, r1, r4, c20.w
mad r4, r1, r4, -c21.y
mad r1, r1, r4, c22.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c22.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c20.x, c20.y
mad r1, r3, r1, c20.z
mad r1, r3, r1, c20.w
mad r1, r3, r1, -c21.y
mad r1, r3, r1, c22.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.w, c3, r1
mul r2.xz, r0.xyww, c21.y
dp4 r0.y, c1, r1
dp4 r0.z, c2, r1
mul r1.x, r0.y, c9.x
mov o0, r0
mov o4.zw, r0
mov o5.x, r0.z
mul r2.w, r1.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedojdbeeebknncjiclejanlfahmfadcblcabaaaaaammajaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oiahaaaaeaaaabaapkabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaaabaaaaaa
egiacaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaaabaaaaaa
ogikcaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaaabaaaaaa
egiacaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaaabaaaaaa
ogikcaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
enaaaaahpcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaabaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaabaaaaaaigaabaaa
aaaaaaaaigaabaaaabaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaa
adaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagaabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaai
bcaabaaaaeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaai
ccaabaaaaeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaai
ecaabaaaaeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaaapaaaaai
icaabaaaaeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaa
acaaaaaaenaaaaagaanaaaaapcaabaaaabaaaaaaegaobaaaabaaaaaadiaaaaaj
pcaabaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaa
diaaaaaipcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaa
agaibaaaacaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaah
bcaabaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaadgaaaaagecaabaaaabaaaaaaakaabaiaebaaaaaa
acaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaabaaaaaaagiacaaaaaaaaaaa
agaaaaaadgaaaaafccaabaaaabaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpdgaaaaaficcabaaa
acaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaadaaaaaa
igiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaigiicaaaacaaaaaa
amaaaaaaagaabaaaadaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
igiicaaaacaaaaaaaoaaaaaakgakbaaaadaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
aeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_4;
  vec4 tmpvar_5;
  tmpvar_5 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_7;
  tmpvar_7.x = dot (_GDirectionAB.xy, tmpvar_3.xz);
  tmpvar_7.y = dot (_GDirectionAB.zw, tmpvar_3.xz);
  tmpvar_7.z = dot (_GDirectionCD.xy, tmpvar_3.xz);
  tmpvar_7.w = dot (_GDirectionCD.zw, tmpvar_3.xz);
  vec4 tmpvar_8;
  tmpvar_8 = (_GFrequency * tmpvar_7);
  vec4 cse_9;
  cse_9 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_10;
  tmpvar_10 = cos((tmpvar_8 + cse_9));
  vec4 tmpvar_11;
  tmpvar_11.xy = tmpvar_5.xz;
  tmpvar_11.zw = tmpvar_6.xz;
  offsets_4.x = dot (tmpvar_10, tmpvar_11);
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_5.yw;
  tmpvar_12.zw = tmpvar_6.yw;
  offsets_4.z = dot (tmpvar_10, tmpvar_12);
  offsets_4.y = dot (sin((tmpvar_8 + cse_9)), _GAmplitude);
  vec2 xzVtx_13;
  xzVtx_13 = (tmpvar_3.xz + offsets_4.xz);
  vec3 nrml_14;
  nrml_14.y = 2.0;
  vec4 tmpvar_15;
  tmpvar_15 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_17;
  tmpvar_17.x = dot (_GDirectionAB.xy, xzVtx_13);
  tmpvar_17.y = dot (_GDirectionAB.zw, xzVtx_13);
  tmpvar_17.z = dot (_GDirectionCD.xy, xzVtx_13);
  tmpvar_17.w = dot (_GDirectionCD.zw, xzVtx_13);
  vec4 tmpvar_18;
  tmpvar_18 = cos(((_GFrequency * tmpvar_17) + cse_9));
  vec4 tmpvar_19;
  tmpvar_19.xy = tmpvar_15.xz;
  tmpvar_19.zw = tmpvar_16.xz;
  nrml_14.x = -(dot (tmpvar_18, tmpvar_19));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_15.yw;
  tmpvar_20.zw = tmpvar_16.yw;
  nrml_14.z = -(dot (tmpvar_18, tmpvar_20));
  nrml_14.xz = (nrml_14.xz * _GerstnerIntensity);
  vec3 tmpvar_21;
  tmpvar_21 = normalize(nrml_14);
  nrml_14 = tmpvar_21;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_4);
  vec4 tmpvar_22;
  tmpvar_22 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 o_23;
  vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_22 * 0.5);
  vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_23;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _BumpMap;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_7;
  tmpvar_7 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, _ReflectionColor, vec4(clamp (
    (tmpvar_7 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = (clamp ((_InvFadeParemeter * 
    ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w))) - xlv_TEXCOORD3.z)
  ), 0.0, 1.0).x * clamp ((0.5 + tmpvar_7), 0.0, 1.0));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
def c21, 0.159154937, 0.5, 6.28318548, -3.14159274
def c22, 1, 0.159154937, 0.25, 2
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c21.x, c21.y
mad r3, r3, c22.y, c22.z
frc r3, r3
mad r3, r3, c21.z, c21.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c21.z, c21.w
mul r4, r4, r4
mad r5, r4, c20.x, c20.y
mad r5, r4, r5, c20.z
mad r5, r4, r5, c20.w
mad r5, r4, r5, -c21.y
mad r4, r4, r5, c22.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c21.x, c21.y
frc r1, r1
mad r1, r1, c21.z, c21.w
mul r1, r1, r1
mad r4, r1, c20.x, c20.y
mad r4, r1, r4, c20.z
mad r4, r1, r4, c20.w
mad r4, r1, r4, -c21.y
mad r1, r1, r4, c22.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c22.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c20.x, c20.y
mad r1, r3, r1, c20.z
mad r1, r3, r1, c20.w
mad r1, r3, r1, -c21.y
mad r1, r3, r1, c22.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.w, c3, r1
mul r2.xz, r0.xyww, c21.y
dp4 r0.y, c1, r1
dp4 r0.z, c2, r1
mul r1.x, r0.y, c9.x
mov o0, r0
mov o4.zw, r0
mul r2.w, r1.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhhflnhffmdmplbafolcfljonmmfkjdbjabaaaaaajeajaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcmiahaaaaeaaaabaapcabaaaafjaaaaaeegiocaaaaaaaaaaa
biaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaaabaaaaaaegiacaaa
aaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaaabaaaaaaogikcaaa
aaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaaabaaaaaaegiacaaa
aaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaaabaaaaaaogikcaaa
aaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaa
aaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaenaaaaah
pcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
abaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaajpcaabaaa
aeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaadiaaaaai
pcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaaagaibaaa
aeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaahecaabaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaaabaaaaaa
egaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
abaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaabaaaaaaigaabaaaaaaaaaaa
igaabaaaabaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaaadaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaaibcaabaaa
aeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaaiccaabaaa
aeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaaiecaabaaa
aeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaaapaaaaaiicaabaaa
aeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaa
enaaaaagaanaaaaapcaabaaaabaaaaaaegaobaaaabaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaa
acaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahbcaabaaa
acaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaadgaaaaagecaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaa
diaaaaaifcaabaaaabaaaaaaagacbaaaabaaaaaaagiacaaaaaaaaaaaagaaaaaa
dgaaaaafccaabaaaabaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaipcaabaaaabaaaaaa
fgafbaaaadaaaaaaigiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaa
igiicaaaacaaaaaaamaaaaaaagaabaaaadaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaigiicaaaacaaaaaaaoaaaaaakgakbaaaadaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaa
aaaaaaaaegiocaaaaaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaa
adaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_4;
  vec4 tmpvar_5;
  tmpvar_5 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_7;
  tmpvar_7.x = dot (_GDirectionAB.xy, tmpvar_3.xz);
  tmpvar_7.y = dot (_GDirectionAB.zw, tmpvar_3.xz);
  tmpvar_7.z = dot (_GDirectionCD.xy, tmpvar_3.xz);
  tmpvar_7.w = dot (_GDirectionCD.zw, tmpvar_3.xz);
  vec4 tmpvar_8;
  tmpvar_8 = (_GFrequency * tmpvar_7);
  vec4 cse_9;
  cse_9 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_10;
  tmpvar_10 = cos((tmpvar_8 + cse_9));
  vec4 tmpvar_11;
  tmpvar_11.xy = tmpvar_5.xz;
  tmpvar_11.zw = tmpvar_6.xz;
  offsets_4.x = dot (tmpvar_10, tmpvar_11);
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_5.yw;
  tmpvar_12.zw = tmpvar_6.yw;
  offsets_4.z = dot (tmpvar_10, tmpvar_12);
  offsets_4.y = dot (sin((tmpvar_8 + cse_9)), _GAmplitude);
  vec2 xzVtx_13;
  xzVtx_13 = (tmpvar_3.xz + offsets_4.xz);
  vec3 nrml_14;
  nrml_14.y = 2.0;
  vec4 tmpvar_15;
  tmpvar_15 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_17;
  tmpvar_17.x = dot (_GDirectionAB.xy, xzVtx_13);
  tmpvar_17.y = dot (_GDirectionAB.zw, xzVtx_13);
  tmpvar_17.z = dot (_GDirectionCD.xy, xzVtx_13);
  tmpvar_17.w = dot (_GDirectionCD.zw, xzVtx_13);
  vec4 tmpvar_18;
  tmpvar_18 = cos(((_GFrequency * tmpvar_17) + cse_9));
  vec4 tmpvar_19;
  tmpvar_19.xy = tmpvar_15.xz;
  tmpvar_19.zw = tmpvar_16.xz;
  nrml_14.x = -(dot (tmpvar_18, tmpvar_19));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_15.yw;
  tmpvar_20.zw = tmpvar_16.yw;
  nrml_14.z = -(dot (tmpvar_18, tmpvar_20));
  nrml_14.xz = (nrml_14.xz * _GerstnerIntensity);
  vec3 tmpvar_21;
  tmpvar_21 = normalize(nrml_14);
  nrml_14 = tmpvar_21;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_4);
  vec4 tmpvar_22;
  tmpvar_22 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 o_23;
  vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_22 * 0.5);
  vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_23;
  xlv_TEXCOORD4 = tmpvar_22.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_7;
  tmpvar_7 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, _ReflectionColor, vec4(clamp (
    (tmpvar_7 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = (clamp ((_InvFadeParemeter * 
    ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w))) - xlv_TEXCOORD3.z)
  ), 0.0, 1.0).x * clamp ((0.5 + tmpvar_7), 0.0, 1.0));
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD4))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
def c21, 0.159154937, 0.5, 6.28318548, -3.14159274
def c22, 1, 0.159154937, 0.25, 2
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.x
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c21.x, c21.y
mad r3, r3, c22.y, c22.z
frc r3, r3
mad r3, r3, c21.z, c21.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c21.z, c21.w
mul r4, r4, r4
mad r5, r4, c20.x, c20.y
mad r5, r4, r5, c20.z
mad r5, r4, r5, c20.w
mad r5, r4, r5, -c21.y
mad r4, r4, r5, c22.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c21.x, c21.y
frc r1, r1
mad r1, r1, c21.z, c21.w
mul r1, r1, r1
mad r4, r1, c20.x, c20.y
mad r4, r1, r4, c20.z
mad r4, r1, r4, c20.w
mad r4, r1, r4, -c21.y
mad r1, r1, r4, c22.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c22.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c20.x, c20.y
mad r1, r3, r1, c20.z
mad r1, r3, r1, c20.w
mad r1, r3, r1, -c21.y
mad r1, r3, r1, c22.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.w, c3, r1
mul r2.xz, r0.xyww, c21.y
dp4 r0.y, c1, r1
dp4 r0.z, c2, r1
mul r1.x, r0.y, c9.x
mov o0, r0
mov o4.zw, r0
mov o5.x, r0.z
mul r2.w, r1.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedojdbeeebknncjiclejanlfahmfadcblcabaaaaaammajaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oiahaaaaeaaaabaapkabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaaabaaaaaa
egiacaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaaabaaaaaa
ogikcaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaaabaaaaaa
egiacaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaaabaaaaaa
ogikcaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
enaaaaahpcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaabaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaabaaaaaaigaabaaa
aaaaaaaaigaabaaaabaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaa
adaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagaabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaai
bcaabaaaaeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaai
ccaabaaaaeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaai
ecaabaaaaeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaaapaaaaai
icaabaaaaeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaa
acaaaaaaenaaaaagaanaaaaapcaabaaaabaaaaaaegaobaaaabaaaaaadiaaaaaj
pcaabaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaa
diaaaaaipcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaa
agaibaaaacaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaah
bcaabaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaadgaaaaagecaabaaaabaaaaaaakaabaiaebaaaaaa
acaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaabaaaaaaagiacaaaaaaaaaaa
agaaaaaadgaaaaafccaabaaaabaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpdgaaaaaficcabaaa
acaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaadaaaaaa
igiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaigiicaaaacaaaaaa
amaaaaaaagaabaaaadaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
igiicaaaacaaaaaaaoaaaaaakgakbaaaadaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
aeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_4;
  vec4 tmpvar_5;
  tmpvar_5 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_7;
  tmpvar_7.x = dot (_GDirectionAB.xy, tmpvar_3.xz);
  tmpvar_7.y = dot (_GDirectionAB.zw, tmpvar_3.xz);
  tmpvar_7.z = dot (_GDirectionCD.xy, tmpvar_3.xz);
  tmpvar_7.w = dot (_GDirectionCD.zw, tmpvar_3.xz);
  vec4 tmpvar_8;
  tmpvar_8 = (_GFrequency * tmpvar_7);
  vec4 cse_9;
  cse_9 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_10;
  tmpvar_10 = cos((tmpvar_8 + cse_9));
  vec4 tmpvar_11;
  tmpvar_11.xy = tmpvar_5.xz;
  tmpvar_11.zw = tmpvar_6.xz;
  offsets_4.x = dot (tmpvar_10, tmpvar_11);
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_5.yw;
  tmpvar_12.zw = tmpvar_6.yw;
  offsets_4.z = dot (tmpvar_10, tmpvar_12);
  offsets_4.y = dot (sin((tmpvar_8 + cse_9)), _GAmplitude);
  vec2 xzVtx_13;
  xzVtx_13 = (tmpvar_3.xz + offsets_4.xz);
  vec3 nrml_14;
  nrml_14.y = 2.0;
  vec4 tmpvar_15;
  tmpvar_15 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_17;
  tmpvar_17.x = dot (_GDirectionAB.xy, xzVtx_13);
  tmpvar_17.y = dot (_GDirectionAB.zw, xzVtx_13);
  tmpvar_17.z = dot (_GDirectionCD.xy, xzVtx_13);
  tmpvar_17.w = dot (_GDirectionCD.zw, xzVtx_13);
  vec4 tmpvar_18;
  tmpvar_18 = cos(((_GFrequency * tmpvar_17) + cse_9));
  vec4 tmpvar_19;
  tmpvar_19.xy = tmpvar_15.xz;
  tmpvar_19.zw = tmpvar_16.xz;
  nrml_14.x = -(dot (tmpvar_18, tmpvar_19));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_15.yw;
  tmpvar_20.zw = tmpvar_16.yw;
  nrml_14.z = -(dot (tmpvar_18, tmpvar_20));
  nrml_14.xz = (nrml_14.xz * _GerstnerIntensity);
  vec3 tmpvar_21;
  tmpvar_21 = normalize(nrml_14);
  nrml_14 = tmpvar_21;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_4);
  vec4 tmpvar_22;
  tmpvar_22 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 o_23;
  vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_22 * 0.5);
  vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_23;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_8;
  tmpvar_8 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, mix (texture2DProj (_ReflectionTex, 
    (xlv_TEXCOORD3 + tmpvar_7)
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (tmpvar_8 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((0.5 + tmpvar_8), 0.0, 1.0);
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
def c21, 0.159154937, 0.5, 6.28318548, -3.14159274
def c22, 1, 0.159154937, 0.25, 2
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c21.x, c21.y
mad r3, r3, c22.y, c22.z
frc r3, r3
mad r3, r3, c21.z, c21.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c21.z, c21.w
mul r4, r4, r4
mad r5, r4, c20.x, c20.y
mad r5, r4, r5, c20.z
mad r5, r4, r5, c20.w
mad r5, r4, r5, -c21.y
mad r4, r4, r5, c22.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c21.x, c21.y
frc r1, r1
mad r1, r1, c21.z, c21.w
mul r1, r1, r1
mad r4, r1, c20.x, c20.y
mad r4, r1, r4, c20.z
mad r4, r1, r4, c20.w
mad r4, r1, r4, -c21.y
mad r1, r1, r4, c22.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c22.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c20.x, c20.y
mad r1, r3, r1, c20.z
mad r1, r3, r1, c20.w
mad r1, r3, r1, -c21.y
mad r1, r3, r1, c22.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.w, c3, r1
mul r2.xz, r0.xyww, c21.y
dp4 r0.y, c1, r1
dp4 r0.z, c2, r1
mul r1.x, r0.y, c9.x
mov o0, r0
mov o4.zw, r0
mul r2.w, r1.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhhflnhffmdmplbafolcfljonmmfkjdbjabaaaaaajeajaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcmiahaaaaeaaaabaapcabaaaafjaaaaaeegiocaaaaaaaaaaa
biaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaaabaaaaaaegiacaaa
aaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaaabaaaaaaogikcaaa
aaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaaabaaaaaaegiacaaa
aaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaaabaaaaaaogikcaaa
aaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaa
aaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaenaaaaah
pcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
abaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaajpcaabaaa
aeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaadiaaaaai
pcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaaagaibaaa
aeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaahecaabaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaaabaaaaaa
egaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
abaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaabaaaaaaigaabaaaaaaaaaaa
igaabaaaabaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaaadaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaaibcaabaaa
aeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaaiccaabaaa
aeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaaiecaabaaa
aeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaaapaaaaaiicaabaaa
aeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaa
enaaaaagaanaaaaapcaabaaaabaaaaaaegaobaaaabaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaa
acaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahbcaabaaa
acaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaadgaaaaagecaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaa
diaaaaaifcaabaaaabaaaaaaagacbaaaabaaaaaaagiacaaaaaaaaaaaagaaaaaa
dgaaaaafccaabaaaabaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaipcaabaaaabaaaaaa
fgafbaaaadaaaaaaigiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaa
igiicaaaacaaaaaaamaaaaaaagaabaaaadaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaigiicaaaacaaaaaaaoaaaaaakgakbaaaadaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaa
aaaaaaaaegiocaaaaaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaa
adaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_4;
  vec4 tmpvar_5;
  tmpvar_5 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_7;
  tmpvar_7.x = dot (_GDirectionAB.xy, tmpvar_3.xz);
  tmpvar_7.y = dot (_GDirectionAB.zw, tmpvar_3.xz);
  tmpvar_7.z = dot (_GDirectionCD.xy, tmpvar_3.xz);
  tmpvar_7.w = dot (_GDirectionCD.zw, tmpvar_3.xz);
  vec4 tmpvar_8;
  tmpvar_8 = (_GFrequency * tmpvar_7);
  vec4 cse_9;
  cse_9 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_10;
  tmpvar_10 = cos((tmpvar_8 + cse_9));
  vec4 tmpvar_11;
  tmpvar_11.xy = tmpvar_5.xz;
  tmpvar_11.zw = tmpvar_6.xz;
  offsets_4.x = dot (tmpvar_10, tmpvar_11);
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_5.yw;
  tmpvar_12.zw = tmpvar_6.yw;
  offsets_4.z = dot (tmpvar_10, tmpvar_12);
  offsets_4.y = dot (sin((tmpvar_8 + cse_9)), _GAmplitude);
  vec2 xzVtx_13;
  xzVtx_13 = (tmpvar_3.xz + offsets_4.xz);
  vec3 nrml_14;
  nrml_14.y = 2.0;
  vec4 tmpvar_15;
  tmpvar_15 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_17;
  tmpvar_17.x = dot (_GDirectionAB.xy, xzVtx_13);
  tmpvar_17.y = dot (_GDirectionAB.zw, xzVtx_13);
  tmpvar_17.z = dot (_GDirectionCD.xy, xzVtx_13);
  tmpvar_17.w = dot (_GDirectionCD.zw, xzVtx_13);
  vec4 tmpvar_18;
  tmpvar_18 = cos(((_GFrequency * tmpvar_17) + cse_9));
  vec4 tmpvar_19;
  tmpvar_19.xy = tmpvar_15.xz;
  tmpvar_19.zw = tmpvar_16.xz;
  nrml_14.x = -(dot (tmpvar_18, tmpvar_19));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_15.yw;
  tmpvar_20.zw = tmpvar_16.yw;
  nrml_14.z = -(dot (tmpvar_18, tmpvar_20));
  nrml_14.xz = (nrml_14.xz * _GerstnerIntensity);
  vec3 tmpvar_21;
  tmpvar_21 = normalize(nrml_14);
  nrml_14 = tmpvar_21;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_4);
  vec4 tmpvar_22;
  tmpvar_22 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 o_23;
  vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_22 * 0.5);
  vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_23;
  xlv_TEXCOORD4 = tmpvar_22.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_8;
  tmpvar_8 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, mix (texture2DProj (_ReflectionTex, 
    (xlv_TEXCOORD3 + tmpvar_7)
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (tmpvar_8 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((0.5 + tmpvar_8), 0.0, 1.0);
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD4))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
def c21, 0.159154937, 0.5, 6.28318548, -3.14159274
def c22, 1, 0.159154937, 0.25, 2
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.x
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c21.x, c21.y
mad r3, r3, c22.y, c22.z
frc r3, r3
mad r3, r3, c21.z, c21.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c21.z, c21.w
mul r4, r4, r4
mad r5, r4, c20.x, c20.y
mad r5, r4, r5, c20.z
mad r5, r4, r5, c20.w
mad r5, r4, r5, -c21.y
mad r4, r4, r5, c22.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c21.x, c21.y
frc r1, r1
mad r1, r1, c21.z, c21.w
mul r1, r1, r1
mad r4, r1, c20.x, c20.y
mad r4, r1, r4, c20.z
mad r4, r1, r4, c20.w
mad r4, r1, r4, -c21.y
mad r1, r1, r4, c22.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c22.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c20.x, c20.y
mad r1, r3, r1, c20.z
mad r1, r3, r1, c20.w
mad r1, r3, r1, -c21.y
mad r1, r3, r1, c22.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.w, c3, r1
mul r2.xz, r0.xyww, c21.y
dp4 r0.y, c1, r1
dp4 r0.z, c2, r1
mul r1.x, r0.y, c9.x
mov o0, r0
mov o4.zw, r0
mov o5.x, r0.z
mul r2.w, r1.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedojdbeeebknncjiclejanlfahmfadcblcabaaaaaammajaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oiahaaaaeaaaabaapkabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaaabaaaaaa
egiacaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaaabaaaaaa
ogikcaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaaabaaaaaa
egiacaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaaabaaaaaa
ogikcaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
enaaaaahpcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaabaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaabaaaaaaigaabaaa
aaaaaaaaigaabaaaabaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaa
adaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagaabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaai
bcaabaaaaeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaai
ccaabaaaaeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaai
ecaabaaaaeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaaapaaaaai
icaabaaaaeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaa
acaaaaaaenaaaaagaanaaaaapcaabaaaabaaaaaaegaobaaaabaaaaaadiaaaaaj
pcaabaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaa
diaaaaaipcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaa
agaibaaaacaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaah
bcaabaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaadgaaaaagecaabaaaabaaaaaaakaabaiaebaaaaaa
acaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaabaaaaaaagiacaaaaaaaaaaa
agaaaaaadgaaaaafccaabaaaabaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpdgaaaaaficcabaaa
acaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaadaaaaaa
igiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaigiicaaaacaaaaaa
amaaaaaaagaabaaaadaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
igiicaaaacaaaaaaaoaaaaaakgakbaaaadaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
aeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_4;
  vec4 tmpvar_5;
  tmpvar_5 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_7;
  tmpvar_7.x = dot (_GDirectionAB.xy, tmpvar_3.xz);
  tmpvar_7.y = dot (_GDirectionAB.zw, tmpvar_3.xz);
  tmpvar_7.z = dot (_GDirectionCD.xy, tmpvar_3.xz);
  tmpvar_7.w = dot (_GDirectionCD.zw, tmpvar_3.xz);
  vec4 tmpvar_8;
  tmpvar_8 = (_GFrequency * tmpvar_7);
  vec4 cse_9;
  cse_9 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_10;
  tmpvar_10 = cos((tmpvar_8 + cse_9));
  vec4 tmpvar_11;
  tmpvar_11.xy = tmpvar_5.xz;
  tmpvar_11.zw = tmpvar_6.xz;
  offsets_4.x = dot (tmpvar_10, tmpvar_11);
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_5.yw;
  tmpvar_12.zw = tmpvar_6.yw;
  offsets_4.z = dot (tmpvar_10, tmpvar_12);
  offsets_4.y = dot (sin((tmpvar_8 + cse_9)), _GAmplitude);
  vec2 xzVtx_13;
  xzVtx_13 = (tmpvar_3.xz + offsets_4.xz);
  vec3 nrml_14;
  nrml_14.y = 2.0;
  vec4 tmpvar_15;
  tmpvar_15 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_17;
  tmpvar_17.x = dot (_GDirectionAB.xy, xzVtx_13);
  tmpvar_17.y = dot (_GDirectionAB.zw, xzVtx_13);
  tmpvar_17.z = dot (_GDirectionCD.xy, xzVtx_13);
  tmpvar_17.w = dot (_GDirectionCD.zw, xzVtx_13);
  vec4 tmpvar_18;
  tmpvar_18 = cos(((_GFrequency * tmpvar_17) + cse_9));
  vec4 tmpvar_19;
  tmpvar_19.xy = tmpvar_15.xz;
  tmpvar_19.zw = tmpvar_16.xz;
  nrml_14.x = -(dot (tmpvar_18, tmpvar_19));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_15.yw;
  tmpvar_20.zw = tmpvar_16.yw;
  nrml_14.z = -(dot (tmpvar_18, tmpvar_20));
  nrml_14.xz = (nrml_14.xz * _GerstnerIntensity);
  vec3 tmpvar_21;
  tmpvar_21 = normalize(nrml_14);
  nrml_14 = tmpvar_21;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_4);
  vec4 tmpvar_22;
  tmpvar_22 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 o_23;
  vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_22 * 0.5);
  vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_23;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_7;
  tmpvar_7 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, _ReflectionColor, vec4(clamp (
    (tmpvar_7 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((0.5 + tmpvar_7), 0.0, 1.0);
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
def c21, 0.159154937, 0.5, 6.28318548, -3.14159274
def c22, 1, 0.159154937, 0.25, 2
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c21.x, c21.y
mad r3, r3, c22.y, c22.z
frc r3, r3
mad r3, r3, c21.z, c21.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c21.z, c21.w
mul r4, r4, r4
mad r5, r4, c20.x, c20.y
mad r5, r4, r5, c20.z
mad r5, r4, r5, c20.w
mad r5, r4, r5, -c21.y
mad r4, r4, r5, c22.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c21.x, c21.y
frc r1, r1
mad r1, r1, c21.z, c21.w
mul r1, r1, r1
mad r4, r1, c20.x, c20.y
mad r4, r1, r4, c20.z
mad r4, r1, r4, c20.w
mad r4, r1, r4, -c21.y
mad r1, r1, r4, c22.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c22.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c20.x, c20.y
mad r1, r3, r1, c20.z
mad r1, r3, r1, c20.w
mad r1, r3, r1, -c21.y
mad r1, r3, r1, c22.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.w, c3, r1
mul r2.xz, r0.xyww, c21.y
dp4 r0.y, c1, r1
dp4 r0.z, c2, r1
mul r1.x, r0.y, c9.x
mov o0, r0
mov o4.zw, r0
mul r2.w, r1.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhhflnhffmdmplbafolcfljonmmfkjdbjabaaaaaajeajaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcmiahaaaaeaaaabaapcabaaaafjaaaaaeegiocaaaaaaaaaaa
biaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaaabaaaaaaegiacaaa
aaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaaabaaaaaaogikcaaa
aaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaaabaaaaaaegiacaaa
aaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaaabaaaaaaogikcaaa
aaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaa
aaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaaenaaaaah
pcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
abaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaajpcaabaaa
aeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaadiaaaaai
pcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaaagaibaaa
aeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaahecaabaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaaabaaaaaa
egaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
abaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaabaaaaaaigaabaaaaaaaaaaa
igaabaaaabaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaaadaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaaibcaabaaa
aeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaaiccaabaaa
aeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaaiecaabaaa
aeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaaapaaaaaiicaabaaa
aeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaa
enaaaaagaanaaaaapcaabaaaabaaaaaaegaobaaaabaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaa
acaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahbcaabaaa
acaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaadgaaaaagecaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaa
diaaaaaifcaabaaaabaaaaaaagacbaaaabaaaaaaagiacaaaaaaaaaaaagaaaaaa
dgaaaaafccaabaaaabaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaipcaabaaaabaaaaaa
fgafbaaaadaaaaaaigiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaa
igiicaaaacaaaaaaamaaaaaaagaabaaaadaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaigiicaaaacaaaaaaaoaaaaaakgakbaaaadaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaa
aaaaaaaaegiocaaaaaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaa
adaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform float _GerstnerIntensity;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
uniform vec4 _GAmplitude;
uniform vec4 _GFrequency;
uniform vec4 _GSteepness;
uniform vec4 _GSpeed;
uniform vec4 _GDirectionAB;
uniform vec4 _GDirectionCD;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = gl_Vertex.w;
  vec4 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_3 = (_Object2World * gl_Vertex).xyz;
  vec3 offsets_4;
  vec4 tmpvar_5;
  tmpvar_5 = ((_GSteepness.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_6;
  tmpvar_6 = ((_GSteepness.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_7;
  tmpvar_7.x = dot (_GDirectionAB.xy, tmpvar_3.xz);
  tmpvar_7.y = dot (_GDirectionAB.zw, tmpvar_3.xz);
  tmpvar_7.z = dot (_GDirectionCD.xy, tmpvar_3.xz);
  tmpvar_7.w = dot (_GDirectionCD.zw, tmpvar_3.xz);
  vec4 tmpvar_8;
  tmpvar_8 = (_GFrequency * tmpvar_7);
  vec4 cse_9;
  cse_9 = (_Time.yyyy * _GSpeed);
  vec4 tmpvar_10;
  tmpvar_10 = cos((tmpvar_8 + cse_9));
  vec4 tmpvar_11;
  tmpvar_11.xy = tmpvar_5.xz;
  tmpvar_11.zw = tmpvar_6.xz;
  offsets_4.x = dot (tmpvar_10, tmpvar_11);
  vec4 tmpvar_12;
  tmpvar_12.xy = tmpvar_5.yw;
  tmpvar_12.zw = tmpvar_6.yw;
  offsets_4.z = dot (tmpvar_10, tmpvar_12);
  offsets_4.y = dot (sin((tmpvar_8 + cse_9)), _GAmplitude);
  vec2 xzVtx_13;
  xzVtx_13 = (tmpvar_3.xz + offsets_4.xz);
  vec3 nrml_14;
  nrml_14.y = 2.0;
  vec4 tmpvar_15;
  tmpvar_15 = ((_GFrequency.xxyy * _GAmplitude.xxyy) * _GDirectionAB);
  vec4 tmpvar_16;
  tmpvar_16 = ((_GFrequency.zzww * _GAmplitude.zzww) * _GDirectionCD);
  vec4 tmpvar_17;
  tmpvar_17.x = dot (_GDirectionAB.xy, xzVtx_13);
  tmpvar_17.y = dot (_GDirectionAB.zw, xzVtx_13);
  tmpvar_17.z = dot (_GDirectionCD.xy, xzVtx_13);
  tmpvar_17.w = dot (_GDirectionCD.zw, xzVtx_13);
  vec4 tmpvar_18;
  tmpvar_18 = cos(((_GFrequency * tmpvar_17) + cse_9));
  vec4 tmpvar_19;
  tmpvar_19.xy = tmpvar_15.xz;
  tmpvar_19.zw = tmpvar_16.xz;
  nrml_14.x = -(dot (tmpvar_18, tmpvar_19));
  vec4 tmpvar_20;
  tmpvar_20.xy = tmpvar_15.yw;
  tmpvar_20.zw = tmpvar_16.yw;
  nrml_14.z = -(dot (tmpvar_18, tmpvar_20));
  nrml_14.xz = (nrml_14.xz * _GerstnerIntensity);
  vec3 tmpvar_21;
  tmpvar_21 = normalize(nrml_14);
  nrml_14 = tmpvar_21;
  tmpvar_1.xyz = (gl_Vertex.xyz + offsets_4);
  vec4 tmpvar_22;
  tmpvar_22 = (gl_ModelViewProjectionMatrix * tmpvar_1);
  vec4 o_23;
  vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_22 * 0.5);
  vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = (((_Object2World * tmpvar_1).xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_23;
  xlv_TEXCOORD4 = tmpvar_22.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_7;
  tmpvar_7 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, _ReflectionColor, vec4(clamp (
    (tmpvar_7 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((0.5 + tmpvar_7), 0.0, 1.0);
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD4))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_BumpDirection]
Vector 12 [_BumpTiling]
Vector 14 [_GAmplitude]
Vector 18 [_GDirectionAB]
Vector 19 [_GDirectionCD]
Vector 15 [_GFrequency]
Vector 17 [_GSpeed]
Vector 16 [_GSteepness]
Float 11 [_GerstnerIntensity]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c20, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
def c21, 0.159154937, 0.5, 6.28318548, -3.14159274
def c22, 1, 0.159154937, 0.25, 2
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.x
mov r0.xy, c7
mul r1, r0.y, c17
dp4 r2.x, c4, v0
dp4 r2.z, c6, v0
mul r3, r2.xxzz, c18.xzyw
add r3.xy, r3.zwzw, r3
mul r0.yz, r2.z, c19.xyww
mad r3.zw, c19.xyxz, r2.x, r0.xyyz
mad r3, c15, r3, r1
mad r4, r3, c21.x, c21.y
mad r3, r3, c22.y, c22.z
frc r3, r3
mad r3, r3, c21.z, c21.w
mul r3, r3, r3
frc r4, r4
mad r4, r4, c21.z, c21.w
mul r4, r4, r4
mad r5, r4, c20.x, c20.y
mad r5, r4, r5, c20.z
mad r5, r4, r5, c20.w
mad r5, r4, r5, -c21.y
mad r4, r4, r5, c22.x
mov r5, c14
mul r6, r5, c16
mul r7, r6.xyxy, c18.ywxz
mul r6, r6.zzww, c19
mov r8.xy, r7.zwzw
mov r8.zw, r6.xyxz
mov r7.zw, r6.xyyw
dp4 r6.z, r4, r7
dp4 r6.x, r4, r8
add r4, r2.xzxz, r6.xzxz
mul r7, r4.zwzw, c18
mul r4, r4, c19
add r4.zw, r4.xyyw, r4.xyxz
add r4.xy, r7.ywzw, r7.xzzw
mad r1, c15, r4, r1
mad r1, r1, c21.x, c21.y
frc r1, r1
mad r1, r1, c21.z, c21.w
mul r1, r1, r1
mad r4, r1, c20.x, c20.y
mad r4, r1, r4, c20.z
mad r4, r1, r4, c20.w
mad r4, r1, r4, -c21.y
mad r1, r1, r4, c22.x
mul r4, r5, c15
mul r5, r4.xyxy, c18.ywxz
mul r4, r4.zzww, c19
mov r7.xy, r5.zwzw
mov r7.zw, r4.xyxz
mov r5.zw, r4.xyyw
dp4 r0.y, r1, r5
dp4 r0.z, r1, r7
mov r1.xz, -r0.zyyw
mul r1.xz, r1, c11.x
mov r1.y, c22.w
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul o1.xyz, r0.y, r1
mad r1, r3, c20.x, c20.y
mad r1, r3, r1, c20.z
mad r1, r3, r1, c20.w
mad r1, r3, r1, -c21.y
mad r1, r3, r1, c22.x
dp4 r6.y, r1, c14
add r1.xyz, r6, v0
mov r1.w, v0.w
dp4 r3.x, c4, r1
dp4 r3.y, c6, r1
mad r0, r0.x, c13, r3.xyxy
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
dp4 r0.x, c0, r1
dp4 r0.w, c3, r1
mul r2.xz, r0.xyww, c21.y
dp4 r0.y, c1, r1
dp4 r0.z, c2, r1
mul r1.x, r0.y, c9.x
mov o0, r0
mov o4.zw, r0
mov o5.x, r0.z
mul r2.w, r1.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Float 96 [_GerstnerIntensity]
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
Vector 288 [_GAmplitude]
Vector 304 [_GFrequency]
Vector 320 [_GSteepness]
Vector 336 [_GSpeed]
Vector 352 [_GDirectionAB]
Vector 368 [_GDirectionCD]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedojdbeeebknncjiclejanlfahmfadcblcabaaaaaammajaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
oiahaaaaeaaaabaapkabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaapaaaaaibcaabaaaabaaaaaa
egiacaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiccaabaaaabaaaaaa
ogikcaaaaaaaaaaabgaaaaaaigaabaaaaaaaaaaaapaaaaaiecaabaaaabaaaaaa
egiacaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaaapaaaaaiicaabaaaabaaaaaa
ogikcaaaaaaaaaaabhaaaaaaigaabaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
enaaaaahpcaabaaaabaaaaaapcaabaaaadaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaabaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaabaaaaaaigaabaaa
aaaaaaaaigaabaaaabaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgafbaaa
adaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagaabaaaadaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaaapaaaaai
bcaabaaaaeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaai
ccaabaaaaeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaabaaaaaaapaaaaai
ecaabaaaaeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaaapaaaaai
icaabaaaaeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaa
acaaaaaaenaaaaagaanaaaaapcaabaaaabaaaaaaegaobaaaabaaaaaadiaaaaaj
pcaabaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaa
diaaaaaipcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaa
agaibaaaacaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaah
bcaabaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaadgaaaaagecaabaaaabaaaaaaakaabaiaebaaaaaa
acaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaabaaaaaaagiacaaaaaaaaaaa
agaaaaaadgaaaaafccaabaaaabaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpdgaaaaaficcabaaa
acaaaaaackaabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaadaaaaaa
igiicaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaabaaaaaaigiicaaaacaaaaaa
amaaaaaaagaabaaaadaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
igiicaaaacaaaaaaaoaaaaaakgakbaaaadaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaigiicaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaegaobaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
aeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  vec4 cse_6;
  cse_6 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD1 = (cse_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((cse_6.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_3;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_8;
  tmpvar_8 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, mix (texture2DProj (_ReflectionTex, 
    (xlv_TEXCOORD3 + tmpvar_7)
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (tmpvar_8 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = (clamp ((_InvFadeParemeter * 
    ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w))) - xlv_TEXCOORD3.z)
  ), 0.0, 1.0).x * clamp ((0.5 + tmpvar_8), 0.0, 1.0));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov o0, r0
mov o4.zw, r0
mov o1, c13.yzyz

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedjkejkknkibbbcakdmbpjaepeepifodffabaaaaaakiaeaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcnmacaaaaeaaaabaalhaaaaaafjaaaaaeegiocaaaaaaaaaaa
bcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
dcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaa
bbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  vec4 cse_6;
  cse_6 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD1 = (cse_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((cse_6.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_3;
  xlv_TEXCOORD4 = tmpvar_2.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_8;
  tmpvar_8 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, mix (texture2DProj (_ReflectionTex, 
    (xlv_TEXCOORD3 + tmpvar_7)
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (tmpvar_8 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = (clamp ((_InvFadeParemeter * 
    ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w))) - xlv_TEXCOORD3.z)
  ), 0.0, 1.0).x * clamp ((0.5 + tmpvar_8), 0.0, 1.0));
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD4))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.x
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov o0, r0
mov o4.zw, r0
mov o5.x, r0.z
mov o1, c13.yzyz

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedanohdkninjjiiedennacdajecjoakajaabaaaaaaoaaeaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
pmacaaaaeaaaabaalpaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaackaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  vec4 cse_6;
  cse_6 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD1 = (cse_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((cse_6.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_3;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _BumpMap;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_7;
  tmpvar_7 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, _ReflectionColor, vec4(clamp (
    (tmpvar_7 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = (clamp ((_InvFadeParemeter * 
    ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w))) - xlv_TEXCOORD3.z)
  ), 0.0, 1.0).x * clamp ((0.5 + tmpvar_7), 0.0, 1.0));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov o0, r0
mov o4.zw, r0
mov o1, c13.yzyz

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedjkejkknkibbbcakdmbpjaepeepifodffabaaaaaakiaeaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcnmacaaaaeaaaabaalhaaaaaafjaaaaaeegiocaaaaaaaaaaa
bcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
dcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaa
bbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  vec4 cse_6;
  cse_6 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD1 = (cse_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((cse_6.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_3;
  xlv_TEXCOORD4 = tmpvar_2.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform vec4 _InvFadeParemeter;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_7;
  tmpvar_7 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, _ReflectionColor, vec4(clamp (
    (tmpvar_7 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = (clamp ((_InvFadeParemeter * 
    ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w))) - xlv_TEXCOORD3.z)
  ), 0.0, 1.0).x * clamp ((0.5 + tmpvar_7), 0.0, 1.0));
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD4))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.x
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov o0, r0
mov o4.zw, r0
mov o5.x, r0.z
mov o1, c13.yzyz

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedanohdkninjjiiedennacdajecjoakajaabaaaaaaoaaeaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
pmacaaaaeaaaabaalpaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaackaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  vec4 cse_6;
  cse_6 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD1 = (cse_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((cse_6.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_8;
  tmpvar_8 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, mix (texture2DProj (_ReflectionTex, 
    (xlv_TEXCOORD3 + tmpvar_7)
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (tmpvar_8 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((0.5 + tmpvar_8), 0.0, 1.0);
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov o0, r0
mov o4.zw, r0
mov o1, c13.yzyz

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedjkejkknkibbbcakdmbpjaepeepifodffabaaaaaakiaeaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcnmacaaaaeaaaabaalhaaaaaafjaaaaaeegiocaaaaaaaaaaa
bcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
dcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaa
bbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  vec4 cse_6;
  cse_6 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD1 = (cse_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((cse_6.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_3;
  xlv_TEXCOORD4 = tmpvar_2.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_8;
  tmpvar_8 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, mix (texture2DProj (_ReflectionTex, 
    (xlv_TEXCOORD3 + tmpvar_7)
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (tmpvar_8 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((0.5 + tmpvar_8), 0.0, 1.0);
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD4))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.x
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov o0, r0
mov o4.zw, r0
mov o5.x, r0.z
mov o1, c13.yzyz

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedanohdkninjjiiedennacdajecjoakajaabaaaaaaoaaeaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
pmacaaaaeaaaabaalpaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaackaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  vec4 cse_6;
  cse_6 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD1 = (cse_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((cse_6.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_7;
  tmpvar_7 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, _ReflectionColor, vec4(clamp (
    (tmpvar_7 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((0.5 + tmpvar_7), 0.0, 1.0);
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov o0, r0
mov o4.zw, r0
mov o1, c13.yzyz

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedjkejkknkibbbcakdmbpjaepeepifodffabaaaaaakiaeaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcnmacaaaaeaaaabaalhaaaaaafjaaaaaeegiocaaaaaaaaaaa
bcaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaj
hccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaa
dcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaa
bbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD3;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  vec4 cse_6;
  cse_6 = (_Object2World * gl_Vertex);
  xlv_TEXCOORD1 = (cse_6.xyz - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((cse_6.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_3;
  xlv_TEXCOORD4 = tmpvar_2.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD2;
varying float xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((normalize(xlv_TEXCOORD0.xyz) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_7;
  tmpvar_7 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, _ReflectionColor, vec4(clamp (
    (tmpvar_7 * 2.0)
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((0.5 + tmpvar_7), 0.0, 1.0);
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (exp2(
    -((unity_FogParams.y * xlv_TEXCOORD4))
  ), 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_BumpDirection]
Vector 11 [_BumpTiling]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_3_0
def c13, 0.5, 0, 1, 0
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5.x
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c12, r0.xzxz
mul o3, r1, c11
dp4 r0.y, c5, v0
add o2.xyz, r0, -c8
dp4 r0.y, c1, v0
mul r1.x, r0.y, c9.x
mul r1.w, r1.x, c13.x
dp4 r0.x, c0, v0
dp4 r0.w, c3, v0
mul r1.xz, r0.xyww, c13.x
mad o4.xy, r1.z, c10.zwzw, r1.xwzw
dp4 r0.z, c2, v0
mov o0, r0
mov o4.zw, r0
mov o5.x, r0.z
mov o1, c13.yzyz

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedanohdkninjjiiedennacdajecjoakajaabaaaaaaoaaeaaaaadaaaaaa
cmaaaaaaceabaaaanmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
pmacaaaaeaaaabaalpaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaaipccabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaiadpdiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaajhccabaaaacaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaalpcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaigaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaackaabaaa
aaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Vector 2 [_BaseColor]
Vector 7 [_DistortParams]
Float 8 [_FresnelScale]
Vector 4 [_InvFadeParemeter]
Vector 3 [_ReflectionColor]
Float 5 [_Shininess]
Vector 1 [_SpecularColor]
Vector 6 [_WorldLightDir]
Vector 0 [_ZBufferParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, 0, 0, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mul_pp r0.xyz, r0, c9.zwzw
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mad_pp r0.xyz, v0, r0.w, r0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c8.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c6
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c7.y
mul_pp r1.xy, r1, c10.x
max r2.w, r0.w, c9.w
pow r0.w, r2.w, c5.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c9.y
cmp_pp r0.x, r0.x, r0.y, -c9.y
max_pp r2.x, r0.x, c9.w
pow_pp r0.x, r2.x, c7.z
mov r0.y, c9.y
lrp_sat_pp r2.x, r0.x, -r0.y, c7.w
add_sat r0.x, r2.x, r2.x
add_sat_pp r0.y, r2.x, c9.z
mov_pp r1.zw, c9.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r2.xyz, c3.w, c3, r1
lrp_pp r1.xyz, r0.x, r2, c2
mad_pp oC0.xyz, r0.w, c1, r1
texldp_pp r1, v3, s2
mad r0.x, c0.z, r1.x, c0.w
rcp_pp r0.x, r0.x
add r0.x, r0.x, -v3.z
mul_sat_pp r0.x, r0.x, c4.x
mul_pp oC0.w, r0.y, r0.x

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedkihjmmcjkihbnjkmkepocpkjkabhciahabaaaaaabeajaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcamaiaaaaeaaaaaaaadacaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaaoaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaa
agacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaa
bkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaa
egbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaai
icaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaa
aaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaj
bcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadp
dccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaaoaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadp
ddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaigcaabaaa
abaaaaaaagacbaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaa
acaaaaaajgafbaaaabaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaa
dgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaaaaaaaaahocaabaaaabaaaaaa
agajbaaaacaaaaaaagbnbaaaaeaaaaaaaoaaaaahgcaabaaaabaaaaaafgagbaaa
abaaaaaapgapbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaajgafbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaajocaabaaaabaaaaaaagajbaia
ebaaaaaaacaaaaaaagijcaaaaaaaaaaaakaaaaaadcaaaaakocaabaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaaaaaaaaaj
ocaabaaaabaaaaaafgaobaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaaajaaaaaa
dcaaaaakhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaegiccaaa
aaaaaaaaajaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
amaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhccabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaackbabaiaebaaaaaaaeaaaaaadicaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahiccabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Vector 4 [_BaseColor]
Vector 9 [_DistortParams]
Float 10 [_FresnelScale]
Vector 6 [_InvFadeParemeter]
Vector 5 [_ReflectionColor]
Float 7 [_Shininess]
Vector 3 [_SpecularColor]
Vector 8 [_WorldLightDir]
Vector 0 [_ZBufferParams]
Vector 1 [unity_FogColor]
Vector 2 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"ps_3_0
def c11, 2, -1, 0.5, 0
def c12, 10, 0, 0, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
texldp_pp r0, v3, s2
mad r0.x, c0.z, r0.x, c0.w
rcp_pp r0.x, r0.x
add r0.x, r0.x, -v3.z
mul_sat_pp r0.x, r0.x, c6.x
texld_pp r1, v2, s0
mad_pp r0.yzw, r1.xwwy, c11.x, c11.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c11.x, c11.y
add_pp r0.yzw, r0, r1.xxyz
mul_pp r0.yzw, r0, c9.x
mul_pp r0.yzw, r0, c11.xzwz
dp3 r1.x, v0, v0
rsq r1.x, r1.x
mad_pp r0.yzw, v0.xxyz, r1.x, r0
nrm_pp r1.xyz, r0.yzww
mul_pp r2.xz, r1, c10.x
mov_pp r2.y, r1.y
dp3 r0.y, v1, v1
rsq r0.y, r0.y
mul_pp r3.xyz, r0.y, v1
mad r0.yzw, v1.xxyz, r0.y, c8.xxyz
nrm_pp r4.xyz, r0.yzww
dp3_pp r0.y, r1, -r4
mul r0.zw, r1.xyxz, c9.y
mul_pp r1.xy, r0.zwzw, c12.x
max r2.w, r0.y, c11.w
pow r0.y, r2.w, c7.x
dp3_pp r0.z, -r3, r2
add_pp r0.w, -r0.z, -c11.y
cmp_pp r0.z, r0.z, r0.w, -c11.y
max_pp r2.x, r0.z, c11.w
pow_pp r0.z, r2.x, c9.z
mov r2.y, c11.y
lrp_sat_pp r3.x, r0.z, -r2.y, c9.w
add_sat_pp r0.z, r3.x, c11.z
add_sat r0.w, r3.x, r3.x
mul_pp oC0.w, r0.z, r0.x
mov_pp r1.zw, c11.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r2.xyz, c5.w, c5, r1
lrp_pp r1.xyz, r0.w, r2, c4
mad_pp r0.xyz, r0.y, c3, r1
add r0.xyz, r0, -c1
mul r0.w, c2.y, v4.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0
eefieceddhligfochocdcfejcmbecfanhhbkjejcabaaaaaaoiajaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmiaiaaaa
eaaaaaaadcacaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadicbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaiadpaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
aaaaaaaaegbcbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaa
aaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaaacaaaaaapgapbaaa
aaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaaigcaabaaaabaaaaaaagacbaaaaaaaaaaa
fgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaaacaaaaaajgafbaaaabaaaaaa
aceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaacaaaaaa
abeaaaaaaaaaaaaaaaaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaaagbnbaaa
aeaaaaaaaoaaaaahgcaabaaaabaaaaaafgagbaaaabaaaaaapgapbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaajgafbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaajocaabaaaabaaaaaaagajbaiaebaaaaaaacaaaaaaagijcaaa
aaaaaaaaakaaaaaadcaaaaakocaabaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaa
fgaobaaaabaaaaaaagajbaaaacaaaaaaaaaaaaajocaabaaaabaaaaaafgaobaaa
abaaaaaaagijcaiaebaaaaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaa
agaabaaaabaaaaaajgahbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaadkbabaaaacaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaagbcaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaaddaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaaagaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaa
ckiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaaahaaaaaa
aoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackbabaia
ebaaaaaaaeaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaalaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Vector 2 [_BaseColor]
Vector 7 [_DistortParams]
Float 8 [_FresnelScale]
Vector 4 [_InvFadeParemeter]
Vector 3 [_ReflectionColor]
Float 5 [_Shininess]
Vector 1 [_SpecularColor]
Vector 6 [_WorldLightDir]
Vector 0 [_ZBufferParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_3_0
def c9, 2, -1, 0.5, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mul_pp r0.xyz, r0, c9.zwzw
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mad_pp r0.xyz, v0, r0.w, r0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c8.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c6
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
max r1.x, r0.w, c9.w
pow r0.w, r1.x, c5.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c9.y
cmp_pp r0.x, r0.x, r0.y, -c9.y
max_pp r1.x, r0.x, c9.w
pow_pp r0.x, r1.x, c7.z
mov r0.y, c9.y
lrp_sat_pp r1.x, r0.x, -r0.y, c7.w
add_sat r0.x, r1.x, r1.x
add_sat_pp r0.y, r1.x, c9.z
mov r1.xyz, c2
add r1.xyz, -r1, c3
mad_pp r1.xyz, r0.x, r1, c2
mad_pp oC0.xyz, r0.w, c1, r1
texldp_pp r1, v3, s1
mad r0.x, c0.z, r1.x, c0.w
rcp_pp r0.x, r0.x
add r0.x, r0.x, -v3.z
mul_sat_pp r0.x, r0.x, c4.x
mul_pp oC0.w, r0.y, r0.x

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedfmbcpmklcakojckdpegbdgpmkpkndikoabaaaaaapiahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpaagaaaaeaaaaaaalmabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaaoaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaa
abaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaa
abaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaa
adaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
baaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaoaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaadpddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
ddaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaak
ocaabaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaaajaaaaaaagijcaaaaaaaaaaa
akaaaaaadcaaaaakhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
hccabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaa
abaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
abaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaackbabaiaebaaaaaaaeaaaaaadicaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Vector 4 [_BaseColor]
Vector 9 [_DistortParams]
Float 10 [_FresnelScale]
Vector 6 [_InvFadeParemeter]
Vector 5 [_ReflectionColor]
Float 7 [_Shininess]
Vector 3 [_SpecularColor]
Vector 8 [_WorldLightDir]
Vector 0 [_ZBufferParams]
Vector 1 [unity_FogColor]
Vector 2 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_3_0
def c11, 2, -1, 0.5, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4.x
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c11.x, c11.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c11.x, c11.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c9.x
mul_pp r0.xyz, r0, c11.zwzw
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mad_pp r0.xyz, v0, r0.w, r0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c10.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c8
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
max r1.x, r0.w, c11.w
pow r0.w, r1.x, c7.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c11.y
cmp_pp r0.x, r0.x, r0.y, -c11.y
max_pp r1.x, r0.x, c11.w
pow_pp r0.x, r1.x, c9.z
mov r0.y, c11.y
lrp_sat_pp r1.x, r0.x, -r0.y, c9.w
add_sat_pp r0.x, r1.x, c11.z
add_sat r0.y, r1.x, r1.x
texldp_pp r1, v3, s1
mad r0.z, c0.z, r1.x, c0.w
rcp_pp r0.z, r0.z
add r0.z, r0.z, -v3.z
mul_sat_pp r0.z, r0.z, c6.x
mul_pp oC0.w, r0.x, r0.z
mov r1.xyz, c4
add r1.xyz, -r1, c5
mad_pp r0.xyz, r0.y, r1, c4
mad_pp r0.xyz, r0.w, c3, r0
add r0.xyz, r0, -c1
mul r0.w, c2.y, v4.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0
eefiecedlopchjmcndkacjjpeejamobkncepopbkabaaaaaammaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmahaaaa
eaaaaaaaolabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadicbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
aoaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaaaaaaaaaiadpaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaa
egbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegbcbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaa
agiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaaacaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaa
dkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaa
aaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaa
aaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaakocaabaaaabaaaaaaagijcaia
ebaaaaaaaaaaaaaaajaaaaaaagijcaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
abaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaadkbabaaaacaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaag
bcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaddaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaaagaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaa
aaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaa
ahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckbabaiaebaaaaaaaeaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaalaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Vector 1 [_BaseColor]
Vector 5 [_DistortParams]
Float 6 [_FresnelScale]
Vector 2 [_ReflectionColor]
Float 3 [_Shininess]
Vector 0 [_SpecularColor]
Vector 4 [_WorldLightDir]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
"ps_3_0
def c7, 2, -1, 0.5, 0
def c8, 10, 0, 0, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c7.x, c7.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c7.x, c7.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c5.x
mul_pp r0.xyz, r0, c7.zwzw
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mad_pp r0.xyz, v0, r0.w, r0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c6.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c4
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c5.y
mul_pp r1.xy, r1, c8.x
max r2.w, r0.w, c7.w
pow r0.w, r2.w, c3.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c7.y
cmp_pp r0.x, r0.x, r0.y, -c7.y
max_pp r2.x, r0.x, c7.w
pow_pp r0.x, r2.x, c5.z
mov r0.y, c7.y
lrp_sat_pp r2.x, r0.x, -r0.y, c5.w
add_sat r0.x, r2.x, r2.x
add_sat_pp oC0.w, r2.x, c7.z
mov_pp r1.zw, c7.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r2.xyz, c2.w, c2, r1
lrp_pp r1.xyz, r0.x, r2, c1
mad_pp oC0.xyz, r0.w, c0, r1

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedannagnemppokgokdfpghcgmoaokpiioeabaaaaaapiahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpaagaaaaeaaaaaaalmabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
lcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaiadpaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
aaaaaaaaegbcbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaa
aaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaaacaaaaaapgapbaaa
aaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaahiccabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaaidcaabaaaabaaaaaaigaabaaaaaaaaaaa
fgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaa
aeaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Vector 3 [_BaseColor]
Vector 7 [_DistortParams]
Float 8 [_FresnelScale]
Vector 4 [_ReflectionColor]
Float 5 [_Shininess]
Vector 2 [_SpecularColor]
Vector 6 [_WorldLightDir]
Vector 0 [unity_FogColor]
Vector 1 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, 0, 0, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4.x
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mul_pp r0.xyz, r0, c9.zwzw
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mad_pp r0.xyz, v0, r0.w, r0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c8.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c6
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c7.y
mul_pp r1.xy, r1, c10.x
max r2.w, r0.w, c9.w
pow r0.w, r2.w, c5.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c9.y
cmp_pp r0.x, r0.x, r0.y, -c9.y
max_pp r2.x, r0.x, c9.w
pow_pp r0.x, r2.x, c7.z
mov r0.y, c9.y
lrp_sat_pp r2.x, r0.x, -r0.y, c7.w
add_sat_pp oC0.w, r2.x, c9.z
add_sat r0.x, r2.x, r2.x
mov r1.zw, c9.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r2.xyz, c4.w, c4, r1
lrp_pp r1.xyz, r0.x, r2, c3
mad_pp r0.xyz, r0.w, c2, r1
add r0.xyz, r0, -c0
mul r0.w, c1.y, v4.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedkjhkkgenpmmeapcnbbbpghodhpkllnacabaaaaaammaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmahaaaa
eaaaaaaaolabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaa
pganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
pganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaadiaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
fcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaaf
ccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaak
hcaabaaaadaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaa
anaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaa
abeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaadpddaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpddaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaaidcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaa
diaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaacaebaaaacaeb
aaaaaaaaaaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaaaeaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
aaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaajaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaai
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaa
egacbaaaabaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkbabaaaacaaaaaa
bkiacaaaabaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
dcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Vector 1 [_BaseColor]
Vector 5 [_DistortParams]
Float 6 [_FresnelScale]
Vector 2 [_ReflectionColor]
Float 3 [_Shininess]
Vector 0 [_SpecularColor]
Vector 4 [_WorldLightDir]
SetTexture 0 [_BumpMap] 2D 0
"ps_3_0
def c7, 2, -1, 0.5, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_2d s0
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c7.x, c7.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c7.x, c7.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c5.x
mul_pp r0.xyz, r0, c7.zwzw
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mad_pp r0.xyz, v0, r0.w, r0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c6.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c4
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
max r1.x, r0.w, c7.w
pow r0.w, r1.x, c3.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c7.y
cmp_pp r0.x, r0.x, r0.y, -c7.y
max_pp r1.x, r0.x, c7.w
pow_pp r0.x, r1.x, c5.z
mov r0.y, c7.y
lrp_sat_pp r1.x, r0.x, -r0.y, c5.w
add_sat r0.x, r1.x, r1.x
add_sat_pp oC0.w, r1.x, c7.z
mov r1.xyz, c1
add r1.xyz, -r1, c2
mad_pp r0.xyz, r0.x, r1, c1
mad_pp oC0.xyz, r0.w, c0, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmncmkeiidnimhocmchkkjhknajfhicheabaaaaaanaagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmiafaaaaeaaaaaaahcabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaa
aaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaa
dgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaa
dcaaaaakhcaabaaaadaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaa
aaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
egacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaadpddaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpddaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaiadpaaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakhccabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Vector 3 [_BaseColor]
Vector 7 [_DistortParams]
Float 8 [_FresnelScale]
Vector 4 [_ReflectionColor]
Float 5 [_Shininess]
Vector 2 [_SpecularColor]
Vector 6 [_WorldLightDir]
Vector 0 [unity_FogColor]
Vector 1 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
"ps_3_0
def c9, 2, -1, 0.5, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord4 v3.x
dcl_2d s0
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mul_pp r0.xyz, r0, c9.zwzw
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mad_pp r0.xyz, v0, r0.w, r0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c8.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c6
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
max r1.x, r0.w, c9.w
pow r0.w, r1.x, c5.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c9.y
cmp_pp r0.x, r0.x, r0.y, -c9.y
max_pp r1.x, r0.x, c9.w
pow_pp r0.x, r1.x, c7.z
mov r0.y, c9.y
lrp_sat_pp r1.x, r0.x, -r0.y, c7.w
add_sat_pp oC0.w, r1.x, c9.z
add_sat r0.x, r1.x, r1.x
mov r1.xyz, c3
add r1.xyz, -r1, c4
mad_pp r0.xyz, r0.x, r1, c3
mad_pp r0.xyz, r0.w, c2, r0
add r0.xyz, r0, -c0
mul r0.w, c1.y, v3.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedmfmpcjnmmhppanhgfpoanfbomdkpacfpabaaaaaakeahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcieagaaaa
eaaaaaaakbabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
icbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaaoaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaa
agacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaa
bkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaa
egbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaai
icaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaa
aaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaj
bcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadp
dccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaaoaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadp
ddaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaah
icaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaakhcaabaaa
abaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaaegiccaaaaaaaaaaaakaaaaaa
dcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaajaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
amaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkbabaaaacaaaaaabkiacaaaabaaaaaa
abaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Vector 2 [_BaseColor]
Vector 7 [_DistortParams]
Float 8 [_FresnelScale]
Vector 4 [_InvFadeParemeter]
Vector 3 [_ReflectionColor]
Float 5 [_Shininess]
Vector 1 [_SpecularColor]
Vector 6 [_WorldLightDir]
Vector 0 [_ZBufferParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, 0, 0, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mul_pp r0.xyz, r0, c9.zwzw
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mad_pp r0.xyz, v0, r0.w, r0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c8.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c6
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c7.y
mul_pp r1.xy, r1, c10.x
max r2.w, r0.w, c9.w
pow r0.w, r2.w, c5.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c9.y
cmp_pp r0.x, r0.x, r0.y, -c9.y
max_pp r2.x, r0.x, c9.w
pow_pp r0.x, r2.x, c7.z
mov r0.y, c9.y
lrp_sat_pp r2.x, r0.x, -r0.y, c7.w
add_sat r0.x, r2.x, r2.x
add_sat_pp r0.y, r2.x, c9.z
mov_pp r1.zw, c9.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r2.xyz, c3.w, c3, r1
lrp_pp r1.xyz, r0.x, r2, c2
mad_pp oC0.xyz, r0.w, c1, r1
texldp_pp r1, v3, s2
mad r0.x, c0.z, r1.x, c0.w
rcp_pp r0.x, r0.x
add r0.x, r0.x, -v3.z
mul_sat_pp r0.x, r0.x, c4.x
mul_pp oC0.w, r0.y, r0.x

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedkihjmmcjkihbnjkmkepocpkjkabhciahabaaaaaabeajaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcamaiaaaaeaaaaaaaadacaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaaoaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaa
agacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaa
bkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaa
egbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaai
icaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaa
aaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaj
bcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadp
dccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaaoaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadp
ddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaigcaabaaa
abaaaaaaagacbaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaa
acaaaaaajgafbaaaabaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaa
dgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaaaaaaaaahocaabaaaabaaaaaa
agajbaaaacaaaaaaagbnbaaaaeaaaaaaaoaaaaahgcaabaaaabaaaaaafgagbaaa
abaaaaaapgapbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaajgafbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaajocaabaaaabaaaaaaagajbaia
ebaaaaaaacaaaaaaagijcaaaaaaaaaaaakaaaaaadcaaaaakocaabaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaaaaaaaaaj
ocaabaaaabaaaaaafgaobaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaaajaaaaaa
dcaaaaakhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaegiccaaa
aaaaaaaaajaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
amaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhccabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
dcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaackbabaiaebaaaaaaaeaaaaaadicaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahiccabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Vector 4 [_BaseColor]
Vector 9 [_DistortParams]
Float 10 [_FresnelScale]
Vector 6 [_InvFadeParemeter]
Vector 5 [_ReflectionColor]
Float 7 [_Shininess]
Vector 3 [_SpecularColor]
Vector 8 [_WorldLightDir]
Vector 0 [_ZBufferParams]
Vector 1 [unity_FogColor]
Vector 2 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"ps_3_0
def c11, 2, -1, 0.5, 0
def c12, 10, 0, 0, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
texldp_pp r0, v3, s2
mad r0.x, c0.z, r0.x, c0.w
rcp_pp r0.x, r0.x
add r0.x, r0.x, -v3.z
mul_sat_pp r0.x, r0.x, c6.x
texld_pp r1, v2, s0
mad_pp r0.yzw, r1.xwwy, c11.x, c11.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c11.x, c11.y
add_pp r0.yzw, r0, r1.xxyz
mul_pp r0.yzw, r0, c9.x
mul_pp r0.yzw, r0, c11.xzwz
dp3 r1.x, v0, v0
rsq r1.x, r1.x
mad_pp r0.yzw, v0.xxyz, r1.x, r0
nrm_pp r1.xyz, r0.yzww
mul_pp r2.xz, r1, c10.x
mov_pp r2.y, r1.y
dp3 r0.y, v1, v1
rsq r0.y, r0.y
mul_pp r3.xyz, r0.y, v1
mad r0.yzw, v1.xxyz, r0.y, c8.xxyz
nrm_pp r4.xyz, r0.yzww
dp3_pp r0.y, r1, -r4
mul r0.zw, r1.xyxz, c9.y
mul_pp r1.xy, r0.zwzw, c12.x
max r2.w, r0.y, c11.w
pow r0.y, r2.w, c7.x
dp3_pp r0.z, -r3, r2
add_pp r0.w, -r0.z, -c11.y
cmp_pp r0.z, r0.z, r0.w, -c11.y
max_pp r2.x, r0.z, c11.w
pow_pp r0.z, r2.x, c9.z
mov r2.y, c11.y
lrp_sat_pp r3.x, r0.z, -r2.y, c9.w
add_sat_pp r0.z, r3.x, c11.z
add_sat r0.w, r3.x, r3.x
mul_pp oC0.w, r0.z, r0.x
mov_pp r1.zw, c11.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r2.xyz, c5.w, c5, r1
lrp_pp r1.xyz, r0.w, r2, c4
mad_pp r0.xyz, r0.y, c3, r1
add r0.xyz, r0, -c1
mul r0.w, c2.y, v4.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0
eefieceddhligfochocdcfejcmbecfanhhbkjejcabaaaaaaoiajaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmiaiaaaa
eaaaaaaadcacaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadicbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaiadpaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
aaaaaaaaegbcbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaa
aaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaaacaaaaaapgapbaaa
aaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaaigcaabaaaabaaaaaaagacbaaaaaaaaaaa
fgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaaacaaaaaajgafbaaaabaaaaaa
aceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaacaaaaaa
abeaaaaaaaaaaaaaaaaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaaagbnbaaa
aeaaaaaaaoaaaaahgcaabaaaabaaaaaafgagbaaaabaaaaaapgapbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaajgafbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaajocaabaaaabaaaaaaagajbaiaebaaaaaaacaaaaaaagijcaaa
aaaaaaaaakaaaaaadcaaaaakocaabaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaa
fgaobaaaabaaaaaaagajbaaaacaaaaaaaaaaaaajocaabaaaabaaaaaafgaobaaa
abaaaaaaagijcaiaebaaaaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaa
agaabaaaabaaaaaajgahbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaadiaaaaaibcaabaaa
abaaaaaadkbabaaaacaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaagbcaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaaddaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaaagaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaa
ckiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaaahaaaaaa
aoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackbabaia
ebaaaaaaaeaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaalaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Vector 2 [_BaseColor]
Vector 7 [_DistortParams]
Float 8 [_FresnelScale]
Vector 4 [_InvFadeParemeter]
Vector 3 [_ReflectionColor]
Float 5 [_Shininess]
Vector 1 [_SpecularColor]
Vector 6 [_WorldLightDir]
Vector 0 [_ZBufferParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_3_0
def c9, 2, -1, 0.5, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mul_pp r0.xyz, r0, c9.zwzw
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mad_pp r0.xyz, v0, r0.w, r0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c8.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c6
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
max r1.x, r0.w, c9.w
pow r0.w, r1.x, c5.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c9.y
cmp_pp r0.x, r0.x, r0.y, -c9.y
max_pp r1.x, r0.x, c9.w
pow_pp r0.x, r1.x, c7.z
mov r0.y, c9.y
lrp_sat_pp r1.x, r0.x, -r0.y, c7.w
add_sat r0.x, r1.x, r1.x
add_sat_pp r0.y, r1.x, c9.z
mov r1.xyz, c2
add r1.xyz, -r1, c3
mad_pp r1.xyz, r0.x, r1, c2
mad_pp oC0.xyz, r0.w, c1, r1
texldp_pp r1, v3, s1
mad r0.x, c0.z, r1.x, c0.w
rcp_pp r0.x, r0.x
add r0.x, r0.x, -v3.z
mul_sat_pp r0.x, r0.x, c4.x
mul_pp oC0.w, r0.y, r0.x

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedfmbcpmklcakojckdpegbdgpmkpkndikoabaaaaaapiahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpaagaaaaeaaaaaaalmabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaaoaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaa
abaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaa
abaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaa
adaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
baaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaoaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaadpddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
ddaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaak
ocaabaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaaajaaaaaaagijcaaaaaaaaaaa
akaaaaaadcaaaaakhcaabaaaabaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
hccabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaa
abaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
abaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaackbabaiaebaaaaaaaeaaaaaadicaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Vector 4 [_BaseColor]
Vector 9 [_DistortParams]
Float 10 [_FresnelScale]
Vector 6 [_InvFadeParemeter]
Vector 5 [_ReflectionColor]
Float 7 [_Shininess]
Vector 3 [_SpecularColor]
Vector 8 [_WorldLightDir]
Vector 0 [_ZBufferParams]
Vector 1 [unity_FogColor]
Vector 2 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_3_0
def c11, 2, -1, 0.5, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4.x
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c11.x, c11.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c11.x, c11.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c9.x
mul_pp r0.xyz, r0, c11.zwzw
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mad_pp r0.xyz, v0, r0.w, r0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c10.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c8
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
max r1.x, r0.w, c11.w
pow r0.w, r1.x, c7.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c11.y
cmp_pp r0.x, r0.x, r0.y, -c11.y
max_pp r1.x, r0.x, c11.w
pow_pp r0.x, r1.x, c9.z
mov r0.y, c11.y
lrp_sat_pp r1.x, r0.x, -r0.y, c9.w
add_sat_pp r0.x, r1.x, c11.z
add_sat r0.y, r1.x, r1.x
texldp_pp r1, v3, s1
mad r0.z, c0.z, r1.x, c0.w
rcp_pp r0.z, r0.z
add r0.z, r0.z, -v3.z
mul_sat_pp r0.z, r0.z, c6.x
mul_pp oC0.w, r0.x, r0.z
mov r1.xyz, c4
add r1.xyz, -r1, c5
mad_pp r0.xyz, r0.y, r1, c4
mad_pp r0.xyz, r0.w, c3, r0
add r0.xyz, r0, -c1
mul r0.w, c2.y, v4.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Vector 176 [_InvFadeParemeter]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
ConstBuffer "UnityPerCamera" 144
Vector 112 [_ZBufferParams]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityFog" 2
"ps_4_0
eefiecedlopchjmcndkacjjpeejamobkncepopbkabaaaaaammaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmahaaaa
eaaaaaaaolabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadicbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
aoaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaaaaaaaaaiadpaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaa
egbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegbcbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaa
agiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaaacaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaa
dkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaa
aaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaa
aaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaakocaabaaaabaaaaaaagijcaia
ebaaaaaaaaaaaaaaajaaaaaaagijcaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
abaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaadkbabaaaacaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaag
bcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaddaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaaagaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaa
aaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaa
ahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckbabaiaebaaaaaaaeaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaalaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Vector 1 [_BaseColor]
Vector 5 [_DistortParams]
Float 6 [_FresnelScale]
Vector 2 [_ReflectionColor]
Float 3 [_Shininess]
Vector 0 [_SpecularColor]
Vector 4 [_WorldLightDir]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
"ps_3_0
def c7, 2, -1, 0.5, 0
def c8, 10, 0, 0, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c7.x, c7.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c7.x, c7.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c5.x
mul_pp r0.xyz, r0, c7.zwzw
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mad_pp r0.xyz, v0, r0.w, r0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c6.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c4
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c5.y
mul_pp r1.xy, r1, c8.x
max r2.w, r0.w, c7.w
pow r0.w, r2.w, c3.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c7.y
cmp_pp r0.x, r0.x, r0.y, -c7.y
max_pp r2.x, r0.x, c7.w
pow_pp r0.x, r2.x, c5.z
mov r0.y, c7.y
lrp_sat_pp r2.x, r0.x, -r0.y, c5.w
add_sat r0.x, r2.x, r2.x
add_sat_pp oC0.w, r2.x, c7.z
mov_pp r1.zw, c7.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r2.xyz, c2.w, c2, r1
lrp_pp r1.xyz, r0.x, r2, c1
mad_pp oC0.xyz, r0.w, c0, r1

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedannagnemppokgokdfpghcgmoaokpiioeabaaaaaapiahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpaagaaaaeaaaaaaalmabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
lcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaiadpaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
aaaaaaaaegbcbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaa
aaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaaacaaaaaapgapbaaa
aaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaahiccabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaaidcaabaaaabaaaaaaigaabaaaaaaaaaaa
fgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaa
aeaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Vector 3 [_BaseColor]
Vector 7 [_DistortParams]
Float 8 [_FresnelScale]
Vector 4 [_ReflectionColor]
Float 5 [_Shininess]
Vector 2 [_SpecularColor]
Vector 6 [_WorldLightDir]
Vector 0 [unity_FogColor]
Vector 1 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, 0, 0, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4.x
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mul_pp r0.xyz, r0, c9.zwzw
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mad_pp r0.xyz, v0, r0.w, r0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c8.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c6
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
mul r1.xy, r1.xzzw, c7.y
mul_pp r1.xy, r1, c10.x
max r2.w, r0.w, c9.w
pow r0.w, r2.w, c5.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c9.y
cmp_pp r0.x, r0.x, r0.y, -c9.y
max_pp r2.x, r0.x, c9.w
pow_pp r0.x, r2.x, c7.z
mov r0.y, c9.y
lrp_sat_pp r2.x, r0.x, -r0.y, c7.w
add_sat_pp oC0.w, r2.x, c9.z
add_sat r0.x, r2.x, r2.x
mov r1.zw, c9.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r2.xyz, c4.w, c4, r1
lrp_pp r1.xyz, r0.x, r2, c3
mad_pp r0.xyz, r0.w, c2, r1
add r0.xyz, r0, -c0
mul r0.w, c1.y, v4.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedkjhkkgenpmmeapcnbbbpghodhpkllnacabaaaaaammaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmahaaaa
eaaaaaaaolabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaa
pganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
pganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaadiaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
fcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaaf
ccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaak
hcaabaaaadaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaa
anaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaa
abeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaadpddaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpddaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
diaaaaaidcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaa
diaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaacaebaaaacaeb
aaaaaaaaaaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaaaeaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaa
aaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaajaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaai
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaa
egacbaaaabaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkbabaaaacaaaaaa
bkiacaaaabaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
dcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Vector 1 [_BaseColor]
Vector 5 [_DistortParams]
Float 6 [_FresnelScale]
Vector 2 [_ReflectionColor]
Float 3 [_Shininess]
Vector 0 [_SpecularColor]
Vector 4 [_WorldLightDir]
SetTexture 0 [_BumpMap] 2D 0
"ps_3_0
def c7, 2, -1, 0.5, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_2d s0
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c7.x, c7.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c7.x, c7.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c5.x
mul_pp r0.xyz, r0, c7.zwzw
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mad_pp r0.xyz, v0, r0.w, r0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c6.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c4
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
max r1.x, r0.w, c7.w
pow r0.w, r1.x, c3.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c7.y
cmp_pp r0.x, r0.x, r0.y, -c7.y
max_pp r1.x, r0.x, c7.w
pow_pp r0.x, r1.x, c5.z
mov r0.y, c7.y
lrp_sat_pp r1.x, r0.x, -r0.y, c5.w
add_sat r0.x, r1.x, r1.x
add_sat_pp oC0.w, r1.x, c7.z
mov r1.xyz, c1
add r1.xyz, -r1, c2
mad_pp r0.xyz, r0.x, r1, c1
mad_pp oC0.xyz, r0.w, c0, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmncmkeiidnimhocmchkkjhknajfhicheabaaaaaanaagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmiafaaaaeaaaaaaahcabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaa
aaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaa
dgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaa
dcaaaaakhcaabaaaadaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaa
aaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
egacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaadpddaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpddaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaiadpaaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakhccabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Vector 3 [_BaseColor]
Vector 7 [_DistortParams]
Float 8 [_FresnelScale]
Vector 4 [_ReflectionColor]
Float 5 [_Shininess]
Vector 2 [_SpecularColor]
Vector 6 [_WorldLightDir]
Vector 0 [unity_FogColor]
Vector 1 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
"ps_3_0
def c9, 2, -1, 0.5, 0
dcl_texcoord v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord4 v3.x
dcl_2d s0
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mul_pp r0.xyz, r0, c9.zwzw
dp3 r0.w, v0, v0
rsq r0.w, r0.w
mad_pp r0.xyz, v0, r0.w, r0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c8.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c6
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
max r1.x, r0.w, c9.w
pow r0.w, r1.x, c5.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c9.y
cmp_pp r0.x, r0.x, r0.y, -c9.y
max_pp r1.x, r0.x, c9.w
pow_pp r0.x, r1.x, c7.z
mov r0.y, c9.y
lrp_sat_pp r1.x, r0.x, -r0.y, c7.w
add_sat_pp oC0.w, r1.x, c9.z
add_sat r0.x, r1.x, r1.x
mov r1.xyz, c3
add r1.xyz, -r1, c4
mad_pp r0.xyz, r0.x, r1, c3
mad_pp r0.xyz, r0.w, c2, r0
add r0.xyz, r0, -c0
mul r0.w, c1.y, v3.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedmfmpcjnmmhppanhgfpoanfbomdkpacfpabaaaaaakeahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcieagaaaa
eaaaaaaakbabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
icbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaaoaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaa
agacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaa
bkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaa
egbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaai
icaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaa
aaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaj
bcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadp
dccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaaoaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadp
ddaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaah
icaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaakhcaabaaa
abaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaaegiccaaaaaaaaaaaakaaaaaa
dcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaajaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
amaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkbabaaaacaaaaaabkiacaaaabaaaaaa
abaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
doaaaaab"
}
}
 }
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask RGB
  GpuProgramID 158538
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  tmpvar_1.xyz = (tmpvar_2 - _WorldSpaceCameraPos);
  tmpvar_1.w = 1.0;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD1.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD1.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((vec3(0.0, 1.0, 0.0) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD0.xyz);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_7;
  tmpvar_7 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.w = clamp (((2.0 * tmpvar_7) + 0.5), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, _ReflectionColor, vec4(clamp (
    (tmpvar_7 * 2.0)
  , 0.0, 1.0))).xyz + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor.xyz));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_BumpDirection]
Vector 9 [_BumpTiling]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
"vs_2_0
def c11, 1, 0, 0, 0
dcl_position v0
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c10, r0.xzxz
mul oT1, r1, c9
dp4 r0.y, c5, v0
add oT0.xyz, r0, -c8
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.z, c2, v0
dp4 oPos.w, c3, v0
mov oT0.w, c11.x

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedblkbbpjchhkmmemkddhgfklkbcfcadakabaaaaaamiadaaaaadaaaaaa
cmaaaaaaceabaaaajeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefccmacaaaaeaaaabaa
ilaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaalpcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaigaibaaaaaaaaaaadiaaaaaipccabaaaacaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaaabaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedbifeejkilgigdencgpklpalhliocafimabaaaaaagiafaaaaaeaaaaaa
daaaaaaammabaaaaaaaeaaaapiaeaaaaebgpgodjjeabaaaajeabaaaaaaacpopp
daabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaabaaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaa
acaaaaaaaeaaafaaaaaaaaaaacaaamaaaeaaajaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafanaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjaafaaaaadaaaaahiaaaaaffjaakaaoekaaeaaaaaeaaaaahiaajaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaahiaalaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaahiaamaaoekaaaaappjaaaaaoeiaabaaaaacabaaabiaadaaaakaaeaaaaae
abaaapiaabaaaaiaacaaoekaaaaaiiiaacaaaaadaaaaahoaaaaaoeiaaeaaoekb
afaaaaadabaaapoaabaaoeiaabaaoekaafaaaaadaaaaapiaaaaaffjaagaaoeka
aeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaahaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaioaanaaaakappppaaaafdeieefccmacaaaaeaaaabaailaaaaaafjaaaaae
egiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaal
pcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaa
igaibaaaaaaaaaaadiaaaaaipccabaaaacaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaabaaaaaaadgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpdoaaaaab
ejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
njaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaaoaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
oaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
uniform vec4 unity_FogParams;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying float xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  tmpvar_1.xyz = (tmpvar_2 - _WorldSpaceCameraPos);
  vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD2 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform sampler2D _BumpMap;
uniform vec4 _SpecularColor;
uniform vec4 _BaseColor;
uniform vec4 _ReflectionColor;
uniform float _Shininess;
uniform vec4 _WorldLightDir;
uniform vec4 _DistortParams;
uniform float _FresnelScale;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying float xlv_TEXCOORD2;
void main ()
{
  vec4 baseColor_1;
  vec3 worldNormal_2;
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD1.xy).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (
    dot (normal_3.xy, normal_3.xy)
  , 0.0, 1.0)));
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD1.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5 = normalize((vec3(0.0, 1.0, 0.0) + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD0.xyz);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  float tmpvar_7;
  tmpvar_7 = clamp ((_DistortParams.w + (
    (1.0 - _DistortParams.w)
   * 
    pow (clamp ((1.0 - max (
      dot (-(tmpvar_6), worldNormal_2)
    , 0.0)), 0.0, 1.0), _DistortParams.z)
  )), 0.0, 1.0);
  baseColor_1.w = clamp (((2.0 * tmpvar_7) + 0.5), 0.0, 1.0);
  baseColor_1.xyz = (mix (_BaseColor, _ReflectionColor, vec4(clamp (
    (tmpvar_7 * 2.0)
  , 0.0, 1.0))).xyz + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor.xyz));
  baseColor_1.xyz = mix (unity_FogColor.xyz, baseColor_1.xyz, vec3(clamp (xlv_TEXCOORD2, 0.0, 1.0)));
  gl_FragData[0] = baseColor_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
Vector 11 [_BumpDirection]
Vector 10 [_BumpTiling]
Vector 7 [_Time]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_FogParams]
"vs_2_0
def c12, 1, 0, 0, 0
dcl_position v0
dp4 r0.x, c4, v0
dp4 r0.z, c6, v0
mov r1.x, c7.x
mad r1, r1.x, c11, r0.xzxz
mul oT1, r1, c10
dp4 r0.y, c5, v0
add oT0.xyz, r0, -c8
dp4 oPos.x, c0, v0
dp4 oPos.y, c1, v0
dp4 oPos.w, c3, v0
dp4 r0.x, c2, v0
mul r0.y, r0.x, c9.y
mov oPos.z, r0.x
exp oT2.x, -r0.y
mov oT0.w, c12.x

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0
eefiecedhbhnmnknogdkfdomgoemkkkkebfchcekabaaaaaaeiaeaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaabaoaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcjeacaaaaeaaaabaakfaaaaaafjaaaaae
egiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaabaaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadbccabaaaadaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaa
aaaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaagbccabaaaadaaaaaaakaabaia
ebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaalpcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaigaibaaaaaaaaaaadiaaaaaipccabaaaacaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaaabaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 400
Vector 256 [_BumpTiling]
Vector 272 [_BumpDirection]
ConstBuffer "UnityPerCamera" 144
Vector 0 [_Time]
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
ConstBuffer "UnityFog" 32
Vector 16 [unity_FogParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
BindCB  "UnityFog" 3
"vs_4_0_level_9_1
eefiecedjoojcmlmagloanaadjdmabigioklaeldabaaaaaabaagaaaaaeaaaaaa
daaaaaaapeabaaaajaaeaaaaiiafaaaaebgpgodjlmabaaaalmabaaaaaaacpopp
emabaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaabaaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaa
acaaaaaaaeaaafaaaaaaaaaaacaaamaaaeaaajaaaaaaaaaaadaaabaaabaaanaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafaoaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjaafaaaaadaaaaahiaaaaaffjaakaaoeka
aeaaaaaeaaaaahiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaalaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaappjaaaaaoeiaabaaaaac
abaaabiaadaaaakaaeaaaaaeabaaapiaabaaaaiaacaaoekaaaaaiiiaacaaaaad
aaaaahoaaaaaoeiaaeaaoekbafaaaaadabaaapoaabaaoeiaabaaoekaafaaaaad
aaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaakkiaanaaffkaaoaaaaacacaaaboa
abaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaaioaaoaaaakappppaaaafdeieefcjeacaaaaeaaaabaa
kfaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafjaaaaaeegiocaaaadaaaaaa
acaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadbccabaaa
adaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaackaabaaaaaaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaagbccabaaa
adaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhccabaaaabaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaeaaaaaadcaaaaalpcaabaaaaaaaaaaaagiacaaaabaaaaaa
aaaaaaaaegiocaaaaaaaaaaabbaaaaaaigaibaaaaaaaaaaadiaaaaaipccabaaa
acaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaabaaaaaaadgaaaaaficcabaaa
abaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaa
miaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
oaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaabaoaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Vector 1 [_BaseColor]
Vector 5 [_DistortParams]
Float 6 [_FresnelScale]
Vector 2 [_ReflectionColor]
Float 3 [_Shininess]
Vector 0 [_SpecularColor]
Vector 4 [_WorldLightDir]
SetTexture 0 [_BumpMap] 2D 0
"ps_2_0
def c7, 2, -1, 0, 1
def c8, 0.5, 0, 0.5, 2
def c9, 0, 1, 0, 0
dcl t0.xyz
dcl_pp t1
dcl_2d s0
mov_pp r0.x, t1.z
mov_pp r0.y, t1.w
texld_pp r0, r0, s0
texld_pp r1, t1, s0
mad_pp r2.xy, r0.w, c7.x, c7.y
mad_pp r2.z, r0.y, c7.x, c7.y
mad_pp r0.xy, r1.w, c7.x, c7.y
mad_pp r0.z, r1.y, c7.x, c7.y
add_pp r0.xyz, r2, r0
mul_pp r0.xyz, r0, c5.x
mov r1.xyz, c8
mad_pp r0.xyz, r0, r1, c9
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c6.x
mov_pp r0.y, r1.y
dp3 r0.w, t0, t0
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, t0
mad r3.xyz, t0, r0.w, c4
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
max r2.w, r0.w, c7.z
pow r0.w, r2.w, c3.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, c7.w
cmp_pp r0.x, r0.x, r0.y, c7.w
max_pp r1.x, r0.x, c7.z
pow_pp r0.x, r1.x, c5.z
mov r1.w, c7.w
lrp_sat_pp r2.x, r0.x, r1.w, c5.w
add_pp r0.x, r2.x, r2.x
mad_sat_pp r1.w, r2.x, c8.w, c8.x
mov_sat r0.x, r0.x
mov r2.xyz, c1
add r2.xyz, -r2, c2
mad_pp r0.xyz, r0.x, r2, c1
mad_pp r1.xyz, r0.w, c0, r0
mov_pp oC0, r1

"
}
SubProgram "d3d11 " {
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0
eefieceddfgoebenakdfmjjhoeaaffaldoonahjeabaaaaaafmagaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcieafaaaaeaaaaaaagbabaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaap
hcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaap
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadp
aaaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaa
apaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaa
abaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaaabaaaaaapgapbaaaaaaaaaaa
egiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaahbcaabaaa
abaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaaadpddaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaakhcaabaaaabaaaaaaegiccaia
ebaaaaaaaaaaaaaaajaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecednhfceokhpmlckjhaeikbidiglfopehhiabaaaaaahmajaaaaaeaaaaaa
daaaaaaaemadaaaaniaiaaaaeiajaaaaebgpgodjbeadaaaabeadaaaaaaacpppp
neacaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaaiaaadaaaaaaaaaaaaaaaaaaamaaaeaaadaaaaaaaaaaaaacppppfbaaaaaf
ahaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafaiaaapkaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaeafbaaaaafajaaapkaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacplabpaaaaac
aaaaaajaaaaiapkaabaaaaacaaaacbiaabaakklaabaaaaacaaaacciaabaappla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadabaacpiaabaaoelaaaaioeka
aeaaaaaeacaacdiaaaaappiaahaaaakaahaaffkaaeaaaaaeacaaceiaaaaaffia
ahaaaakaahaaffkaaeaaaaaeaaaacdiaabaappiaahaaaakaahaaffkaaeaaaaae
aaaaceiaabaaffiaahaaaakaahaaffkaacaaaaadaaaachiaacaaoeiaaaaaoeia
afaaaaadaaaachiaaaaaoeiaafaaaakaabaaaaacabaaahiaaiaaoekaaeaaaaae
aaaachiaaaaaoeiaabaaoeiaajaaoekaceaaaaacabaachiaaaaaoeiaafaaaaad
aaaacfiaabaaoeiaagaaaakaabaaaaacaaaacciaabaaffiaaiaaaaadaaaaaiia
aaaaoelaaaaaoelaahaaaaacaaaaaiiaaaaappiaafaaaaadacaachiaaaaappia
aaaaoelaaeaaaaaeadaaahiaaaaaoelaaaaappiaaeaaoekaceaaaaacaeaachia
adaaoeiaaiaaaaadaaaaciiaabaaoeiaaeaaoeibalaaaaadacaaaiiaaaaappia
ahaakkkacaaaaaadaaaaaiiaacaappiaadaaaakaaiaaaaadaaaacbiaacaaoeib
aaaaoeiaacaaaaadaaaacciaaaaaaaibahaappkafiaaaaaeaaaacbiaaaaaaaia
aaaaffiaahaappkaalaaaaadabaacbiaaaaaaaiaahaakkkacaaaaaadaaaacbia
abaaaaiaafaakkkaabaaaaacabaaaiiaahaappkabcaaaaaeacaadbiaaaaaaaia
abaappiaafaappkaacaaaaadaaaacbiaacaaaaiaacaaaaiaaeaaaaaeabaadiia
acaaaaiaaiaappkaaiaaaakaabaaaaacaaaabbiaaaaaaaiaabaaaaacacaaahia
abaaoekaacaaaaadacaaahiaacaaoeibacaaoekaaeaaaaaeaaaachiaaaaaaaia
acaaoeiaabaaoekaaeaaaaaeabaachiaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefcieafaaaaeaaaaaaagbabaaaafjaaaaae
egiocaaaaaaaaaaabaaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaa
aaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaaphcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaa
aceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaa
dgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaabaaaaaa
dcaaaaakhcaabaaaadaaaaaaegbcbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
aaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
egacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaahbcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaaadpddaaaaahiccabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaahicaabaaaaaaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaa
aaaaaaaaajaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapahaaaafmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" }
Vector 2 [_BaseColor]
Vector 6 [_DistortParams]
Float 7 [_FresnelScale]
Vector 3 [_ReflectionColor]
Float 4 [_Shininess]
Vector 1 [_SpecularColor]
Vector 5 [_WorldLightDir]
Vector 0 [unity_FogColor]
SetTexture 0 [_BumpMap] 2D 0
"ps_2_0
def c8, 2, -1, 0, 1
def c9, 0.5, 0, 0.5, 2
def c10, 0, 1, 0, 0
dcl t0.xyz
dcl_pp t1
dcl t2.x
dcl_2d s0
mov_pp r0.x, t1.z
mov_pp r0.y, t1.w
texld_pp r0, r0, s0
texld_pp r1, t1, s0
mad_pp r2.xy, r0.w, c8.x, c8.y
mad_pp r2.z, r0.y, c8.x, c8.y
mad_pp r0.xy, r1.w, c8.x, c8.y
mad_pp r0.z, r1.y, c8.x, c8.y
add_pp r0.xyz, r2, r0
mul_pp r0.xyz, r0, c6.x
mov r1.xyz, c9
mad_pp r0.xyz, r0, r1, c10
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c7.x
mov_pp r0.y, r1.y
dp3 r0.w, t0, t0
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, t0
mad r3.xyz, t0, r0.w, c5
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
max r2.w, r0.w, c8.z
pow r0.w, r2.w, c4.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, c8.w
cmp_pp r0.x, r0.x, r0.y, c8.w
max_pp r1.x, r0.x, c8.z
pow_pp r0.x, r1.x, c6.z
mov r1.w, c8.w
lrp_sat_pp r2.x, r0.x, r1.w, c6.w
add_pp r0.x, r2.x, r2.x
mad_sat_pp r1.w, r2.x, c9.w, c9.x
mov_sat r0.x, r0.x
mov r2.xyz, c2
add r2.xyz, -r2, c3
mad_pp r0.xyz, r0.x, r2, c2
mad_pp r0.xyz, r0.w, c1, r0
mov_sat r0.w, t2.x
lrp_pp r1.xyz, r0.w, r0, c0
mov_pp oC0, r1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" }
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0
eefiecedaemclifppckpnbodplbmagphkmbhgmmgabaaaaaapaagaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaababaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaaagaaaaeaaaaaaaiaabaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaadbcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaaphcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaaaceaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaa
abaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaa
abaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaa
egbcbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegbcbaaaabaaaaaadcaaaaakhcaabaaa
adaaaaaaegbcbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
baaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaiadpdccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaoaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaeaabeaaaaaaaaaaadpddaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpddaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaiadpaaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaaakbabaaa
adaaaaaadcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FOG_EXP" }
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 400
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
ConstBuffer "UnityFog" 32
Vector 0 [unity_FogColor]
BindCB  "$Globals" 0
BindCB  "UnityFog" 1
"ps_4_0_level_9_1
eefiecedhopfmnmogfbokakmhkiahkbpfmkackkaabaaaaaaeiakaaaaaeaaaaaa
daaaaaaaieadaaaaimajaaaabeakaaaaebgpgodjemadaaaaemadaaaaaaacpppp
aaadaaaaemaaaaaaadaaciaaaaaaemaaaaaaemaaabaaceaaaaaaemaaaaaaaaaa
aaaaaiaaadaaaaaaaaaaaaaaaaaaamaaaeaaadaaaaaaaaaaabaaaaaaabaaahaa
aaaaaaaaaaacppppfbaaaaafaiaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadp
fbaaaaafajaaapkaaaaaaadpaaaaaaaaaaaaaadpaaaaaaeafbaaaaafakaaapka
aaaaaaaaaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaacplabpaaaaacaaaaaaiaacaaablabpaaaaacaaaaaajaaaaiapka
abaaaaacaaaacbiaabaakklaabaaaaacaaaacciaabaapplaecaaaaadaaaacpia
aaaaoeiaaaaioekaecaaaaadabaacpiaabaaoelaaaaioekaaeaaaaaeacaacdia
aaaappiaaiaaaakaaiaaffkaaeaaaaaeacaaceiaaaaaffiaaiaaaakaaiaaffka
aeaaaaaeaaaacdiaabaappiaaiaaaakaaiaaffkaaeaaaaaeaaaaceiaabaaffia
aiaaaakaaiaaffkaacaaaaadaaaachiaacaaoeiaaaaaoeiaafaaaaadaaaachia
aaaaoeiaafaaaakaabaaaaacabaaahiaajaaoekaaeaaaaaeaaaachiaaaaaoeia
abaaoeiaakaaoekaceaaaaacabaachiaaaaaoeiaafaaaaadaaaacfiaabaaoeia
agaaaakaabaaaaacaaaacciaabaaffiaaiaaaaadaaaaaiiaaaaaoelaaaaaoela
ahaaaaacaaaaaiiaaaaappiaafaaaaadacaachiaaaaappiaaaaaoelaaeaaaaae
adaaahiaaaaaoelaaaaappiaaeaaoekaceaaaaacaeaachiaadaaoeiaaiaaaaad
aaaaciiaabaaoeiaaeaaoeibalaaaaadacaaaiiaaaaappiaaiaakkkacaaaaaad
aaaaaiiaacaappiaadaaaakaaiaaaaadaaaacbiaacaaoeibaaaaoeiaacaaaaad
aaaacciaaaaaaaibaiaappkafiaaaaaeaaaacbiaaaaaaaiaaaaaffiaaiaappka
alaaaaadabaacbiaaaaaaaiaaiaakkkacaaaaaadaaaacbiaabaaaaiaafaakkka
abaaaaacabaaaiiaaiaappkabcaaaaaeacaadbiaaaaaaaiaabaappiaafaappka
acaaaaadaaaacbiaacaaaaiaacaaaaiaaeaaaaaeabaadiiaacaaaaiaajaappka
ajaaaakaabaaaaacaaaabbiaaaaaaaiaabaaaaacacaaahiaabaaoekaacaaaaad
acaaahiaacaaoeibacaaoekaaeaaaaaeaaaachiaaaaaaaiaacaaoeiaabaaoeka
aeaaaaaeaaaachiaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaabiiaacaaaala
bcaaaaaeabaachiaaaaappiaaaaaoeiaahaaoekaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefcaaagaaaaeaaaaaaaiaabaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaadbcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaaoaaaaaadcaaaaaphcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaa
agacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaa
bkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaa
abaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegbcbaaaabaaaaaadcaaaaakhcaabaaaadaaaaaa
egbcbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaai
icaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaa
aaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaj
bcaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadp
dccaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaaoaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaea
abeaaaaaaaaaaadpddaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpddaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaakhcaabaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaaegiccaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaajaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaai
bcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaa
egacbaaaabaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaabaaaaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaaakbabaaaadaaaaaa
dcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaababaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
}
Fallback "Transparent/Diffuse"
}