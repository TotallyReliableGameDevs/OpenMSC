using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SetParticleMaterialColor : FsmStateAction
	{
		public FsmOwnerDefault gameObject;
		public FsmInt materialIndex;
		public FsmMaterial material;
		public FsmString namedColor;
		public FsmColor color;
		public bool everyFrame;
	}
}
