using UnityEngine;

public class UploadDownloadTexture : MonoBehaviour
{
	public enum Mode
	{
		Upload = 0,
		Download = 1,
	}

	public Mode mode;
	public string url;
	public string filename;
	public string textureTag;
	public string webUsername;
	public string webPassword;
}
