using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class BuildStringFast : FsmStateAction
	{
		public FsmString[] stringParts;
		public FsmString separator;
		public FsmBool addToEnd;
		public FsmString storeResult;
		public FsmBool everyFrame;
	}
}
