using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class AddMixingTransform : FsmStateAction
	{
		public FsmOwnerDefault gameObject;
		public FsmString animationName;
		public FsmString transform;
		public FsmBool recursive;
	}
}
