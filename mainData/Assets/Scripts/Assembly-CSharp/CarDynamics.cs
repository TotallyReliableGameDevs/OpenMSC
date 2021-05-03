using UnityEngine;

public class CarDynamics : MonoBehaviour
{
	public enum Controller
	{
		axis = 0,
		mouse = 1,
		mobile = 2,
		external = 3,
	}

	public enum SurfaceType
	{
		track = 0,
		grass = 1,
		sand = 2,
		offroad = 3,
		oil = 4,
	}

	public enum Tires
	{
		competition_front = 0,
		competition_rear = 1,
		supersport_front = 2,
		supersport_rear = 3,
		sport_front = 4,
		sport_rear = 5,
		touring_front = 6,
		touring_rear = 7,
		offroad_front = 8,
		offroad_rear = 9,
		truck_front = 10,
		truck_rear = 11,
	}

	public float factor;
	public float velo;
	public Controller controller;
	public CarController carController;
	public float transitionDamperVelo;
	public Transform centerOfMass;
	public float dampAbsRoadVelo;
	public float inertiaFactor;
	public float frontRearWeightRepartition;
	public float frontRearBrakeBalance;
	public float frontRearHandBrakeBalance;
	public bool enableForceFeedback;
	public float forceFeedback;
	public bool tridimensionalTire;
	public bool tirePressureEnabled;
	public float airDensity;
	public Skidmarks skidmarks;
	public MyPhysicMaterial[] physicMaterials;
	public float xlocalPosition;
	public float xlocalPosition_orig;
	public float zlocalPosition;
	public float zlocalPosition_orig;
	public float ylocalPosition;
	public float ylocalPosition_orig;
	public float fixedTimeStepScalar;
	public float invFixedTimeStepScalar;
}
