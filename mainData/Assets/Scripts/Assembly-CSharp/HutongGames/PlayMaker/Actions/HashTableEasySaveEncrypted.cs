using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class HashTableEasySaveEncrypted : HashTableActions
	{
		public FsmOwnerDefault gameObject;
		public FsmString reference;
		public FsmString uniqueTag;
		public FsmBool encryption;
		public FsmString password;
		public FsmString saveFile;
	}
}
