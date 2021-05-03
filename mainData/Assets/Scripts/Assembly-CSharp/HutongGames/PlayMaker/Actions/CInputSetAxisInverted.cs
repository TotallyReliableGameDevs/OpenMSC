using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class CInputSetAxisInverted : FsmStateAction
	{
		public FsmString axisName;
		public FsmBool axisInverted;
		public FsmBool storeResult;
		public FsmBool everyFrame;
	}
}
