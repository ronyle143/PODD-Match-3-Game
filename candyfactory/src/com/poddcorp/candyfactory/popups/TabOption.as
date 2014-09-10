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
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.filters.BlurFilter;
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
		private var btn_options:Button;
		private var _header:Image;
		
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
				_imgclipboard = new Image(CandyFactory.assets.getTexture("clipboard_blank"));
				_imgclipboard.width = Constants.STAGE_WIDTH*0.8;
				_imgclipboard.height = _imgclipboard.width * 0.8;
				_imgclipboard.x = (Constants.STAGE_WIDTH - _imgclipboard.width) / 2;
				_imgclipboard.y = (Constants.STAGE_HEIGHT - _imgclipboard.height) / 2;
			}else {
				_imgclipboard = new Image(CandyFactory.assets.getTexture("clipboard_blank_big"));
				_imgclipboard.width = Constants.STAGE_WIDTH*0.8;
				_imgclipboard.height = _imgclipboard.width * 1.5;
				_imgclipboard.x = (Constants.STAGE_WIDTH - _imgclipboard.width) / 2;
				_imgclipboard.y = (Constants.STAGE_HEIGHT - _imgclipboard.height) / 2;
			}			
            placeholder.addChild(_imgclipboard);
			
			_header = new Image(CandyFactory.assets.getTexture("header_option"));
			_header.width = _imgclipboard.width / 1.5;
			_header.height = _header.width / 3.4;
			_header.x = (Constants.STAGE_WIDTH - _header.width)/2;
			_header.y = _imgclipboard.y - _header.height/2;
            placeholder.addChild(_header);
			
			_imgcheckbox1c = new Button(CandyFactory.assets.getTexture("sfx"));
			_imgcheckbox1c.height = (_imgclipboard.width/5);
			_imgcheckbox1c.width = _imgcheckbox1c.height;
			_imgcheckbox1c.x = _imgclipboard.width /5;
			_imgcheckbox1c.y = _imgclipboard.y + (_imgcheckbox1c.height * 1);
			placeholder.addChild(_imgcheckbox1c);
			
			_imgcheckbox1 = new Button(CandyFactory.assets.getTexture("sfx_x"));
			_imgcheckbox1.height = _imgcheckbox1c.height;
			_imgcheckbox1.width = _imgcheckbox1.height;
			_imgcheckbox1.x = _imgcheckbox1c.x;
			_imgcheckbox1.y = _imgcheckbox1c.y;
			placeholder.addChild(_imgcheckbox1);
			
			if (GameAudio.SFX) {
				_imgcheckbox1c.visible = true;
				_imgcheckbox1.visible = false;
			}else {
				_imgcheckbox1c.visible = false;
				_imgcheckbox1.visible = true;
			}
			
			//var textField:TextField = new TextField(100, 20, "SFX", "Arista 2.0", 12, Color.RED);
			var txt_SFX:TextField = new TextField(Constants.STAGE_WIDTH * 0.5, _imgcheckbox1c.height, "SFX", "BubbleBud", _imgcheckbox1c.height/1.3, 0x333333);
			txt_SFX.x = _imgcheckbox1.x + _imgcheckbox1.width;
			txt_SFX.y = _imgcheckbox1.y;
			txt_SFX.hAlign = "left";
			placeholder.addChild(txt_SFX);
	//txt_SFX.border = true;
	
			_imgcheckbox2c = new Button(CandyFactory.assets.getTexture("bgm"));
			_imgcheckbox2c.height =_imgcheckbox1.height;
			_imgcheckbox2c.width = _imgcheckbox2c.height;
			_imgcheckbox2c.x = _imgcheckbox1.x;
			_imgcheckbox2c.y = _imgcheckbox1c.y + (_imgcheckbox2c.height * 1.5);
			placeholder.addChild(_imgcheckbox2c);
			
			_imgcheckbox2 = new Button(CandyFactory.assets.getTexture("bgm_x"));
			_imgcheckbox2.height =_imgcheckbox1.height;
			_imgcheckbox2.width = _imgcheckbox2.height;
			_imgcheckbox2.x = _imgcheckbox1.x;
			_imgcheckbox2.y = _imgcheckbox2c.y;
			placeholder.addChild(_imgcheckbox2);
			
			if (GameAudio.BGM) {
				_imgcheckbox2c.visible = true;
				_imgcheckbox2.visible = false;
			}else {
				_imgcheckbox2c.visible = false;
				_imgcheckbox2.visible = true;
			}
			
			var txt_BMG:TextField = new TextField(Constants.STAGE_WIDTH * 0.5, _imgcheckbox1c.height, "BGM", "BubbleBud", _imgcheckbox1c.height/1.3, 0x333333);
			txt_BMG.x = _imgcheckbox2.x + _imgcheckbox2.width;
			txt_BMG.y = _imgcheckbox2.y;
			txt_BMG.hAlign = "left";
			placeholder.addChild(txt_BMG);
	//txt_BMG.border = true;
			
			if (GameAPI.GameState == 1) {
				_imgcloseclipboard = new Button(CandyFactory.assets.getTexture("btn_close"));
				_imgcloseclipboard.height = Constants.STAGE_WIDTH / 8;
				_imgcloseclipboard.width = _imgcloseclipboard.height;
				_imgcloseclipboard.x = (Constants.STAGE_WIDTH - _imgcloseclipboard.width) * 0.85;
				_imgcloseclipboard.y = _imgclipboard.y+(_imgcloseclipboard.height*0.2);
				placeholder.addChild(_imgcloseclipboard);
			}else {	
				_btnresume = new Button(CandyFactory.assets.getTexture("btn_resume"));
				_btnresume.height =_imgcheckbox1.height*1.3;
				_btnresume.width = _btnresume.height*3;
				_btnresume.x = (Constants.STAGE_WIDTH - _btnresume.width)/2;
				_btnresume.y = _imgcheckbox2c.y + (_imgcheckbox2c.height * 1.5);
				placeholder.addChild(_btnresume);
				
				_btnmainmenu = new Button(CandyFactory.assets.getTexture("btn_mainmenu"));
				_btnmainmenu.height =_imgcheckbox1.height*1.3;
				_btnmainmenu.width = _btnmainmenu.height*3;
				_btnmainmenu.x = (Constants.STAGE_WIDTH - _btnmainmenu.width)/2;
				_btnmainmenu.y = _btnresume.y + _btnresume.height;
				placeholder.addChild(_btnmainmenu);
			}
			
		//this.visible = false;
			this.addChild(placeholder);
			placeholder.visible = false;
			_imgscreenmask.visible = false;
			
			
			btn_options = new Button(CandyFactory.assets.getTexture("btn_option"));
			btn_options.height = Constants.STAGE_WIDTH / 8;
			btn_options.width = btn_options.height;
            btn_options.x = this.width - btn_options.width;
            btn_options.y = 0;
			btn_options.filter = BlurFilter.createDropShadow();
			this.addChild(btn_options);
			btn_options.addEventListener(Event.TRIGGERED, onButtonClickOption);
		}
		
		private function onButtonClickOption(e:Event):void 
		{
			GameAudio.playSound("pop");
			popUp();
			btn_options.visible = false;
		}
		
		private function loop(e:EnterFrameEvent):void 
		{
			if (GameAPI.paused == false) {
				removeEventListener(EnterFrameEvent.ENTER_FRAME, loop);
				btn_options.visible = true;
			}
		}
		
		private function turnOnSFX(e:Event):void 
		{
			GameAudio.SFX = true;
			_imgcheckbox1c.visible = true;
			_imgcheckbox1.visible = false;
			GameAPI.note("S", "SFX set to " + GameAudio.SFX);
			GameAudio.playSound("pop");
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
			GameAudio.playBGM();
			_imgcheckbox2c.visible = true;
			_imgcheckbox2.visible = false;
			GameAPI.note("S", "BGM set to "+GameAudio.BGM);
		}
		private function turnOffBGM(e:Event):void 
		{
			GameAudio.BGM = false;
			GameAudio.stopBGM();
			_imgcheckbox2c.visible = false;
			_imgcheckbox2.visible = true;
			GameAPI.note("S", "BGM set to "+GameAudio.BGM);
		}
		
		public function popUp():void {
			removeEventListeners();
			this.visible = true;
			_imgscreenmask.visible = true;
			_imgscreenmask.alpha = 0.5;
			placeholder.visible = true;
			placeholder.y = Constants.STAGE_HEIGHT;
			if (GameAPI.GameState == 1) {
				GameAPI.note("!", "Opened OptionsTab");
				_imgcloseclipboard.alpha = 0.25;
				GameAPI.paused = true;
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
			popup.moveTo(0, 0);
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
			GameAudio.playSound("pop");
			var popup:Tween = new Tween(placeholder, 0.5, "easeOutBounce");
			popup.moveTo(0, Constants.STAGE_HEIGHT);
			popup.onComplete = function():void {
				if (GameAPI.GameState == 1) {
					GameAPI.note("!", "Closed OptionsTab");
					GameAPI.paused = false;
				}else {
					GameAPI.note("!", "Game Unpaused");
					GameAPI.paused = false;
				}
				placeholder.y = 0;
				placeholder.visible = false;
				btn_options.visible = true;
				_imgscreenmask.visible = false;
			 }
			Starling.juggler.add(popup);
			var fademask:Tween = new Tween(_imgscreenmask, 0.5, "easeOutBack");
			fademask.fadeTo(0);
			Starling.juggler.add(fademask);
		}
		
		private function optionMenu(e:Event):void 
		{
			GameAudio.playSound("pop");
			_btnresume.visible = false;
			_btnmainmenu.visible = false;
			GameAPI.GameState = 1;
			GameAPI.StateChange = true;
		}
		
	}
}