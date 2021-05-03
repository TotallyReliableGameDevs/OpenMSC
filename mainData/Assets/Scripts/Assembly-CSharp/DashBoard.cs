using UnityEngine;

public class DashBoard : MonoBehaviour
{
	public enum Docking
	{
		Left = 0,
		Right = 1,
	}

	public enum SpeedoMeterType
	{
		RigidBody = 0,
		Wheel = 1,
	}

	public enum Unit
	{
		Kmh = 0,
		Mph = 1,
	}

	public int depth;
	public Texture2D tachoMeter;
	public bool tachoMeterDisabled;
	public Vector2 tachoMeterPosition;
	public Docking tachoMeterDocking;
	public float tachoMeterDimension;
	public Texture2D tachoMeterNeedle;
	public Vector2 tachoMeterNeedleSize;
	public float tachoMeterNeedleAngle;
	public float RPMFactor;
	public Texture2D speedoMeter;
	public bool speedoMeterDisabled;
	public Vector2 speedoMeterPosition;
	public Docking speedoMeterDocking;
	public float speedoMeterDimension;
	public Texture2D speedoMeterNeedle;
	public Vector2 speedoMeterNeedleSize;
	public float speedoMeterNeedleAngle;
	public float speedoMeterFactor;
	public SpeedoMeterType speedoMeterType;
	public Unit digitalSpeedoUnit;
	public GUIStyle digitalSpeedoStyle;
	public Vector2 digitalSpeedoPosition;
	public Docking digitalSpeedoDocking;
	public GUIStyle gearMonitorStyle;
	public Vector2 gearMonitorPosition;
	public Docking gearMonitorDocking;
	public Texture2D clutchMonitor;
	public Texture2D throttleMonitor;
	public Texture2D brakeMonitor;
	public Vector2 pedalsMonitorPosition;
	public Texture2D ABS;
	public Texture2D TCS;
	public Texture2D ESP;
	public Vector2 dashboardLightsPosition;
	public Docking dashboardLightsDocking;
	public float dashboardLightsDimension;
	public GameObject digitalSpeedoOnBoard;
	public GameObject digitalGearOnBoard;
	public GameObject tachoMeterNeedleOnBoard;
	public GameObject speedoMeterNeedleOnBoard;
	public bool showGUIDashboard;
	public CarController carController;
}
