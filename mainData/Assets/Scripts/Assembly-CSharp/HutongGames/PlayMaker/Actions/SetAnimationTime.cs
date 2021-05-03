using UnityEngine;
using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SetAnimationTime : ComponentAction<Animation>
	{
		public FsmOwnerDefault gameObject;
		public FsmString animName;
		public FsmFloat time;
		public bool normalized;
		public bool everyFrame;
	}
}
