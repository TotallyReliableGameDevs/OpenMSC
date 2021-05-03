using UnityEngine;
using System;

namespace UnityStandardAssets.Utility
{
	public class TimedObjectActivator : MonoBehaviour
	{
		[Serializable]
		public class Entry
		{
			public GameObject target;
			public TimedObjectActivator.Action action;
			public float delay;
		}

		[Serializable]
		public class Entries
		{
			public TimedObjectActivator.Entry[] entries;
		}

		public enum Action
		{
			Activate = 0,
			Deactivate = 1,
			Destroy = 2,
			ReloadLevel = 3,
			Call = 4,
		}

		public Entries entries;
	}
}
