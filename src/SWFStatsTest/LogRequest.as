package SWFStatsTest
{
	import flash.events.Event;	
	import flash.events.IOErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public final class LogRequest
	{
		private var Data:String = "";
		private var Pieces:int;
		private var Retries:int = 0;		
		public var Ready:Boolean = false;

		public function LogRequest()
		{
		}

		public function Queue(data:String):void
		{
			this.Pieces++;
			this.Data += (this.Data == "" ? "" : "~") + data;

			if(this.Pieces == 8 || this.Data.length > 300)
			{
				this.Ready = true;
			}
		}

		public function Send():void
		{
			trace("Sending events");
			var sendaction:URLLoader = new URLLoader();
			sendaction.addEventListener(Event.COMPLETE, this.Complete);
			sendaction.addEventListener(IOErrorEvent.IO_ERROR, this.IOErrorHandler);
			sendaction.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.StatusChange);
			sendaction.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.SecurityErrorHandler);
			sendaction.load(new URLRequest("http://trackertest.swfstats.com/Games/q.aspx?guid=" + Log.GUID + "&swfid=" + Log.SWFID + "&q=" + this.Data + "&url=" + Log.SourceUrl + "&" + Math.random() + "z"));
		}
		
		private function Complete(e:Event):void
		{
			var loader:URLLoader = e.target as URLLoader;
			trace("--------------------------------------------\n" + loader["data"]);
		}
		
		private function Retry():void
		{
			this.Retries++;
			
			if(this.Retries == 3)
			{
				trace("Disabling API");
				Log.Enabled = false;
			}
			else if(Log.Enabled)
			{
				trace("Retrying (#" + this.Retries + ")");
				this.Send();
			}
		}
		
		private function IOErrorHandler(e:IOErrorEvent):void
		{
			this.Retry();
		}

		private function SecurityErrorHandler(e:SecurityErrorEvent):void
		{
			this.Retry();
		}

		private function StatusChange(e:HTTPStatusEvent):void
		{
		}
	}
}