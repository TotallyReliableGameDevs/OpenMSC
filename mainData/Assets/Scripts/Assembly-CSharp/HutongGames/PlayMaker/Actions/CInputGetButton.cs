using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class CInputGetButton : FsmStateAction
	{
		public FsmString buttonName;
		public FsmEvent buttonDownEvent;
		public FsmEvent buttonUpEvent;
		public FsmEvent buttonPressedEvent;
		public FsmBool everyFrame;
	}
}
