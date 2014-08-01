package  
{
	import flash.display.GradientType;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ScreenPlay extends Sprite 
	{
		private var img_stage_bg:Image;
		private var btn_options:Button;
		private var option:TabOption;
		private var grid:Grid;
		
		public function ScreenPlay() 
		{
			GameAPI.Note("!", "Switched to ScreenPlay");
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
			this.addChild(btn_options);
			
			option = new TabOption();
			this.addChild(option);
			
			btn_options.addEventListener(Event.TRIGGERED, onButtonClickOption);
		}
		
		private function onButtonClickOption(e:Event):void 
		{
			option.popUp();
		}
		
		
	}

}