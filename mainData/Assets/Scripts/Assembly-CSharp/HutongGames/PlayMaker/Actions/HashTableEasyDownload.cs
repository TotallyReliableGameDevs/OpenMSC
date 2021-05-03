using HutongGames.PlayMaker;

namespace HutongGames.PlayMaker.Actions
{
	public class HashTableEasyDownload : HashTableActions
	{
		public FsmOwnerDefault gameObject;
		public FsmString reference;
		public FsmString uniqueTag;
		public FsmString saveFile;
		public FsmString localFile;
		public FsmString urlToPHPFile;
		public FsmString username;
		public FsmString password;
		public FsmEvent isDownloaded;
		public FsmEvent isError;
		public FsmString errorMessage;
		public FsmString errorCode;
	}
}
