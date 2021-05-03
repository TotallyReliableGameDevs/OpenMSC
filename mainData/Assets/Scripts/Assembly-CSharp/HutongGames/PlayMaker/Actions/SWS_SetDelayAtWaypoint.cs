using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SWS_SetDelayAtWaypoint : FsmStateAction
	{
		public FsmOwnerDefault walkerObject;
		public FsmInt wpIndex;
		public FsmFloat min;
		public FsmFloat max;
	}
}
