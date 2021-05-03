using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class CInputGetKey : FsmStateAction
	{
		public FsmString keyName;
		public FsmEvent keyDownEvent;
		public FsmEvent keyUpEvent;
		public FsmEvent keyPressedEvent;
		public FsmBool everyFrame;
	}
}
