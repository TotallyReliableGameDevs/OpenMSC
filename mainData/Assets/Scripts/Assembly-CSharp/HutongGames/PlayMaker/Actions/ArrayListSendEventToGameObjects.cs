using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class ArrayListSendEventToGameObjects : ArrayListActions
	{
		public FsmOwnerDefault gameObject;
		public FsmString reference;
		public FsmEvent sendEvent;
		public FsmBool excludeSelf;
		public FsmBool sendToChildren;
	}
}
