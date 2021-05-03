using System;
using UnityEngine;
using System.Collections.Generic;

namespace HutongGames.PlayMaker
{
	[Serializable]
	public class Fsm
	{
		[SerializeField]
		private FsmTemplate usedInTemplate;
		[SerializeField]
		private string name;
		[SerializeField]
		private string startState;
		[SerializeField]
		private FsmState[] states;
		[SerializeField]
		private FsmEvent[] events;
		[SerializeField]
		private FsmTransition[] globalTransitions;
		[SerializeField]
		private FsmVariables variables;
		[SerializeField]
		private string description;
		[SerializeField]
		private string docUrl;
		[SerializeField]
		private bool showStateLabel;
		[SerializeField]
		private int maxLoopCount;
		[SerializeField]
		private string watermark;
		public int version;
		public List<FsmEvent> ExposedEvents;
		public bool RestartOnEnable;
		public bool EnableDebugFlow;
		public bool StepFrame;
		[SerializeField]
		private string activeStateName;
	}
}
