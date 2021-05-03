using System;

namespace HutongGames.PlayMaker
{
	[Serializable]
	public class FsmVarOverride
	{
		public FsmVarOverride(FsmVarOverride source)
		{
		}

		public NamedVariable variable;
		public FsmVar fsmVar;
		public bool isEdited;
	}
}
