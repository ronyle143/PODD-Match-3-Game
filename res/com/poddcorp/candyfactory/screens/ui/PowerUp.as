package  com.poddcorp.candyfactory.screens.ui
{
	import com.poddcorp.candyfactory.api.Constants;
	import com.poddcorp.candyfactory.api.GameAPI;
	import com.poddcorp.candyfactory.api.GameData;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	
	public class PowerUp extends Sprite  
	{
		public var power1:Button;
		public var _txtScore:TextField = new TextField(Constants.STAGE_WIDTH*0.1,Constants.STAGE_HEIGHT*0.05, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 25, 0x000000F);
		
		public function PowerUp() 
		{
			power1 = new Button(CandyFactory.assets.getTexture("all_white"));
			power1.height = Constants.STAGE_WIDTH / 8;
			power1.width = power1.height;
			power1.text = "Taster";
			power1.fontSize *= 0.8;
			power1.textHAlign = "center";
			power1.fontName = "Showcard Gothic";
            power1.x = Constants.STAGE_HEIGHT*0.007;
            power1.y = Constants.STAGE_HEIGHT*0.37 - power1.height;
			addChild(power1);
			power1.filter = BlurFilter.createDropShadow();
			power1.addEventListener(Event.TRIGGERED, power1Triggered);
			_txtScore.text = "" + GameData.useTaster;
			addChild(_txtScore);
			_txtScore.x = power1.x + power1.width / 3;
			//_txtScore.border = true;
			_txtScore.hAlign = "right";
			_txtScore.y = power1.y + power1.height / 1.7;
			_txtScore.filter = BlurFilter.createDropShadow(0, 0.785, 0xFFFFFF, 1);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, loop);
		}
		
		private function loop(e:EnterFrameEvent):void 
		{
			if (GameData.useTaster > 0) {
				power1.alpha = 1;
			}else {
				power1.alpha = 0.1;
			}
			_txtScore.text = "" + GameData.useTaster;
		}
		
		private function power1Triggered(e:Event):void 
		{
			GameAPI.powerType = "TASTER";
		}
		
	}

}