using HutongGames.PlayMaker;

public class MasterAudioBusSetVolume : FsmStateAction
{
	public FsmBool allBuses;
	public FsmString busName;
	public FsmFloat volume;
	public bool everyFrame;
}
