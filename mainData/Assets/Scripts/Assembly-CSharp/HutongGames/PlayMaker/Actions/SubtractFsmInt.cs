using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SubtractFsmInt : FsmStateAction
	{
		public FsmOwnerDefault gameObject;
		public FsmString fsmName;
		public FsmString variableName;
		public FsmInt subtractValue;
		public bool everyFrame;
		public bool perSecond;
	}
}
