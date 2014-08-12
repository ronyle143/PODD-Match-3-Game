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
		public static var		increment		:int		= 30;
		
		public static function init():void 
		{
			score = 0;
			gauge = 0;
			multiplier = 1;
			production = 60;
			goal = 500;
			increment = 30;
			
		}
		
		
		
		public static function updateScore(x:int):int {
			var res:int = x * multiplier;
			score += res;
			return score
		}
		public static function getScore():int {
			return score;
		}
		
		public static function checkGauge():void 
		{
			//trace("checking goal: " + score + "/" + goal);
			if (gauge >= 100) {
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
			goal = goal * 1.5;
			return goal;
		}
		
		public static function increaseProduction():int 
		{
			production += increment;
			return production;
		}
	}

}