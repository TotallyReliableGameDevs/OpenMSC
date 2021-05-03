using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class Iterate : FsmStateAction
	{
		public FsmInt startIndex;
		public FsmInt endIndex;
		public FsmInt increment;
		public FsmEvent loopEvent;
		public FsmEvent finishedEvent;
		public FsmInt currentIndex;
	}
}
