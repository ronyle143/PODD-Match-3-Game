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
		private var _txtScore:TextField = new TextField(Constants.STAGE_WIDTH*0.4,Constants.STAGE_HEIGHT*0.07, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 32, 0xFFFFFF);
		private var _Score:TextField 	= new TextField(Constants.STAGE_WIDTH*0.4,Constants.STAGE_HEIGHT*0.10, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 20, 0xFFFFFF);
		private var _imgscreenmask:Quad;
		private var _imgclipboard:Image;
		private var _btnmainmenu:Button;
		private var _btnretry:Button;
		private var _txtHScore:TextField = new TextField(Constants.STAGE_WIDTH*0.4,Constants.STAGE_HEIGHT*0.07, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 32, 0xFFFFFF);
		private var _HScore:TextField 	= new TextField(Constants.STAGE_WIDTH*0.8,Constants.STAGE_HEIGHT*0.10, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 20, 0xFFFFFF);
		private var _gameover:Image;
		private var placeholder:Sprite;
		
		
		public function GameOver() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//this.y = Constants.STAGE_HEIGHT;
			
			placeholder = new Sprite();
			
			_imgscreenmask = new Quad(Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT, 0x000000, true);
			//_imgscreenmask.y = Constants.STAGE_HEIGHT*0.2;
			_imgscreenmask.visible = false;
			_imgscreenmask.alpha = 0.5;
			this.addChild(_imgscreenmask);
			
			_imgclipboard = new Image(CandyFactory.assets.getTexture("clipboard"));
			_imgclipboard.width = Constants.STAGE_WIDTH*0.8;
			_imgclipboard.height = Constants.STAGE_HEIGHT * 0.8;
			_imgclipboard.x = (Constants.STAGE_WIDTH - _imgclipboard.width) / 2;
			_imgclipboard.y = 0;
            placeholder.addChild(_imgclipboard);
			
			_btnmainmenu = new Button(CandyFactory.assets.getTexture("btn_mainmenu"));
			_btnmainmenu.height = (Constants.STAGE_WIDTH / 6)*1.2;
			_btnmainmenu.width = _btnmainmenu.height*2.2;
			_btnmainmenu.x = (Constants.STAGE_WIDTH - _btnmainmenu.width)/2;
			_btnmainmenu.y = Constants.STAGE_HEIGHT * 0.6;
			placeholder.addChild(_btnmainmenu);
			
			_btnretry = new Button(CandyFactory.assets.getTexture("btn_retry"));
			_btnretry.height =Constants.STAGE_WIDTH / 6*1.2;
			_btnretry.width = _btnretry.height*2.2;
			_btnretry.x = (Constants.STAGE_WIDTH - _btnretry.width)/2;
			_btnretry.y = _btnmainmenu.y - _btnmainmenu.height;
			placeholder.addChild(_btnretry);
			
			_Score.text = "Score:" ;
			_Score.x = (Constants.STAGE_WIDTH - _Score.width)/2;
			_Score.y = Constants.STAGE_HEIGHT/2 * 0.35;
			_Score.filter = BlurFilter.createDropShadow();
			placeholder.addChild(_Score);
			
			_txtScore.text = "" + GameData.score ;
			_txtScore.x = (this.width - _txtScore.width)/2;
			_txtScore.y = Constants.STAGE_HEIGHT/2 * 0.5;
			_txtScore.filter = BlurFilter.createDropShadow();
			placeholder.addChild(_txtScore);
			
			_HScore.text = "High Score:" ;
			_HScore.x = (Constants.STAGE_WIDTH - _HScore.width)/2;
			_HScore.y = Constants.STAGE_HEIGHT/2 * 0.6;
			_HScore.filter = BlurFilter.createDropShadow();
			placeholder.addChild(_HScore);
			
			_txtHScore.text = "" + GameData.saveDataObject.data.Highscore ;
			_txtHScore.x = (this.width - _txtHScore.width)/2;
			_txtHScore.y = _HScore.y + _txtHScore.height;
			_txtHScore.filter = BlurFilter.createDropShadow();
			placeholder.addChild(_txtHScore);
			
			_gameover = new Image(CandyFactory.assets.getTexture("game_over"));
			//_gameover.width = Constants.STAGE_WIDTH*0.8;
			//_gameover.height = Constants.STAGE_HEIGHT * 0.8;
			_gameover.x = (Constants.STAGE_WIDTH - _imgclipboard.width) / 2;
			_gameover.y = -Constants.STAGE_HEIGHT * 0.05;
			_gameover.filter = BlurFilter.createGlow(0xFFFFFF);
            placeholder.addChild(_gameover);
			this.visible = false;
			placeholder.y=Constants.STAGE_HEIGHT * 0.1;
			this.addChild(placeholder);
		}
		
		public function popUp():void {
			this.visible = true;
			placeholder.y = Constants.STAGE_HEIGHT;
			_txtScore.text = "" + GameData.score ;
			_txtHScore.text = "" + (0+GameData.saveDataObject.data.Highscore) ;
			if (_txtHScore.text == "undefined") {
				_txtHScore.text = "" + 0;
			}
			GameData.compareHS();
			if (GameAPI.GameState == 1) {
				GameAPI.note("!", "Opened OptionsTab");
			}else {
				GameAPI.note("!", "Game Paused");
				GameAPI.paused = true;
			}
			var popup:Tween = new Tween(placeholder, 0.5, "easeOutBack");
			popup.moveTo(0,Constants.STAGE_HEIGHT*0.1);
			Starling.juggler.add(popup);
			_imgscreenmask.visible = true;
			
			_btnmainmenu.addEventListener(Event.TRIGGERED, optionMenu);
			_btnretry.addEventListener(Event.TRIGGERED, optionRetry);
		}
		
		private function optionRetry(e:Event):void 
		{
			_btnmainmenu.visible = false;
			_btnretry.visible = false;
			GameAPI.StateChange = true;
		}
		
		private function optionMenu(e:Event):void 
		{
			_btnretry.visible = false;
			_btnmainmenu.visible = false;
			GameAPI.GameState = 1;
			GameAPI.StateChange = true;
		}
		
	}

}