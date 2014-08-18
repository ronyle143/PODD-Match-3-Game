package com.poddcorp.candyfactory.api  
{
	import com.poddcorp.candyfactory.api.Constants;
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	//import com.adobe.serialization.json.JSON;
	
	public class GameData 
	{
		public function GameData(){
		}
		
		public static var 		saveDataObject	:SharedObject;
		
		public static var		score			:int		= 0;
		public static var		gauge			:int		= 0;
		public static var		multiplier		:int		= 1;
		
		public static var		production		:int		= 60;
		public static var		goal			:int		= 500;
		
		public static var		increment		:int		= 20;
		public static var		goalIncrement	:Number		= 1.5;
		public static var		timeMod			:Number		= Constants.GAME_TIME;
		
		public static var		useTaster		:int		= 3;
		
		public static function init():void 
		{

			/*var myRequest:URLRequest = new URLRequest("staff.txt");
			var myLoader:URLLoader = new URLLoader();
			myLoader.addEventListener(Event.COMPLETE, onload);
			myLoader.load(myRequest);

			function onload(evt:Event):void
			{
			var myData:Object = JSON.decode(myLoader.data);

			trace(myData.staff[0].firstName);
			}//*/
			saveDataObject = SharedObject.getLocal("CandyFactorySaveFile");
			
			score = 0;
			gauge = 0;
			multiplier = 1;
			production = 160;
			goal = 3200;
			useTaster = 3;
			useTaster = saveDataObject.data.UseTaster;
			timeMod = Constants.GAME_TIME;
		}
		
		public static function saveData():void {
			saveDataObject.data.UseTaster = useTaster;
			saveDataObject.flush();
		}
		
		public static function updateScore(x:int):int {
			var res:int = x * multiplier;
			score += res;
			checkGoal();
			return score
		}
		public static function getScore():int {
			return score;
		}
		
		public static function checkGauge():void 
		{
			//trace("checking goal: " + score + "/" + goal);
			if (gauge >= 50*multiplier) {
				increaseMultiplier();
				gauge = 0;
			}
		}
		
		static private function increaseMultiplier():void 
		{
			multiplier++;
		}
		
		public static function checkGoal():void 
		{
			//trace("checking goal: " + score + "/" + goal);
			if (score >= goal) {
				increaseGoal();
				increaseProduction();
			}
		}
		
		static private function increaseGoal():int 
		{
			goal = goal * goalIncrement;
			return goal;
		}
		
		public static function increaseProduction():int 
		{
			production += increment;
			
			//trace(goalIncrement);
			return production;
		}
	}

}