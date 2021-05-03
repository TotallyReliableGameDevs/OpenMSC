using System;
using UnityEngine;

[Serializable]
public class SmoothFollow : MonoBehaviour
{
	public Transform target;
	public float distance;
	public float height;
	public float heightDamping;
	public float rotationDamping;
}
