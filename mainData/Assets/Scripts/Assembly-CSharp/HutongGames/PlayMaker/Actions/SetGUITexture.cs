using UnityEngine;
using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SetGUITexture : ComponentAction<UnityEngine.UI.Image>
	{
		public FsmOwnerDefault gameObject;
		public FsmTexture texture;
	}
}
