using System;
using System.Collections.Generic;
using UnityEngine;

namespace HutongGames.PlayMaker
{
	[Serializable]
	public class ActionData
	{
		[SerializeField]
		private List<string> actionNames;
		[SerializeField]
		private List<string> customNames;
		[SerializeField]
		private List<bool> actionEnabled;
		[SerializeField]
		private List<bool> actionIsOpen;
		[SerializeField]
		private List<int> actionStartIndex;
		[SerializeField]
		private List<int> actionHashCodes;
		[SerializeField]
		private List<UnityEngine.Object> unityObjectParams;
		[SerializeField]
		private List<FsmGameObject> fsmGameObjectParams;
		[SerializeField]
		private List<FsmOwnerDefault> fsmOwnerDefaultParams;
		[SerializeField]
		private List<FsmAnimationCurve> animationCurveParams;
		[SerializeField]
		private List<FunctionCall> functionCallParams;
		[SerializeField]
		private List<FsmTemplateControl> fsmTemplateControlParams;
		[SerializeField]
		private List<FsmEventTarget> fsmEventTargetParams;
		[SerializeField]
		private List<FsmProperty> fsmPropertyParams;
		[SerializeField]
		private List<LayoutOption> layoutOptionParams;
		[SerializeField]
		private List<FsmString> fsmStringParams;
		[SerializeField]
		private List<FsmObject> fsmObjectParams;
		[SerializeField]
		private List<FsmVar> fsmVarParams;
		[SerializeField]
		private List<byte> byteData;
		[SerializeField]
		private List<int> arrayParamSizes;
		[SerializeField]
		private List<string> arrayParamTypes;
		[SerializeField]
		private List<int> customTypeSizes;
		[SerializeField]
		private List<string> customTypeNames;
		[SerializeField]
		private List<ParamDataType> paramDataType;
		[SerializeField]
		private List<string> paramName;
		[SerializeField]
		private List<int> paramDataPos;
		[SerializeField]
		private List<int> paramByteDataSize;
	}
}
