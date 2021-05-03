using HutongGames.PlayMaker;
using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	public class WWWPOST : FsmStateAction
	{
		public FsmString url;
		public FsmString[] postKeys;
		public FsmVar[] postValues;
		public FsmString storeText;
		public FsmTexture storeTexture;
		public FsmObject storeMovieTexture;
		public FsmObject storeAudio;
		public FsmBool audio3d;
		public FsmBool audioStream;
		public AudioType audioType;
		public FsmString errorString;
		public FsmFloat progress;
		public FsmEvent isDone;
		public FsmEvent isError;
	}
}
