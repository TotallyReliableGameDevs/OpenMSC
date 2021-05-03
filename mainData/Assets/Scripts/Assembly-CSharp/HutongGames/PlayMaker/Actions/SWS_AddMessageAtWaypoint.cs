using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SWS_AddMessageAtWaypoint : FsmStateAction
	{
		public FsmOwnerDefault walkerObject;
		public FsmInt wpIndex;
		public PlayMakerFSM fsmReceiver;
		public FsmString fsmEvent;
	}
}
