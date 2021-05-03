using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class ResourcesLoad : FsmStateAction
	{
		public FsmString assetPath;
		public FsmVar storeAsset;
		public FsmEvent successEvent;
		public FsmEvent failureEvent;
	}
}
