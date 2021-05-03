using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SetHingeJointLimits : FsmStateAction
	{
		public FsmOwnerDefault gameObject;
		public FsmFloat min;
		public FsmFloat max;
		public bool everyFrame;
	}
}
