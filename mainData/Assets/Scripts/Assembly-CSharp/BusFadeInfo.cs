using System;

[Serializable]
public class BusFadeInfo
{
	public string NameOfBus;
	public GroupBus ActingBus;
	public float TargetVolume;
	public float VolumeStep;
	public bool IsActive;
}
