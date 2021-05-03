using UnityEngine;

namespace UnityStandardAssets.Utility
{
	public class SimpleMouseRotator : MonoBehaviour
	{
		public Vector2 rotationRange;
		public float rotationSpeed;
		public float dampingTime;
		public bool autoZeroVerticalOnMobile;
		public bool autoZeroHorizontalOnMobile;
		public bool relative;
	}
}
