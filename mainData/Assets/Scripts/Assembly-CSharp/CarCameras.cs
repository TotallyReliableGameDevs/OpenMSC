using UnityEngine;

public class CarCameras : MonoBehaviour
{
	public enum Cameras
	{
		SmoothLookAt = 0,
		MouseOrbit = 1,
		FixedTo = 2,
		Map = 3,
	}

	public Cameras mycamera;
	public Transform target;
	public float distance;
	public float height;
	public float yawAngle;
	public float pitchAngle;
	public float rotationDamping;
	public float heightDamping;
	public bool dampFixedCamera;
	public bool mouseOrbitFixedCamera;
	public bool driverView;
	public float distanceMin;
	public float distanceMax;
	public float x;
	public float y;
	public Transform myTransform;
	public Transform mtarget;
}
