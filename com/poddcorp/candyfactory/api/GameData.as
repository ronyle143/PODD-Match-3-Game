package api  
{
	import api.Constants;
	
	public class GameData 
	{
		public function GameData(){
			
		}
		
		public static var		score			:int		= 0;
		public static var		gauge			:int		= 0;
		public static var		multiplier		:int		= 1;
		public static var		production		:int		= 50;
		public static var		goal			:int		= 500;
			
		
		public static function init():void 
		{
			score = 0;
			gauge = 0;
			multiplier = 1;
			production = 50;
			goal = 500;
		}
		
		
		public static function updateScore(x:int):int {
			var res:int = x * multiplier;
			score += res;
			return score
		}
		public static function getScore():int {
			return score;
		}
		
		public static function checkGoal():void 
		{
			
		}
		
		public static function increaseProduction():int 
		{
			production += 10;
			return production;
		}
	}

}