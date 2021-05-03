using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class AddFsmFloat : FsmStateAction
	{
		public FsmOwnerDefault gameObject;
		public FsmString fsmName;
		public FsmString variableName;
		public FsmFloat addValue;
		public bool everyFrame;
		public bool perSecond;
	}
}
