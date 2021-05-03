using HutongGames.PlayMaker;

public class MasterAudioPlaySound : FsmStateAction
{
	public FsmOwnerDefault gameObject;
	public FsmString soundGroupName;
	public FsmString variationName;
	public FsmFloat volume;
	public FsmFloat delaySound;
	public FsmBool useThisLocation;
	public FsmBool attachToGameObject;
	public FsmBool useFixedPitch;
	public FsmFloat fixedPitch;
}
