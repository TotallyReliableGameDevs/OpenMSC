using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SetCharacterMotorProperties : FsmStateAction
	{
		public FsmOwnerDefault gameObject;
		public FsmBool canControl;
		public FsmFloat maxForwardSpeed;
		public FsmFloat maxSidewaysSpeed;
		public FsmFloat maxBackwardsSpeed;
		public FsmFloat maxGroundAcceleration;
		public FsmFloat gravity;
		public FsmFloat maxFallSpeed;
		public FsmBool jumpEnabled;
		public FsmFloat baseHeight;
		public FsmFloat extraHeight;
		public FsmFloat perpAmount;
		public FsmFloat steepPerpAmount;
		public FsmBool movingPlatformEnabled;
		public FsmBool slidingEnabled;
		public FsmFloat slidingSpeed;
		public FsmFloat sidewaysControl;
		public FsmFloat speedControl;
		public bool everyFrame;
	}
}
