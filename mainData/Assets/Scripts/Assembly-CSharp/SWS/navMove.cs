using UnityEngine;

namespace SWS
{
	public class navMove : MonoBehaviour
	{
		public enum LoopType
		{
			none = 0,
			loop = 1,
			pingPong = 2,
			random = 3,
		}

		public PathManager pathContainer;
		public int currentPoint;
		public bool onStart;
		public bool moveToPath;
		public bool closeLoop;
		public bool updateRotation;
		public RangeValue[] delays;
		public Messages messages;
		public LoopType loopType;
		public Transform[] waypoints;
		public bool repeat;
	}
}
