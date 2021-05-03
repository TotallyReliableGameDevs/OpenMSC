using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class CInputChangeKey : FsmStateAction
	{
		public FsmString actionName;
		public FsmInt index;
		public FsmInt input;
		public FsmBool allowDuplicates;
		public FsmBool allowMouseAxis;
		public FsmBool allowMouseButtons;
		public FsmBool allowGamepadAxis;
		public FsmBool allowGamepadButtons;
		public FsmBool allowKeyboard;
		public FsmEvent keyChangedEvent;
	}
}
