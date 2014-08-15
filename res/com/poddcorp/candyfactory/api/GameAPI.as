package com.poddcorp.candyfactory.api
{
	import com.poddcorp.candyfactory.api.Constants;
	
	public class GameAPI 
	{
		public function GameAPI() { 
			
		}
		
		public static var 		GameState		:int 		= Constants.GAME_STATE;
		public static var 		StateChange		:Boolean 	= true;
		static private var 		noteOn			:Boolean 	= true;
		public static var 		paused			:Boolean 	= false;
		public static var 		powerType		:String 	= "BURST";
		public static var		checktheMax		:Boolean	= false;
		public static var		checktheBlock	:Boolean	= false;
		public static var		difficulty		:int		= 3;
		
		public static function init():void 
		{
			paused = false;
			powerType = "BURST";
			checktheMax = false;
			checktheBlock = false;
		}
		
		public static function note(x:String, y:String):void {
				if (noteOn) {
				trace("["+x+"] - "+y+".");
				}
		}
	}

}