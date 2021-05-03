using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class CInputGetKeySequence : FsmStateAction
	{
		public FsmString[] keyNames;
		public FsmInt storeMissingKeysCount;
		public FsmString storeExpectingKey;
		public FsmEvent sendSequenceFinished;
		public FsmEvent sendSequenceFailed;
	}
}
