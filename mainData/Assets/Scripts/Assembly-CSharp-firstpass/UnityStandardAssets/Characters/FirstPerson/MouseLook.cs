using System;

namespace UnityStandardAssets.Characters.FirstPerson
{
	[Serializable]
	public class MouseLook
	{
		public float XSensitivity;
		public float YSensitivity;
		public bool clampVerticalRotation;
		public float MinimumX;
		public float MaximumX;
		public bool smooth;
		public float smoothTime;
	}
}
