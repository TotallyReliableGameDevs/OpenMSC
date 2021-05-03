using HutongGames.PlayMaker;

public class MasterAudioGroupSetVolume : FsmStateAction
{
	public FsmBool allGroups;
	public FsmString soundGroupName;
	public FsmFloat volume;
	public bool everyFrame;
}
