Shader "FX/SimpleWater4" {
Properties {
 _ReflectionTex ("Internal reflection", 2D) = "white" { }
 _MainTex ("Fallback texture", 2D) = "black" { }
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
  GpuProgramID 30319
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
varying vec4 xlv_TEXCOORD4;
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
  vec4 grabPassPos_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_22 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_22.zw;
  grabPassPos_23.xy = ((tmpvar_22.xy + tmpvar_22.w) * 0.5);
  grabPassPos_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_24;
  xlv_TEXCOORD4 = grabPassPos_23;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
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
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec4 rtRefractions_2;
  vec3 worldNormal_3;
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_4 + normal_5) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_3 = tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = ((tmpvar_6.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD4 + tmpvar_8);
  vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_2 = texture2DProj (_RefractionTex, tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_ReflectionTex, (xlv_TEXCOORD3 + tmpvar_8));
  float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_9).x) + _ZBufferParams.w)));
  if ((tmpvar_12 < xlv_TEXCOORD3.z)) {
    rtRefractions_2 = tmpvar_10;
  };
  worldNormal_3.xz = (tmpvar_6.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (rtRefractions_2, _BaseColor, _BaseColor.wwww), mix (tmpvar_11, _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_7), worldNormal_3), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_6, -(
      normalize((_WorldLightDir.xyz + tmpvar_7))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0).x;
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.z, c3, r0
mul r2.xz, r1, c21.y
dp4 r1.y, c1, r0
dp4 r0.z, c2, r0
mul r2.y, r1.y, c9.x
mul r2.w, r2.y, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r1.w, -r1.y
mov r0.xyw, r1.xyzz
add r1.xy, r1.z, r1.xwzw
mul o5.xy, r1, c21.y
mov o0, r0
mov o1.w, c22.x
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedmbmfofbgmnmdnclibhcabobjlpahpgjaabaaaaaakiajaaaaadaaaaaa
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
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
meahaaaaeaaaabaapbabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaadiaaaaaj
pcaabaaaaaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaaibcaabaaa
acaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiccaabaaa
acaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiecaabaaa
acaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaaiicaabaaa
acaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaa
enaaaaahpcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
acaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaacaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaaigaabaaa
abaaaaaaigaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaadaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
adaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaaibcaabaaa
aeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiccaabaaa
aeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiecaabaaa
aeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaaiicaabaaa
aeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaaaaaaaaa
enaaaaagaanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaa
acaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahicaabaaa
abaaaaaaegaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
diaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaagaaaaaa
dgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaaacaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalpcaabaaa
aaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaaigaibaaa
abaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
baaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
diaaaaakfcaabaaaaaaaaaaaagadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaaaaaaaaamgaabaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaadaaaaaadiaaaaakdccabaaaafaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadgaaaaaf
mccabaaaaeaaaaaakgaobaaaadaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaa
adaaaaaadoaaaaab"
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
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
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
  vec4 grabPassPos_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_22 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_22.zw;
  grabPassPos_23.xy = ((tmpvar_22.xy + tmpvar_22.w) * 0.5);
  grabPassPos_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_24;
  xlv_TEXCOORD4 = grabPassPos_23;
  xlv_TEXCOORD5 = tmpvar_22.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
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
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 baseColor_1;
  vec4 rtRefractions_2;
  vec3 worldNormal_3;
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_4 + normal_5) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_3 = tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = ((tmpvar_6.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD4 + tmpvar_8);
  vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_2 = texture2DProj (_RefractionTex, tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_ReflectionTex, (xlv_TEXCOORD3 + tmpvar_8));
  float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_9).x) + _ZBufferParams.w)));
  if ((tmpvar_12 < xlv_TEXCOORD3.z)) {
    rtRefractions_2 = tmpvar_10;
  };
  worldNormal_3.xz = (tmpvar_6.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (rtRefractions_2, _BaseColor, _BaseColor.wwww), mix (tmpvar_11, _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_7), worldNormal_3), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_6, -(
      normalize((_WorldLightDir.xyz + tmpvar_7))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0).x;
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
def c20, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
def c21, 0.159154937, 0.5, 6.28318548, -3.14159274
def c22, 1, 0.159154937, 0.25, 2
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.z, c3, r0
mul r2.xz, r1, c21.y
dp4 r1.y, c1, r0
dp4 r0.z, c2, r0
mul r2.y, r1.y, c9.x
mul r2.w, r2.y, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r1.w, -r1.y
mov r0.xyw, r1.xyzz
add r1.xy, r1.z, r1.xwzw
mul o5.xy, r1, c21.y
mov o0, r0
mov o6.x, r0.z
mov o1.w, c22.x
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedljneepbghobijfidhlbamdbfheifekmaabaaaaaaoaajaaaaadaaaaaa
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
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeahaaaaeaaaabaa
pjabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaa
diaaaaajpcaabaaaaaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaai
bcaabaaaacaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaai
ccaabaaaacaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaai
ecaabaaaacaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaai
icaabaaaacaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaak
pcaabaaaacaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaa
aaaaaaaaenaaaaahpcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaa
diaaaaajpcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaa
beaaaaaadiaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaa
bgaaaaaadiaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaa
bhaaaaaadgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaa
agaaaaaaagaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaa
bbaaaaahecaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaah
bcaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaa
adaaaaaaegacbaaaacaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaa
igaabaaaabaaaaaaigaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaa
adaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaa
acaaaaaaaaaaaaaaagaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
adaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaa
dcaaaaakpcaabaaaadaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaadaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaai
bcaabaaaaeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaai
ccaabaaaaeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaai
ecaabaaaaeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaai
icaabaaaaeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaa
aaaaaaaaenaaaaagaanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaj
pcaabaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaa
diaaaaaipcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaa
agaibaaaacaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaah
icaabaaaabaaaaaaegaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaa
abaaaaaadiaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaa
agaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaal
pcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaa
igaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaackaabaaaadaaaaaadiaaaaai
bcaabaaaaaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaa
aaaaaaaaagadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadcaaaaam
dcaabaaaaaaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaa
aaaaaaaapgapbaaaadaaaaaadiaaaaakdccabaaaafaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadgaaaaafmccabaaaaeaaaaaa
kgaobaaaadaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaaadaaaaaadoaaaaab
"
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
varying vec4 xlv_TEXCOORD4;
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
  vec4 grabPassPos_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_22 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_22.zw;
  grabPassPos_23.xy = ((tmpvar_22.xy + tmpvar_22.w) * 0.5);
  grabPassPos_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_24;
  xlv_TEXCOORD4 = grabPassPos_23;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
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
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec4 rtRefractions_2;
  vec3 worldNormal_3;
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_4 + normal_5) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_3 = tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = ((tmpvar_6.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD4 + tmpvar_8);
  vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_2 = texture2DProj (_RefractionTex, tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_9).x) + _ZBufferParams.w)));
  if ((tmpvar_11 < xlv_TEXCOORD3.z)) {
    rtRefractions_2 = tmpvar_10;
  };
  worldNormal_3.xz = (tmpvar_6.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (rtRefractions_2, _BaseColor, _BaseColor.wwww), _ReflectionColor, vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_7), worldNormal_3), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_6, -(
      normalize((_WorldLightDir.xyz + tmpvar_7))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0).x;
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.z, c3, r0
mul r2.xz, r1, c21.y
dp4 r1.y, c1, r0
dp4 r0.z, c2, r0
mul r2.y, r1.y, c9.x
mul r2.w, r2.y, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r1.w, -r1.y
mov r0.xyw, r1.xyzz
add r1.xy, r1.z, r1.xwzw
mul o5.xy, r1, c21.y
mov o0, r0
mov o1.w, c22.x
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedmbmfofbgmnmdnclibhcabobjlpahpgjaabaaaaaakiajaaaaadaaaaaa
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
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
meahaaaaeaaaabaapbabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaadiaaaaaj
pcaabaaaaaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaaibcaabaaa
acaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiccaabaaa
acaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiecaabaaa
acaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaaiicaabaaa
acaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaa
enaaaaahpcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
acaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaacaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaaigaabaaa
abaaaaaaigaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaadaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
adaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaaibcaabaaa
aeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiccaabaaa
aeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiecaabaaa
aeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaaiicaabaaa
aeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaaaaaaaaa
enaaaaagaanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaa
acaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahicaabaaa
abaaaaaaegaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
diaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaagaaaaaa
dgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaaacaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalpcaabaaa
aaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaaigaibaaa
abaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
baaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
diaaaaakfcaabaaaaaaaaaaaagadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaaaaaaaaamgaabaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaadaaaaaadiaaaaakdccabaaaafaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadgaaaaaf
mccabaaaaeaaaaaakgaobaaaadaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaa
adaaaaaadoaaaaab"
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
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
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
  vec4 grabPassPos_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_22 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_22.zw;
  grabPassPos_23.xy = ((tmpvar_22.xy + tmpvar_22.w) * 0.5);
  grabPassPos_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_24;
  xlv_TEXCOORD4 = grabPassPos_23;
  xlv_TEXCOORD5 = tmpvar_22.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
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
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 baseColor_1;
  vec4 rtRefractions_2;
  vec3 worldNormal_3;
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_4 + normal_5) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_3 = tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = ((tmpvar_6.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD4 + tmpvar_8);
  vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_2 = texture2DProj (_RefractionTex, tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_9).x) + _ZBufferParams.w)));
  if ((tmpvar_11 < xlv_TEXCOORD3.z)) {
    rtRefractions_2 = tmpvar_10;
  };
  worldNormal_3.xz = (tmpvar_6.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (rtRefractions_2, _BaseColor, _BaseColor.wwww), _ReflectionColor, vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_7), worldNormal_3), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_6, -(
      normalize((_WorldLightDir.xyz + tmpvar_7))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0).x;
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
def c20, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
def c21, 0.159154937, 0.5, 6.28318548, -3.14159274
def c22, 1, 0.159154937, 0.25, 2
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.z, c3, r0
mul r2.xz, r1, c21.y
dp4 r1.y, c1, r0
dp4 r0.z, c2, r0
mul r2.y, r1.y, c9.x
mul r2.w, r2.y, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r1.w, -r1.y
mov r0.xyw, r1.xyzz
add r1.xy, r1.z, r1.xwzw
mul o5.xy, r1, c21.y
mov o0, r0
mov o6.x, r0.z
mov o1.w, c22.x
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedljneepbghobijfidhlbamdbfheifekmaabaaaaaaoaajaaaaadaaaaaa
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
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeahaaaaeaaaabaa
pjabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaa
diaaaaajpcaabaaaaaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaai
bcaabaaaacaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaai
ccaabaaaacaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaai
ecaabaaaacaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaai
icaabaaaacaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaak
pcaabaaaacaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaa
aaaaaaaaenaaaaahpcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaa
diaaaaajpcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaa
beaaaaaadiaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaa
bgaaaaaadiaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaa
bhaaaaaadgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaa
agaaaaaaagaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaa
bbaaaaahecaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaah
bcaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaa
adaaaaaaegacbaaaacaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaa
igaabaaaabaaaaaaigaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaa
adaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaa
acaaaaaaaaaaaaaaagaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
adaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaa
dcaaaaakpcaabaaaadaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaadaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaai
bcaabaaaaeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaai
ccaabaaaaeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaai
ecaabaaaaeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaai
icaabaaaaeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaa
aaaaaaaaenaaaaagaanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaj
pcaabaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaa
diaaaaaipcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaa
agaibaaaacaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaah
icaabaaaabaaaaaaegaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaa
abaaaaaadiaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaa
agaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaal
pcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaa
igaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaackaabaaaadaaaaaadiaaaaai
bcaabaaaaaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaa
aaaaaaaaagadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadcaaaaam
dcaabaaaaaaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaa
aaaaaaaapgapbaaaadaaaaaadiaaaaakdccabaaaafaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadgaaaaafmccabaaaaeaaaaaa
kgaobaaaadaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaaadaaaaaadoaaaaab
"
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
varying vec4 xlv_TEXCOORD4;
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
  vec4 grabPassPos_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_22 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_22.zw;
  grabPassPos_23.xy = ((tmpvar_22.xy + tmpvar_22.w) * 0.5);
  grabPassPos_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_24;
  xlv_TEXCOORD4 = grabPassPos_23;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
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
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (texture2DProj (_RefractionTex, 
    (xlv_TEXCOORD4 + tmpvar_7)
  ), _BaseColor, _BaseColor.wwww), mix (texture2DProj (_ReflectionTex, 
    (xlv_TEXCOORD3 + tmpvar_7)
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_6), worldNormal_2), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
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
def c20, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
def c21, 0.159154937, 0.5, 6.28318548, -3.14159274
def c22, 1, 0.159154937, 0.25, 2
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.z, c3, r0
mul r2.xz, r1, c21.y
dp4 r1.y, c1, r0
dp4 r0.z, c2, r0
mul r2.y, r1.y, c9.x
mul r2.w, r2.y, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r1.w, -r1.y
mov r0.xyw, r1.xyzz
add r1.xy, r1.z, r1.xwzw
mul o5.xy, r1, c21.y
mov o0, r0
mov o1.w, c22.x
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedmbmfofbgmnmdnclibhcabobjlpahpgjaabaaaaaakiajaaaaadaaaaaa
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
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
meahaaaaeaaaabaapbabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaadiaaaaaj
pcaabaaaaaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaaibcaabaaa
acaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiccaabaaa
acaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiecaabaaa
acaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaaiicaabaaa
acaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaa
enaaaaahpcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
acaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaacaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaaigaabaaa
abaaaaaaigaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaadaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
adaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaaibcaabaaa
aeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiccaabaaa
aeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiecaabaaa
aeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaaiicaabaaa
aeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaaaaaaaaa
enaaaaagaanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaa
acaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahicaabaaa
abaaaaaaegaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
diaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaagaaaaaa
dgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaaacaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalpcaabaaa
aaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaaigaibaaa
abaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
baaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
diaaaaakfcaabaaaaaaaaaaaagadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaaaaaaaaamgaabaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaadaaaaaadiaaaaakdccabaaaafaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadgaaaaaf
mccabaaaaeaaaaaakgaobaaaadaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaa
adaaaaaadoaaaaab"
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
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
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
  vec4 grabPassPos_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_22 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_22.zw;
  grabPassPos_23.xy = ((tmpvar_22.xy + tmpvar_22.w) * 0.5);
  grabPassPos_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_24;
  xlv_TEXCOORD4 = grabPassPos_23;
  xlv_TEXCOORD5 = tmpvar_22.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
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
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (texture2DProj (_RefractionTex, 
    (xlv_TEXCOORD4 + tmpvar_7)
  ), _BaseColor, _BaseColor.wwww), mix (texture2DProj (_ReflectionTex, 
    (xlv_TEXCOORD3 + tmpvar_7)
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_6), worldNormal_2), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
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
def c20, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
def c21, 0.159154937, 0.5, 6.28318548, -3.14159274
def c22, 1, 0.159154937, 0.25, 2
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.z, c3, r0
mul r2.xz, r1, c21.y
dp4 r1.y, c1, r0
dp4 r0.z, c2, r0
mul r2.y, r1.y, c9.x
mul r2.w, r2.y, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r1.w, -r1.y
mov r0.xyw, r1.xyzz
add r1.xy, r1.z, r1.xwzw
mul o5.xy, r1, c21.y
mov o0, r0
mov o6.x, r0.z
mov o1.w, c22.x
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedljneepbghobijfidhlbamdbfheifekmaabaaaaaaoaajaaaaadaaaaaa
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
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeahaaaaeaaaabaa
pjabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaa
diaaaaajpcaabaaaaaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaai
bcaabaaaacaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaai
ccaabaaaacaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaai
ecaabaaaacaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaai
icaabaaaacaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaak
pcaabaaaacaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaa
aaaaaaaaenaaaaahpcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaa
diaaaaajpcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaa
beaaaaaadiaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaa
bgaaaaaadiaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaa
bhaaaaaadgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaa
agaaaaaaagaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaa
bbaaaaahecaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaah
bcaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaa
adaaaaaaegacbaaaacaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaa
igaabaaaabaaaaaaigaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaa
adaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaa
acaaaaaaaaaaaaaaagaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
adaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaa
dcaaaaakpcaabaaaadaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaadaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaai
bcaabaaaaeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaai
ccaabaaaaeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaai
ecaabaaaaeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaai
icaabaaaaeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaa
aaaaaaaaenaaaaagaanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaj
pcaabaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaa
diaaaaaipcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaa
agaibaaaacaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaah
icaabaaaabaaaaaaegaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaa
abaaaaaadiaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaa
agaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaal
pcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaa
igaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaackaabaaaadaaaaaadiaaaaai
bcaabaaaaaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaa
aaaaaaaaagadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadcaaaaam
dcaabaaaaaaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaa
aaaaaaaapgapbaaaadaaaaaadiaaaaakdccabaaaafaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadgaaaaafmccabaaaaeaaaaaa
kgaobaaaadaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaaadaaaaaadoaaaaab
"
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
varying vec4 xlv_TEXCOORD4;
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
  vec4 grabPassPos_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_22 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_22.zw;
  grabPassPos_23.xy = ((tmpvar_22.xy + tmpvar_22.w) * 0.5);
  grabPassPos_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_24;
  xlv_TEXCOORD4 = grabPassPos_23;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
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
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (texture2DProj (_RefractionTex, 
    (xlv_TEXCOORD4 + tmpvar_7)
  ), _BaseColor, _BaseColor.wwww), _ReflectionColor, vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_6), worldNormal_2), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
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
def c20, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
def c21, 0.159154937, 0.5, 6.28318548, -3.14159274
def c22, 1, 0.159154937, 0.25, 2
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.z, c3, r0
mul r2.xz, r1, c21.y
dp4 r1.y, c1, r0
dp4 r0.z, c2, r0
mul r2.y, r1.y, c9.x
mul r2.w, r2.y, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r1.w, -r1.y
mov r0.xyw, r1.xyzz
add r1.xy, r1.z, r1.xwzw
mul o5.xy, r1, c21.y
mov o0, r0
mov o1.w, c22.x
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedmbmfofbgmnmdnclibhcabobjlpahpgjaabaaaaaakiajaaaaadaaaaaa
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
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
meahaaaaeaaaabaapbabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaadiaaaaaj
pcaabaaaaaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaaibcaabaaa
acaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiccaabaaa
acaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiecaabaaa
acaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaaiicaabaaa
acaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaa
enaaaaahpcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
acaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaacaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaaigaabaaa
abaaaaaaigaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaadaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
adaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaaibcaabaaa
aeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiccaabaaa
aeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiecaabaaa
aeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaaiicaabaaa
aeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaaaaaaaaa
enaaaaagaanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaa
acaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahicaabaaa
abaaaaaaegaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
diaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaagaaaaaa
dgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaaacaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalpcaabaaa
aaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaaigaibaaa
abaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
baaaaaaadiaaaaaibcaabaaaaaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
diaaaaakfcaabaaaaaaaaaaaagadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaaaaaaaaamgaabaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaadaaaaaadiaaaaakdccabaaaafaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadgaaaaaf
mccabaaaaeaaaaaakgaobaaaadaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaa
adaaaaaadoaaaaab"
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
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
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
  vec4 grabPassPos_23;
  vec4 o_24;
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_22 * 0.5);
  vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_22.zw;
  grabPassPos_23.xy = ((tmpvar_22.xy + tmpvar_22.w) * 0.5);
  grabPassPos_23.zw = tmpvar_22.zw;
  tmpvar_2.xyz = tmpvar_21;
  tmpvar_2.w = 1.0;
  gl_Position = tmpvar_22;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_3 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_24;
  xlv_TEXCOORD4 = grabPassPos_23;
  xlv_TEXCOORD5 = tmpvar_22.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
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
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (texture2DProj (_RefractionTex, 
    (xlv_TEXCOORD4 + tmpvar_7)
  ), _BaseColor, _BaseColor.wwww), _ReflectionColor, vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_6), worldNormal_2), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
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
def c20, -2.52398507e-007, 2.47609005e-005, -0.00138883968, 0.0416666418
def c21, 0.159154937, 0.5, 6.28318548, -3.14159274
def c22, 1, 0.159154937, 0.25, 2
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xyz
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.z, c3, r0
mul r2.xz, r1, c21.y
dp4 r1.y, c1, r0
dp4 r0.z, c2, r0
mul r2.y, r1.y, c9.x
mul r2.w, r2.y, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov r1.w, -r1.y
mov r0.xyw, r1.xyzz
add r1.xy, r1.z, r1.xwzw
mul o5.xy, r1, c21.y
mov o0, r0
mov o6.x, r0.z
mov o1.w, c22.x
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedljneepbghobijfidhlbamdbfheifekmaabaaaaaaoaajaaaaadaaaaaa
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
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeahaaaaeaaaabaa
pjabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaa
diaaaaajpcaabaaaaaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaai
bcaabaaaacaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaai
ccaabaaaacaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaai
ecaabaaaacaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaai
icaabaaaacaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaak
pcaabaaaacaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaa
aaaaaaaaenaaaaahpcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaa
diaaaaajpcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaa
beaaaaaadiaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaa
bgaaaaaadiaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaa
bhaaaaaadgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaa
agaaaaaaagaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaa
bbaaaaahecaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaah
bcaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaa
adaaaaaaegacbaaaacaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaa
igaabaaaabaaaaaaigaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaa
adaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaa
acaaaaaaaaaaaaaaagaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
adaaaaaaegiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaa
dcaaaaakpcaabaaaadaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaadaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaai
bcaabaaaaeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaai
ccaabaaaaeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaai
ecaabaaaaeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaai
icaabaaaaeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaa
aaaaaaaaenaaaaagaanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaj
pcaabaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaa
diaaaaaipcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaa
agaibaaaacaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaah
icaabaaaabaaaaaaegaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaa
abaaaaaadiaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaa
agaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaa
acaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaal
pcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaa
igaibaaaabaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaabaaaaaaadgaaaaaficcabaaaacaaaaaackaabaaaadaaaaaadiaaaaai
bcaabaaaaaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaa
aaaaaaaaagadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadcaaaaam
dcaabaaaaaaaaaaaegaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaa
aaaaaaaapgapbaaaadaaaaaadiaaaaakdccabaaaafaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadgaaaaafmccabaaaaeaaaaaa
kgaobaaaadaaaaaadgaaaaafmccabaaaafaaaaaakgaobaaaadaaaaaadoaaaaab
"
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
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_4;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  grabPassPos_4.xy = ((tmpvar_3.xy + tmpvar_3.w) * 0.5);
  grabPassPos_4.zw = tmpvar_3.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD4 = grabPassPos_4;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
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
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec4 rtRefractions_2;
  vec3 worldNormal_3;
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_4 + normal_5) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_3 = tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = ((tmpvar_6.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD4 + tmpvar_8);
  vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_2 = texture2DProj (_RefractionTex, tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_ReflectionTex, (xlv_TEXCOORD3 + tmpvar_8));
  float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_9).x) + _ZBufferParams.w)));
  if ((tmpvar_12 < xlv_TEXCOORD3.z)) {
    rtRefractions_2 = tmpvar_10;
  };
  worldNormal_3.xz = (tmpvar_6.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (rtRefractions_2, _BaseColor, _BaseColor.wwww), mix (tmpvar_11, _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_7), worldNormal_3), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_6, -(
      normalize((_WorldLightDir.xyz + tmpvar_7))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0).x;
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
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedkmpcceilcipcpifpeoiaoempjkeclcfcabaaaaaafeafaaaaadaaaaaa
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
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
haadaaaaeaaaabaanmaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
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
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_4;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  grabPassPos_4.xy = ((tmpvar_3.xy + tmpvar_3.w) * 0.5);
  grabPassPos_4.zw = tmpvar_3.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD4 = grabPassPos_4;
  xlv_TEXCOORD5 = tmpvar_3.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
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
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 baseColor_1;
  vec4 rtRefractions_2;
  vec3 worldNormal_3;
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_4 + normal_5) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_3 = tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = ((tmpvar_6.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD4 + tmpvar_8);
  vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_2 = texture2DProj (_RefractionTex, tmpvar_9);
  vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_ReflectionTex, (xlv_TEXCOORD3 + tmpvar_8));
  float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_9).x) + _ZBufferParams.w)));
  if ((tmpvar_12 < xlv_TEXCOORD3.z)) {
    rtRefractions_2 = tmpvar_10;
  };
  worldNormal_3.xz = (tmpvar_6.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (rtRefractions_2, _BaseColor, _BaseColor.wwww), mix (tmpvar_11, _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_7), worldNormal_3), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_6, -(
      normalize((_WorldLightDir.xyz + tmpvar_7))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0).x;
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
dcl_texcoord1 o2.xyz
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
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefieceddphhnlhjahmkhcacchhkceojdaaijbnjabaaaaaaimafaaaaadaaaaaa
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
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjaadaaaaeaaaabaa
oeaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaa
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
ckaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaakdccabaaa
afaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaafmccabaaaafaaaaaa
kgaobaaaaaaaaaaadoaaaaab"
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
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_4;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  grabPassPos_4.xy = ((tmpvar_3.xy + tmpvar_3.w) * 0.5);
  grabPassPos_4.zw = tmpvar_3.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD4 = grabPassPos_4;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
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
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 baseColor_1;
  vec4 rtRefractions_2;
  vec3 worldNormal_3;
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_4 + normal_5) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_3 = tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = ((tmpvar_6.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD4 + tmpvar_8);
  vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_2 = texture2DProj (_RefractionTex, tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_9).x) + _ZBufferParams.w)));
  if ((tmpvar_11 < xlv_TEXCOORD3.z)) {
    rtRefractions_2 = tmpvar_10;
  };
  worldNormal_3.xz = (tmpvar_6.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (rtRefractions_2, _BaseColor, _BaseColor.wwww), _ReflectionColor, vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_7), worldNormal_3), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_6, -(
      normalize((_WorldLightDir.xyz + tmpvar_7))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0).x;
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
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedkmpcceilcipcpifpeoiaoempjkeclcfcabaaaaaafeafaaaaadaaaaaa
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
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
haadaaaaeaaaabaanmaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
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
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_4;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  grabPassPos_4.xy = ((tmpvar_3.xy + tmpvar_3.w) * 0.5);
  grabPassPos_4.zw = tmpvar_3.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD4 = grabPassPos_4;
  xlv_TEXCOORD5 = tmpvar_3.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
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
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 baseColor_1;
  vec4 rtRefractions_2;
  vec3 worldNormal_3;
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.xy).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (
    dot (normal_4.xy, normal_4.xy)
  , 0.0, 1.0)));
  vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, xlv_TEXCOORD2.zw).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (
    dot (normal_5.xy, normal_5.xy)
  , 0.0, 1.0)));
  vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_4 + normal_5) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_3 = tmpvar_6;
  vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = ((tmpvar_6.xz * _DistortParams.y) * 10.0);
  vec4 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD4 + tmpvar_8);
  vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_RefractionTex, xlv_TEXCOORD4);
  rtRefractions_2 = texture2DProj (_RefractionTex, tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, tmpvar_9).x) + _ZBufferParams.w)));
  if ((tmpvar_11 < xlv_TEXCOORD3.z)) {
    rtRefractions_2 = tmpvar_10;
  };
  worldNormal_3.xz = (tmpvar_6.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (rtRefractions_2, _BaseColor, _BaseColor.wwww), _ReflectionColor, vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_7), worldNormal_3), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_6, -(
      normalize((_WorldLightDir.xyz + tmpvar_7))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((_InvFadeParemeter * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w)), 0.0, 1.0).x;
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
dcl_texcoord1 o2.xyz
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
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefieceddphhnlhjahmkhcacchhkceojdaaijbnjabaaaaaaimafaaaaadaaaaaa
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
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjaadaaaaeaaaabaa
oeaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaa
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
ckaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaakdccabaaa
afaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaafmccabaaaafaaaaaa
kgaobaaaaaaaaaaadoaaaaab"
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
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_4;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  grabPassPos_4.xy = ((tmpvar_3.xy + tmpvar_3.w) * 0.5);
  grabPassPos_4.zw = tmpvar_3.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD4 = grabPassPos_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
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
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (texture2DProj (_RefractionTex, 
    (xlv_TEXCOORD4 + tmpvar_7)
  ), _BaseColor, _BaseColor.wwww), mix (texture2DProj (_ReflectionTex, 
    (xlv_TEXCOORD3 + tmpvar_7)
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_6), worldNormal_2), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
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
dcl_texcoord1 o2.xyz
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
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedkmpcceilcipcpifpeoiaoempjkeclcfcabaaaaaafeafaaaaadaaaaaa
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
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
haadaaaaeaaaabaanmaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
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
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_4;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  grabPassPos_4.xy = ((tmpvar_3.xy + tmpvar_3.w) * 0.5);
  grabPassPos_4.zw = tmpvar_3.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD4 = grabPassPos_4;
  xlv_TEXCOORD5 = tmpvar_3.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _ReflectionTex;
uniform sampler2D _RefractionTex;
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
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (texture2DProj (_RefractionTex, 
    (xlv_TEXCOORD4 + tmpvar_7)
  ), _BaseColor, _BaseColor.wwww), mix (texture2DProj (_ReflectionTex, 
    (xlv_TEXCOORD3 + tmpvar_7)
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_6), worldNormal_2), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
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
dcl_texcoord1 o2.xyz
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
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefieceddphhnlhjahmkhcacchhkceojdaaijbnjabaaaaaaimafaaaaadaaaaaa
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
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjaadaaaaeaaaabaa
oeaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaa
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
ckaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaakdccabaaa
afaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaafmccabaaaafaaaaaa
kgaobaaaaaaaaaaadoaaaaab"
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
varying vec4 xlv_TEXCOORD4;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_4;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  grabPassPos_4.xy = ((tmpvar_3.xy + tmpvar_3.w) * 0.5);
  grabPassPos_4.zw = tmpvar_3.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD4 = grabPassPos_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
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
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (texture2DProj (_RefractionTex, 
    (xlv_TEXCOORD4 + tmpvar_7)
  ), _BaseColor, _BaseColor.wwww), _ReflectionColor, vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_6), worldNormal_2), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
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
dcl_texcoord1 o2.xyz
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
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedkmpcceilcipcpifpeoiaoempjkeclcfcabaaaaaafeafaaaaadaaaaaa
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
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
haadaaaaeaaaabaanmaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
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
varying vec4 xlv_TEXCOORD4;
varying float xlv_TEXCOORD5;
void main ()
{
  vec4 tmpvar_1;
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
  vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 grabPassPos_4;
  vec4 o_5;
  vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  grabPassPos_4.xy = ((tmpvar_3.xy + tmpvar_3.w) * 0.5);
  grabPassPos_4.zw = tmpvar_3.zw;
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD4 = grabPassPos_4;
  xlv_TEXCOORD5 = tmpvar_3.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _RefractionTex;
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
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = ((tmpvar_5.xz * _DistortParams.y) * 10.0);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (mix (mix (texture2DProj (_RefractionTex, 
    (xlv_TEXCOORD4 + tmpvar_7)
  ), _BaseColor, _BaseColor.wwww), _ReflectionColor, vec4(clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_6), worldNormal_2), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0))) + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
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
dcl_texcoord1 o2.xyz
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
mov o4.zw, r0
mov o5.zw, r0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefieceddphhnlhjahmkhcacchhkceojdaaijbnjabaaaaaaimafaaaaadaaaaaa
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
apaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiahaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcjaadaaaaeaaaabaa
oeaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaa
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
ckaabaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaadpdiaaaaakfcaabaaaabaaaaaaagadbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaakdccabaaa
afaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaadgaaaaafmccabaaaafaaaaaa
kgaobaaaaaaaaaaadoaaaaab"
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
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texldp_pp r0, v3, s3
mad r0.x, c0.z, r0.x, c0.w
rcp_pp r0.x, r0.x
add r0.x, r0.x, -v3.w
mul_sat_pp oC0.w, r0.x, c4.x
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mad_pp r0.xyz, r0, c9.zwzw, v0
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
mov r1.zw, c9.w
add_pp r3, r1, v4
add_pp r1, r1.xyww, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c3.w, c3, r1
texldp_pp r1, r3, s3
texldp_pp r3, r3, s2
mad r1.x, c0.z, r1.x, c0.w
rcp r1.x, r1.x
add r1.x, r1.x, -v3.z
texldp_pp r4, v4, s2
cmp_pp r1.xyz, r1.x, r3, r4
lrp_pp r2.yzw, c2.w, c2.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r0, r2.yzww
mad_pp oC0.xyz, r0.w, c1, r1

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 2
SetTexture 2 [_CameraDepthTexture] 2D 3
SetTexture 3 [_ReflectionTex] 2D 1
ConstBuffer "$Globals" 384
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
eefiecedjaamfjpnncdjacabakljlccfmeaampjeabaaaaaabeakaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeaiaaaa
eaaaaaaadnacaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacagaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaafaaaaaapgbpbaaa
afaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaabaaaaaapganbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaapganbaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaabaaaaaaaaaaaaak
hcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
agiacaaaaaaaaaaaaoaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaidcaabaaaacaaaaaaigaabaaaabaaaaaafgifcaaa
aaaaaaaaaoaaaaaadiaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaa
aaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaa
aaaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaacaaaaaaegbdbaaaafaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegbdbaaaaeaaaaaaaoaaaaah
dcaabaaaacaaaaaaegaabaaaacaaaaaakgakbaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaaoaaaaah
dcaabaaaadaaaaaaegaabaaaadaaaaaakgakbaaaadaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
dcaaaaalicaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaeaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackbabaaaaeaaaaaadhaaaaajhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaajhcaabaaaadaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaa
aaaaaaaapgipcaaaaaaaaaaaajaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaa
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
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkbabaiaebaaaaaaaeaaaaaadicaaaaiiccabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaalaaaaaadoaaaaab"
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
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
"ps_3_0
def c11, 2, -1, 0.5, 0
def c12, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texldp_pp r0, v3, s3
mad r0.x, c0.z, r0.x, c0.w
rcp_pp r0.x, r0.x
add r0.x, r0.x, -v3.w
mul_sat_pp oC0.w, r0.x, c6.x
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c11.x, c11.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c11.x, c11.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c9.x
mad_pp r0.xyz, r0, c11.zwzw, v0
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
mul_pp r1.xy, r1, c12.x
max r2.w, r0.w, c11.w
pow r0.w, r2.w, c7.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c11.y
cmp_pp r0.x, r0.x, r0.y, -c11.y
max_pp r2.x, r0.x, c11.w
pow_pp r0.x, r2.x, c9.z
mov r0.y, c11.y
lrp_sat_pp r2.x, r0.x, -r0.y, c9.w
mov r1.zw, c11.w
add_pp r3, r1, v4
add_pp r1, r1.xyww, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c5.w, c5, r1
texldp_pp r1, r3, s3
texldp_pp r3, r3, s2
mad r1.x, c0.z, r1.x, c0.w
rcp r1.x, r1.x
add r1.x, r1.x, -v3.z
texldp_pp r4, v4, s2
cmp_pp r1.xyz, r1.x, r3, r4
lrp_pp r2.yzw, c4.w, c4.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r0, r2.yzww
mad_pp r0.xyz, r0.w, c3, r1
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
SetTexture 2 [_CameraDepthTexture] 2D 3
SetTexture 3 [_ReflectionTex] 2D 1
ConstBuffer "$Globals" 384
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
eefiecedcopmgihkkigmdnmienkkojaclmggejnfabaaaaaaoiakaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclaajaaaaeaaaaaaagmacaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaad
lcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaaphcaabaaaabaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaabaaaaaapganbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaaaoaaaaaa
dcaaaaamhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
dcaabaaaacaaaaaaigaabaaaabaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaak
dcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaa
aaaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaa
adaaaaaaegacbaaaacaaaaaaegbdbaaaafaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegbdbaaaaeaaaaaaaoaaaaahdcaabaaaacaaaaaaegaabaaa
acaaaaaakgakbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaadaaaaaaaagabaaaabaaaaaaaoaaaaahdcaabaaaadaaaaaaegaabaaa
adaaaaaakgakbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaalicaabaaaaaaaaaaa
ckiacaaaabaaaaaaahaaaaaaakaabaaaaeaaaaaadkiacaaaabaaaaaaahaaaaaa
aoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackbabaaa
aeaaaaaadhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaadaaaaaaaaaaaaajhcaabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaa
egiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaaaaaaaaaapgipcaaaaaaaaaaa
ajaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaadaaaaaa
egacbaiaebaaaaaaacaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
acaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaa
aaaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaacaaaaaa
diaaaaaifcaabaaaadaaaaaaagacbaaaabaaaaaaagiacaaaaaaaaaaaapaaaaaa
dgaaaaafccaabaaaadaaaaaabkaabaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaa
dcaaaaakhcaabaaaafaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaa
aaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaa
egacbaaaadaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaadcaaaaajhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
afaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaa
acaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegiccaaa
aaaaaaaaaiaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkbabaaaacaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaiaebaaaaaa
aeaaaaaadicaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
alaaaaaadoaaaaab"
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
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_2d s0
dcl_2d s1
dcl_2d s2
texldp_pp r0, v3, s2
mad r0.x, c0.z, r0.x, c0.w
rcp_pp r0.x, r0.x
add r0.x, r0.x, -v3.w
mul_sat_pp oC0.w, r0.x, c4.x
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mad_pp r0.xyz, r0, c9.zwzw, v0
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
mov r1.zw, c9.w
add_pp r1, r1, v4
texldp_pp r3, r1, s2
texldp_pp r1, r1, s1
mad r0.x, c0.z, r3.x, c0.w
rcp r0.x, r0.x
add r0.x, r0.x, -v3.z
texldp_pp r3, v4, s1
cmp_pp r0.xyz, r0.x, r1, r3
lrp_pp r1.xyz, c2.w, c2, r0
lrp_pp r0.xyz, r2.x, c3, r1
mad_pp oC0.xyz, r0.w, c1, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 384
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
eefiecedfledlbpebjbnghhnenaccgndebapgccgabaaaaaafeajaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeaiaaaa
eaaaaaaaanacaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaa
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
hcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaaafaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
icaabaaaabaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaabaaaaaadbaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaackbabaaaaeaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaafaaaaaa
pgbpbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadhaaaaajhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaia
ebaaaaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaa
pgipcaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaa
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkbabaiaebaaaaaaaeaaaaaadicaaaaiiccabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaalaaaaaadoaaaaab"
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
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"ps_3_0
def c11, 2, -1, 0.5, 0
def c12, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
texldp_pp r0, v3, s2
mad r0.x, c0.z, r0.x, c0.w
rcp_pp r0.x, r0.x
add r0.x, r0.x, -v3.w
mul_sat_pp oC0.w, r0.x, c6.x
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c11.x, c11.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c11.x, c11.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c9.x
mad_pp r0.xyz, r0, c11.zwzw, v0
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
mul_pp r1.xy, r1, c12.x
max r2.w, r0.w, c11.w
pow r0.w, r2.w, c7.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c11.y
cmp_pp r0.x, r0.x, r0.y, -c11.y
max_pp r2.x, r0.x, c11.w
pow_pp r0.x, r2.x, c9.z
mov r0.y, c11.y
lrp_sat_pp r2.x, r0.x, -r0.y, c9.w
mov r1.zw, c11.w
add_pp r1, r1, v4
texldp_pp r3, r1, s2
texldp_pp r1, r1, s1
mad r0.x, c0.z, r3.x, c0.w
rcp r0.x, r0.x
add r0.x, r0.x, -v3.z
texldp_pp r3, v4, s1
cmp_pp r0.xyz, r0.x, r1, r3
lrp_pp r1.xyz, c4.w, c4, r0
lrp_pp r0.xyz, r2.x, c5, r1
mad_pp r0.xyz, r0.w, c3, r0
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
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 384
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
eefiecedljfikjfhpibonjbjnagcinbbpflehbhpabaaaaaaciakaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpaaiaaaaeaaaaaaadmacaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
icbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
aoaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaaaaaaaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
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
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaadiaaaaaidcaabaaaabaaaaaa
igaabaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaaf
ecaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegbdbaaaafaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
kgakbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaalicaabaaaabaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
icaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
abaaaaaadbaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaackbabaaaaeaaaaaa
aoaaaaahdcaabaaaacaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dhaaaaajhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaa
aaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaaaaaaaaaaajaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaia
ebaaaaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaajhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
adaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkbabaaaacaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaiaebaaaaaa
aeaaaaaadicaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
alaaaaaadoaaaaab"
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
SetTexture 2 [_RefractionTex] 2D 2
"ps_3_0
def c7, 2, -1, 0.5, 0
def c8, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c7.x, c7.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c7.x, c7.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c5.x
mad_pp r0.xyz, r0, c7.zwzw, v0
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
mov_pp r1.zw, c7.w
add_pp r3, r1.xyww, v3
add_pp r1, r1, v4
texldp_pp r1, r1, s2
lrp_pp r0.xyz, c1.w, c1, r1
texldp_pp r1, r3, s1
lrp_pp r2.yzw, c2.w, c2.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r2.yzww, r0
mad_pp oC0.xyz, r0.w, c0, r1
mov_pp oC0.w, -c7.y

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 2
SetTexture 2 [_ReflectionTex] 2D 1
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedneihhhffijillkdjdokfhjakeaipmhnkabaaaaaadaaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbaahaaaa
eaaaaaaameabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagcbaaaad
lcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaaj
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
abaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaa
egbdbaaaaeaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaa
afaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaaaoaaaaahdcaabaaaacaaaaaaegaabaaaacaaaaaakgakbaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
abaaaaaaaaaaaaajhcaabaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaacaaaaaapgipcaaaaaaaaaaaakaaaaaa
egacbaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaajhcaabaaaaeaaaaaaegacbaia
ebaaaaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaa
pgipcaaaaaaaaaaaajaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
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
SetTexture 2 [_RefractionTex] 2D 2
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mad_pp r0.xyz, r0, c9.zwzw, v0
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
mov_pp r1.zw, c9.w
add_pp r3, r1.xyww, v3
add_pp r1, r1, v4
texldp_pp r1, r1, s2
lrp_pp r0.xyz, c3.w, c3, r1
texldp_pp r1, r3, s1
lrp_pp r2.yzw, c4.w, c4.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r2.yzww, r0
mad_pp r0.xyz, r0.w, c2, r1
add r0.xyz, r0, -c0
mul r0.w, c1.y, v5.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c0
mov_pp oC0.w, -c9.y

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 2
SetTexture 2 [_ReflectionTex] 2D 1
ConstBuffer "$Globals" 384
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
eefiecedldfcfkmipppphgcppeoifedfkhgpnjfoabaaaaaaaeajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmmahaaaaeaaaaaaapdabaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagcbaaaadlcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
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
aaaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegbdbaaaaeaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaaafaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaaoaaaaahdcaabaaa
acaaaaaaegaabaaaacaaaaaakgakbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaaaaaaaajhcaabaaa
aeaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaacaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaaaeaaaaaaegacbaaa
acaaaaaaaaaaaaajhcaabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaa
aaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaaaaaaaaaaajaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaia
ebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkbabaaa
acaaaaaabkiacaaaabaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
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
SetTexture 1 [_RefractionTex] 2D 1
"ps_3_0
def c7, 2, -1, 0.5, 0
def c8, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord4 v3
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c7.x, c7.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c7.x, c7.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c5.x
mad_pp r0.xyz, r0, c7.zwzw, v0
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
mov_pp r1.zw, c7.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c1.w, c1, r1
lrp_pp r1.xyz, r2.x, c2, r0
mad_pp oC0.xyz, r0.w, c0, r1
mov_pp oC0.w, -c7.y

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmoaekiobdeplcfehfodnhmepokcenpiaabaaaaaageahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceeagaaaa
eaaaaaaajbabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaa
aaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaa
egbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
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
aaaaaaaaaoaaaaaadiaaaaaidcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaa
aaaaaaaaaoaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaa
aaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaa
aaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaaafaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaaaaaaaaaaajaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaa
abaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakhccabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
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
SetTexture 1 [_RefractionTex] 2D 1
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord4 v3
dcl_texcoord5 v4.x
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mad_pp r0.xyz, r0, c9.zwzw, v0
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
mov_pp r1.zw, c9.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c3.w, c3, r1
lrp_pp r1.xyz, r2.x, c4, r0
mad_pp r0.xyz, r0.w, c2, r1
add r0.xyz, r0, -c0
mul r0.w, c1.y, v4.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c0
mov_pp oC0.w, -c9.y

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
ConstBuffer "$Globals" 384
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
eefiecedmpipkdjjpacfdchcjnegbjbojcpbobbaabaaaaaadiaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaahaaaaeaaaaaaamaabaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
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
egaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaa
abaaaaaapgipcaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaa
akaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
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
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
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
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texldp_pp r0, v3, s3
mad r0.x, c0.z, r0.x, c0.w
rcp_pp r0.x, r0.x
add r0.x, r0.x, -v3.w
mul_sat_pp oC0.w, r0.x, c4.x
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mad_pp r0.xyz, r0, c9.zwzw, v0
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
mov r1.zw, c9.w
add_pp r3, r1, v4
add_pp r1, r1.xyww, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c3.w, c3, r1
texldp_pp r1, r3, s3
texldp_pp r3, r3, s2
mad r1.x, c0.z, r1.x, c0.w
rcp r1.x, r1.x
add r1.x, r1.x, -v3.z
texldp_pp r4, v4, s2
cmp_pp r1.xyz, r1.x, r3, r4
lrp_pp r2.yzw, c2.w, c2.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r0, r2.yzww
mad_pp oC0.xyz, r0.w, c1, r1

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 2
SetTexture 2 [_CameraDepthTexture] 2D 3
SetTexture 3 [_ReflectionTex] 2D 1
ConstBuffer "$Globals" 384
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
eefiecedjaamfjpnncdjacabakljlccfmeaampjeabaaaaaabeakaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeaiaaaa
eaaaaaaadnacaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacagaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaafaaaaaapgbpbaaa
afaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaaabaaaaaapganbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaapganbaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaabaaaaaaaaaaaaak
hcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
agiacaaaaaaaaaaaaoaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaidcaabaaaacaaaaaaigaabaaaabaaaaaafgifcaaa
aaaaaaaaaoaaaaaadiaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaa
aaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaa
aaaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaacaaaaaaegbdbaaaafaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegbdbaaaaeaaaaaaaoaaaaah
dcaabaaaacaaaaaaegaabaaaacaaaaaakgakbaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaaoaaaaah
dcaabaaaadaaaaaaegaabaaaadaaaaaakgakbaaaadaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
dcaaaaalicaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaeaaaaaa
dkiacaaaabaaaaaaahaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackbabaaaaeaaaaaadhaaaaajhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaajhcaabaaaadaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaa
aaaaaaaapgipcaaaaaaaaaaaajaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaa
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
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkbabaiaebaaaaaaaeaaaaaadicaaaaiiccabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaalaaaaaadoaaaaab"
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
SetTexture 2 [_RefractionTex] 2D 2
SetTexture 3 [_CameraDepthTexture] 2D 3
"ps_3_0
def c11, 2, -1, 0.5, 0
def c12, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
texldp_pp r0, v3, s3
mad r0.x, c0.z, r0.x, c0.w
rcp_pp r0.x, r0.x
add r0.x, r0.x, -v3.w
mul_sat_pp oC0.w, r0.x, c6.x
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c11.x, c11.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c11.x, c11.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c9.x
mad_pp r0.xyz, r0, c11.zwzw, v0
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
mul_pp r1.xy, r1, c12.x
max r2.w, r0.w, c11.w
pow r0.w, r2.w, c7.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c11.y
cmp_pp r0.x, r0.x, r0.y, -c11.y
max_pp r2.x, r0.x, c11.w
pow_pp r0.x, r2.x, c9.z
mov r0.y, c11.y
lrp_sat_pp r2.x, r0.x, -r0.y, c9.w
mov r1.zw, c11.w
add_pp r3, r1, v4
add_pp r1, r1.xyww, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c5.w, c5, r1
texldp_pp r1, r3, s3
texldp_pp r3, r3, s2
mad r1.x, c0.z, r1.x, c0.w
rcp r1.x, r1.x
add r1.x, r1.x, -v3.z
texldp_pp r4, v4, s2
cmp_pp r1.xyz, r1.x, r3, r4
lrp_pp r2.yzw, c4.w, c4.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r0, r2.yzww
mad_pp r0.xyz, r0.w, c3, r1
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
SetTexture 2 [_CameraDepthTexture] 2D 3
SetTexture 3 [_ReflectionTex] 2D 1
ConstBuffer "$Globals" 384
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
eefiecedcopmgihkkigmdnmienkkojaclmggejnfabaaaaaaoiakaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclaajaaaaeaaaaaaagmacaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaad
lcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaaphcaabaaaabaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaabaaaaaapganbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaaaaaaaaaaaoaaaaaa
dcaaaaamhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
dcaabaaaacaaaaaaigaabaaaabaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaak
dcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaa
aaaaaaaadgaaaaafecaabaaaacaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaa
adaaaaaaegacbaaaacaaaaaaegbdbaaaafaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegbdbaaaaeaaaaaaaoaaaaahdcaabaaaacaaaaaaegaabaaa
acaaaaaakgakbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaadaaaaaaaagabaaaabaaaaaaaoaaaaahdcaabaaaadaaaaaaegaabaaa
adaaaaaakgakbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaalicaabaaaaaaaaaaa
ckiacaaaabaaaaaaahaaaaaaakaabaaaaeaaaaaadkiacaaaabaaaaaaahaaaaaa
aoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackbabaaa
aeaaaaaadhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaadaaaaaaaaaaaaajhcaabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaa
egiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaaaaaaaaaapgipcaaaaaaaaaaa
ajaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaadaaaaaa
egacbaiaebaaaaaaacaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
acaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaa
aaaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaacaaaaaa
diaaaaaifcaabaaaadaaaaaaagacbaaaabaaaaaaagiacaaaaaaaaaaaapaaaaaa
dgaaaaafccaabaaaadaaaaaabkaabaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaa
dcaaaaakhcaabaaaafaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaa
aaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaaeaaaaaa
egacbaaaadaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
aoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaadcaaaaajhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
afaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaa
acaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegiccaaa
aaaaaaaaaiaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkbabaaaacaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaiaebaaaaaa
aeaaaaaadicaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
alaaaaaadoaaaaab"
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
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_2d s0
dcl_2d s1
dcl_2d s2
texldp_pp r0, v3, s2
mad r0.x, c0.z, r0.x, c0.w
rcp_pp r0.x, r0.x
add r0.x, r0.x, -v3.w
mul_sat_pp oC0.w, r0.x, c4.x
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mad_pp r0.xyz, r0, c9.zwzw, v0
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
mov r1.zw, c9.w
add_pp r1, r1, v4
texldp_pp r3, r1, s2
texldp_pp r1, r1, s1
mad r0.x, c0.z, r3.x, c0.w
rcp r0.x, r0.x
add r0.x, r0.x, -v3.z
texldp_pp r3, v4, s1
cmp_pp r0.xyz, r0.x, r1, r3
lrp_pp r1.xyz, c2.w, c2, r0
lrp_pp r0.xyz, r2.x, c3, r1
mad_pp oC0.xyz, r0.w, c1, r0

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 384
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
eefiecedfledlbpebjbnghhnenaccgndebapgccgabaaaaaafeajaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeaiaaaa
eaaaaaaaanacaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaa
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
hcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaaafaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaal
icaabaaaabaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaabaaaaaadbaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaackbabaaaaeaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaafaaaaaa
pgbpbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadhaaaaajhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaia
ebaaaaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaa
pgipcaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaa
dcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaa
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkbabaiaebaaaaaaaeaaaaaadicaaaaiiccabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaalaaaaaadoaaaaab"
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
SetTexture 1 [_RefractionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"ps_3_0
def c11, 2, -1, 0.5, 0
def c12, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
texldp_pp r0, v3, s2
mad r0.x, c0.z, r0.x, c0.w
rcp_pp r0.x, r0.x
add r0.x, r0.x, -v3.w
mul_sat_pp oC0.w, r0.x, c6.x
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c11.x, c11.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c11.x, c11.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c9.x
mad_pp r0.xyz, r0, c11.zwzw, v0
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
mul_pp r1.xy, r1, c12.x
max r2.w, r0.w, c11.w
pow r0.w, r2.w, c7.x
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c11.y
cmp_pp r0.x, r0.x, r0.y, -c11.y
max_pp r2.x, r0.x, c11.w
pow_pp r0.x, r2.x, c9.z
mov r0.y, c11.y
lrp_sat_pp r2.x, r0.x, -r0.y, c9.w
mov r1.zw, c11.w
add_pp r1, r1, v4
texldp_pp r3, r1, s2
texldp_pp r1, r1, s1
mad r0.x, c0.z, r3.x, c0.w
rcp r0.x, r0.x
add r0.x, r0.x, -v3.z
texldp_pp r3, v4, s1
cmp_pp r0.xyz, r0.x, r1, r3
lrp_pp r1.xyz, c4.w, c4, r0
lrp_pp r0.xyz, r2.x, c5, r1
mad_pp r0.xyz, r0.w, c3, r0
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
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 384
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
eefiecedljfikjfhpibonjbjnagcinbbpflehbhpabaaaaaaciakaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpaaiaaaaeaaaaaaadmacaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fjaaaaaeegiocaaaacaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
icbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
aoaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaaaaaaaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
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
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaadiaaaaaidcaabaaaabaaaaaa
igaabaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaaf
ecaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegbdbaaaafaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
kgakbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaalicaabaaaabaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaacaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
icaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaa
abaaaaaadbaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaackbabaaaaeaaaaaa
aoaaaaahdcaabaaaacaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dhaaaaajhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaa
aaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaaaaaaaaaaajaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaia
ebaaaaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaajhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
adaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkbabaaaacaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaiaebaaaaaa
aeaaaaaadicaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
alaaaaaadoaaaaab"
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
SetTexture 2 [_RefractionTex] 2D 2
"ps_3_0
def c7, 2, -1, 0.5, 0
def c8, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c7.x, c7.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c7.x, c7.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c5.x
mad_pp r0.xyz, r0, c7.zwzw, v0
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
mov_pp r1.zw, c7.w
add_pp r3, r1.xyww, v3
add_pp r1, r1, v4
texldp_pp r1, r1, s2
lrp_pp r0.xyz, c1.w, c1, r1
texldp_pp r1, r3, s1
lrp_pp r2.yzw, c2.w, c2.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r2.yzww, r0
mad_pp oC0.xyz, r0.w, c0, r1
mov_pp oC0.w, -c7.y

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 2
SetTexture 2 [_ReflectionTex] 2D 1
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedneihhhffijillkdjdokfhjakeaipmhnkabaaaaaadaaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbaahaaaa
eaaaaaaameabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagcbaaaad
lcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaaj
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
abaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaa
egbdbaaaaeaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaa
afaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaaaoaaaaahdcaabaaaacaaaaaaegaabaaaacaaaaaakgakbaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
abaaaaaaaaaaaaajhcaabaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaacaaaaaapgipcaaaaaaaaaaaakaaaaaa
egacbaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaajhcaabaaaaeaaaaaaegacbaia
ebaaaaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaa
pgipcaaaaaaaaaaaajaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaaj
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
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
SetTexture 2 [_RefractionTex] 2D 2
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.x
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mad_pp r0.xyz, r0, c9.zwzw, v0
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
mov_pp r1.zw, c9.w
add_pp r3, r1.xyww, v3
add_pp r1, r1, v4
texldp_pp r1, r1, s2
lrp_pp r0.xyz, c3.w, c3, r1
texldp_pp r1, r3, s1
lrp_pp r2.yzw, c4.w, c4.xxyz, r1.xxyz
lrp_pp r1.xyz, r2.x, r2.yzww, r0
mad_pp r0.xyz, r0.w, c2, r1
add r0.xyz, r0, -c0
mul r0.w, c1.y, v5.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c0
mov_pp oC0.w, -c9.y

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 2
SetTexture 2 [_ReflectionTex] 2D 1
ConstBuffer "$Globals" 384
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
eefiecedldfcfkmipppphgcppeoifedfkhgpnjfoabaaaaaaaeajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmmahaaaaeaaaaaaapdabaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagcbaaaadlcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
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
aaaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegbdbaaaaeaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaaafaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaaoaaaaahdcaabaaa
acaaaaaaegaabaaaacaaaaaakgakbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaaaaaaaajhcaabaaa
aeaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaacaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaaaeaaaaaaegacbaaa
acaaaaaaaaaaaaajhcaabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaa
aaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaaaaaaaaaaajaaaaaa
egacbaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaia
ebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaabaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkbabaaa
acaaaaaabkiacaaaabaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
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
SetTexture 1 [_RefractionTex] 2D 1
"ps_3_0
def c7, 2, -1, 0.5, 0
def c8, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord4 v3
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c7.x, c7.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c7.x, c7.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c5.x
mad_pp r0.xyz, r0, c7.zwzw, v0
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
mov_pp r1.zw, c7.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c1.w, c1, r1
lrp_pp r1.xyz, r2.x, c2, r0
mad_pp oC0.xyz, r0.w, c0, r1
mov_pp oC0.w, -c7.y

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmoaekiobdeplcfehfodnhmepokcenpiaabaaaaaageahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceeagaaaa
eaaaaaaajbabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaphcaabaaa
aaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaa
egbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
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
aaaaaaaaaoaaaaaadiaaaaaidcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaa
aaaaaaaaaoaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaa
aaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaa
aaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaaafaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaa
ajaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaaaaaaaaaaajaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaa
abaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakhccabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
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
SetTexture 1 [_RefractionTex] 2D 1
"ps_3_0
def c9, 2, -1, 0.5, 0
def c10, 10, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord4 v3
dcl_texcoord5 v4.x
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c9.x, c9.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c9.x, c9.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c7.x
mad_pp r0.xyz, r0, c9.zwzw, v0
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
mov_pp r1.zw, c9.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp_pp r0.xyz, c3.w, c3, r1
lrp_pp r1.xyz, r2.x, c4, r0
mad_pp r0.xyz, r0.w, c2, r1
add r0.xyz, r0, -c0
mul r0.w, c1.y, v4.x
exp_sat r0.w, -r0.w
mad_pp oC0.xyz, r0.w, r0, c0
mov_pp oC0.w, -c9.y

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_RefractionTex] 2D 1
ConstBuffer "$Globals" 384
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
eefiecedmpipkdjjpacfdchcjnegbjbojcpbobbaabaaaaaadiaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaahaaaaeaaaaaaamaabaaaa
fjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
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
egaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaadcaaaaakhcaabaaa
abaaaaaapgipcaaaaaaaaaaaajaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaa
akaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
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
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
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
  GpuProgramID 103931
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
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
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
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (tmpvar_8, 0.0, 1.0))) + (max (0.0, 
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.w, c3, r0
mul r2.xz, r1.xyww, c21.y
dp4 r1.y, c1, r0
dp4 r1.z, c2, r0
mul r0.x, r1.y, c9.x
mov o0, r1
mov o4.zw, r1
mul r2.w, r0.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedcmhiihidpfafeacojfljdgpilblipifpabaaaaaabiajaaaaadaaaaaa
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
aaklklklfdeieefcemahaaaaeaaaabaandabaaaafjaaaaaeegiocaaaaaaaaaaa
biaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaajpcaabaaa
aaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaaibcaabaaaacaaaaaa
egiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiccaabaaaacaaaaaa
ogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiecaabaaaacaaaaaa
egiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaaiicaabaaaacaaaaaa
ogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaaenaaaaah
pcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaajpcaabaaa
aeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaadiaaaaai
pcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaaagaibaaa
aeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaahecaabaaa
acaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaaacaaaaaa
egaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
acaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaaigaabaaaabaaaaaa
igaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaadaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaacaaaaaaaaaaaaaa
agaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaaegiocaaa
acaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
adaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaadaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaaibcaabaaaaeaaaaaa
egiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiccaabaaaaeaaaaaa
ogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiecaabaaaaeaaaaaa
egiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaaiicaabaaaaeaaaaaa
ogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaaaaaaaaaenaaaaag
aanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaaipcaabaaa
aeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaaipcaabaaa
acaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaafdcaabaaa
afaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaaacaaaaaa
dgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahicaabaaaabaaaaaa
egaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaai
fcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaagaaaaaadgaaaaaf
ccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaaacaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalpcaabaaaaaaaaaaa
agiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaaigaibaaaabaaaaaa
diaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaabaaaaaaa
diaaaaaibcaabaaaaaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaaaaaaaaaagadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaadgaaaaafmccabaaaaeaaaaaakgaobaaaadaaaaaaaaaaaaahdccabaaa
aeaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadoaaaaab"
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
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
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
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (tmpvar_8, 0.0, 1.0))) + (max (0.0, 
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.w, c3, r0
mul r2.xz, r1.xyww, c21.y
dp4 r1.y, c1, r0
dp4 r1.z, c2, r0
mul r0.x, r1.y, c9.x
mov o0, r1
mov o4.zw, r1
mov o5.x, r1.z
mul r2.w, r0.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedpdmbgibnokoaikaefpcngllhfmaibhhhabaaaaaafaajaaaaadaaaaaa
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
gmahaaaaeaaaabaanlabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaaj
pcaabaaaaaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaaibcaabaaa
acaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiccaabaaa
acaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiecaabaaa
acaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaaiicaabaaa
acaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaa
enaaaaahpcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
acaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaacaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaaigaabaaa
abaaaaaaigaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaadaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
adaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaaibcaabaaa
aeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiccaabaaa
aeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiecaabaaa
aeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaaiicaabaaa
aeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaaaaaaaaa
enaaaaagaanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaa
acaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahicaabaaa
abaaaaaaegaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
diaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaagaaaaaa
dgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaaacaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalpcaabaaa
aaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaaigaibaaa
abaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
baaaaaaadgaaaaaficcabaaaacaaaaaackaabaaaadaaaaaadiaaaaaibcaabaaa
aaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaaaaaaaaa
agadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaadgaaaaaf
mccabaaaaeaaaaaakgaobaaaadaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaa
aaaaaaaamgaabaaaaaaaaaaadoaaaaab"
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
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_23;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _BumpMap;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (_ReflectionColor + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = (clamp ((_InvFadeParemeter * 
    ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w))) - xlv_TEXCOORD3.z)
  ), 0.0, 1.0).x * clamp ((0.5 + 
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_6)
      , worldNormal_2), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  ), 0.0, 1.0));
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.w, c3, r0
mul r2.xz, r1.xyww, c21.y
dp4 r1.y, c1, r0
dp4 r1.z, c2, r0
mul r0.x, r1.y, c9.x
mov o0, r1
mov o4.zw, r1
mul r2.w, r0.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedcmhiihidpfafeacojfljdgpilblipifpabaaaaaabiajaaaaadaaaaaa
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
aaklklklfdeieefcemahaaaaeaaaabaandabaaaafjaaaaaeegiocaaaaaaaaaaa
biaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaajpcaabaaa
aaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaaibcaabaaaacaaaaaa
egiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiccaabaaaacaaaaaa
ogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiecaabaaaacaaaaaa
egiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaaiicaabaaaacaaaaaa
ogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaaenaaaaah
pcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaajpcaabaaa
aeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaadiaaaaai
pcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaaagaibaaa
aeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaahecaabaaa
acaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaaacaaaaaa
egaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
acaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaaigaabaaaabaaaaaa
igaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaadaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaacaaaaaaaaaaaaaa
agaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaaegiocaaa
acaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
adaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaadaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaaibcaabaaaaeaaaaaa
egiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiccaabaaaaeaaaaaa
ogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiecaabaaaaeaaaaaa
egiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaaiicaabaaaaeaaaaaa
ogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaaaaaaaaaenaaaaag
aanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaaipcaabaaa
aeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaaipcaabaaa
acaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaafdcaabaaa
afaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaaacaaaaaa
dgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahicaabaaaabaaaaaa
egaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaai
fcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaagaaaaaadgaaaaaf
ccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaaacaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalpcaabaaaaaaaaaaa
agiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaaigaibaaaabaaaaaa
diaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaabaaaaaaa
diaaaaaibcaabaaaaaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaaaaaaaaaagadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaadgaaaaafmccabaaaaeaaaaaakgaobaaaadaaaaaaaaaaaaahdccabaaa
aeaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadoaaaaab"
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
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (_ReflectionColor + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = (clamp ((_InvFadeParemeter * 
    ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w))) - xlv_TEXCOORD3.z)
  ), 0.0, 1.0).x * clamp ((0.5 + 
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_6)
      , worldNormal_2), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  ), 0.0, 1.0));
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.w, c3, r0
mul r2.xz, r1.xyww, c21.y
dp4 r1.y, c1, r0
dp4 r1.z, c2, r0
mul r0.x, r1.y, c9.x
mov o0, r1
mov o4.zw, r1
mov o5.x, r1.z
mul r2.w, r0.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedpdmbgibnokoaikaefpcngllhfmaibhhhabaaaaaafaajaaaaadaaaaaa
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
gmahaaaaeaaaabaanlabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaaj
pcaabaaaaaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaaibcaabaaa
acaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiccaabaaa
acaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiecaabaaa
acaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaaiicaabaaa
acaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaa
enaaaaahpcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
acaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaacaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaaigaabaaa
abaaaaaaigaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaadaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
adaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaaibcaabaaa
aeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiccaabaaa
aeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiecaabaaa
aeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaaiicaabaaa
aeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaaaaaaaaa
enaaaaagaanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaa
acaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahicaabaaa
abaaaaaaegaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
diaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaagaaaaaa
dgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaaacaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalpcaabaaa
aaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaaigaibaaa
abaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
baaaaaaadgaaaaaficcabaaaacaaaaaackaabaaaadaaaaaadiaaaaaibcaabaaa
aaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaaaaaaaaa
agadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaadgaaaaaf
mccabaaaaeaaaaaakgaobaaaadaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaa
aaaaaaaamgaabaaaaaaaaaaadoaaaaab"
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
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
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
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (tmpvar_8, 0.0, 1.0))) + (max (0.0, 
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.w, c3, r0
mul r2.xz, r1.xyww, c21.y
dp4 r1.y, c1, r0
dp4 r1.z, c2, r0
mul r0.x, r1.y, c9.x
mov o0, r1
mov o4.zw, r1
mul r2.w, r0.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedcmhiihidpfafeacojfljdgpilblipifpabaaaaaabiajaaaaadaaaaaa
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
aaklklklfdeieefcemahaaaaeaaaabaandabaaaafjaaaaaeegiocaaaaaaaaaaa
biaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaajpcaabaaa
aaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaaibcaabaaaacaaaaaa
egiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiccaabaaaacaaaaaa
ogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiecaabaaaacaaaaaa
egiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaaiicaabaaaacaaaaaa
ogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaaenaaaaah
pcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaajpcaabaaa
aeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaadiaaaaai
pcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaaagaibaaa
aeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaahecaabaaa
acaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaaacaaaaaa
egaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
acaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaaigaabaaaabaaaaaa
igaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaadaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaacaaaaaaaaaaaaaa
agaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaaegiocaaa
acaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
adaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaadaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaaibcaabaaaaeaaaaaa
egiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiccaabaaaaeaaaaaa
ogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiecaabaaaaeaaaaaa
egiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaaiicaabaaaaeaaaaaa
ogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaaaaaaaaaenaaaaag
aanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaaipcaabaaa
aeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaaipcaabaaa
acaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaafdcaabaaa
afaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaaacaaaaaa
dgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahicaabaaaabaaaaaa
egaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaai
fcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaagaaaaaadgaaaaaf
ccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaaacaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalpcaabaaaaaaaaaaa
agiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaaigaibaaaabaaaaaa
diaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaabaaaaaaa
diaaaaaibcaabaaaaaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaaaaaaaaaagadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaadgaaaaafmccabaaaaeaaaaaakgaobaaaadaaaaaaaaaaaaahdccabaaa
aeaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadoaaaaab"
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
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
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
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (tmpvar_8, 0.0, 1.0))) + (max (0.0, 
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.w, c3, r0
mul r2.xz, r1.xyww, c21.y
dp4 r1.y, c1, r0
dp4 r1.z, c2, r0
mul r0.x, r1.y, c9.x
mov o0, r1
mov o4.zw, r1
mov o5.x, r1.z
mul r2.w, r0.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedpdmbgibnokoaikaefpcngllhfmaibhhhabaaaaaafaajaaaaadaaaaaa
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
gmahaaaaeaaaabaanlabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaaj
pcaabaaaaaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaaibcaabaaa
acaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiccaabaaa
acaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiecaabaaa
acaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaaiicaabaaa
acaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaa
enaaaaahpcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
acaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaacaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaaigaabaaa
abaaaaaaigaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaadaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
adaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaaibcaabaaa
aeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiccaabaaa
aeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiecaabaaa
aeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaaiicaabaaa
aeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaaaaaaaaa
enaaaaagaanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaa
acaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahicaabaaa
abaaaaaaegaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
diaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaagaaaaaa
dgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaaacaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalpcaabaaa
aaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaaigaibaaa
abaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
baaaaaaadgaaaaaficcabaaaacaaaaaackaabaaaadaaaaaadiaaaaaibcaabaaa
aaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaaaaaaaaa
agadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaadgaaaaaf
mccabaaaaeaaaaaakgaobaaaadaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaa
aaaaaaaamgaabaaaaaaaaaaadoaaaaab"
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
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_23;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform vec4 _SpecularColor;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (_ReflectionColor + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((0.5 + clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_6), worldNormal_2), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0)), 0.0, 1.0);
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.w, c3, r0
mul r2.xz, r1.xyww, c21.y
dp4 r1.y, c1, r0
dp4 r1.z, c2, r0
mul r0.x, r1.y, c9.x
mov o0, r1
mov o4.zw, r1
mul r2.w, r0.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedcmhiihidpfafeacojfljdgpilblipifpabaaaaaabiajaaaaadaaaaaa
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
aaklklklfdeieefcemahaaaaeaaaabaandabaaaafjaaaaaeegiocaaaaaaaaaaa
biaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaajpcaabaaa
aaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaaibcaabaaaacaaaaaa
egiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiccaabaaaacaaaaaa
ogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiecaabaaaacaaaaaa
egiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaaiicaabaaaacaaaaaa
ogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaakpcaabaaaacaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaaenaaaaah
pcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaajpcaabaaa
aeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaadiaaaaai
pcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaaagaibaaa
aeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaahecaabaaa
acaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaaacaaaaaa
egaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
acaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaaigaabaaaabaaaaaa
igaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaadaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaacaaaaaaaaaaaaaa
agaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaaegiocaaa
acaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
adaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaadaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaaibcaabaaaaeaaaaaa
egiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiccaabaaaaeaaaaaa
ogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiecaabaaaaeaaaaaa
egiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaaiicaabaaaaeaaaaaa
ogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaaaaaaaaaenaaaaag
aanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajpcaabaaaacaaaaaa
egiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaaipcaabaaa
aeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaaipcaabaaa
acaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaafdcaabaaa
afaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaaacaaaaaa
dgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahicaabaaaabaaaaaa
egaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaadiaaaaai
fcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaagaaaaaadgaaaaaf
ccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaaacaaaaaaegacbaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalpcaabaaaaaaaaaaa
agiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaaigaibaaaabaaaaaa
diaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaabaaaaaaa
diaaaaaibcaabaaaaaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaak
fcaabaaaaaaaaaaaagadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaaaadgaaaaafmccabaaaaeaaaaaakgaobaaaadaaaaaaaaaaaaahdccabaaa
aeaaaaaakgakbaaaaaaaaaaamgaabaaaaaaaaaaadoaaaaab"
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
  xlv_TEXCOORD2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_23;
  xlv_TEXCOORD4 = tmpvar_22.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform vec4 _SpecularColor;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (_ReflectionColor + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((0.5 + clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_6), worldNormal_2), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0)), 0.0, 1.0);
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
mad r0, r0.x, c13, r2.xzxz
mul o3, r0, c12
dp4 r2.y, c5, v0
add o2.xyz, r2, -c8
mad r0, r3, c20.x, c20.y
mad r0, r3, r0, c20.z
mad r0, r3, r0, c20.w
mad r0, r3, r0, -c21.y
mad r0, r3, r0, c22.x
dp4 r6.y, r0, c14
add r0.xyz, r6, v0
mov r0.w, v0.w
dp4 r1.x, c0, r0
dp4 r1.w, c3, r0
mul r2.xz, r1.xyww, c21.y
dp4 r1.y, c1, r0
dp4 r1.z, c2, r0
mul r0.x, r1.y, c9.x
mov o0, r1
mov o4.zw, r1
mov o5.x, r1.z
mul r2.w, r0.x, c21.y
mad o4.xy, r2.z, c10.zwzw, r2.xwzw
mov o1.w, c22.x

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedpdmbgibnokoaikaefpcngllhfmaibhhhabaaaaaafaajaaaaadaaaaaa
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
gmahaaaaeaaaabaanlabaaaafjaaaaaeegiocaaaaaaaaaaabiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadiccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaaj
pcaabaaaaaaaaaaaegiocaaaaaaaaaaabfaaaaaafgifcaaaabaaaaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaabaaaaaaapaaaaaibcaabaaa
acaaaaaaegiacaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiccaabaaa
acaaaaaaogikcaaaaaaaaaaabgaaaaaaigaabaaaabaaaaaaapaaaaaiecaabaaa
acaaaaaaegiacaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaaapaaaaaiicaabaaa
acaaaaaaogikcaaaaaaaaaaabhaaaaaaigaabaaaabaaaaaadcaaaaakpcaabaaa
acaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaa
enaaaaahpcaabaaaacaaaaaapcaabaaaadaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabcaaaaaadiaaaaaj
pcaabaaaaeaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabeaaaaaa
diaaaaaipcaabaaaafaaaaaaegaebaaaaeaaaaaangiicaaaaaaaaaaabgaaaaaa
diaaaaaipcaabaaaaeaaaaaakgapbaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaa
dgaaaaafdcaabaaaagaaaaaaogakbaaaafaaaaaadgaaaaafmcaabaaaagaaaaaa
agaibaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaafganbaaaaeaaaaaabbaaaaah
ecaabaaaacaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaabbaaaaahbcaabaaa
acaaaaaaegaobaaaadaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaacaaaaaaegbcbaaaaaaaaaaaaaaaaaahdcaabaaaacaaaaaaigaabaaa
abaaaaaaigaabaaaacaaaaaadiaaaaaipcaabaaaaeaaaaaafgafbaaaadaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaeaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaadaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaadaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaadaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
adaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaadaaaaaaapaaaaaibcaabaaa
aeaaaaaaegiacaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiccaabaaa
aeaaaaaaogikcaaaaaaaaaaabgaaaaaaegaabaaaacaaaaaaapaaaaaiecaabaaa
aeaaaaaaegiacaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaaapaaaaaiicaabaaa
aeaaaaaaogikcaaaaaaaaaaabhaaaaaaegaabaaaacaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaeaaaaaaegaobaaaaaaaaaaa
enaaaaagaanaaaaapcaabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaajpcaabaaa
acaaaaaaegiocaaaaaaaaaaabcaaaaaaegiocaaaaaaaaaaabdaaaaaadiaaaaai
pcaabaaaaeaaaaaaegaebaaaacaaaaaangiicaaaaaaaaaaabgaaaaaadiaaaaai
pcaabaaaacaaaaaakgapbaaaacaaaaaaegiocaaaaaaaaaaabhaaaaaadgaaaaaf
dcaabaaaafaaaaaaogakbaaaaeaaaaaadgaaaaafmcaabaaaafaaaaaaagaibaaa
acaaaaaadgaaaaafmcaabaaaaeaaaaaafganbaaaacaaaaaabbaaaaahicaabaaa
abaaaaaaegaobaaaaaaaaaaaegaobaaaaeaaaaaabbaaaaahbcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaafaaaaaadgaaaaagbcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
diaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaagaaaaaa
dgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaeabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaajhccabaaaacaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalpcaabaaa
aaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaaigaibaaa
abaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
baaaaaaadgaaaaaficcabaaaacaaaaaackaabaaaadaaaaaadiaaaaaibcaabaaa
aaaaaaaabkaabaaaadaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdiaaaaakfcaabaaaaaaaaaaa
agadbaaaadaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaaaadgaaaaaf
mccabaaaaeaaaaaakgaobaaaadaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaa
aaaaaaaamgaabaaaaaaaaaaadoaaaaab"
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
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
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
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_4;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
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
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (tmpvar_8, 0.0, 1.0))) + (max (0.0, 
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
ConstBuffer "$Globals" 384
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
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
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
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_4;
  xlv_TEXCOORD4 = tmpvar_3.z;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
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
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (tmpvar_8, 0.0, 1.0))) + (max (0.0, 
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
ConstBuffer "$Globals" 384
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
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
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
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_4;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform sampler2D _BumpMap;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (_ReflectionColor + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = (clamp ((_InvFadeParemeter * 
    ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w))) - xlv_TEXCOORD3.z)
  ), 0.0, 1.0).x * clamp ((0.5 + 
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_6)
      , worldNormal_2), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  ), 0.0, 1.0));
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
ConstBuffer "$Globals" 384
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
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
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
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_4;
  xlv_TEXCOORD4 = tmpvar_3.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 _ZBufferParams;
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform sampler2D _CameraDepthTexture;
uniform vec4 _SpecularColor;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (_ReflectionColor + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = (clamp ((_InvFadeParemeter * 
    ((1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD3).x) + _ZBufferParams.w))) - xlv_TEXCOORD3.z)
  ), 0.0, 1.0).x * clamp ((0.5 + 
    clamp ((_DistortParams.w + ((1.0 - _DistortParams.w) * pow (
      clamp ((1.0 - max (dot (
        -(tmpvar_6)
      , worldNormal_2), 0.0)), 0.0, 1.0)
    , _DistortParams.z))), 0.0, 1.0)
  ), 0.0, 1.0));
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
ConstBuffer "$Globals" 384
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
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
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
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_4;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
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
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (tmpvar_8, 0.0, 1.0))) + (max (0.0, 
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
ConstBuffer "$Globals" 384
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
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
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
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_4;
  xlv_TEXCOORD4 = tmpvar_3.z;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
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
  ), _ReflectionColor, _ReflectionColor.wwww), vec4(clamp (tmpvar_8, 0.0, 1.0))) + (max (0.0, 
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
ConstBuffer "$Globals" 384
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
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
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
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BumpMap;
uniform vec4 _SpecularColor;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (_ReflectionColor + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((0.5 + clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_6), worldNormal_2), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0)), 0.0, 1.0);
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
ConstBuffer "$Globals" 384
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
  vec3 tmpvar_2;
  tmpvar_2 = (_Object2World * gl_Vertex).xyz;
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
  tmpvar_1.xyz = vec3(0.0, 1.0, 0.0);
  tmpvar_1.w = 1.0;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_2 - _WorldSpaceCameraPos);
  xlv_TEXCOORD2 = ((tmpvar_2.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD3 = o_4;
  xlv_TEXCOORD4 = tmpvar_3.z;
}


#endif
#ifdef FRAGMENT
uniform vec4 unity_FogColor;
uniform vec4 unity_FogParams;
uniform sampler2D _BumpMap;
uniform vec4 _SpecularColor;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0.xyz + (
    (((normal_3 + normal_4) * 0.5).xxy * _DistortParams.x)
   * vec3(1.0, 0.0, 1.0))));
  worldNormal_2.y = tmpvar_5.y;
  vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD1);
  worldNormal_2.xz = (tmpvar_5.xz * _FresnelScale);
  baseColor_1.xyz = (_ReflectionColor + (max (0.0, 
    pow (max (0.0, dot (tmpvar_5, -(
      normalize((_WorldLightDir.xyz + tmpvar_6))
    ))), _Shininess)
  ) * _SpecularColor)).xyz;
  baseColor_1.w = clamp ((0.5 + clamp (
    (_DistortParams.w + ((1.0 - _DistortParams.w) * pow (clamp (
      (1.0 - max (dot (-(tmpvar_6), worldNormal_2), 0.0))
    , 0.0, 1.0), _DistortParams.z)))
  , 0.0, 1.0)), 0.0, 1.0);
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
ConstBuffer "$Globals" 384
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
dcl_texcoord_pp v0.xyz
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
mad_pp r0.xyz, r0, c9.zwzw, v0
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
mov r1.zw, c9.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r0.xyz, c3.w, c3, r1
lrp_pp r1.xyz, r2.x, r0, c2
add_sat_pp r0.x, r2.x, c9.z
mad_pp oC0.xyz, r0.w, c1, r1
texldp_pp r1, v3, s2
mad r0.y, c0.z, r1.x, c0.w
rcp_pp r0.y, r0.y
add r0.y, r0.y, -v3.z
mul_sat_pp r0.y, r0.y, c4.x
mul_pp oC0.w, r0.x, r0.y

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 384
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
eefiecedilmhkknnclgaeboidkkfhneliddeohlpabaaaaaajaaiaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefciiahaaaaeaaaaaaaocabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaa
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
egacbaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaa
aaaaaaaaaoaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaa
aaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaa
aaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaaaeaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaa
akaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaiaebaaaaaaaaaaaaaaajaaaaaadiaaaaaifcaabaaaacaaaaaaagacbaaa
aaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaacaaaaaabkaabaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaaaeaaaaaaegbcbaaa
acaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaa
aaaaaaaaegacbaiaebaaaaaaadaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaa
abaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaak
icaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
aoaaaaaadcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaadpddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpbaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaa
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaiaebaaaaaaaeaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaaaaaaaaadoaaaaab"
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
dcl_texcoord_pp v0.xyz
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
mad_pp r0.yzw, r0, c11.xzwz, v0.xxyz
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
mul_pp oC0.w, r0.z, r0.x
mov r1.zw, c11.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r0.xzw, c5.w, c5.xyyz, r1.xyyz
lrp_pp r1.xyz, r3.x, r0.xzww, c4
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
ConstBuffer "$Globals" 384
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
eefiecedapkohoconffbjjobcjmnljdjnmgjalkoabaaaaaageajaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceeaiaaaa
eaaaaaaabbacaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadicbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaaj
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
dcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaa
aaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegbdbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
abaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaa
ajaaaaaadiaaaaaifcaabaaaacaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaa
apaaaaaadgaaaaafccaabaaaacaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaa
acaaaaaadcaaaaakhcaabaaaaeaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaa
egiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaa
adaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaadkaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaadcaaaaakhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpbaaaaaahicaabaaa
abaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaa
aeaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
dkbabaaaacaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaagbcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaddaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackbabaiaebaaaaaa
aeaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
alaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Vector 6 [_DistortParams]
Float 7 [_FresnelScale]
Vector 3 [_InvFadeParemeter]
Vector 2 [_ReflectionColor]
Float 4 [_Shininess]
Vector 1 [_SpecularColor]
Vector 5 [_WorldLightDir]
Vector 0 [_ZBufferParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_3_0
def c8, 2, -1, 0.5, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c8.x, c8.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c8.x, c8.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c6.x
mad_pp r0.xyz, r0, c8.zwzw, v0
nrm_pp r1.xyz, r0
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mad r0.yzw, v1.xxyz, r0.x, c5.xxyz
mul_pp r2.xyz, r0.x, v1
nrm_pp r3.xyz, r0.yzww
dp3_pp r0.x, r1, -r3
max r1.w, r0.x, c8.w
pow r0.x, r1.w, c4.x
mov r3.xyz, c1
mad_pp oC0.xyz, r0.x, r3, c2
mul_pp r1.xz, r1, c7.x
dp3_pp r0.x, -r2, r1
add_pp r0.y, -r0.x, -c8.y
cmp_pp r0.x, r0.x, r0.y, -c8.y
max_pp r1.x, r0.x, c8.w
pow_pp r0.x, r1.x, c6.z
mov r0.y, c8.y
lrp_sat_pp r1.x, r0.x, -r0.y, c6.w
add_sat_pp r0.x, r1.x, c8.z
texldp_pp r1, v3, s1
mad r0.y, c0.z, r1.x, c0.w
rcp_pp r0.y, r0.y
add r0.y, r0.y, -v3.z
mul_sat_pp r0.y, r0.y, c3.x
mul_pp oC0.w, r0.x, r0.y

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
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
eefiecedgpiegcbifmkocjilcmeloffljjgmbmfcabaaaaaaciahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefccaagaaaaeaaaaaaaiiabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
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
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaahdcaabaaa
abaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaa
abaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaa
ahaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
ckbabaiaebaaaaaaaeaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
akiacaaaaaaaaaaaalaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
amaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalhccabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegiccaaaaaaaaaaa
akaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
Vector 8 [_DistortParams]
Float 9 [_FresnelScale]
Vector 5 [_InvFadeParemeter]
Vector 4 [_ReflectionColor]
Float 6 [_Shininess]
Vector 3 [_SpecularColor]
Vector 7 [_WorldLightDir]
Vector 0 [_ZBufferParams]
Vector 1 [unity_FogColor]
Vector 2 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_3_0
def c10, 2, -1, 0.5, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4.x
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c10.x, c10.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c10.x, c10.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c8.x
mad_pp r0.xyz, r0, c10.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c9.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c7
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
max r1.x, r0.w, c10.w
pow r0.w, r1.x, c6.x
mov r1.xyz, c3
mad_pp r1.xyz, r0.w, r1, c4
add r1.xyz, r1, -c1
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c10.y
cmp_pp r0.x, r0.x, r0.y, -c10.y
max_pp r1.w, r0.x, c10.w
pow_pp r0.x, r1.w, c8.z
mov r0.y, c10.y
lrp_sat_pp r1.w, r0.x, -r0.y, c8.w
add_sat_pp r0.x, r1.w, c10.z
texldp_pp r2, v3, s1
mad r0.y, c0.z, r2.x, c0.w
rcp_pp r0.y, r0.y
add r0.y, r0.y, -v3.z
mul_sat_pp r0.y, r0.y, c5.x
mul_pp oC0.w, r0.x, r0.y
mul r0.x, c2.y, v4.x
exp_sat r0.x, -r0.x
mad_pp oC0.xyz, r0.x, r1, c1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
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
eefiecedmknedpinfgnkifpfjielnjjpnhjdkhmlabaaaaaapmahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmagaaaa
eaaaaaaalhabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
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
aoaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaaaaaaaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
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
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaoaaaaahdcaabaaaabaaaaaaegbabaaaaeaaaaaa
pgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaaeaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaalaaaaaa
diaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaaiaaaaaaegiccaaaaaaaaaaaakaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkbabaaaacaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaag
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadoaaaaab"
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
dcl_texcoord_pp v0.xyz
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
mad_pp r0.xyz, r0, c7.zwzw, v0
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
mov r1.zw, c7.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r0.xyz, c2.w, c2, r1
lrp_pp r1.xyz, r2.x, r0, c1
add_sat_pp oC0.w, r2.x, c7.z
mad_pp oC0.xyz, r0.w, c0, r1

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedghpnknipdejnjhgbiamikfjjmffcanemabaaaaaaheahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgmagaaaaeaaaaaaajlabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
lcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaaj
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
dcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaa
aaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegbdbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
abaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaa
ajaaaaaadiaaaaaifcaabaaaacaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaa
apaaaaaadgaaaaafccaabaaaacaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaa
acaaaaaadcaaaaakhcaabaaaaeaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaa
egiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaa
adaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaadkaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaadcaaaaakhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaah
iccabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpbaaaaaahicaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aeaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aaaaaaaaaiaaaaaaegacbaaaabaaaaaadoaaaaab"
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
dcl_texcoord_pp v0.xyz
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
mad_pp r0.xyz, r0, c9.zwzw, v0
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
mov r1.zw, c9.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r0.xyz, c4.w, c4, r1
lrp_pp r1.xyz, r2.x, r0, c3
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
ConstBuffer "$Globals" 384
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
eefiecedphmofdghlgpojlkhcljikkgolncmdnmlabaaaaaaeiaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcciahaaaa
eaaaaaaamkabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
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
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaaigaabaaa
aaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaa
abaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaa
abaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egbdbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaaaaaaaaaa
akaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaadiaaaaaifcaabaaa
acaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaa
acaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaa
aeaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
baaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaaegacbaaaacaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaiadpdccaaaakicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaoaaaaaadcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpbaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaa
egacbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaeaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkbabaaaacaaaaaabkiacaaa
abaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
ddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaak
hccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Vector 4 [_DistortParams]
Float 5 [_FresnelScale]
Vector 1 [_ReflectionColor]
Float 2 [_Shininess]
Vector 0 [_SpecularColor]
Vector 3 [_WorldLightDir]
SetTexture 0 [_BumpMap] 2D 0
"ps_3_0
def c6, 2, -1, 0.5, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_2d s0
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c6.x, c6.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c6.x, c6.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c4.x
mad_pp r0.xyz, r0, c6.zwzw, v0
nrm_pp r1.xyz, r0
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mad r0.yzw, v1.xxyz, r0.x, c3.xxyz
mul_pp r2.xyz, r0.x, v1
nrm_pp r3.xyz, r0.yzww
dp3_pp r0.x, r1, -r3
max r1.w, r0.x, c6.w
pow r0.x, r1.w, c2.x
mov r3.xyz, c0
mad_pp oC0.xyz, r0.x, r3, c1
mul_pp r1.xz, r1, c5.x
dp3_pp r0.x, -r2, r1
add_pp r0.y, -r0.x, -c6.y
cmp_pp r0.x, r0.x, r0.y, -c6.y
max_pp r1.x, r0.x, c6.w
pow_pp r0.x, r1.x, c4.z
mov r0.y, c6.y
lrp_sat_pp r1.x, r0.x, -r0.y, c4.w
add_sat_pp oC0.w, r1.x, c6.z

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedclmoflgfdaokfpjmbgdflbfdjmbodnoaabaaaaaaaaagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpiaeaaaaeaaaaaaadoabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
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
aaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaa
egbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
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
aaaaaaaaaoaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaadpddaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
baaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalhccabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegiccaaaaaaaaaaaakaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
Vector 6 [_DistortParams]
Float 7 [_FresnelScale]
Vector 3 [_ReflectionColor]
Float 4 [_Shininess]
Vector 2 [_SpecularColor]
Vector 5 [_WorldLightDir]
Vector 0 [unity_FogColor]
Vector 1 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
"ps_3_0
def c8, 2, -1, 0.5, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord4 v3.x
dcl_2d s0
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c8.x, c8.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c8.x, c8.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c6.x
mad_pp r0.xyz, r0, c8.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c7.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c5
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
max r1.x, r0.w, c8.w
pow r0.w, r1.x, c4.x
mov r1.xyz, c2
mad_pp r1.xyz, r0.w, r1, c3
add r1.xyz, r1, -c0
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c8.y
cmp_pp r0.x, r0.x, r0.y, -c8.y
max_pp r1.w, r0.x, c8.w
pow_pp r0.x, r1.w, c6.z
mov r0.y, c8.y
lrp_sat_pp r1.w, r0.x, -r0.y, c6.w
add_sat_pp oC0.w, r1.w, c8.z
mul r0.x, c1.y, v3.x
exp_sat r0.x, -r0.x
mad_pp oC0.xyz, r0.x, r1, c0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_ON" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
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
eefiecedengafgmmgbhggglkdjmgkgmlcinhdpgkabaaaaaaneagaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleafaaaa
eaaaaaaagnabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
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
akaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpbaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaalhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaegiccaaaaaaaaaaaakaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkbabaaaacaaaaaabkiacaaaabaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadoaaaaab"
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
dcl_texcoord_pp v0.xyz
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
mad_pp r0.xyz, r0, c9.zwzw, v0
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
mov r1.zw, c9.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r0.xyz, c3.w, c3, r1
lrp_pp r1.xyz, r2.x, r0, c2
add_sat_pp r0.x, r2.x, c9.z
mad_pp oC0.xyz, r0.w, c1, r1
texldp_pp r1, v3, s2
mad r0.y, c0.z, r1.x, c0.w
rcp_pp r0.y, r0.y
add r0.y, r0.y, -v3.z
mul_sat_pp r0.y, r0.y, c4.x
mul_pp oC0.w, r0.x, r0.y

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 384
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
eefiecedilmhkknnclgaeboidkkfhneliddeohlpabaaaaaajaaiaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefciiahaaaaeaaaaaaaocabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaa
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
egacbaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaa
aaaaaaaaaoaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaa
aaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaa
aaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbdbaaaaeaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaa
akaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaiaebaaaaaaaaaaaaaaajaaaaaadiaaaaaifcaabaaaacaaaaaaagacbaaa
aaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaaacaaaaaabkaabaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaaaeaaaaaaegbcbaaa
acaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaa
aaaaaaaaegacbaiaebaaaaaaadaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaa
abaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaak
icaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
aoaaaaaadcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaadpddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpbaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaa
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaal
bcaabaaaaaaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaadkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaackbabaiaebaaaaaaaeaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaalaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaaaaaaaaadoaaaaab"
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
dcl_texcoord_pp v0.xyz
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
mad_pp r0.yzw, r0, c11.xzwz, v0.xxyz
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
mul_pp oC0.w, r0.z, r0.x
mov r1.zw, c11.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r0.xzw, c5.w, c5.xyyz, r1.xyyz
lrp_pp r1.xyz, r3.x, r0.xzww, c4
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
ConstBuffer "$Globals" 384
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
eefiecedapkohoconffbjjobcjmnljdjnmgjalkoabaaaaaageajaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceeaiaaaa
eaaaaaaabbacaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafjaaaaaeegiocaaaacaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadicbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaaj
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
dcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaa
aaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegbdbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
abaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaa
ajaaaaaadiaaaaaifcaabaaaacaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaa
apaaaaaadgaaaaafccaabaaaacaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaa
acaaaaaadcaaaaakhcaabaaaaeaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaa
egiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaa
adaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaadkaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaadcaaaaakhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpbaaaaaahicaabaaa
abaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaa
aeaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaadiaaaaaibcaabaaaabaaaaaa
dkbabaaaacaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaagbcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaddaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaaaacaaaaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackbabaiaebaaaaaa
aeaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
alaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Vector 6 [_DistortParams]
Float 7 [_FresnelScale]
Vector 3 [_InvFadeParemeter]
Vector 2 [_ReflectionColor]
Float 4 [_Shininess]
Vector 1 [_SpecularColor]
Vector 5 [_WorldLightDir]
Vector 0 [_ZBufferParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_3_0
def c8, 2, -1, 0.5, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c8.x, c8.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c8.x, c8.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c6.x
mad_pp r0.xyz, r0, c8.zwzw, v0
nrm_pp r1.xyz, r0
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mad r0.yzw, v1.xxyz, r0.x, c5.xxyz
mul_pp r2.xyz, r0.x, v1
nrm_pp r3.xyz, r0.yzww
dp3_pp r0.x, r1, -r3
max r1.w, r0.x, c8.w
pow r0.x, r1.w, c4.x
mov r3.xyz, c1
mad_pp oC0.xyz, r0.x, r3, c2
mul_pp r1.xz, r1, c7.x
dp3_pp r0.x, -r2, r1
add_pp r0.y, -r0.x, -c8.y
cmp_pp r0.x, r0.x, r0.y, -c8.y
max_pp r1.x, r0.x, c8.w
pow_pp r0.x, r1.x, c6.z
mov r0.y, c8.y
lrp_sat_pp r1.x, r0.x, -r0.y, c6.w
add_sat_pp r0.x, r1.x, c8.z
texldp_pp r1, v3, s1
mad r0.y, c0.z, r1.x, c0.w
rcp_pp r0.y, r0.y
add r0.y, r0.y, -v3.z
mul_sat_pp r0.y, r0.y, c3.x
mul_pp oC0.w, r0.x, r0.y

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
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
eefiecedgpiegcbifmkocjilcmeloffljjgmbmfcabaaaaaaciahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefccaagaaaaeaaaaaaaiiabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
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
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaahdcaabaaa
abaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaa
abaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaa
ahaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
ckbabaiaebaaaaaaaeaaaaaadicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaa
akiacaaaaaaaaaaaalaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
amaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalhccabaaa
aaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegiccaaaaaaaaaaa
akaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
Vector 8 [_DistortParams]
Float 9 [_FresnelScale]
Vector 5 [_InvFadeParemeter]
Vector 4 [_ReflectionColor]
Float 6 [_Shininess]
Vector 3 [_SpecularColor]
Vector 7 [_WorldLightDir]
Vector 0 [_ZBufferParams]
Vector 1 [unity_FogColor]
Vector 2 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
"ps_3_0
def c10, 2, -1, 0.5, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord3 v3
dcl_texcoord4 v4.x
dcl_2d s0
dcl_2d s1
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c10.x, c10.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c10.x, c10.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c8.x
mad_pp r0.xyz, r0, c10.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c9.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c7
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
max r1.x, r0.w, c10.w
pow r0.w, r1.x, c6.x
mov r1.xyz, c3
mad_pp r1.xyz, r0.w, r1, c4
add r1.xyz, r1, -c1
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c10.y
cmp_pp r0.x, r0.x, r0.y, -c10.y
max_pp r1.w, r0.x, c10.w
pow_pp r0.x, r1.w, c8.z
mov r0.y, c10.y
lrp_sat_pp r1.w, r0.x, -r0.y, c8.w
add_sat_pp r0.x, r1.w, c10.z
texldp_pp r2, v3, s1
mad r0.y, c0.z, r2.x, c0.w
rcp_pp r0.y, r0.y
add r0.y, r0.y, -v3.z
mul_sat_pp r0.y, r0.y, c5.x
mul_pp oC0.w, r0.x, r0.y
mul r0.x, c2.y, v4.x
exp_sat r0.x, -r0.x
mad_pp oC0.xyz, r0.x, r1, c1

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_ON" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
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
eefiecedmknedpinfgnkifpfjielnjjpnhjdkhmlabaaaaaapmahaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmagaaaa
eaaaaaaalhabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
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
aoaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaaaaaaaaaiadpaaaaaaaaegbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
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
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaoaaaaahdcaabaaaabaaaaaaegbabaaaaeaaaaaa
pgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaabaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackbabaiaebaaaaaaaeaaaaaa
dicaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaalaaaaaa
diaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaaiaaaaaaegiccaaaaaaaaaaaakaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkbabaaaacaaaaaabkiacaaaacaaaaaaabaaaaaabjaaaaag
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaacaaaaaaaaaaaaaadoaaaaab"
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
dcl_texcoord_pp v0.xyz
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
mad_pp r0.xyz, r0, c7.zwzw, v0
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
mov r1.zw, c7.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r0.xyz, c2.w, c2, r1
lrp_pp r1.xyz, r2.x, r0, c1
add_sat_pp oC0.w, r2.x, c7.z
mad_pp oC0.xyz, r0.w, c0, r1

"
}
SubProgram "d3d11 " {
Keywords { "WATER_REFLECTIVE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_ReflectionTex] 2D 1
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedghpnknipdejnjhgbiamikfjjmffcanemabaaaaaaheahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgmagaaaaeaaaaaaajlabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
lcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaaj
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
dcaabaaaabaaaaaaigaabaaaaaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaa
aaaaaaaadgaaaaafecaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegbdbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaabaaaaaakgakbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaa
egacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaa
abaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaa
ajaaaaaadiaaaaaifcaabaaaacaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaa
apaaaaaadgaaaaafccaabaaaacaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaa
acaaaaaadcaaaaakhcaabaaaaeaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaa
egiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaa
adaaaaaaegacbaaaacaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaadkaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaadcaaaaakhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaah
iccabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpbaaaaaahicaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aeaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaa
acaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aaaaaaaaaiaaaaaaegacbaaaabaaaaaadoaaaaab"
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
dcl_texcoord_pp v0.xyz
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
mad_pp r0.xyz, r0, c9.zwzw, v0
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
mov r1.zw, c9.w
add_pp r1, r1, v3
texldp_pp r1, r1, s1
lrp r0.xyz, c4.w, c4, r1
lrp_pp r1.xyz, r2.x, r0, c3
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
ConstBuffer "$Globals" 384
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
eefiecedphmofdghlgpojlkhcljikkgolncmdnmlabaaaaaaeiaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcciahaaaa
eaaaaaaamkabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadicbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
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
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaaigaabaaa
aaaaaaaafgifcaaaaaaaaaaaaoaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaa
abaaaaaaaceaaaaaaaaacaebaaaacaebaaaaaaaaaaaaaaaadgaaaaafecaabaaa
abaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egbdbaaaaeaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaakgakbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaaaaaaaaaakaaaaaadcaaaaakhcaabaaaabaaaaaapgipcaaaaaaaaaaa
akaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaadiaaaaaifcaabaaa
acaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadgaaaaafccaabaaa
acaaaaaabkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaakhcaabaaa
aeaaaaaaegbcbaaaacaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
baaaaaaiicaabaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaaegacbaaaacaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaoaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaaoaaaaaaabeaaaaa
aaaaiadpdccaaaakicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaoaaaaaadcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaajaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpbaaaaaahicaabaaaaaaaaaaaegacbaaaaeaaaaaa
egacbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaeaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaa
abaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkbabaaaacaaaaaabkiacaaa
abaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
ddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaak
hccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Vector 4 [_DistortParams]
Float 5 [_FresnelScale]
Vector 1 [_ReflectionColor]
Float 2 [_Shininess]
Vector 0 [_SpecularColor]
Vector 3 [_WorldLightDir]
SetTexture 0 [_BumpMap] 2D 0
"ps_3_0
def c6, 2, -1, 0.5, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_2d s0
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c6.x, c6.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c6.x, c6.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c4.x
mad_pp r0.xyz, r0, c6.zwzw, v0
nrm_pp r1.xyz, r0
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mad r0.yzw, v1.xxyz, r0.x, c3.xxyz
mul_pp r2.xyz, r0.x, v1
nrm_pp r3.xyz, r0.yzww
dp3_pp r0.x, r1, -r3
max r1.w, r0.x, c6.w
pow r0.x, r1.w, c2.x
mov r3.xyz, c0
mad_pp oC0.xyz, r0.x, r3, c1
mul_pp r1.xz, r1, c5.x
dp3_pp r0.x, -r2, r1
add_pp r0.y, -r0.x, -c6.y
cmp_pp r0.x, r0.x, r0.y, -c6.y
max_pp r1.x, r0.x, c6.w
pow_pp r0.x, r1.x, c4.z
mov r0.y, c6.y
lrp_sat_pp r1.x, r0.x, -r0.y, c4.w
add_sat_pp oC0.w, r1.x, c6.z

"
}
SubProgram "d3d11 " {
Keywords { "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedclmoflgfdaokfpjmbgdflbfdjmbodnoaabaaaaaaaaagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpiaeaaaaeaaaaaaadoabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
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
aaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaa
egbcbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
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
aaaaaaaaaoaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaadpddaaaaahiccabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
baaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalhccabaaaaaaaaaaaagaabaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegiccaaaaaaaaaaaakaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
Vector 6 [_DistortParams]
Float 7 [_FresnelScale]
Vector 3 [_ReflectionColor]
Float 4 [_Shininess]
Vector 2 [_SpecularColor]
Vector 5 [_WorldLightDir]
Vector 0 [unity_FogColor]
Vector 1 [unity_FogParams]
SetTexture 0 [_BumpMap] 2D 0
"ps_3_0
def c8, 2, -1, 0.5, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2
dcl_texcoord4 v3.x
dcl_2d s0
texld_pp r0, v2, s0
mad_pp r0.xyz, r0.wwyw, c8.x, c8.y
texld_pp r1, v2.zwzw, s0
mad_pp r1.xyz, r1.wwyw, c8.x, c8.y
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c6.x
mad_pp r0.xyz, r0, c8.zwzw, v0
nrm_pp r1.xyz, r0
mul_pp r0.xz, r1, c7.x
mov_pp r0.y, r1.y
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul_pp r2.xyz, r0.w, v1
mad r3.xyz, v1, r0.w, c5
nrm_pp r4.xyz, r3
dp3_pp r0.w, r1, -r4
max r1.x, r0.w, c8.w
pow r0.w, r1.x, c4.x
mov r1.xyz, c2
mad_pp r1.xyz, r0.w, r1, c3
add r1.xyz, r1, -c0
dp3_pp r0.x, -r2, r0
add_pp r0.y, -r0.x, -c8.y
cmp_pp r0.x, r0.x, r0.y, -c8.y
max_pp r1.w, r0.x, c8.w
pow_pp r0.x, r1.w, c6.z
mov r0.y, c8.y
lrp_sat_pp r1.w, r0.x, -r0.y, c6.w
add_sat_pp oC0.w, r1.w, c8.z
mul r0.x, c1.y, v3.x
exp_sat r0.x, -r0.x
mad_pp oC0.xyz, r0.x, r1, c0

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" "WATER_SIMPLE" "WATER_VERTEX_DISPLACEMENT_OFF" "WATER_EDGEBLEND_OFF" }
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
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
eefiecedengafgmmgbhggglkdjmgkgmlcinhdpgkabaaaaaaneagaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapahaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaacaaaaaaaiaiaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleafaaaa
eaaaaaaagnabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
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
akaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpddaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpbaaaaaahicaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakiacaaaaaaaaaaaamaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaalhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaa
aiaaaaaaegiccaaaaaaaaaaaakaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaa
dkbabaaaacaaaaaabkiacaaaabaaaaaaabaaaaaabjaaaaagicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadoaaaaab"
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
  GpuProgramID 156204
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX
uniform vec4 _Time;
uniform vec3 _WorldSpaceCameraPos;

uniform mat4 _Object2World;
uniform vec4 _BumpTiling;
uniform vec4 _BumpDirection;
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (tmpvar_1 - _WorldSpaceCameraPos);
  xlv_TEXCOORD1 = ((tmpvar_1.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
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
varying vec3 xlv_TEXCOORD0;
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
  tmpvar_6 = normalize(xlv_TEXCOORD0);
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

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedloaenbggkffnindofdjmcbklhpjbcfjgabaaaaaaleadaaaaadaaaaaa
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
ahaiaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcbiacaaaaeaaaabaa
igaaaaaafjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
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
aaaaaaaaegiocaaaaaaaaaaabaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedfpkobcmknokalhdinjgneblnnkbgmfmeabaaaaaadaafaaaaaeaaaaaa
daaaaaaakiabaaaamiadaaaamaaeaaaaebgpgodjhaabaaaahaabaaaaaaacpopp
amabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaabaaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaa
acaaaaaaaeaaafaaaaaaaaaaacaaamaaaeaaajaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjaafaaaaadaaaaahiaaaaaffjaakaaoekaaeaaaaae
aaaaahiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiaalaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaappjaaaaaoeiaabaaaaacabaaabia
adaaaakaaeaaaaaeabaaapiaabaaaaiaacaaoekaaaaaiiiaacaaaaadaaaaahoa
aaaaoeiaaeaaoekbafaaaaadabaaapoaabaaoeiaabaaoekaafaaaaadaaaaapia
aaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefcbiacaaaaeaaaabaaigaaaaaafjaaaaaeegiocaaa
aaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadcaaaaalpcaabaaa
aaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaaaaaaaaaabbaaaaaaigaibaaa
aaaaaaaadiaaaaaipccabaaaacaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
baaaaaaadoaaaaabejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaa
oaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaa
ojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
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
varying vec3 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD1;
varying float xlv_TEXCOORD2;
void main ()
{
  vec3 tmpvar_1;
  tmpvar_1 = (_Object2World * gl_Vertex).xyz;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (tmpvar_1 - _WorldSpaceCameraPos);
  xlv_TEXCOORD1 = ((tmpvar_1.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
  xlv_TEXCOORD2 = exp2(-((unity_FogParams.y * tmpvar_2.z)));
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
varying vec3 xlv_TEXCOORD0;
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
  tmpvar_6 = normalize(xlv_TEXCOORD0);
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

"
}
SubProgram "d3d11 " {
Keywords { "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedoommldofkccpndhknknagflikoeeioggabaaaaaadeaeaaaaadaaaaaa
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
ahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiahaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefciaacaaaaeaaaabaakaaaaaaafjaaaaae
egiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaabaaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaafpaaaaad
pcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaa
abaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaackaabaaa
aaaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaagiccabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaa
aeaaaaaadcaaaaalpcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaaigaibaaaaaaaaaaadiaaaaaipccabaaaacaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaabaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FOG_EXP" }
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "$Globals" 384
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
eefiecedjpnpnnikjomnjhnpiljejpopjhipaflhabaaaaaaniafaaaaaeaaaaaa
daaaaaaanaabaaaafiaeaaaafaafaaaaebgpgodjjiabaaaajiabaaaaaaacpopp
ciabaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaabaaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaa
acaaaaaaaeaaafaaaaaaaaaaacaaamaaaeaaajaaaaaaaaaaadaaabaaabaaanaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjaafaaaaadaaaaahia
aaaaffjaakaaoekaaeaaaaaeaaaaahiaajaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiaalaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaappja
aaaaoeiaabaaaaacabaaabiaadaaaakaaeaaaaaeabaaapiaabaaaaiaacaaoeka
aaaaiiiaacaaaaadaaaaahoaaaaaoeiaaeaaoekbafaaaaadabaaapoaabaaoeia
abaaoekaafaaaaadaaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaaiaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaakkiaanaaffka
aoaaaaacaaaaaioaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefciaacaaaaeaaaabaakaaaaaaa
fjaaaaaeegiocaaaaaaaaaaabcaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaa
fjaaaaaeegiocaaaacaaaaaabaaaaaaafjaaaaaeegiocaaaadaaaaaaacaaaaaa
fpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadiccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkiacaaaadaaaaaaabaaaaaabjaaaaagiccabaaaabaaaaaa
akaabaiaebaaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhccabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaadcaaaaalpcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaa
egiocaaaaaaaaaaabbaaaaaaigaibaaaaaaaaaaadiaaaaaipccabaaaacaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaabaaaaaaadoaaaaabejfdeheopaaaaaaa
aiaaaaaaaiaaaaaamiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
nbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaaaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaaoaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
oaaaaaaaacaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
ahaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
abaaaaaaaiahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0
eefiecedcmpoofkbclicgdfpimkohedodpgplajjabaaaaaafmagaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
ConstBuffer "$Globals" 384
Vector 128 [_SpecularColor]
Vector 144 [_BaseColor]
Vector 160 [_ReflectionColor]
Float 192 [_Shininess]
Vector 208 [_WorldLightDir]
Vector 224 [_DistortParams]
Float 240 [_FresnelScale]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedfpkmhedkgeifpleacfmkadajblogebdhabaaaaaahmajaaaaaeaaaaaa
daaaaaaaemadaaaaniaiaaaaeiajaaaaebgpgodjbeadaaaabeadaaaaaaacpppp
neacaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaaiaaadaaaaaaaaaaaaaaaaaaamaaaeaaadaaaaaaaaaaaaacppppfbaaaaaf
ahaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafaiaaapkaaaaaaadp
aaaaaaaaaaaaaadpaaaaaaeafbaaaaafajaaapkaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaacplabpaaaaac
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
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaa
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
ConstBuffer "$Globals" 384
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
eefiecedpkmkibcjmojfammmmbcohehlmojjlmagabaaaaaapaagaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
aiaiaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaaagaaaaeaaaaaaaiaabaaaafjaaaaaeegiocaaa
aaaaaaaabaaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagfaaaaadpccabaaa
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
egiccaiaebaaaaaaabaaaaaaaaaaaaaadgcaaaaficaabaaaaaaaaaaadkbabaaa
abaaaaaadcaaaaakhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaabaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "FOG_EXP" }
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 384
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
eefiecedphmlejfcnfalhakgoeoncgbjbpacnnjbabaaaaaadmakaaaaaeaaaaaa
daaaaaaahiadaaaaiaajaaaaaiakaaaaebgpgodjeaadaaaaeaadaaaaaaacpppp
peacaaaaemaaaaaaadaaciaaaaaaemaaaaaaemaaabaaceaaaaaaemaaaaaaaaaa
aaaaaiaaadaaaaaaaaaaaaaaaaaaamaaaeaaadaaaaaaaaaaabaaaaaaabaaahaa
aaaaaaaaaaacppppfbaaaaafaiaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadp
fbaaaaafajaaapkaaaaaaadpaaaaaaaaaaaaaadpaaaaaaeafbaaaaafakaaapka
aaaaaaaaaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaacplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaacbiaabaakkla
abaaaaacaaaacciaabaapplaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoelaaaaioekaaeaaaaaeacaacdiaaaaappiaaiaaaakaaiaaffka
aeaaaaaeacaaceiaaaaaffiaaiaaaakaaiaaffkaaeaaaaaeaaaacdiaabaappia
aiaaaakaaiaaffkaaeaaaaaeaaaaceiaabaaffiaaiaaaakaaiaaffkaacaaaaad
aaaachiaacaaoeiaaaaaoeiaafaaaaadaaaachiaaaaaoeiaafaaaakaabaaaaac
abaaahiaajaaoekaaeaaaaaeaaaachiaaaaaoeiaabaaoeiaakaaoekaceaaaaac
abaachiaaaaaoeiaafaaaaadaaaacfiaabaaoeiaagaaaakaabaaaaacaaaaccia
abaaffiaaiaaaaadaaaaaiiaaaaaoelaaaaaoelaahaaaaacaaaaaiiaaaaappia
afaaaaadacaachiaaaaappiaaaaaoelaaeaaaaaeadaaahiaaaaaoelaaaaappia
aeaaoekaceaaaaacaeaachiaadaaoeiaaiaaaaadaaaaciiaabaaoeiaaeaaoeib
alaaaaadacaaaiiaaaaappiaaiaakkkacaaaaaadaaaaaiiaacaappiaadaaaaka
aiaaaaadaaaacbiaacaaoeibaaaaoeiaacaaaaadaaaacciaaaaaaaibaiaappka
fiaaaaaeaaaacbiaaaaaaaiaaaaaffiaaiaappkaalaaaaadabaacbiaaaaaaaia
aiaakkkacaaaaaadaaaacbiaabaaaaiaafaakkkaabaaaaacabaaaiiaaiaappka
bcaaaaaeacaadbiaaaaaaaiaabaappiaafaappkaacaaaaadaaaacbiaacaaaaia
acaaaaiaaeaaaaaeabaadiiaacaaaaiaajaappkaajaaaakaabaaaaacaaaabbia
aaaaaaiaabaaaaacacaaahiaabaaoekaacaaaaadacaaahiaacaaoeibacaaoeka
aeaaaaaeaaaachiaaaaaaaiaacaaoeiaabaaoekaaeaaaaaeaaaachiaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaabiiaaaaapplabcaaaaaeabaachiaaaaappia
aaaaoeiaahaaoekaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcaaagaaaa
eaaaaaaaiaabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadicbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaaphcaabaaaaaaaaaaapganbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaaaaaaaaapganbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaaoaaaaaa
dcaaaaaphcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaiadpaaaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaifcaabaaaabaaaaaaagacbaaaaaaaaaaaagiacaaa
aaaaaaaaapaaaaaadgaaaaafccaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egbcbaaaabaaaaaadcaaaaakhcaabaaaadaaaaaaegbcbaaaabaaaaaapgapbaaa
aaaaaaaaegiccaaaaaaaaaaaanaaaaaabaaaaaaiicaabaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaaaoaaaaaaabeaaaaaaaaaiadpdccaaaakicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaaoaaaaaaaaaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaeaabeaaaaaaaaaaadpddaaaaah
iccabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpddaaaaahicaabaaa
aaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaakhcaabaaaabaaaaaa
egiccaiaebaaaaaaaaaaaaaaajaaaaaaegiccaaaaaaaaaaaakaaaaaadcaaaaak
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
ajaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaa
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaaegacbaaaabaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaaaaaaaa
dgcaaaaficaabaaaaaaaaaaadkbabaaaabaaaaaadcaaaaakhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadoaaaaab
ejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaaaiaiaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "Transparent/Diffuse"
}