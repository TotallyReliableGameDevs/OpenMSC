using UnityEngine;
using System;

public class SimpleIKSolver : MonoBehaviour
{
	[Serializable]
	public class AngleRestriction
	{
		public bool xAxis;
		public float xMin;
		public float xMax;
		public bool yAxis;
		public float yMin;
		public float yMax;
		public bool zAxis;
		public float zMin;
		public float zMax;
	}

	[Serializable]
	public class JointEntity
	{
		public Transform Joint;
		public SimpleIKSolver.AngleRestriction AngleRestrictionRange;
	}

	public bool IsActive;
	public Transform Target;
	public JointEntity[] JointEntities;
	public bool IsDamping;
	public float DampingMax;
}
