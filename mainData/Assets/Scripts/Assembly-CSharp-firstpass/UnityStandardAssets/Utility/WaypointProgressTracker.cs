using UnityEngine;

namespace UnityStandardAssets.Utility
{
	public class WaypointProgressTracker : MonoBehaviour
	{
		public enum ProgressStyle
		{
			SmoothAlongRoute = 0,
			PointToPoint = 1,
		}

		[SerializeField]
		private WaypointCircuit circuit;
		[SerializeField]
		private float lookAheadForTargetOffset;
		[SerializeField]
		private float lookAheadForTargetFactor;
		[SerializeField]
		private float lookAheadForSpeedOffset;
		[SerializeField]
		private float lookAheadForSpeedFactor;
		[SerializeField]
		private ProgressStyle progressStyle;
		[SerializeField]
		private float pointToPointThreshold;
		public Transform target;
	}
}
