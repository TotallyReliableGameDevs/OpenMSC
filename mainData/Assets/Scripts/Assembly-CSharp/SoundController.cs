using UnityEngine;

public class SoundController : MonoBehaviour
{
	public AudioClip engineThrottle;
	public float engineThrottleVolume;
	public float engineThrottlePitchFactor;
	public AudioClip engineNoThrottle;
	public float engineNoThrottleVolume;
	public float engineNoThrottlePitchFactor;
	public AudioClip startEngine;
	public float startEngineVolume;
	public float startEnginePitch;
	public GameObject enginePosition;
	public AudioClip transmission;
	public float transmissionVolume;
	public float transmissionVolumeReverse;
	public float transmissionSourcePitch;
	public AudioClip brakeNoise;
	public float brakeNoiseVolume;
	public AudioClip skid;
	public float skidVolume;
	public float skidPitchFactor;
	public AudioClip crashHiSpeed;
	public float crashHighVolume;
	public AudioClip crashLowSpeed;
	public float crashLowVolume;
	public AudioClip scrapeNoise;
	public float scrapeNoiseVolume;
	public AudioClip ABSTrigger;
	public float ABSTriggerVolume;
	public AudioClip shiftTrigger;
	public float shiftTriggerVolume;
	public AudioClip wind;
	public float windVolume;
	public AudioClip rollingNoiseGrass;
	public AudioClip rollingNoiseSand;
	public AudioClip rollingNoiseOffroad;
	public CarController carController;
}
