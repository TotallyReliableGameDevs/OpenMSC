using UnityEngine;

public class Deformable : MonoBehaviour
{
	public MeshFilter meshFilter;
	public float Hardness;
	public bool DeformMeshCollider;
	public float UpdateFrequency;
	public float MaxVertexMov;
	public Color32 DeformedVertexColor;
	public Texture2D HardnessMap;
}
