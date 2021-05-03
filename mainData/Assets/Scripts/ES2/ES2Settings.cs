public class ES2Settings
{
	public enum OptimizeMode
	{
		Fast = 0,
		LowMemory = 1,
	}

	public enum Format
	{
		Binary = 0,
	}

	public enum ES2FileMode
	{
		Create = 0,
		Append = 1,
		Open = 2,
	}

	public enum SaveLocation
	{
		PlayerPrefs = 0,
		File = 1,
		Resources = 2,
		Memory = 3,
	}

	public SaveLocation saveLocation;
	public OptimizeMode optimizeMode;
	public Format format;
	public bool encrypt;
	public string encryptionPassword;
	public string webUsername;
	public string webPassword;
	public string webFilename;
	public bool saveNormals;
	public bool saveUV;
	public bool saveUV2;
	public bool saveTangents;
	public bool saveSubmeshes;
	public bool saveSkinning;
	public bool saveColors;
	public byte meshSettingsCount;
	public string name;
	public ES2FileMode fileMode;
	public int bufferSize;
}
