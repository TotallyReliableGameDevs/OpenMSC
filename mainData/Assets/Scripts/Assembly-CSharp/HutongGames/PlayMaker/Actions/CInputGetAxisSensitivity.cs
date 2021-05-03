using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class CInputGetAxisSensitivity : FsmStateAction
	{
		public FsmString axisName;
		public FsmFloat storeAxisSensitivity;
		public FsmBool everyFrame;
	}
}
