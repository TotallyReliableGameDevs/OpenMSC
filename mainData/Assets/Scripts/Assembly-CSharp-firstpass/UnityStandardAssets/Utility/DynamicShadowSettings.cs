using UnityEngine;

namespace UnityStandardAssets.Utility
{
	public class DynamicShadowSettings : MonoBehaviour
	{
		public Light sunLight;
		public float minHeight;
		public float minShadowDistance;
		public float minShadowBias;
		public float maxHeight;
		public float maxShadowDistance;
		public float maxShadowBias;
		public float adaptTime;
	}
}
