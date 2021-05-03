using System;
using UnityEngine;

namespace HutongGames.PlayMaker
{
	[Serializable]
	public class FsmEvent
	{
		public FsmEvent(string name)
		{
		}

		[SerializeField]
		private string name;
		[SerializeField]
		private bool isSystemEvent;
		[SerializeField]
		private bool isGlobal;
	}
}
