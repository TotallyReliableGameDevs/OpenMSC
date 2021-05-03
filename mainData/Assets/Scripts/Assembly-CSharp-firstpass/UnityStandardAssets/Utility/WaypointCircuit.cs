using UnityEngine;
using System;

namespace UnityStandardAssets.Utility
{
	public class WaypointCircuit : MonoBehaviour
	{
		[Serializable]
		public class WaypointList
		{
			public WaypointCircuit circuit;
			public Transform[] items;
		}

		public WaypointList waypointList;
		[SerializeField]
		private bool smoothRoute;
		public float editorVisualisationSubsteps;
	}
}
