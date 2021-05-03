using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class BuildString : FsmStateAction
	{
		public FsmString[] stringParts;
		public FsmString separator;
		public FsmString storeResult;
		public bool everyFrame;
	}
}
