using UnityEngine;

namespace UnityStandardAssets.Effects
{
	public class Hose : MonoBehaviour
	{
		public float maxPower;
		public float minPower;
		public float changeSpeed;
		public ParticleSystem[] hoseWaterSystems;
		public Renderer systemRenderer;
	}
}
