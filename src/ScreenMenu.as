package  
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ScreenMenu extends Sprite 
	{
		//public var var_GameState:int=1;
		
		private var img_menu_bg:Image;
		private var img_menu_title:Image;
		private var btn_start:Button;
		private var btn_options:Button;
		private var option:TabOption;
		
		public function ScreenMenu() 
		{
			GameAPI.Note("!", "Switched to ScreenMenu");
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			img_menu_bg = new Image(CandyFactory.assets.getTexture("img_bg"));
			img_menu_bg.width = Constants.STAGE_WIDTH;
			img_menu_bg.height = Constants.STAGE_HEIGHT;
            this.addChild(img_menu_bg);
			
			img_menu_title = new Image(CandyFactory.assets.getTexture("img_title"));
			img_menu_title.width = Constants.STAGE_WIDTH;
			img_menu_title.height = Constants.STAGE_HEIGHT/3;
            this.addChild(img_menu_title);
			
			btn_start = new Button(CandyFactory.assets.getTexture("btn_play"));
			btn_options = new Button(CandyFactory.assets.getTexture("btn_option"));
			btn_start.width = Constants.STAGE_WIDTH/2;
			btn_start.height = Constants.STAGE_WIDTH / 4;
			btn_options.height = btn_start.height;
			btn_options.width = btn_options.height;
            btn_start.x = (Constants.STAGE_WIDTH - (btn_start.width+btn_options.width))*0.5;
            btn_start.y = (Constants.STAGE_HEIGHT - btn_start.height)*0.75;
            btn_options.x = btn_start.x+btn_start.width;
            btn_options.y = btn_start.y;
            this.addChild(btn_start);
			this.addChild(btn_options);
			
			btn_start.addEventListener(Event.TRIGGERED, onButtonClickStart);
			btn_options.addEventListener(Event.TRIGGERED, onButtonClickOption);
			
			option = new TabOption();
			this.addChild(option);
			
		}
		
		private function onButtonClickStart(e:Event):void 
		{
			GameAPI.GameState = 2;
			GameAPI.StateChange = true;
		}
		
		private function onButtonClickOption(e:Event):void 
		{
			option.popUp();
		}
		
		
	}

}