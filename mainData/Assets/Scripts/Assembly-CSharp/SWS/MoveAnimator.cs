using UnityEngine;

namespace SWS
{
	public class MoveAnimator : MonoBehaviour
	{
		public enum MovementType
		{
			splineMove = 0,
			bezierMove = 1,
			navMove = 2,
		}

		public MovementType mType;
	}
}
