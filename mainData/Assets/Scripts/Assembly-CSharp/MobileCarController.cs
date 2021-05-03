using System;
using UnityEngine;
using UnityEngine.UI;

public class MobileCarController : CarController
{
	[Serializable]
	public class TouchButton
	{
		public Image texture;
		public float alphaButtonDown;
		public float alphaButtonReleased;
	}

	public TouchButton throttleButton;
	public TouchButton brakeButton;
	public TouchButton handbrakeButton;
	public TouchButton gearUpButton;
	public TouchButton gearDownButton;
}
