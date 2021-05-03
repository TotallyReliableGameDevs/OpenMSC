using HutongGames.PlayMaker;
using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	public class SphereCast : FsmStateAction
	{
		public FsmOwnerDefault fromGameObject;
		public FsmVector3 fromPosition;
		public FsmVector3 direction;
		public float radius;
		public Space space;
		public FsmFloat distance;
		public FsmEvent hitEvent;
		public FsmBool storeDidHit;
		public FsmGameObject storeHitObject;
		public FsmVector3 storeHitPoint;
		public FsmVector3 storeHitNormal;
		public FsmFloat storeHitDistance;
		public FsmInt repeatInterval;
		public FsmInt[] layerMask;
		public FsmBool invertMask;
		public FsmColor debugColor;
		public FsmBool debug;
	}
}
