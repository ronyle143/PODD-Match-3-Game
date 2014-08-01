package   
{
	import starling.errors.AbstractClassError;
	public class GameAudio 
	{
		public function GameAudio() { 
			throw new AbstractClassError();
		}
		
		public static var SFX:Boolean = Constants.GAME_SFX;
		public static var BGM:Boolean = Constants.GAME_BMG;
	}

}