using UnityEngine;
using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class PlayRandomAnimation : ComponentAction<Animation>
	{
		public FsmOwnerDefault gameObject;
		public FsmString[] animations;
		public FsmFloat[] weights;
		public PlayMode playMode;
		public FsmFloat blendTime;
		public FsmEvent finishEvent;
		public FsmEvent loopEvent;
		public bool stopOnExit;
	}
}
