using System;
using UnityEngine;

[Serializable]
public class IKLimb_BrunoFerreira : MonoBehaviour
{
	public enum HandRotations
	{
		KeepLocalRotation = 0,
		KeepGlobalRotation = 1,
		UseTargetRotation = 2,
	}

	public Transform upperArm;
	public Transform forearm;
	public Transform hand;
	public Transform target;
	public Transform elbowTarget;
	public bool IsEnabled;
	public bool debug;
	public float transition;
	public bool idleOptimization;
	public HandRotations handRotationPolicy;
}
