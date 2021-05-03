using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class CInputGetButtonStates : FsmStateAction
	{
		public FsmString buttonName;
		public FsmBool storeButtonDown;
		public FsmBool storeButtonUp;
		public FsmBool storeButtonPressed;
		public FsmBool everyFrame;
	}
}
