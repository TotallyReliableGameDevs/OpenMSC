using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class WWWObjectRelative : FsmStateAction
	{
		public FsmString url;
		public FsmBool pathIsRelative;
		public FsmString storeText;
		public FsmTexture storeTexture;
		public FsmObject storeAudio;
		public FsmObject storeMovieTexture;
		public FsmString errorString;
		public FsmFloat progress;
		public FsmEvent isDone;
		public FsmEvent isError;
	}
}
