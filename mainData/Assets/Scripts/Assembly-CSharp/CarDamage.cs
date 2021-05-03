using UnityEngine;

public class CarDamage : MonoBehaviour
{
	public MeshCollider meshCollider;
	public MeshFilter[] meshFilters;
	public float deformNoise;
	public float deformRadius;
	public float bounceBackSpeed;
	public float maxDeform;
	public float minForce;
	public float multiplier;
	public float YforceDamp;
	public bool repair;
	public float sign;
}
