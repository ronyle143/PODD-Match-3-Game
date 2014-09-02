package  com.poddcorp.candyfactory.screens.ui
{
	import com.poddcorp.candyfactory.api.Constants;
	import com.poddcorp.candyfactory.api.GameAPI;
	import com.poddcorp.candyfactory.api.GameData;
	import com.poddcorp.candyfactory.core.CandyFactory;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class PowerUp extends Sprite  
	{
		public var _power1:Button;
		public var _power1txt:TextField = new TextField(Constants.STAGE_WIDTH*0.16,Constants.STAGE_HEIGHT*0.05, "0", "BubbleBud", Constants.STAGE_HEIGHT / 25, 0x000000F);
		public var _power2:Button;
		public var _power2txt:TextField = new TextField(Constants.STAGE_WIDTH*0.16,Constants.STAGE_HEIGHT*0.05, "0", "BubbleBud", Constants.STAGE_HEIGHT / 25, 0x000000F);
		
		public function PowerUp() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_power1 = new Button(CandyFactory.assets.getTexture("scoopUp"));
			_power1.height = Constants.STAGE_WIDTH / 8;
			_power1.width = _power1.height;
			//_power1.text = "Taster";
			_power1.fontSize *= 0.8;
			_power1.textHAlign = "center";
			_power1.fontName = "BubbleBud";
            _power1.x = Constants.STAGE_HEIGHT*0.007;
            _power1.y = Constants.STAGE_HEIGHT*0.35 - _power1.height;
			addChild(_power1);
			_power1.filter = BlurFilter.createDropShadow();
			_power1.addEventListener(Event.TRIGGERED, power1Triggered);
			_power1txt.text = "" + GameData.useTaster;
			_power1txt.touchable = false;
			addChild(_power1txt);
			_power1txt.x = 0;
			//_power1txt.border = true;
			_power1txt.hAlign = "right";
			_power1txt.y = _power1.y + _power1.height / 1.7;
			_power1txt.filter = BlurFilter.createDropShadow(0, 0.785, 0xFFFFFF, 1);
			
			_power2 = new Button(CandyFactory.assets.getTexture("timefreeze"));
			_power2.height = Constants.STAGE_WIDTH / 8;
			_power2.width = _power2.height;
			//_power2.text = "Freeze";
			_power2.fontSize *= 0.8;
			_power2.textHAlign = "center";
			_power2.fontName = "BubbleBud";
            _power2.x = Constants.STAGE_HEIGHT*0.007;
            _power2.y = Constants.STAGE_HEIGHT*0.4;
			addChild(_power2);
			_power2.filter = BlurFilter.createDropShadow();
			_power2.addEventListener(Event.TRIGGERED, power2Triggered);
			_power2txt.text = "" + GameData.useFreeze;
			_power2txt.touchable = false;
			addChild(_power2txt);
			_power2txt.x = 0;
			//_power2txt.border = true;
			_power2txt.hAlign = "right";
			_power2txt.y = _power2.y + _power2.height / 1.7;
			_power2txt.filter = BlurFilter.createDropShadow(0, 0.785, 0xFFFFFF, 1);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, loop);
		}
		
		private function loop(e:EnterFrameEvent):void 
		{
			if (GameData.useTaster > 0) {
				_power1.alpha = 1;
			}else {
				_power1.alpha = 0.1;
			}
			_power1txt.text = "" + GameData.useTaster;
			if (GameData.useFreeze > 0) {
				_power2.alpha = 1;
			}else {
				_power2.alpha = 0.1;
			}
			_power2txt.text = "" + GameData.useFreeze;
		}
		
		private function power1Triggered(e:Event):void 
		{
			GameAPI.powerType = "TASTER";
			_power1.filter = BlurFilter.createGlow(Color.WHITE);
		}
		
		private function power2Triggered(e:Event):void 
		{
			if (GameData.timeMod == 1) {
				GameData.timeMod = 0.1;
				var myTimer:Timer = new Timer(10000, 1);
				myTimer.addEventListener(TimerEvent.TIMER, timerListener);
				function timerListener (e:TimerEvent):void{
					GameData.timeMod = 1;
					_power2.filter = BlurFilter.createDropShadow();
				}
				myTimer.start();
				GameData.useFreeze -= 1;
				GameData.saveData();
				_power2.filter = BlurFilter.createGlow(Color.WHITE);
			}
		}
	}

}