using System;
using UnityEngine;

[Serializable]
public class ThirdPersonController : MonoBehaviour
{
	public AnimationClip idleAnimation;
	public AnimationClip walkAnimation;
	public AnimationClip runAnimation;
	public AnimationClip jumpPoseAnimation;
	public float walkMaxAnimationSpeed;
	public float trotMaxAnimationSpeed;
	public float runMaxAnimationSpeed;
	public float jumpAnimationSpeed;
	public float landAnimationSpeed;
	public float walkSpeed;
	public float trotSpeed;
	public float runSpeed;
	public float inAirControlAcceleration;
	public float jumpHeight;
	public float gravity;
	public float speedSmoothing;
	public float rotateSpeed;
	public float trotAfterSeconds;
	public bool canJump;
}
