using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class DuplicateMaterial : FsmStateAction
	{
		public FsmString material_name;
		public FsmMaterial material;
		public FsmMaterial new_material;
	}
}
