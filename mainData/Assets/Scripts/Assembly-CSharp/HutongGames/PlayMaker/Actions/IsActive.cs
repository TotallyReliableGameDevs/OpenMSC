using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class IsActive : FsmStateAction
	{
		public FsmGameObject gameObject;
		public FsmBool isActive;
		public FsmEvent isActiveEvent;
		public FsmEvent isNotActiveEvent;
		public bool everyFrame;
	}
}
