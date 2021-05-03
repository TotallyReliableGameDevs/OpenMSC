using System;
using UnityEngine.Audio;

[Serializable]
public class GroupBus
{
	public string busName;
	public float volume;
	public bool isSoloed;
	public bool isMuted;
	public int voiceLimit;
	public bool stopOldest;
	public bool isExisting;
	public AudioMixerGroup mixerChannel;
}
