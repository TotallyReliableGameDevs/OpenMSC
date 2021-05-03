using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SetCursorMode : FsmStateAction
	{
		public enum RenderMode
		{
			Auto = 0,
			ForceSoftware = 1,
		}

		public enum CurState
		{
			None = 0,
			LockedToCenter = 1,
			ConfinedToGameWindow = 2,
		}

		public FsmObject cursorTexture;
		public FsmVector2 hotSpot;
		public RenderMode renderMode;
		public CurState lockMode;
		public FsmBool hideCursor;
	}
}
