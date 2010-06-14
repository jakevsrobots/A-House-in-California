package SWFStatsTest
{
	import flash.events.IOErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;

	public final class Get
	{
		public static const Random:Number = Math.random();
		private var Callback:Function;
		private var Loader:URLLoader;
		private var Mode:int; // 0 = general format, 1 = custom metric, 2 = level counter, 3 = level ranged, 4 = level average

		public function Get() { } 

		// ------------------------------------------------------------------------------
		// General stats
		// ------------------------------------------------------------------------------
		public static function General(type:String, callback:Function, day:int=0, month:int=0, year:int=0):void
		{
			Log.Output("SWFStats.Get.General  TYPE '" + type + "' CALLBACK '" + callback + "' DAY '" + day + "' MONTH '" + month + "' YEAR '" + year + "'");
			
			type = type.toLowerCase();
			
			if(type != "views" && type != "plays" && type != "playtime")
			{
				Log.Output("** ERROR GETTING GENERAL DATA **\n" + 
					   "    You passed a 'type' that is not valid..\n" + 
					   "    Valid types are:\n" + 
					   "       1) views\n" + 
					   "       2) plays\n" + 
					   "       3) playtime\n");
					   
				return;
			}

			var get:Get = new Get();
			get.Callback = callback;
			get.Mode = 0;
			get.Loader = new URLLoader();
			get.Loader.addEventListener(Event.COMPLETE, get.ProcessData);
			get.Loader.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler);
			get.Loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, StatusChange);
			get.Loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler);
			get.Loader.load(new URLRequest("http://utils.swfstats.com/data/" + type + ".aspx?swfid=" + Log.SWFID + "&guid=" + Log.GUID + "&day=" + day + "&month=" + month + "&year=" + year + "&" + Random));
		}

		public static function Goal(goalname:String, callback:Function, day:int=0, month:int=0, year:int=0):void
		{
			Log.Output("SWFStats.Get.Goal  GOALNAME '" + goalname + "' CALLBACK '" + callback + "' DAY '" + day + "' MONTH '" + month + "' YEAR '" + year + "'");

			var get:Get = new Get();
			get.Callback = callback;
			get.Mode = 1;
			get.Loader = new URLLoader();
			get.Loader.addEventListener(Event.COMPLETE, get.ProcessData);
			get.Loader.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler);
			get.Loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, StatusChange);
			get.Loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler);
			get.Loader.load(new URLRequest("http://utils.swfstats.com/data/goal.aspx?swfid=" + Log.SWFID + "&guid=" + Log.GUID + "&goal=" + escape(goalname) + "&day=" + day + "&month=" + month + "&year=" + year + "&" + Random));
		}
		
		public static function CustomMetric(metric:String, callback:Function, day:int=0, month:int=0, year:int=0):void
		{
			Log.Output("SWFStats.Get.CustomMetric  METRIC '" + metric + "' CALLBACK '" + callback + "' DAY '" + day + "' MONTH '" + month + "' YEAR '" + year + "'");

			var get:Get = new Get();
			get.Callback = callback;
			get.Mode = 1;
			get.Loader = new URLLoader();
			get.Loader.addEventListener(Event.COMPLETE, get.ProcessData);
			get.Loader.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler);
			get.Loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, StatusChange);
			get.Loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler);
			get.Loader.load(new URLRequest("http://utils.swfstats.com/data/custommetric.aspx?swfid=" + Log.SWFID + "&guid=" + Log.GUID + "&metric=" + escape(metric) + "&day=" + day + "&month=" + month + "&year=" + year + "&" + Random));
		}
		
		public static function LevelMetricCounter(metric:String, level:*, callback:Function, day:int=0, month:int=0, year:int=0):void
		{
			Log.Output("SWFStats.Get.LevelMetricCounter  METRIC '" + metric + "' LEVEL '" + level + "' CALLBACK '" + callback + "' DAY '" + day + "' MONTH '" + month + "' YEAR '" + year + "'");			
			LevelMetric("Counter", 2, metric, level, callback, day, month, year);
		}
		
		public static function LevelMetricRanged(metric:String, level:*, callback:Function, day:int=0, month:int=0, year:int=0):void
		{
			Log.Output("SWFStats.Get.LevelMetricRanged  METRIC '" + metric + "' LEVEL '" + level + "' CALLBACK '" + callback + "' DAY '" + day + "' MONTH '" + month + "' YEAR '" + year + "'");						
			LevelMetric("Ranged", 3, metric, level, callback, day, month, year);
		}
		
		public static function LevelMetricAverage(metric:String, level:*, callback:Function, day:int=0, month:int=0, year:int=0):void
		{
			Log.Output("SWFStats.Get.LevelMetricAverage  METRIC '" + metric + "' LEVEL '" + level + "' CALLBACK '" + callback + "' DAY '" + day + "' MONTH '" + month + "' YEAR '" + year + "'");						
			LevelMetric("Average", 4, metric, level, callback, day, month, year);
		}
		
		private static function LevelMetric(type:String, mode:int, metric:String, level:*, callback:Function, day:int=0, month:int=0, year:int=0):void
		{
			var get:Get = new Get();
			get.Callback = callback;
			get.Mode = mode;
			get.Loader = new URLLoader();
			get.Loader.addEventListener(Event.COMPLETE, get.ProcessData);
			get.Loader.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler);
			get.Loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, StatusChange);
			get.Loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler);
			get.Loader.load(new URLRequest("http://utils.swfstats.com/data/levelmetric" + type + ".aspx?swfid=" + Log.SWFID + "&guid=" + Log.GUID + "&metric=" + escape(metric) + "&level=" + level + "&day=" + day + "&month=" + month + "&year=" + year + "&" + Random));
		}

		// ------------------------------------------------------------------------------
		// Handling the responses
		// ------------------------------------------------------------------------------
		private function ProcessData(e:Event):void
		{
			Log.Output("SWFStats.Get.ProcessData");	

			var data:XML = new XML(e.target["data"]);

			switch(this.Mode)
			{
				case 0: case 1: // general stats: views, plays, play time, goals and custom metrics shares the same XML format
					this.Callback(data["name"], data["date"], int(data["value"]));
					return;

				case 2: // level counter
					this.Callback(data["name"], data["date"], data["level"], int(data["value"]));
					break;

				case 3: // level ranged
					var values:Array = new Array();
					var list:XMLList = data["value"];
					var n:XML;
					
					for each(n in list)
						values.push({Value: int(n.@trackvalue), Occurances: int(n)});	
				
					this.Callback(data["name"], data["date"], data["level"], values);
					break;

				case 4: // level average
					this.Callback(data["name"], data["date"], data["level"], int(data["value"]), int(data["max"]), int(data["min"]));				
					break;
			}
		}


		// ------------------------------------------------------------------------------
		// Error handling
		// ------------------------------------------------------------------------------
		private static function ErrorHandler(...args):void
		{
			Log.Output("** ERROR COMPLETING REQUEST ~ SWFStats.Get **");
		}
		
		private static function StatusChange(e:*):void
		{
		}		
	}
}