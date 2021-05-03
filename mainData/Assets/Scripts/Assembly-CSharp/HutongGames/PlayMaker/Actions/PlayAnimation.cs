using UnityEngine;
using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class PlayAnimation : ComponentAction<Animation>
	{
		public FsmOwnerDefault gameObject;
		public FsmString animName;
		public PlayMode playMode;
		public FsmFloat blendTime;
		public FsmEvent finishEvent;
		public FsmEvent loopEvent;
		public bool stopOnExit;
	}
}
