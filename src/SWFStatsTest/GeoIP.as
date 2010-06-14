package SWFStatsTest
{
	import flash.events.IOErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;

	public class GeoIP
	{
		private static var Callback:Function;

		// ------------------------------------------------------------------------------
		// Retrieving score lists
		// ------------------------------------------------------------------------------
		public static function Lookup(callback:Function):void
		{
			Log.Output("SWFStats.GeoIP.Lookup  CALLBACK '" + callback + "'");

			Callback = callback;
				
			var sendaction:URLLoader = new URLLoader();
			sendaction.dataFormat = URLLoaderDataFormat.VARIABLES;
			sendaction.addEventListener(Event.COMPLETE, LookupFinished);
			sendaction.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler);
			sendaction.addEventListener(HTTPStatusEvent.HTTP_STATUS, StatusChange);
			sendaction.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler);
			sendaction.load(new URLRequest("http://utils.swfstats.com/geoip/Lookup.aspx?swfid=" + Log.SWFID + "&guid=" + Log.GUID));
		}


		// ------------------------------------------------------------------------------
		// Handling the responses
		// ------------------------------------------------------------------------------
		private static function LookupFinished(e:Event):void
		{
			Log.Output("SWFStats.GeoIP.LookupFinished");	
			
			var loader:URLLoader = e.target as URLLoader;
			
			Callback({Code: loader.data["code"], Name: loader.data["name"]});			
			Callback = null;
		}


		// ------------------------------------------------------------------------------
		// Error handling
		// ------------------------------------------------------------------------------
		private static function ErrorHandler(...args):void
		{
			Log.Output("** ERROR COMPLETING REQUEST ~ SWFStats.GeoIP **");
		}
		
		private static function StatusChange(e:*):void
		{
		}				
	}
}