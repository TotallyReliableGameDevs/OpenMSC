using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class CInputSetAxis : FsmStateAction
	{
		public FsmString axisName;
		public FsmString negativeInput;
		public FsmString positiveInput;
		public FsmFloat axisSensitivity;
		public FsmFloat axisGravity;
		public FsmFloat axisDeadzone;
	}
}
