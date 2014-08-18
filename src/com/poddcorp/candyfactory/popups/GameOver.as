package  com.poddcorp.candyfactory.popups
{
	
	import com.poddcorp.candyfactory.api.GameAudio;
	import com.poddcorp.candyfactory.api.Constants;
	import com.poddcorp.candyfactory.api.GameAPI;
	import com.poddcorp.candyfactory.api.GameData;
	import com.poddcorp.candyfactory.core.CandyFactory;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	
	import starling.display.Sprite;
	
	public class GameOver extends Sprite 
	{
		private var _txtScore:TextField = new TextField(Constants.STAGE_WIDTH*0.4,Constants.STAGE_HEIGHT*0.07, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 32, 0x000000);
		private var _Score:TextField 	= new TextField(Constants.STAGE_WIDTH*0.4,Constants.STAGE_HEIGHT*0.10, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 20, 0x000000);
		private var _imgscreenmask:Quad;
		private var _imgclipboard:Image;
		private var _btnmainmenu:Button;
		private var _btnretry:Button;
		
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
			
			_btnretry = new Button(CandyFactory.assets.getTexture("btn_retry"));
			_btnretry.height =Constants.STAGE_WIDTH / 6*1.2;
			_btnretry.width = _btnretry.height*2.2;
			_btnretry.x = (Constants.STAGE_WIDTH - _btnretry.width)/2;
			_btnretry.y = _btnmainmenu.y - _btnmainmenu.height;
			this.addChild(_btnretry);
			_btnretry.addEventListener(Event.TRIGGERED, optionRetry);
			
			_Score.text = "Score:" ;
			_Score.x = (this.width - _txtScore.width)/2;
			_Score.y = Constants.STAGE_HEIGHT/2 * 0.35;
			_Score.filter = BlurFilter.createDropShadow();
			addChild(_Score);
			
			_txtScore.text = "" + GameData.score ;
			_txtScore.x = (this.width - _txtScore.width)/2;
			_txtScore.y = Constants.STAGE_HEIGHT/2 * 0.5;
			_txtScore.filter = BlurFilter.createDropShadow();
			addChild(_txtScore);
		}
		
		public function popUp():void {
			_txtScore.text = "" + GameData.score ;
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
		
		private function optionRetry(e:Event):void 
		{
			GameAPI.StateChange = true;
		}
		
		private function optionMenu(e:Event):void 
		{
			GameAPI.GameState = 1;
			GameAPI.StateChange = true;
		}
		
	}

}