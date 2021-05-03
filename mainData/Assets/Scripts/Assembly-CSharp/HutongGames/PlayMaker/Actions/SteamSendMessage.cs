using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SteamSendMessage : FsmStateAction
	{
		public FsmString friendID;
		public FsmString message;
		public FsmBool send;
	}
}
