using UnityEngine;
using System.Collections.Generic;

namespace SWS
{
	public class BezierPathManager : PathManager
	{
		public Vector3[] pathPoints;
		public List<BezierPoint> bPoints;
		public bool showHandles;
		public Color color3;
		public float pathDetail;
		public bool customDetail;
		public List<float> segmentDetail;
	}
}
