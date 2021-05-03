using UnityEngine;

public class SimpleSmoothMouseLook : MonoBehaviour
{
	public Vector2 clampInDegrees;
	public bool lockCursor;
	public Vector2 sensitivity;
	public Vector2 smoothing;
	public Vector2 targetDirection;
	public Vector2 targetCharacterDirection;
	public GameObject characterBody;
}
