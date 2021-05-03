using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class CInputGetText : FsmStateAction
	{
		public FsmString actionName;
		public FsmInt input;
		public FsmBool returnBlank;
		public FsmString storeInputName;
		public FsmBool everyFrame;
	}
}
