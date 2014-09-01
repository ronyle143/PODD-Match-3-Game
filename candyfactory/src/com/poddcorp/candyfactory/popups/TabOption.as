package  com.poddcorp.candyfactory.popups
{
	import com.poddcorp.candyfactory.api.GameAudio;
	import com.poddcorp.candyfactory.api.Constants;
	import com.poddcorp.candyfactory.api.GameAPI;
	import com.poddcorp.candyfactory.core.CandyFactory;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class TabOption extends Sprite 
	{		
		public var _imgcloseclipboard:Button;
		private var _imgclipboard:Image;
		private var _imgscreenmask:Quad;
		private var _imgcheckbox1:Button;
		private var _imgcheckbox2:Button;
		private var _btnresume:Button;
		private var _btnmainmenu:Button;
		private var _imgcheckbox1c:Button;
		private var _imgcheckbox2c:Button;
		private var _DSelect:Button;
		private var placeholder:Sprite;
		
		public function TabOption() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			placeholder = new Sprite();
			
			_imgscreenmask = new Quad(Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT, 0x000000, true);
			//_imgscreenmask.y = -Constants.STAGE_HEIGHT;
			_imgscreenmask.alpha = 0.5;
			this.addChild(_imgscreenmask);
			
			if (GameAPI.GameState == 1) {
				_imgclipboard = new Image(CandyFactory.assets.getTexture("clipboard_compact"));
			}else {
				_imgclipboard = new Image(CandyFactory.assets.getTexture("clipboard"));
			}			
			
			_imgclipboard.width = Constants.STAGE_WIDTH*0.8;
			_imgclipboard.height = Constants.STAGE_HEIGHT * 0.8;
			_imgclipboard.x = (Constants.STAGE_WIDTH - _imgclipboard.width) / 2;
			_imgclipboard.y = 0;
            placeholder.addChild(_imgclipboard);
			
			_imgcheckbox1c = new Button(CandyFactory.assets.getTexture("sfx"));
			_imgcheckbox1c.height = Constants.STAGE_WIDTH / 6;
			_imgcheckbox1c.width = _imgcheckbox1c.height;
			_imgcheckbox1c.x = Constants.STAGE_WIDTH * 0.2;
			_imgcheckbox1c.y = Constants.STAGE_HEIGHT * 0.2;
			placeholder.addChild(_imgcheckbox1c);
			
			_imgcheckbox1 = new Button(CandyFactory.assets.getTexture("sfx_x"));
			_imgcheckbox1.height = Constants.STAGE_WIDTH / 6;
			_imgcheckbox1.width = _imgcheckbox1.height;
			_imgcheckbox1.x = Constants.STAGE_WIDTH * 0.2;
			_imgcheckbox1.y = Constants.STAGE_HEIGHT * 0.2;
			placeholder.addChild(_imgcheckbox1);
			
			if (GameAudio.SFX) {
				_imgcheckbox1c.visible = true;
				_imgcheckbox1.visible = false;
			}else {
				_imgcheckbox1c.visible = false;
				_imgcheckbox1.visible = true;
			}
			
			//var textField:TextField = new TextField(100, 20, "SFX", "Arista 2.0", 12, Color.RED);
			var txt_SFX:TextField = new TextField(Constants.STAGE_WIDTH * 0.6, Constants.STAGE_HEIGHT / 10, "SFX", "Showcard Gothic", Constants.STAGE_HEIGHT / 12, 0x333333);
			txt_SFX.x = _imgcheckbox1.x + _imgcheckbox1.width;
			txt_SFX.y = _imgcheckbox1.y;
			txt_SFX.hAlign = "left";
			placeholder.addChild(txt_SFX);
			
			_imgcheckbox2c = new Button(CandyFactory.assets.getTexture("bgm"));
			_imgcheckbox2c.height =_imgcheckbox1.height;
			_imgcheckbox2c.width = _imgcheckbox2c.height;
			_imgcheckbox2c.x = _imgcheckbox1.x;
			_imgcheckbox2c.y = Constants.STAGE_HEIGHT * 0.35;
			placeholder.addChild(_imgcheckbox2c);
			
			_imgcheckbox2 = new Button(CandyFactory.assets.getTexture("bgm_x"));
			_imgcheckbox2.height =_imgcheckbox1.height;
			_imgcheckbox2.width = _imgcheckbox2.height;
			_imgcheckbox2.x = _imgcheckbox1.x;
			_imgcheckbox2.y = Constants.STAGE_HEIGHT * 0.35;
			placeholder.addChild(_imgcheckbox2);
			
			if (GameAudio.BGM) {
				_imgcheckbox2c.visible = true;
				_imgcheckbox2.visible = false;
			}else {
				_imgcheckbox2c.visible = false;
				_imgcheckbox2.visible = true;
			}
			
			var txt_BMG:TextField = new TextField(Constants.STAGE_WIDTH * 0.6, Constants.STAGE_HEIGHT / 10, "BMG", "Showcard Gothic", Constants.STAGE_HEIGHT / 12, 0x333333);
			txt_BMG.x = _imgcheckbox2.x + _imgcheckbox2.width;
			txt_BMG.y = _imgcheckbox2.y;
			txt_BMG.hAlign = "left";
			placeholder.addChild(txt_BMG);
			
			if (GameAPI.GameState == 1) {
				_imgcloseclipboard = new Button(CandyFactory.assets.getTexture("btn_close"));
				_imgcloseclipboard.height = Constants.STAGE_WIDTH / 8;
				_imgcloseclipboard.width = _imgcloseclipboard.height;
				_imgcloseclipboard.x = (Constants.STAGE_WIDTH - _imgcloseclipboard.width)*0.8
				_imgcloseclipboard.y = _imgcloseclipboard.width*1.3;
				placeholder.addChild(_imgcloseclipboard);
			}else {	
				_btnmainmenu = new Button(CandyFactory.assets.getTexture("btn_mainmenu"));
				_btnmainmenu.height =_imgcheckbox1.height*1.2;
				_btnmainmenu.width = _btnmainmenu.height*2.2;
				_btnmainmenu.x = (Constants.STAGE_WIDTH - _btnmainmenu.width)/2;
				_btnmainmenu.y = Constants.STAGE_HEIGHT * 0.6;
				placeholder.addChild(_btnmainmenu);
				
				_btnresume = new Button(CandyFactory.assets.getTexture("btn_resume"));
				_btnresume.height =_imgcheckbox1.height*1.2;
				_btnresume.width = _btnresume.height*2.2;
				_btnresume.x = _btnmainmenu.x
				_btnresume.y = _btnmainmenu.y-_btnresume.height;
				placeholder.addChild(_btnresume);
			}
			
			this.visible = false;
			this.addChild(placeholder);
		}
		
		private function turnOnSFX(e:Event):void 
		{
			GameAudio.SFX = true;
			_imgcheckbox1c.visible = true;
			_imgcheckbox1.visible = false;
			GameAPI.note("S", "SFX set to "+GameAudio.SFX);
		}
		private function turnOffSFX(e:Event):void 
		{
			GameAudio.SFX = false;
			_imgcheckbox1c.visible = false;
			_imgcheckbox1.visible = true;
			GameAPI.note("S", "SFX set to "+GameAudio.SFX);
		}
		private function turnOnBGM(e:Event):void 
		{
			GameAudio.BGM = true;
			_imgcheckbox2c.visible = true;
			_imgcheckbox2.visible = false;
			GameAPI.note("S", "BGM set to "+GameAudio.BGM);
		}
		private function turnOffBGM(e:Event):void 
		{
			GameAudio.BGM = false;
			_imgcheckbox2c.visible = false;
			_imgcheckbox2.visible = true;
			GameAPI.note("S", "BGM set to "+GameAudio.BGM);
		}
		
		public function popUp():void {
			removeEventListeners();
			this.visible = true;
			placeholder.visible = true;
			placeholder.y = Constants.STAGE_HEIGHT;
			if (GameAPI.GameState == 1) {
				GameAPI.note("!", "Opened OptionsTab");
				_imgcloseclipboard.alpha = 0.25;
			}else {
				GameAPI.note("!", "Game Paused");
				GameAPI.paused = true;
				_btnmainmenu.alpha = 0.25;
				_btnresume.alpha = 0.25;
			}
			
			_imgcheckbox1c.alpha = 0.25;
			_imgcheckbox1.alpha = 0.25;
			_imgcheckbox2c.alpha = 0.25;
			_imgcheckbox2.alpha = 0.25;
			
			var popup:Tween = new Tween(placeholder, 0.5, "easeOutBack");
			popup.moveTo(0,Constants.STAGE_HEIGHT*0.1);
			Starling.juggler.add(popup);
			_imgscreenmask.visible = true;
			
			
			
			popup.onComplete = function():void {
				_imgcheckbox1c.alpha = 1;
				_imgcheckbox1.alpha = 1;
				_imgcheckbox2c.alpha = 1;
				_imgcheckbox2.alpha = 1;
				
				_imgcheckbox1c.addEventListener(Event.TRIGGERED, turnOffSFX);
				_imgcheckbox1.addEventListener(Event.TRIGGERED, turnOnSFX);
				_imgcheckbox2c.addEventListener(Event.TRIGGERED, turnOffBGM);
				_imgcheckbox2.addEventListener(Event.TRIGGERED, turnOnBGM);
				if (GameAPI.GameState == 1) {
					_imgcloseclipboard.addEventListener(Event.TRIGGERED, onButtonClickClose);
					_imgcloseclipboard.alpha = 1;
				}else {
					_btnmainmenu.addEventListener(Event.TRIGGERED, optionMenu);
					_btnresume.addEventListener(Event.TRIGGERED, onButtonClickClose);
					_btnmainmenu.alpha = 1;
					_btnresume.alpha = 1;
				}
			}
			
		}
		private function onButtonClickClose(e:Event):void 
		{
			if (GameAPI.GameState == 1) {
				GameAPI.note("!", "Closed OptionsTab");
			}else {
				GameAPI.note("!", "Game Unpaused");
				GameAPI.paused = false;
			}
			var popup:Tween = new Tween(placeholder, 0.5, "easeOutBounce");
			popup.moveTo(0, Constants.STAGE_HEIGHT);
			popup.onComplete = function():void {
				placeholder.y = 0;
				placeholder.visible = false;
			 }
			Starling.juggler.add(popup);
			_imgscreenmask.visible = false;
		}
		
		private function optionMenu(e:Event):void 
		{
			_btnresume.visible = false;
			_btnmainmenu.visible = false;
			GameAPI.GameState = 1;
			GameAPI.StateChange = true;
		}
		
	}
}