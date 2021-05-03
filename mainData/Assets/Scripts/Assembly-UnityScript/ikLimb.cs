using System;
using UnityEngine;

[Serializable]
public class ikLimb : MonoBehaviour
{
	public Transform upperArm;
	public Transform forearm;
	public Transform hand;
	public Transform target;
	public Transform elbowTarget;
	public bool IsEnabled;
	public bool debug;
	public float transition;
}
