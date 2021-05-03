using System;
using UnityEngine;

namespace UnityStandardAssets.Utility
{
	[Serializable]
	public class CurveControlledBob
	{
		public float HorizontalBobRange;
		public float VerticalBobRange;
		public AnimationCurve Bobcurve;
		public float VerticaltoHorizontalRatio;
	}
}
