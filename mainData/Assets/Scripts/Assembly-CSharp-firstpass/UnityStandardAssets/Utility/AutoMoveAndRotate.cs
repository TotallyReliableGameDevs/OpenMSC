using UnityEngine;
using System;

namespace UnityStandardAssets.Utility
{
	public class AutoMoveAndRotate : MonoBehaviour
	{
		[Serializable]
		public class Vector3andSpace
		{
			public Vector3 value;
			public Space space;
		}

		public Vector3andSpace moveUnitsPerSecond;
		public Vector3andSpace rotateDegreesPerSecond;
		public bool ignoreTimescale;
	}
}
