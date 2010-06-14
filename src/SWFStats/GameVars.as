package SWFStats
{
	import flash.events.IOErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;

	public final class GameVars
	{
		private static const Random:Number = Math.random();
		private static var Callback:Function = null;

		public function GameVars() { } 

		public static function Load(callback:Function):void
		{
			if(Callback != null)
				return;

			Callback = callback;

			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, ProcessData);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, StatusChange);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler);
			loader.load(new URLRequest("http://utils.swfstats.com/gamevars/load.aspx?swfid=" + Log.SWFID + "&guid=" + Log.GUID + "&" + Random));
		}

		private static function ProcessData(e:Event):void
		{
			var data:XML = XML(e.target["data"]);
			var entries:XMLList = data["var"];
			var object:Object = new Object();
			var name:String;
			var value:String;

			for each(var item:XML in entries) 
			{
				name = item["name"];
				value = item["value"];
				
				object[name] = value;
			}
			
			Callback(object);
			Callback = null;
		}

		private static function ErrorHandler(...args):void
		{
			Callback(null);
			Callback = null;
		}
		
		private static function StatusChange(e:*):void
		{
		}		
	}
}