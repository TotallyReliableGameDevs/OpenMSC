using UnityEngine;
using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SetGUITextureAlpha : ComponentAction<UnityEngine.UI.Image>
	{
		public FsmOwnerDefault gameObject;
		public FsmFloat alpha;
		public bool everyFrame;
	}
}
