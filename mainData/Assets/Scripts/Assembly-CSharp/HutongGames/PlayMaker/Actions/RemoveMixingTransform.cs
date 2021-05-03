using UnityEngine;
using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class RemoveMixingTransform : ComponentAction<Animation>
	{
		public FsmOwnerDefault gameObject;
		public FsmString animationName;
		public FsmString transfrom;
	}
}
