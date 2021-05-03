using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class TakeCameraScreenshotTexture : FsmStateAction
	{
		public enum depthSelect
		{
			_24 = 0,
			_16 = 1,
			_0 = 2,
		}

		public FsmGameObject gameObject;
		public FsmInt resWidth;
		public FsmInt resHeight;
		public FsmBool Auto;
		public FsmBool useCurrentRes;
		public FsmTexture newTexture;
		public FsmBool inclGui;
		public depthSelect setDepth;
	}
}
