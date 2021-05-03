using UnityEngine;

public class RegPlateGen : MonoBehaviour
{
	public Texture2D RegPlateBlank;
	public Texture2D RegPlateAtlas;
	public string PlateString;
	public bool GenerateOnStart;
	public bool UseFilter;
	public bool AllowLeadingZero;
	public bool AdjustCharColor;
	public float BrightnessChar;
	public float ContrastChar;
	public Color TintChar;
	public bool AdjustBgColor;
	public float BrightnessBg;
	public float ContrastBg;
	public Color TintBg;
	public bool SaveToFile;
	public string PlateFileName;
}
