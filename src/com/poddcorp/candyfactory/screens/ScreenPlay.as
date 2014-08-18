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
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	
	public class ScreenPlay extends Sprite 
	{
		private var img_stage_bg:Image;
		private var btn_options:Button;
		private var option:TabOption;
		private var grid:Grid;
		private var gameOver:GameOver;
		private var Crate01:Image;
		private var Crate02:Image;
		
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
			
			img_stage_bg = new Image(CandyFactory.assets.getTexture("stage_bg"));
			img_stage_bg.width = Constants.STAGE_WIDTH;
			img_stage_bg.height = Constants.STAGE_HEIGHT;
            this.addChild(img_stage_bg);
			
			
			grid = new Grid();
			addChild(grid);
			
			
			btn_options = new Button(CandyFactory.assets.getTexture("btn_option"));
			btn_options.height = Constants.STAGE_WIDTH / 8;
			btn_options.width = btn_options.height;
            btn_options.x = this.width - btn_options.width;
            btn_options.y = 0;
			btn_options.filter = BlurFilter.createDropShadow();
			this.addChild(btn_options);
			
			Crate01 = new Image(CandyFactory.assets.getTexture("Crate"));
			Crate01.width = Constants.STAGE_WIDTH/7;
			Crate01.height = Crate01.width;
			Crate01.x = Constants.STAGE_WIDTH - (Crate01.width);
			Crate01.y = Constants.STAGE_HEIGHT * 0.87;
			Crate01.filter = BlurFilter.createDropShadow();
            this.addChild(Crate01);
			
			Crate02 = new Image(CandyFactory.assets.getTexture("Crate"));
			Crate02.width = Constants.STAGE_WIDTH/9;
			Crate02.height = Crate02.width;
			Crate02.x = Constants.STAGE_WIDTH - (Crate02.width*1.5);
			Crate02.y = Constants.STAGE_HEIGHT * 0.90;
			Crate02.filter = BlurFilter.createDropShadow(4, 0.285);
            this.addChild(Crate02);
			
			option = new TabOption();
			this.addChild(option);
			
			gameOver = new GameOver();
			this.addChild(gameOver);
			
			btn_options.addEventListener(Event.TRIGGERED, onButtonClickOption);
			addEventListener(EnterFrameEvent.ENTER_FRAME, loop);
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