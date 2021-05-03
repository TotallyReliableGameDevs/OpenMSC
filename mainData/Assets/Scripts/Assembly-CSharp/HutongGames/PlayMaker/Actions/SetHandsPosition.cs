using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SetHandsPosition : FsmStateAction
	{
		public FsmOwnerDefault gameObject;
		public FsmFloat HandsDist;
		public FsmFloat HandsAngle;
		public FsmVector3 SelectedPoint;
		public FsmGameObject Hand01Obj;
		public FsmGameObject Hand02Obj;
	}
}
