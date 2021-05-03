using System;
using UnityEngine;

[Serializable]
public class S_Deformable : MonoBehaviour
{
	public MeshFilter meshFilter;
	public float Hardness;
	public bool DeformMeshCollider;
	public float UpdateFrequency;
	public float MaxVertexMov;
	public Color32 DeformedVertexColor;
	public Texture2D HardnessMap;
}
