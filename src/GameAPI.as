package  
{
	public class GameAPI 
	{
		public function GameAPI() { 
			
		}
		
		public static var 		GameState		:int 		= Constants.GAME_STATE;
		public static var 		StateChange		:Boolean 	= true;
		static private var 		noteOn			:Boolean 	= true;
		public static var 		paused			:Boolean 	= false;
		
		public static function Note(x:String, y:String):void {
				if (noteOn) {
				trace("["+x+"] - "+y+".");
				}
		}
	}

}