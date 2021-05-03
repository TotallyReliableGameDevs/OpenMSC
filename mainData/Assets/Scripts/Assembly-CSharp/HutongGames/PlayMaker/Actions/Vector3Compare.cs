using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class Vector3Compare : FsmStateAction
	{
		public FsmVector3 vector3Variable1;
		public FsmVector3 vector3Variable2;
		public FsmFloat tolerance;
		public FsmBool result;
		public FsmEvent equal;
		public FsmEvent notEqual;
		public bool everyFrame;
	}
}
