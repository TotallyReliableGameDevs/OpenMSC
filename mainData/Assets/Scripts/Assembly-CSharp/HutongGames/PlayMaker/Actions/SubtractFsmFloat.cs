using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SubtractFsmFloat : FsmStateAction
	{
		public FsmOwnerDefault gameObject;
		public FsmString fsmName;
		public FsmString variableName;
		public FsmFloat subtractValue;
		public bool everyFrame;
		public bool perSecond;
	}
}
