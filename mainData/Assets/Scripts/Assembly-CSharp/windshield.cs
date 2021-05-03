using UnityEngine;
using System;

public class windshield : MonoBehaviour
{
	[Serializable]
	public struct RainType
	{
		public RainType(int dropsPerFrame, float dryingSpeed, float dropSize) : this()
		{
		}

		public int dropsPerFrame;
		public float dryingSpeed;
		public float dropSize;
	}

	public float rain;
	public float wind;
	public float gravityMultiplier;
	public Rect frontUV;
	public Rect sideUV;
	public Rect rearUV;
	public Color Wet;
	public Color Dry;
	public RainType[] raintypes;
	public Vector2 wiper1;
	public Vector2 wiper2;
	public float wiper1AngleOffset;
	public float wiper2AngleOffset;
	public float wiper1Length;
	public float wiper2Length;
	public float wiper1MaxAngle;
	public float wiper2MaxAngle;
	public float wiper1Position;
	public float wiper2Position;
	public bool wipersTestMove;
	public int textureSize;
	public MeshRenderer[] windowRenderers;
	public Transform frontWindowNormal;
	public Transform sideWindowNormal;
	public Transform rearWindowNormal;
	public Transform frontWind;
	public Transform sideWind;
	public Transform rearWind;
	public Vector2 frontFlow;
	public Vector2 sideFlow;
	public Vector2 rearFlow;
}
