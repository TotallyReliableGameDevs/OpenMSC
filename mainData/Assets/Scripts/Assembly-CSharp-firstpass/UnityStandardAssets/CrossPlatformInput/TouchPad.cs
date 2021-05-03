using UnityEngine;

namespace UnityStandardAssets.CrossPlatformInput
{
	public class TouchPad : MonoBehaviour
	{
		public enum AxisOption
		{
			Both = 0,
			OnlyHorizontal = 1,
			OnlyVertical = 2,
		}

		public enum ControlStyle
		{
			Absolute = 0,
			Relative = 1,
			Swipe = 2,
		}

		public AxisOption axesToUse;
		public ControlStyle controlStyle;
		public string horizontalAxisName;
		public string verticalAxisName;
		public float Xsensitivity;
		public float Ysensitivity;
	}
}
