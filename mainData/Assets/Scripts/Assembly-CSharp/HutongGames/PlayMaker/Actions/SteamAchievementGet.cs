using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class SteamAchievementGet : FsmStateAction
	{
		public FsmString achievementId;
		public FsmString achievementName;
		public FsmString achievementDescription;
		public FsmBool achievementUnlocked;
	}
}
