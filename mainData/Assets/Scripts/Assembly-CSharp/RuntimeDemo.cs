using UnityEngine;
using System;
using SWS;

public class RuntimeDemo : MonoBehaviour
{
	[Serializable]
	public class ExampleClass1
	{
		public GameObject walkerPrefab;
		public GameObject pathPrefab;
		public bool done;
	}

	[Serializable]
	public class ExampleClass2
	{
		public splineMove moveRef;
		public string pathName1;
		public string pathName2;
	}

	[Serializable]
	public class ExampleClass3
	{
		public splineMove moveRef;
	}

	[Serializable]
	public class ExampleClass4
	{
		public splineMove moveRef;
	}

	[Serializable]
	public class ExampleClass5
	{
		public splineMove moveRef;
	}

	[Serializable]
	public class ExampleClass6
	{
		public splineMove moveRef;
		public GameObject target;
		public bool done;
	}

	public ExampleClass1 example1;
	public ExampleClass2 example2;
	public ExampleClass3 example3;
	public ExampleClass4 example4;
	public ExampleClass5 example5;
	public ExampleClass6 example6;
}
