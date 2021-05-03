using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class IntEquals : FsmStateAction
	{
		public FsmInt[] integers;
		public FsmEvent equal;
		public FsmEvent notEqual;
		public bool everyFrame;
	}
}
