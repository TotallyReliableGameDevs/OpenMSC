using UnityEngine;
using UnityStandardAssets.Utility;

namespace UnityStandardAssets.Characters.FirstPerson
{
	public class HeadBob : MonoBehaviour
	{
		public Camera Camera;
		public CurveControlledBob motionBob;
		public LerpControlledBob jumpAndLandingBob;
		public RigidbodyFirstPersonController rigidbodyFirstPersonController;
		public float StrideInterval;
		public float RunningStrideLengthen;
	}
}
