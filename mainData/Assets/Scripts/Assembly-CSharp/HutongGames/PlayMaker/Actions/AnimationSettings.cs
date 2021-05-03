using HutongGames.PlayMaker;
using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	public class AnimationSettings : FsmStateAction
	{
		public FsmOwnerDefault gameObject;
		public FsmString animName;
		public WrapMode wrapMode;
		public AnimationBlendMode blendMode;
		public FsmFloat speed;
		public FsmInt layer;
	}
}
