using UnityEngine;
using UnityStandardAssets.Utility;

namespace UnityStandardAssets.Characters.FirstPerson
{
	public class FirstPersonController : MonoBehaviour
	{
		[SerializeField]
		private bool m_IsWalking;
		[SerializeField]
		private float m_WalkSpeed;
		[SerializeField]
		private float m_RunSpeed;
		[SerializeField]
		private float m_RunstepLenghten;
		[SerializeField]
		private float m_JumpSpeed;
		[SerializeField]
		private float m_StickToGroundForce;
		[SerializeField]
		private float m_GravityMultiplier;
		[SerializeField]
		private MouseLook m_MouseLook;
		[SerializeField]
		private bool m_UseFovKick;
		[SerializeField]
		private FOVKick m_FovKick;
		[SerializeField]
		private bool m_UseHeadBob;
		[SerializeField]
		private CurveControlledBob m_HeadBob;
		[SerializeField]
		private LerpControlledBob m_JumpBob;
		[SerializeField]
		private float m_StepInterval;
		[SerializeField]
		private AudioClip[] m_FootstepSounds;
		[SerializeField]
		private AudioClip m_JumpSound;
		[SerializeField]
		private AudioClip m_LandSound;
	}
}
