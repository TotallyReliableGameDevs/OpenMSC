using UnityEngine;
using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class StopAnimation : ComponentAction<Animation>
	{
		public FsmOwnerDefault gameObject;
		public FsmString animName;
	}
}
