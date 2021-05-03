using System;
using System.Collections.Generic;
using UnityEngine;

namespace SWS
{
	[Serializable]
	public class MessageOptions
	{
		public enum ValueType
		{
			None = 0,
			Object = 1,
			Text = 2,
			Numeric = 3,
			Vector2 = 4,
			Vector3 = 5,
		}

		public List<string> message;
		public List<UnityEngine.Object> obj;
		public List<string> text;
		public List<float> num;
		public List<Vector2> vect2;
		public List<Vector3> vect3;
		public List<MessageOptions.ValueType> type;
		public float pos;
	}
}
