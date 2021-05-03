using UnityEngine;
using Holoville.HOTween;

namespace SWS
{
	public class bezierMove : MonoBehaviour
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

		public BezierPathManager pathContainer;
		public PathType pathType;
		public bool onStart;
		public bool moveToPath;
		public OrientToPathType orientToPath;
		public float lookAhead;
		public float sizeToAdd;
		public Messages messages;
		public TimeValue timeValue;
		public float speed;
		public EaseType easeType;
		public AnimationCurve animEaseType;
		public LoopType loopType;
		public Axis lockAxis;
		public Axis lockPosition;
	}
}
