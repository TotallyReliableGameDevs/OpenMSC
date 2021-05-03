using UnityEngine;

public class ES2Auto : MonoBehaviour
{
	[SerializeField]
	public bool saveOnDisable;
	[SerializeField]
	public bool saveOnInterval;
	[SerializeField]
	public float saveInterval;
	[SerializeField]
	public bool loadOnEnable;
	[SerializeField]
	public bool loadOnAwake;
	[SerializeField]
	public bool loadOnStart;
	[SerializeField]
	public bool isPlayMaker;
	[SerializeField]
	public string uniqueTag;
	[SerializeField]
	public bool savePosition;
	[SerializeField]
	public bool saveRotation;
	[SerializeField]
	public bool saveScale;
	[SerializeField]
	public bool saveMesh;
	[SerializeField]
	public bool saveSphereCollider;
	[SerializeField]
	public bool saveBoxCollider;
	[SerializeField]
	public bool saveCapsuleCollider;
	[SerializeField]
	public bool saveMeshCollider;
	[SerializeField]
	public string saveFile;
	[SerializeField]
	public ES2Settings.SaveLocation saveLocation;
	[SerializeField]
	public bool encrypt;
	[SerializeField]
	public string encryptionPassword;
	[SerializeField]
	public string webUsername;
	[SerializeField]
	public string webPassword;
}
