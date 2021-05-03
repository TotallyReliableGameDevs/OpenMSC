using HutongGames.PlayMaker;

public class MasterAudioGroupFade : FsmStateAction
{
	public FsmBool allGroups;
	public FsmString soundGroupName;
	public FsmFloat targetVolume;
	public FsmFloat fadeTime;
}
