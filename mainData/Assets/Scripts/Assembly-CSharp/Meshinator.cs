using UnityEngine;

public class Meshinator : MonoBehaviour
{
	public enum CacheOptions
	{
		None = 0,
		CacheAfterCollision = 1,
		CacheOnLoad = 2,
	}

	public enum ImpactShapes
	{
		FlatImpact = 0,
		SphericalImpact = 1,
	}

	public enum ImpactTypes
	{
		Compression = 0,
		Fracture = 1,
	}

	public CacheOptions m_CacheOption;
	public ImpactShapes m_ImpactShape;
	public ImpactTypes m_ImpactType;
	public float m_ForceResistance;
	public float m_MaxForcePerImpact;
	public float m_ForceMultiplier;
}
