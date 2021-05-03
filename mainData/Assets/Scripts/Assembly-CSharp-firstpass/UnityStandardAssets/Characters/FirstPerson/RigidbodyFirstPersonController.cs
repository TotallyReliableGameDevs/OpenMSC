using UnityEngine;
using System;

namespace UnityStandardAssets.Characters.FirstPerson
{
	public class RigidbodyFirstPersonController : MonoBehaviour
	{
		[Serializable]
		public class MovementSettings
		{
			public float ForwardSpeed;
			public float BackwardSpeed;
			public float StrafeSpeed;
			public float RunMultiplier;
			public KeyCode RunKey;
			public float JumpForce;
			public AnimationCurve SlopeCurveModifier;
			public float CurrentTargetSpeed;
		}

		[Serializable]
		public class AdvancedSettings
		{
			public float groundCheckDistance;
			public float stickToGroundHelperDistance;
			public float slowDownRate;
			public bool airControl;
		}

		public Camera cam;
		public MovementSettings movementSettings;
		public MouseLook mouseLook;
		public AdvancedSettings advancedSettings;
	}
}
