package SWFStatsTest
{
	import flash.events.IOErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	public class HighScores
	{
		private static var ScoresCallback:Function;
		private static var FacebookScoresCallback:Function;
		private static var SubmitCallback:Function;

		// ------------------------------------------------------------------------------
		// Retrieving score lists
		// ------------------------------------------------------------------------------
		public static function Scores(global:Boolean, table:String, callback:Function, mode:String = "alltime"):void
		{
			Log.Output("SWFStats.HighScores.List  GLOBAL: '" + global + "', TABLE '" + table + "', MODE '" + mode + "', CALLBACK '" + callback + "'");

			ScoresCallback = callback;
				
			var sendaction:URLLoader = new URLLoader();
			sendaction.addEventListener(Event.COMPLETE, ScoresFinished);
			sendaction.addEventListener(IOErrorEvent.IO_ERROR, ScoresError);
			sendaction.addEventListener(HTTPStatusEvent.HTTP_STATUS, StatusChange);
			sendaction.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ScoresError);
			sendaction.load(new URLRequest("http://utils.swfstats.com/leaderboards/get.aspx?guid=" + Log.GUID + "&swfid=" + Log.SWFID + "&url=" + (global || Log.SourceUrl == null ? "global" : Log.SourceUrl) + "&table=" + table + "&mode=" + mode + "&" + Math.random()));
			
			trace("http://utils.swfstats.com/leaderboards/get.aspx?guid=" + Log.GUID + "&swfid=" + Log.SWFID + "&url=" + (global || Log.SourceUrl == null ? "global" : Log.SourceUrl) + "&table=" + table + "&" + Math.random());
		}

		public static function FacebookScores(table:String, callback:Function, friendlist:Array = null, mode:String = "alltime"):void
		{
			Log.Output("SWFStats.HighScores.ListFacebook  TABLE '" + table + "', CALLBACK '" + callback + "', FRIENDSLIST '" + (friendlist != null ? friendlist.join(",") : "") + ", MODE '" + mode + "'");

			FacebookScoresCallback = callback;
				
			var sendaction:URLLoader = new URLLoader();
			sendaction.addEventListener(Event.COMPLETE, FacebookScoresFinished);
			sendaction.addEventListener(IOErrorEvent.IO_ERROR, FacebookScoresError);
			sendaction.addEventListener(HTTPStatusEvent.HTTP_STATUS, StatusChange);
			sendaction.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ScoresError);
			sendaction.load(new URLRequest("http://utils.swfstats.com/leaderboards/getfb.aspx?guid=" + Log.GUID + "&swfid=" + Log.SWFID + "&table=" + table + "&friendlist=" + (friendlist != null ? friendlist.join(",") : "") + "&mode=" + mode + "&" + Math.random()));
		}


		// ------------------------------------------------------------------------------
		// Submitting a score
		// ------------------------------------------------------------------------------
		public static function Submit(name:String, score:int, table:String, callback:Function, facebook:Boolean = false):void
		{
			Log.Output("SWFStats.HighScores.Submit  NAME '" + name + "', SCORE " + score + ", TABLE '" + table + "', FACEBOOK '" + facebook + "'");

			SubmitCallback = callback;
				
			var sendaction:URLLoader = new URLLoader();
			sendaction.addEventListener(Event.COMPLETE, SubmitFinished);
			sendaction.addEventListener(IOErrorEvent.IO_ERROR, SubmitError);
			sendaction.addEventListener(HTTPStatusEvent.HTTP_STATUS, StatusChange);
			sendaction.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ScoresError);
			sendaction.load(new URLRequest("http://utils.swfstats.com/leaderboards/save.aspx?guid=" + Log.GUID + "&swfid=" + Log.SWFID + "&url=" + Log.SourceUrl + "&table=" + table + "&name=" + name + "&score=" + score + "&auth=" + Encode.MD5(Log.SourceUrl + score.toString()) + "&fb=" + (facebook ? "1" : "0") + "&r=" + Math.random()));
		}


		// ------------------------------------------------------------------------------
		// Handling the responses
		// ------------------------------------------------------------------------------
		private static function ScoresFinished(e:Event):void
		{
			Log.Output("SWFStats.HighScores.ScoresFinished");	
			ScoresCallback(ProcessScores(e.target as URLLoader));
			ScoresCallback = null;
		}

		private static function ScoresError(e:Event):void
		{
			Log.Output("SWFStats.HighScores.ScoresError");	
			ScoresCallback(null);
			ScoresCallback = null;
		}

		private static function FacebookScoresFinished(e:Event):void
		{
			Log.Output("SWFStats.HighScores.FacebookScoresFinished");	
			FacebookScoresCallback(ProcessScores(e.target as URLLoader));
			FacebookScoresCallback = null;
		}

		private static function FacebookScoresError(e:Event):void
		{
			Log.Output("SWFStats.HighScores.FacebookScoresError");	
			FacebookScoresCallback(null);
			FacebookScoresCallback = null;
		}
		
		private static function SubmitFinished(e:Event):void
		{
			Log.Output("SWFStats.HighScores.SubmitFinished");	

			if(SubmitCallback == null)
				return;

			SubmitCallback((e.target as URLLoader).data == "true");
			SubmitCallback = null;
		}

		private static function SubmitError(e:Event):void
		{
			Log.Output("SWFStats.HighScores.SubmitError");	

			SubmitCallback(false);
			SubmitCallback = null;
		}

		// ------------------------------------------------------------------------------
		// Processing scores
		// ------------------------------------------------------------------------------
		private static function ProcessScores(loader:URLLoader):Array
		{
			Log.Output("SWFStats.HighScores.ProcessScores");	
			
			var data:XML = XML(loader["data"]);
			var entries:XMLList = data["entry"];
			var results:Array = new Array();
			var datestring:String;
			var year:int;
			var month:int;
			var day:int;
			var date:Date = new Date();
			
			for each(var item:XML in entries) 
			{
				datestring = item["sdate"];				
				year = int(datestring.substring(datestring.lastIndexOf("/") + 1));
				month = int(datestring.substring(0, datestring.indexOf("/")));
				day = int(datestring.substring(datestring.indexOf("/" ) + 1).substring(0, 2));
				date.setFullYear(year, month, day);

				results.push({Name: item["name"], Points: item["points"], Website: item["website"], Rank: results.length+1, SDate: date});
			}

			return results;
		}


		// ------------------------------------------------------------------------------
		// Error handling
		// ------------------------------------------------------------------------------
		private static function StatusChange(...args):void
		{
		}
	}
}