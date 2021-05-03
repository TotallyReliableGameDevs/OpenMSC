using System;
using UnityEngine;

[Serializable]
public class deform_842 : MonoBehaviour
{
	public float minForce;
	public float multiplier;
	public float deformRadius;
	public float maxDeform;
	public float bounceBackSpeed;
	public float bounceBackSleepCap;
	public bool onCollision;
	public bool onCall;
	public bool updateCollider;
	public bool updateColliderOnBounce;
}
