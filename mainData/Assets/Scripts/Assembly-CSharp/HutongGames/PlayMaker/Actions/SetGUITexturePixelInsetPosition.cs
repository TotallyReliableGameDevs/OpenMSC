using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SetGUITexturePixelInsetPosition : FsmStateAction
	{
		public FsmOwnerDefault gameObject;
		public FsmFloat PixelInsetX;
		public FsmFloat PixelInsetY;
		public FsmBool AsIncrement;
		public bool everyFrame;
	}
}
