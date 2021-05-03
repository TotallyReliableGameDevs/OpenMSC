using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class CInputGetAxisDeadZone : FsmStateAction
	{
		public FsmString axisName;
		public FsmFloat storeAxisDeadzone;
		public FsmBool everyFrame;
	}
}
