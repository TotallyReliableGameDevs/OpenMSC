using UnityEngine;
using Holoville.HOTween;

namespace SWS
{
	public class minimalMove : MonoBehaviour
	{
		public enum OrientToPathType
		{
			none = 0,
			to2DTopDown = 1,
			to2DSideScroll = 2,
			to3D = 3,
		}

		public enum TimeValue
		{
			time = 0,
			speed = 1,
		}

		public enum LoopType
		{
			none = 0,
			loop = 1,
			pingPong = 2,
		}

		public PathManager pathContainer;
		public PathType pathType;
		public bool onStart;
		public bool moveToPath;
		public bool closeLoop;
		public OrientToPathType orientToPath;
		public float lookAhead;
		public TimeValue timeValue;
		public float speed;
		public EaseType easeType;
		public AnimationCurve animEaseType;
		public LoopType loopType;
		public Vector3[] waypoints;
		public bool repeat;
		public Axis lockAxis;
		public Axis lockPosition;
	}
}
