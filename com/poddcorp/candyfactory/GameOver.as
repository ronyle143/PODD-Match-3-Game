package  
{
	
	import api.GameAudio;
	import api.Constants;
	import api.GameAPI;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	
	import starling.display.Sprite;
	
	public class GameOver extends Sprite 
	{
		private var _imgscreenmask:Quad;
		private var _imgclipboard:Image;
		private var _btnmainmenu:Button;
		
		public function GameOver() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.y = Constants.STAGE_HEIGHT;
			
			_imgscreenmask = new Quad(Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT * 2, 0x000000, true);
			_imgscreenmask.y = -Constants.STAGE_HEIGHT;
			_imgscreenmask.visible = false;
			_imgscreenmask.alpha = 0.5;
			this.addChild(_imgscreenmask);
			
			_imgclipboard = new Image(CandyFactory.assets.getTexture("clipboard"));
			_imgclipboard.width = Constants.STAGE_WIDTH*0.8;
			_imgclipboard.height = Constants.STAGE_HEIGHT * 0.8;
			_imgclipboard.x = (Constants.STAGE_WIDTH - _imgclipboard.width) / 2;
			_imgclipboard.y = 0;
            this.addChild(_imgclipboard);
			
			_btnmainmenu = new Button(CandyFactory.assets.getTexture("btn_mainmenu"));
			_btnmainmenu.height = (Constants.STAGE_WIDTH / 6)*1.2;
			_btnmainmenu.width = _btnmainmenu.height*2.2;
			_btnmainmenu.x = (Constants.STAGE_WIDTH - _btnmainmenu.width)/2;
			_btnmainmenu.y = Constants.STAGE_HEIGHT * 0.6;
			this.addChild(_btnmainmenu);
			_btnmainmenu.addEventListener(Event.TRIGGERED, optionMenu);
		}
		
		public function popUp():void {
			if (GameAPI.GameState == 1) {
				GameAPI.note("!", "Opened OptionsTab");
			}else {
				GameAPI.note("!", "Game Paused");
				GameAPI.paused = true;
			}
			var popup:Tween = new Tween(this, 0.5, "easeOutBack");
			popup.moveTo(0,Constants.STAGE_HEIGHT*0.1);
			Starling.juggler.add(popup);
			_imgscreenmask.visible = true;
		}
		
		private function optionMenu(e:Event):void 
		{
			GameAPI.GameState = 1;
			GameAPI.StateChange = true;
		}
		
	}

}