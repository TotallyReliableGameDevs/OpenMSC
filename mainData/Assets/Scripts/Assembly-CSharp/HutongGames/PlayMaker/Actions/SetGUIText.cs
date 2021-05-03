using UnityEngine;
using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SetGUIText : ComponentAction<UnityEngine.UI.Text>
	{
		public FsmOwnerDefault gameObject;
		public FsmString text;
		public bool everyFrame;
	}
}
