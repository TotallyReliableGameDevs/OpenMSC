using HutongGames.PlayMaker;
using System.IO;

namespace HutongGames.PlayMaker.Actions
{
	public class GetFileInfoByIndex : FsmStateAction
	{
		public FsmString folderPath;
		public FsmString searchPattern;
		public SearchOption searchOption;
		public FsmInt fileIndex;
		public FsmString dateTimeFormat;
		public FsmString fileName;
		public FsmString extension;
		public FsmString fullName;
		public FsmString directoryName;
		public FsmBool isReadOnly;
		public FsmString creationTime;
		public FsmString lastAccessTime;
		public FsmString lastWriteTime;
		public FsmInt fileSize;
		public FsmEvent IndexOutOfRangeEvent;
	}
}
