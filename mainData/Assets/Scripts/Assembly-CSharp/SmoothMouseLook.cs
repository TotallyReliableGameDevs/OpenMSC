using UnityEngine;

public class SmoothMouseLook : MonoBehaviour
{
	public enum RotationAxes
	{
		MouseXAndY = 0,
		MouseX = 1,
		MouseY = 2,
	}

	public RotationAxes axes;
	public float sensitivityX;
	public float sensitivityY;
	public float minimumX;
	public float maximumX;
	public float minimumY;
	public float maximumY;
	public float frameCounter;
}
