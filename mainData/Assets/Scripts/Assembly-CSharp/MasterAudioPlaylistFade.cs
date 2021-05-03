using HutongGames.PlayMaker;

public class MasterAudioPlaylistFade : FsmStateAction
{
	public FsmBool allPlaylistControllers;
	public FsmString playlistControllerName;
	public FsmFloat targetVolume;
	public FsmFloat fadeTime;
}
