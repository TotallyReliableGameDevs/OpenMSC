using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class AddToFsmInt : FsmStateAction
	{
		public FsmOwnerDefault gameObject;
		public FsmString fsmName;
		public FsmString variableName;
		public FsmInt add;
		public FsmInt storeResult;
		public bool everyFrame;
	}
}
