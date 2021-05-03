using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class StringTypewriter : FsmStateAction
	{
		public FsmString baseString;
		public FsmString resultString;
		public FsmFloat pause;
		public FsmBool realtime;
		public FsmEvent finishEvent;
		public string d1;
		public bool useSounds;
		public bool noSoundOnSpaces;
		public FsmObject typingSound;
		public FsmOwnerDefault audioSourceObj;
	}
}
