using UnityEngine;

namespace UnityStandardAssets.CrossPlatformInput
{
	public class Joystick : MonoBehaviour
	{
		public enum AxisOption
		{
			Both = 0,
			OnlyHorizontal = 1,
			OnlyVertical = 2,
		}

		public int MovementRange;
		public AxisOption axesToUse;
		public string horizontalAxisName;
		public string verticalAxisName;
	}
}
