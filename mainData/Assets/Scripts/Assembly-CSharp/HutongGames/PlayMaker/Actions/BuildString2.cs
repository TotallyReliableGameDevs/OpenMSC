using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class BuildString2 : FsmStateAction
	{
		public enum separatorInsertion
		{
			InBetween = 0,
			After = 1,
			Before = 2,
		}

		public FsmString[] stringParts;
		public FsmString separator;
		public separatorInsertion separatorInsert;
		public FsmString storeResult;
		public bool everyFrame;
	}
}
