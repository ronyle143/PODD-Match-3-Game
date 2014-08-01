package  
{
	import api.Constants;
	import api.GameAPI;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ScreenMenu extends Sprite 
	{
		//public var var_GameState:int=1;
		
		private var _imgmenubg:Image;
		private var _imgmenutitle:Image;
		private var _btnstart:Button;
		private var _btnoptions:Button;
		private var _option:TabOption;
		
		public function ScreenMenu() 
		{
			GameAPI.note("!", "Switched to ScreenMenu");
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_imgmenubg = new Image(CandyFactory.assets.getTexture("img_bg"));
			_imgmenubg.width = Constants.STAGE_WIDTH;
			_imgmenubg.height = Constants.STAGE_HEIGHT;
            this.addChild(_imgmenubg);
			
			_imgmenutitle = new Image(CandyFactory.assets.getTexture("img_title"));
			_imgmenutitle.width = Constants.STAGE_WIDTH;
			_imgmenutitle.height = Constants.STAGE_HEIGHT/3;
            this.addChild(_imgmenutitle);
			
			_btnstart = new Button(CandyFactory.assets.getTexture("btn_play"));
			_btnoptions = new Button(CandyFactory.assets.getTexture("btn_option"));
			_btnstart.width = Constants.STAGE_WIDTH/2;
			_btnstart.height = Constants.STAGE_WIDTH / 4;
			_btnoptions.height = _btnstart.height;
			_btnoptions.width = _btnoptions.height;
            _btnstart.x = (Constants.STAGE_WIDTH - (_btnstart.width+_btnoptions.width))*0.5;
            _btnstart.y = (Constants.STAGE_HEIGHT - _btnstart.height)*0.75;
            _btnoptions.x = _btnstart.x+_btnstart.width;
            _btnoptions.y = _btnstart.y;
            this.addChild(_btnstart);
			this.addChild(_btnoptions);
			
			_btnstart.addEventListener(Event.TRIGGERED, onButtonClickStart);
			_btnoptions.addEventListener(Event.TRIGGERED, onButtonClickOption);
			
			_option = new TabOption();
			this.addChild(_option);
			
		}
		
		private function onButtonClickStart(e:Event):void 
		{
			GameAPI.GameState = 2;
			GameAPI.StateChange = true;
		}
		
		private function onButtonClickOption(e:Event):void 
		{
			_option.popUp();
		}
		
		
	}

}