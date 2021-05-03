using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class LineRenderArrayList : ArrayListActions
	{
		public FsmOwnerDefault gameObject;
		public FsmString reference;
		public FsmColor c1;
		public FsmColor c2;
		public FsmFloat width1;
		public FsmFloat width2;
		public FsmMaterial lineMaterial;
		public bool everyFrame;
		public FsmEvent failureEvent;
	}
}
