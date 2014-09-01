package  com.poddcorp.candyfactory.screens
{
	import com.poddcorp.candyfactory.api.Constants;
	import com.poddcorp.candyfactory.api.GameAPI;
	import com.poddcorp.candyfactory.api.GameData;
	import com.poddcorp.candyfactory.core.CandyFactory;
	import com.poddcorp.candyfactory.popups.TabOption;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	
	public class ScreenShop extends Sprite 
	{
		private var _imgbg:Image;
		private var _btnclose:Button;
		private var ghostui:TabOption;
		private var _power2:Image;
		private var _btnbuy1:Button;
		private var _clipboard:Image;
		private var _power1:Image;
		private var _btnbuy2:Button;
		private var _imgscreenmask:Quad;
		private var _imgcloseclipboard:Button;
		public var _power1txt:TextField = new TextField(Constants.STAGE_WIDTH*0.16,Constants.STAGE_HEIGHT*0.05, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 25, 0x000000F);
		public var _power2txt:TextField = new TextField(Constants.STAGE_WIDTH*0.16,Constants.STAGE_HEIGHT*0.05, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 25, 0x000000F);
		
		
		public function ScreenShop() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			
			ghostui = new TabOption();
			addChild(ghostui);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_imgbg = new Image(CandyFactory.assets.getTexture("img_bg"));
			_imgbg.width = Constants.STAGE_WIDTH;
			_imgbg.height = Constants.STAGE_HEIGHT;
            this.addChild(_imgbg);
			
			_clipboard = new Image(CandyFactory.assets.getTexture("clipboard"));
			_clipboard.width = Constants.STAGE_WIDTH;
			_clipboard.height = Constants.STAGE_HEIGHT;
            this.addChild(_clipboard);
			
			_btnclose = new Button(CandyFactory.assets.getTexture("btn_close"));
			_btnclose.width = Constants.STAGE_WIDTH / 6;
			_btnclose.height = Constants.STAGE_WIDTH / 6;
            _btnclose.x = Constants.STAGE_WIDTH - _btnclose.width;
            _btnclose.y = 0;
			this.addChild(_btnclose);
			
			_power1 = new Image(CandyFactory.assets.getTexture("scoopUp"));
			_power1.width = Constants.STAGE_WIDTH / 5;
			_power1.height = _power1.width;
			_power1.x = Constants.STAGE_WIDTH * 0.25;
			_power1.y = Constants.STAGE_HEIGHT * 0.35;
            this.addChild(_power1);
			
			_btnbuy1 = new Button(CandyFactory.assets.getTexture("btn_cart"));
			_btnbuy1.width = Constants.STAGE_WIDTH / 5;
			_btnbuy1.height = _btnbuy1.width;
			_btnbuy1.fontSize *= 1.3;
            _btnbuy1.x = Constants.STAGE_WIDTH * 0.55;
            _btnbuy1.y = _power1.y;
			this.addChild(_btnbuy1);
			
			_power1.filter = BlurFilter.createDropShadow();
			_power1txt.text = "" + GameData.useTaster;
			_power1txt.touchable = false;
			addChild(_power1txt);
			_power1txt.x = 0;
			//_power2txt.border = true;
			_power1txt.hAlign = "right";
			_power1txt.y = _power1.y + _power1.height / 1.3;
			_power1txt.x = _power1.x + _power1.width * 0.2;
			_power1txt.filter = BlurFilter.createDropShadow(0, 0.785, 0xFFFFFF, 1);
			
			_power2 = new Image(CandyFactory.assets.getTexture("timefreeze"));
			_power2.width = Constants.STAGE_WIDTH / 5;
			_power2.height = _power2.width;
			_power2.x = Constants.STAGE_WIDTH * 0.25;
			_power2.y = Constants.STAGE_HEIGHT * 0.55;
            this.addChild(_power2);
			
			_btnbuy2 = new Button(CandyFactory.assets.getTexture("btn_cart"));
			_btnbuy2.width = Constants.STAGE_WIDTH / 5;
			_btnbuy2.height = _btnbuy2.width;
			_btnbuy2.fontSize *= 1.3;
            _btnbuy2.x = Constants.STAGE_WIDTH * 0.55;
            _btnbuy2.y = _power2.y;
			this.addChild(_btnbuy2);
			
			_power2.filter = BlurFilter.createDropShadow();
			_power2txt.text = "" + GameData.useFreeze;
			_power2txt.touchable = false;
			addChild(_power2txt);
			_power2txt.x = 0;
			//_power2txt.border = true;
			_power2txt.hAlign = "right";
			_power2txt.y = _power2.y + _power2.height / 1.3;
			_power2txt.x = _power2.x + _power2.width * 0.2;
			_power2txt.filter = BlurFilter.createDropShadow(0, 0.785, 0xFFFFFF, 1);
			
			//------------------------------//
			
			
			//popup.onComplete = function():void { 
				
			//}
			
			_btnclose.alpha = 0.25;
			_btnbuy1.alpha = 0.25;
			_btnbuy2.alpha = 0.25;
			
			var myTimer:Timer = new Timer(500, 3);
			myTimer.addEventListener(TimerEvent.TIMER, timerListener);
			function timerListener (e:TimerEvent):void {
				_btnclose.alpha = 1;
				_btnbuy1.alpha = 1;
				_btnbuy2.alpha = 1;
				_btnclose.addEventListener(Event.TRIGGERED, gotoMenu);
				_btnbuy1.addEventListener(Event.TRIGGERED, buyPower1);
				_btnbuy2.addEventListener(Event.TRIGGERED, buyPower2);
			}
			myTimer.start();
		}
		
		private function buyPower1(e:Event):void 
		{
			GameData.useTaster += 1;
			GameData.saveData();
			_power1txt.text = "" + (0 + GameData.useTaster);
			pointShow(_power1, "+1");
			//_btnbuy1.visible = false;
			//_btnbuy2.visible = false;
			
			animateBuy();
		}
		
		private function buyPower2(e:Event):void 
		{
			GameData.useFreeze += 1;
			GameData.saveData();
			_power2txt.text = "" + GameData.useFreeze;
			pointShow(_power2, "+1");
			//_btnbuy1.visible = false;
			//_btnbuy2.visible = false;
			
			animateBuy();
		}
		
		private function animateBuy():void 
		{
			var _imgclipboard:Image;
			var placeholder:Sprite;
			
			_imgscreenmask = new Quad(Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT, 0x000000, true);
			_imgscreenmask.alpha = 0.5;
			this.addChild(_imgscreenmask);
			
			placeholder = new Sprite();
			this.addChild(placeholder);
			
			_imgclipboard = new Image(CandyFactory.assets.getTexture("clipboard_compact"));
			_imgclipboard.width = Constants.STAGE_WIDTH*0.8;
			_imgclipboard.height = Constants.STAGE_HEIGHT * 0.8;
			_imgclipboard.x = (Constants.STAGE_WIDTH - _imgclipboard.width) / 2;
			_imgclipboard.y = 0;
            placeholder.addChild(_imgclipboard);
			
			var txt_SFX:TextField = new TextField(Constants.STAGE_WIDTH * 0.6, Constants.STAGE_HEIGHT * 0.25, "Item has been added into your inventory", "Showcard Gothic", Constants.STAGE_HEIGHT * 0.03, 0xFFFFFF);
			txt_SFX.x = ((Constants.STAGE_WIDTH) - txt_SFX.width)/2;
			txt_SFX.y = Constants.STAGE_HEIGHT * 0.3 - (txt_SFX.height/2);
			placeholder.addChild(txt_SFX);
			
			_imgcloseclipboard = new Button(CandyFactory.assets.getTexture("btn_close"));
			_imgcloseclipboard.height = Constants.STAGE_WIDTH / 8;
			_imgcloseclipboard.width = _imgcloseclipboard.height;
			_imgcloseclipboard.x = (Constants.STAGE_WIDTH - _imgcloseclipboard.width)*0.8
			_imgcloseclipboard.y = _imgcloseclipboard.width*1.3;
			placeholder.addChild(_imgcloseclipboard);
			_imgcloseclipboard.addEventListener(Event.TRIGGERED, function closeBuy():void 
				{
					_imgscreenmask.visible = false;
					var popup:Tween = new Tween(placeholder, 0.5, "easeOutBack");
					popup.moveTo(0,Constants.STAGE_HEIGHT);
					Starling.juggler.add(popup);
					popup.onComplete = function():void {
						placeholder.visible = false;
						placeholder.y = 0;
						
						_imgscreenmask.removeFromParent(true);
						placeholder.removeFromParent(true);
					}
				}
			);
			
			/////////////////////////////////
			
			placeholder.y = Constants.STAGE_HEIGHT
			var popup:Tween = new Tween(placeholder, 0.5, "easeOutBack");
			popup.moveTo(0,Constants.STAGE_HEIGHT*0.1);
			Starling.juggler.add(popup);
		}
		
		private function gotoMenu(e:Event):void 
		{
			_btnclose.visible = false;
			GameAPI.GameState = 1;
			GameAPI.StateChange = true;
		}
		
		private function pointShow(x:Image,str:String):void {
			var txxt:TextField = new TextField(Constants.STAGE_WIDTH/2,(Constants.STAGE_WIDTH / 13.5)*2, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 24, 0xFFFFFF);
			txxt.x = x.x - (x.width/2);
			//txxt.border = true;
			txxt.y = x.y
			txxt.text = "" + str;
			this.addChild(txxt);
			var popup0:Tween = new Tween(txxt, 2, "easeOut");
			popup0.fadeTo(0);
			popup0.moveTo(txxt.x,txxt.y-(Constants.STAGE_WIDTH / 13.5*5));
			Starling.juggler.add(popup0);
			txxt.touchable = false;
			
			var pointkill:Timer = new Timer(1500, 1);
			pointkill.addEventListener(TimerEvent.TIMER, PKtimer);
			function PKtimer (e:TimerEvent):void{
				txxt.removeFromParent(true);
			}
			pointkill.start();
		}
	}

}