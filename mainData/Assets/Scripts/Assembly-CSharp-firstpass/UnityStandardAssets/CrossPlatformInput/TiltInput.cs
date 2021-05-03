using UnityEngine;
using System;

namespace UnityStandardAssets.CrossPlatformInput
{
	public class TiltInput : MonoBehaviour
	{
		[Serializable]
		public class AxisMapping
		{
			public enum MappingType
			{
				NamedAxis = 0,
				MousePositionX = 1,
				MousePositionY = 2,
				MousePositionZ = 3,
			}

			public MappingType type;
			public string axisName;
		}

		public enum AxisOptions
		{
			ForwardAxis = 0,
			SidewaysAxis = 1,
		}

		public AxisMapping mapping;
		public AxisOptions tiltAroundAxis;
		public float fullTiltAngle;
		public float centreAngleOffset;
	}
}
