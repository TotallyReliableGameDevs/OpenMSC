using HutongGames.PlayMaker;

public class MasterAudioBusFade : FsmStateAction
{
	public FsmBool allBuses;
	public FsmString busName;
	public FsmFloat targetVolume;
	public FsmFloat fadeTime;
}
