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
		
		private var _txtScore:TextField = new TextField(Constants.STAGE_WIDTH*0.4,Constants.STAGE_HEIGHT*0.06, "0", "Bubblebud", Constants.STAGE_HEIGHT / 32, 0x000000);
		private var _Score:TextField 	= new TextField(Constants.STAGE_WIDTH*0.4,Constants.STAGE_HEIGHT*0.10, "0", "Bubblebud", Constants.STAGE_HEIGHT / 20, 0x000000);
		private var _imgscreenmask:Quad;
		private var _imgclipboard:Image;
		private var _btnmainmenu:Button;
		private var _btnretry:Button;
		private var _txtHScore:TextField = new TextField(Constants.STAGE_WIDTH*0.4,Constants.STAGE_HEIGHT*0.06, "0", "Bubblebud", Constants.STAGE_HEIGHT / 32, 0x000000);
		private var _HScore:TextField 	= new TextField(Constants.STAGE_WIDTH*0.8,Constants.STAGE_HEIGHT*0.10, "0", "Bubblebud", Constants.STAGE_HEIGHT / 20, 0x000000);
		private var _gameover:Image;
		private var placeholder:Sprite;
		private var _header:Image;
		
		
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
			
			_imgclipboard = new Image(CandyFactory.assets.getTexture("clipboard_blank_big"));
			_imgclipboard.width = Constants.STAGE_WIDTH*0.7;
				_imgclipboard.height = _imgclipboard.width * 1.3;
				_imgclipboard.x = (Constants.STAGE_WIDTH - _imgclipboard.width) / 2;
				_imgclipboard.y = (Constants.STAGE_HEIGHT - _imgclipboard.height) / 2;
            placeholder.addChild(_imgclipboard);
			
			_header = new Image(CandyFactory.assets.getTexture("header_gameover"));
			_header.width = _imgclipboard.width / 2;
			_header.height = _header.width / 1.6;
			_header.x = (Constants.STAGE_WIDTH - _header.width)/2;
			_header.y = _imgclipboard.y - _header.height/2;
            placeholder.addChild(_header);
			
			_Score.text = "Score:" ;
			_Score.x = (Constants.STAGE_WIDTH - _Score.width)/2;
			_Score.y = _imgclipboard.y + (_imgclipboard.height * 0.1);
			_Score.filter = BlurFilter.createDropShadow();
			placeholder.addChild(_Score);
			
			_txtScore.text = "" + GameData.score ;
			_txtScore.x = (this.width - _txtScore.width)/2;
			_txtScore.y = _Score.y + _txtScore.height;
			_txtScore.filter = BlurFilter.createDropShadow();
			placeholder.addChild(_txtScore);
			
			_HScore.text = "High Score:" ;
			_HScore.x = (Constants.STAGE_WIDTH - _HScore.width)/2;
			_HScore.y = _txtScore.y + _txtScore.height;
			_HScore.filter = BlurFilter.createDropShadow();
			placeholder.addChild(_HScore);
			
			var temp:int = 0+ GameData.saveDataObject.data.Highscore;
			
			_txtHScore.text = "" +  temp;
			_txtHScore.x = (this.width - _txtHScore.width)/2;
			_txtHScore.y = _HScore.y + _txtHScore.height;
			_txtHScore.filter = BlurFilter.createDropShadow();
			placeholder.addChild(_txtHScore);
			
			var sizeY:Number = ((_imgclipboard.y + _imgclipboard.height) - (_txtHScore.y + _txtHScore.height))/4;
			//trace(sizeY);
			
			_btnretry = new Button(CandyFactory.assets.getTexture("btn_retry"));
			_btnretry.height = sizeY*1.5;
			_btnretry.width = _btnretry.height*3;
			_btnretry.x = (Constants.STAGE_WIDTH - _btnretry.width)/2;
			_btnretry.y = (_txtHScore.y + _txtHScore.height) + (sizeY*0.5);
			placeholder.addChild(_btnretry);
			
			_btnmainmenu = new Button(CandyFactory.assets.getTexture("btn_mainmenu"));
			_btnmainmenu.height = sizeY;
			_btnmainmenu.width = _btnmainmenu.height*3;
			_btnmainmenu.x = (Constants.STAGE_WIDTH - _btnmainmenu.width)/2;
			_btnmainmenu.y = _btnretry.y + _btnretry.height + (sizeY * 0.25);
			placeholder.addChild(_btnmainmenu);
			
			this.visible = false;
			placeholder.y=Constants.STAGE_HEIGHT * 0.1;
			this.addChild(placeholder);
		}
		
		public function popUp():void {
			this.visible = true;
			placeholder.y = Constants.STAGE_HEIGHT;
			_txtScore.text = "" + GameData.score ;
			var temp:int =  0+GameData.saveDataObject.data.Highscore;
			_txtHScore.text = "" + (temp) ;
			if (GameData.score < GameData.saveDataObject.data.Highscore) {
				GameAudio.playSound("gameover");
			}else {
				GameAudio.playSound("gameoverhighscore");
			}
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
			popup.moveTo(0,0);
			Starling.juggler.add(popup);
			_imgscreenmask.visible = true;
			
			_btnmainmenu.addEventListener(Event.TRIGGERED, optionMenu);
			_btnretry.addEventListener(Event.TRIGGERED, optionRetry);
		}
		
		private function optionRetry(e:Event):void 
		{
			GameAudio.playSound("pop");
			_btnmainmenu.visible = false;
			_btnretry.visible = false;
			GameAPI.StateChange = true;
		}
		
		private function optionMenu(e:Event):void 
		{
			GameAudio.playSound("pop");
			_btnretry.visible = false;
			_btnmainmenu.visible = false;
			GameAPI.GameState = 1;
			GameAPI.StateChange = true;
		}
		
	}

}