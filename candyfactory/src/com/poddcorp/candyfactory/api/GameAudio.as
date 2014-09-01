package com.poddcorp.candyfactory.api
{
	import flash.media.Sound;
	import starling.errors.AbstractClassError;
	public class GameAudio 
	{
		public function GameAudio() { 
			throw new AbstractClassError();
		}
		
		public static var SFX:Boolean = Constants.GAME_SFX;
		public static var BGM:Boolean = Constants.GAME_BMG;
		
		
		
		[Embed(source="../../../../../../candyfactory_mobile/assets/audio/pop.mp3")]
		static private var MySound : Class;
		static private var sound:Sound;
		
		public static function playSound(snd:String,loop:Boolean = false):void 
		{
			switch (snd) 
			{
				case "pop":
					if (SFX) {
						sound = (new MySound) as Sound; 
						sound.play();
					}
				break;
				default:
			}
		}
	}

}