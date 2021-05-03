using UnityEngine;
using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SetGUITextureColor : ComponentAction<UnityEngine.UI.Image>
	{
		public FsmOwnerDefault gameObject;
		public FsmColor color;
		public bool everyFrame;
	}
}
