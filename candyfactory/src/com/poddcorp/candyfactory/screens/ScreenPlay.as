package  com.poddcorp.candyfactory.screens
{
	import com.poddcorp.candyfactory.core.CandyFactory;
	import com.poddcorp.candyfactory.popups.GameOver;
	import com.poddcorp.candyfactory.api.Constants;
	import com.poddcorp.candyfactory.api.GameAPI;
	import com.poddcorp.candyfactory.api.GameData;
	import com.poddcorp.candyfactory.popups.TabOption;
	import com.poddcorp.candyfactory.screens.ui.Grid;
	import flash.display.GradientType;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	
	public class ScreenPlay extends Sprite 
	{
		private var img_stage_bg:Image;
		//private var btn_options:Button;
		private var option:TabOption;
		private var grid:Grid;
		private var gameOver:GameOver;
		
		public function ScreenPlay() 
		{
			GameAPI.note("!", "Switched to ScreenPlay");
			GameAPI.init();
			GameData.init();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			img_stage_bg = new Image(CandyFactory.assets.getTexture("img_bg"));
			img_stage_bg.width = Constants.STAGE_WIDTH;
			img_stage_bg.height = Constants.STAGE_HEIGHT;
            this.addChild(img_stage_bg);
			
			
			grid = new Grid();
			addChild(grid);
			
			
			
			
			option = new TabOption();
			option.visible = false;
			this.addChild(option);
			
			gameOver = new GameOver();
			this.addChild(gameOver);
			
			//btn_options.addEventListener(Event.TRIGGERED, onButtonClickOption);
			addEventListener(EnterFrameEvent.ENTER_FRAME, loop);
			
			var myTimer:Timer = new Timer(3000, 1);
			myTimer.addEventListener(TimerEvent.TIMER, timerListener);
			function timerListener (e:TimerEvent):void{
				option.visible = true;
			}
			myTimer.start();
		}
		
		private function loop(e:EnterFrameEvent):void 
		{
			if (GameAPI.checktheMax == true) {
				gameOver.popUp();
				GameAPI.checktheMax = false;
			}
			if (GameAPI.checktheBlock == true) {
				grid.addStack();
				GameAPI.checktheBlock = false;
			}
			if (GameAPI.GameState == 1 && GameAPI.StateChange) {
				GameData.saveData();
				grid.deleteAll();
				destroy();
			}
			/*if (GameAPI.paused) {
				btn_options.visible = false;
			}else 
			{
				btn_options.visible = true;
			}*/
		}
		
		private function destroy():void 
		{
			grid.removeFromParent(true);
			this.removeFromParent(true);
		}
		
		private function onButtonClickOption(e:Event):void 
		{
			option.popUp();
		}
		
		
	}

}