using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class CInputGetKeyStates : FsmStateAction
	{
		public FsmString keyName;
		public FsmBool storeKeyDown;
		public FsmBool storeKeyUp;
		public FsmBool storeKeyPressed;
		public FsmBool everyFrame;
	}
}
