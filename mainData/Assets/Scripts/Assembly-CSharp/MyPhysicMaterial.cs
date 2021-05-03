using System;
using UnityEngine;

[Serializable]
public class MyPhysicMaterial
{
	public PhysicMaterial physicMaterial;
	public float grip;
	public float rollingFriction;
	public float staticFriction;
	public bool isSkidSmoke;
	public bool isSkidMark;
	public bool isDirty;
	public CarDynamics.SurfaceType surfaceType;
}
