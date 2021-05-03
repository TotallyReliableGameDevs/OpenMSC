using UnityEngine;
using System;

namespace UnityStandardAssets.Utility
{
	public class AutoMobileShaderSwitch : MonoBehaviour
	{
		[Serializable]
		public class ReplacementDefinition
		{
			public Shader original;
			public Shader replacement;
		}

		[Serializable]
		public class ReplacementList
		{
			public AutoMobileShaderSwitch.ReplacementDefinition[] items;
		}

		[SerializeField]
		private ReplacementList m_ReplacementList;
	}
}
