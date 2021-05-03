using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class ArrayListSetColorFromTexture : ArrayListActions
	{
		public FsmOwnerDefault gameObject;
		public FsmString reference;
		public FsmBool disableAlpha;
		public FsmTexture texture;
		public FsmEvent doneEvent;
		public FsmEvent failureEvent;
	}
}
