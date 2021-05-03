using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class BlendAnimation : FsmStateAction
	{
		public FsmOwnerDefault gameObject;
		public FsmString animName;
		public FsmFloat targetWeight;
		public FsmFloat time;
		public FsmEvent finishEvent;
	}
}
