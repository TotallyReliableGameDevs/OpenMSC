using System;
using UnityEngine;

[Serializable]
public class IKControl : MonoBehaviour
{
	public Transform forearm;
	public Transform hand;
	public Transform target;
	public float transition;
	public float elbowAngle;
}
