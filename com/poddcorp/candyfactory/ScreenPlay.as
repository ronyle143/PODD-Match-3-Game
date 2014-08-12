package  
{
	import api.Constants;
	import api.GameAPI;
	import api.GameData;
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
			Crate01.y = Constants.STAGE_HEIGHT * 0.9;
            this.addChild(Crate01);
			
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
		}
		
		private function onButtonClickOption(e:Event):void 
		{
			option.popUp();
		}
		
		
	}

}