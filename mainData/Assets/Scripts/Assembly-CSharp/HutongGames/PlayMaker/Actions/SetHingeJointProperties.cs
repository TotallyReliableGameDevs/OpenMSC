using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SetHingeJointProperties : FsmStateAction
	{
		public FsmOwnerDefault gameObject;
		public FsmGameObject connectedBody;
		public FsmFloat breakForce;
		public FsmFloat breakTorque;
		public FsmVector3 anchor;
		public FsmVector3 axis;
		public FsmBool useSpring;
		public FsmFloat spring;
		public FsmFloat damper;
		public FsmFloat targetPosition;
		public FsmBool useMotor;
		public FsmFloat targetVelocity;
		public FsmFloat force;
		public FsmBool freeSpin;
		public FsmBool useLimits;
		public FsmFloat min;
		public FsmFloat max;
		public FsmFloat minBounce;
		public FsmFloat maxBounce;
		public bool everyFrame;
	}
}
