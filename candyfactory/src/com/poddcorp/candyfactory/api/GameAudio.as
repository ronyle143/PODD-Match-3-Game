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
		static private var SoundPop : Class;
		
		[Embed(source="../../../../../../candyfactory_mobile/assets/audio/plop.mp3")]
		static private var SoundPlop : Class;
		
		[Embed(source="../../../../../../candyfactory_mobile/assets/audio/scoop-up.mp3")]
		static private var SoundScoopUp : Class;
		
		[Embed(source="../../../../../../candyfactory_mobile/assets/audio/swoosh.mp3")]
		static private var SoundSwoosh : Class;
		
		[Embed(source="../../../../../../candyfactory_mobile/assets/audio/kaboom.mp3")]
		static private var SoundKaboom : Class;
		
		[Embed(source="../../../../../../candyfactory_mobile/assets/audio/ice.mp3")]
		static private var SoundIce : Class;
		
		[Embed(source="../../../../../../candyfactory_mobile/assets/audio/increase.mp3")]
		static private var SoundIncrease : Class;
		
		[Embed(source="../../../../../../candyfactory_mobile/assets/audio/decrease.mp3")]
		static private var SoundDecrease : Class;
		
		[Embed(source="../../../../../../candyfactory_mobile/assets/audio/buy.mp3")]
		static private var SoundBuy : Class;
		
		[Embed(source="../../../../../../candyfactory_mobile/assets/audio/gameover.mp3")]
		static private var SoundGameOver : Class;
		
		[Embed(source="../../../../../../candyfactory_mobile/assets/audio/gameoverhigh.mp3")]
		static private var SoundGameOverHighScore : Class;
				
		//[Embed(source="../../../../../../candyfactory_mobile/assets/audio/ding.mp3")]
		//static private var SoundDing : Class;
		
		
		
		static private var sound:Sound;
		
		public static function playSound(snd:String,loop:Boolean = false):void 
		{
			switch (snd) 
			{
				case "pop":
					if (SFX) {
						sound = (new SoundPop) as Sound; 
						sound.play();
					}
				break;
				
				case "plop":
					if (SFX) {
						sound = (new SoundPlop) as Sound; 
						sound.play();
					}
				break;
				
				case "scoop-up":
					if (SFX) {
						sound = (new SoundScoopUp) as Sound; 
						sound.play();
					}
				break;
				
				case "swoosh":
					if (SFX) {
						sound = (new SoundSwoosh) as Sound; 
						sound.play();
					}
				break;
				
				case "kaboom":
					if (SFX) {
						sound = (new SoundKaboom) as Sound; 
						sound.play();
					}
				break;
				
				case "ice":
					if (SFX) {
						sound = (new SoundIce) as Sound; 
						sound.play();
					}
				break;
				
				case "increase":
					if (SFX) {
						sound = (new SoundIncrease) as Sound; 
						sound.play();
					}
				break;
				
				case "decrease":
					if (SFX) {
						sound = (new SoundDecrease) as Sound; 
						sound.play();
					}
				break;
				
				case "buy":
					if (SFX) {
						sound = (new SoundBuy) as Sound; 
						sound.play();
					}
				break;
				
				case "gameover":
					if (SFX) {
						sound = (new SoundGameOver) as Sound; 
						sound.play();
					}
				break;
				
				case "gameoverhighscore":
					if (SFX) {
						sound = (new SoundGameOverHighScore) as Sound; 
						sound.play();
					}
				break;
				
				
				/*case "ding":
					if (SFX) {
						sound = (new SoundDing) as Sound; 
						sound.play();
					}
				break;*/
				
				default:
			}
		}
	}

}