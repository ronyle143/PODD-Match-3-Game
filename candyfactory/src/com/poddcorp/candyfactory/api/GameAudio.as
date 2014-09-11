package com.poddcorp.candyfactory.api
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import starling.errors.AbstractClassError;
	import starling.events.Event;
	import starling.events.EnterFrameEvent;
	import starling.extensions.SoundManager;
	
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
				
		[Embed(source="../../../../../../candyfactory_mobile/assets/audio/tick.mp3")]
		static private var SoundTick : Class;
		
		[Embed(source="../../../../../../candyfactory_mobile/assets/audio/FreedomDance.mp3")]
		static private var SoundMain : Class;
		
		
		static private var sound:Sound;
		static private var bgm:Sound;
		static private var myChannel:SoundChannel = new SoundChannel();
		static private var lastPosition:Number = 0;
		static private var soundManager:SoundManager;
		
		public static function init():void 
		{
			soundManager = new SoundManager();
			var music1:Sound = (new SoundMain) as Sound; 
			soundManager.addSound("music1", music1 );
			soundManager.playSound("music1", 1, 9999);
			
			GameAPI.note("!", "SoundManager initialized");
			
			sound = (new SoundPop) as Sound;
				soundManager.addSound("pop", sound );
			sound = (new SoundPlop) as Sound;
				soundManager.addSound("plop", sound );
			sound = (new SoundScoopUp) as Sound; 
				soundManager.addSound("scoop-up", sound );
			sound = (new SoundSwoosh) as Sound; 
				soundManager.addSound("swoosh", sound );
			sound = (new SoundKaboom) as Sound; 
				soundManager.addSound("kaboom", sound );
			sound = (new SoundIce) as Sound; 
				soundManager.addSound("ice", sound );
			sound = (new SoundIncrease) as Sound; 
				soundManager.addSound("increase", sound );
			sound = (new SoundDecrease) as Sound; 
				soundManager.addSound("decrease", sound );
			sound = (new SoundBuy) as Sound; 
				soundManager.addSound("buy", sound );
			sound = (new SoundGameOver) as Sound; 
				soundManager.addSound("gameover", sound );
			sound = (new SoundGameOverHighScore) as Sound;
				soundManager.addSound("gameoverhighscore", sound );
			sound = (new SoundTick) as Sound;
				soundManager.addSound("tick", sound );
		}
		
		public static function playBGM():void 
		{
			soundManager.setVolume("music1", 1);
		}
		
		public static function stopBGM():void 
		{
			soundManager.setVolume("music1", 0);
		}
		
		public static function playSound(snd:String):void 
		{
			if(SFX){
				switch (snd) 
				{
					case "pop":
						soundManager.playSound("pop", 1, 1);
					break;
					
					case "plop":
						soundManager.playSound("plop", 1, 1);
					break;
					
					case "scoop-up":
						soundManager.playSound("scoop-up", 1, 1);
					break;
					
					case "swoosh":
						soundManager.playSound("swoosh", 1, 1);
					break;
					
					case "kaboom":
						soundManager.playSound("kaboom", 1, 1);
					break;
					
					case "ice":
						soundManager.playSound("ice", 1, 1);
					break;
					
					case "increase":
						soundManager.playSound("increase", 1, 1);
					break;
					
					case "decrease":
						soundManager.playSound("decrease", 1, 1);
					break;
					
					case "buy":
						soundManager.playSound("buy", 1, 1);
					break;
					
					case "gameover":
						soundManager.playSound("gameover", 1, 1);
					break;
					
					case "gameoverhighscore":
						soundManager.playSound("gameoverhighscore", 1, 1);
					break;
					
					case "tick":
						soundManager.playSound("tick", 1, 1);
					break;
					
					default:
				}
			}
		}
		
		/*public static function playBGM():void {
			if(BGM){
				bgm = (new SoundMain) as Sound; 
				myChannel = bgm.play(lastPosition);
				myChannel.addEventListener(Event.SOUND_COMPLETE, loopsound)
			}
		}
		
		static private function loopsound(e:Event):void 
		{
			playBGM();
		}
		
		public static function stopBGM():void {
			lastPosition = myChannel.position;
			myChannel.stop();
		}
		
		public static function playSound(snd:String):void 
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
				
				
				case "tick":
					if (SFX) {
						sound = (new SoundTick) as Sound; 
						sound.play();
					}
				break;
				
				default:
			}
		}*/
	}

}