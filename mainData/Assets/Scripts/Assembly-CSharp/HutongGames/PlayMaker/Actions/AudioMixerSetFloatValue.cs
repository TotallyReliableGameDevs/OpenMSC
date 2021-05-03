using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class AudioMixerSetFloatValue : FsmStateAction
	{
		public FsmObject theMixer;
		public FsmString exposedFloatName;
		public FsmFloat floatvalue;
		public bool everyFrame;
	}
}
