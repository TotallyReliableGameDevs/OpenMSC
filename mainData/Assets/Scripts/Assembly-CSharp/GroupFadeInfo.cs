using System;

[Serializable]
public class GroupFadeInfo
{
	public MasterAudioGroup ActingGroup;
	public string NameOfGroup;
	public float TargetVolume;
	public float VolumeStep;
	public bool IsActive;
}
