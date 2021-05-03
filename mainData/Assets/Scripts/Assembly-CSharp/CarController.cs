using UnityEngine;

public class CarController : MonoBehaviour
{
	public float brake;
	public float throttle;
	public float steering;
	public bool brakeKey;
	public bool accelKey;
	public float steerInput;
	public float brakeInput;
	public float throttleInput;
	public float handbrakeInput;
	public float clutchInput;
	public bool startEngineInput;
	public bool smoothInput;
	public float throttleTime;
	public float throttleReleaseTime;
	public float maxThrottleInReverse;
	public float brakesTime;
	public float brakesReleaseTime;
	public float steerTime;
	public float steerReleaseTime;
	public float veloSteerTime;
	public float veloSteerReleaseTime;
	public float steerCorrectionFactor;
	public bool steerAssistance;
	public float SteerAssistanceMinVelocity;
	public bool TCS;
	public bool TCSTriggered;
	public float TCSAllowedSlip;
	public float TCSMinVelocity;
	public float externalTCSThreshold;
	public bool ABS;
	public bool ABSTriggered;
	public float ABSAllowedSlip;
	public float ABSMinVelocity;
	public bool ESP;
	public bool ESPTriggered;
	public float ESPStrength;
	public float ESPMinVelocity;
	public bool reverse;
}
