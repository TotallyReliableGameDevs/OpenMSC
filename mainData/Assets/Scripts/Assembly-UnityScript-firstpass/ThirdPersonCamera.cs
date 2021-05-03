using System;
using UnityEngine;

[Serializable]
public class ThirdPersonCamera : MonoBehaviour
{
	public Transform cameraTransform;
	public float distance;
	public float height;
	public float angularSmoothLag;
	public float angularMaxSpeed;
	public float heightSmoothLag;
	public float snapSmoothLag;
	public float snapMaxSpeed;
	public float clampHeadPositionScreenSpace;
	public float lockCameraTimeout;
}
