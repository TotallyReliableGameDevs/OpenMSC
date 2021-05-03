using System;
using UnityEngine;

[Serializable]
public class MusicSetting
{
	public MasterAudio.AudioLocation audLocation;
	public AudioClip clip;
	public string songName;
	public string resourceFileName;
	public float volume;
	public float pitch;
	public bool isExpanded;
	public bool isLoop;
	public float customStartTime;
	public int lastKnownTimePoint;
	public int songIndex;
	public bool songStartedEventExpanded;
	public string songStartedCustomEvent;
	public bool songChangedEventExpanded;
	public string songChangedCustomEvent;
}
