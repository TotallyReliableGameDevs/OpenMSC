using HutongGames.PlayMaker;

public class MasterAudioVariationChangePitch : FsmStateAction
{
	public FsmString soundGroupName;
	public FsmString variationName;
	public FsmBool changeAllVariations;
	public FsmFloat pitch;
	public bool everyFrame;
}
