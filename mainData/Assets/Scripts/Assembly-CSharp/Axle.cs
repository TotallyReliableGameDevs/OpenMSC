using System;

[Serializable]
public class Axle
{
	public Wheel leftWheel;
	public Wheel rightWheel;
	public Wheel[] wheels;
	public bool powered;
	public float suspensionTravel;
	public float suspensionRate;
	public float bumpRate;
	public float reboundRate;
	public float fastBumpFactor;
	public float fastReboundFactor;
	public float antiRollBarRate;
	public float brakeFrictionTorque;
	public float handbrakeFrictionTorque;
	public float maxSteeringAngle;
	public float forwardGripFactor;
	public float sidewaysGripFactor;
	public float camber;
	public float caster;
	public float deltaCamber;
	public float oldCamber;
	public CarDynamics.Tires tires;
	public float tiresPressure;
	public float optimalTiresPressure;
}
