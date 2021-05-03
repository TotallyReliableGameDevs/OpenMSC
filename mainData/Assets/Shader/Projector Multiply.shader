Shader "Projector/Multiply" {
Properties {
 _ShadowTex ("Cookie", 2D) = "gray" { }
 _FalloffTex ("FallOff", 2D) = "white" { }
}
SubShader { 
 Tags { "RenderType"="Transparent-1" }
 Pass {
  Tags { "RenderType"="Transparent-1" }
  ZWrite Off
  Fog {
   Color (1,1,1,1)
  }
  Blend DstColor Zero
  AlphaTest Greater 0
  ColorMask RGB
  Offset -1, -1
  SetTexture [_ShadowTex] { combine texture, one-texture alpha }
  SetTexture [_FalloffTex] { ConstantColor (1,1,1,0) combine previous lerp(texture) constant }
 }
}
}