package  
{
	import api.Constants;
	import api.GameAPI;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	public class PowerUp extends Sprite  
	{
		public var power1:Button;
		
		public function PowerUp() 
		{
			power1 = new Button(CandyFactory.assets.getTexture("btn_blank"));
			power1.height = Constants.STAGE_WIDTH / 8;
			power1.width = power1.height;
			power1.text = "Add";
			power1.fontSize *= 1.5;
			power1.fontName = "Showcard Gothic";
            //power1.x = 0;
            power1.y = Constants.STAGE_HEIGHT - power1.height;
			addChild(power1);
			power1.addEventListener(Event.TRIGGERED, power1Triggered);
		}
		
		private function power1Triggered(e:Event):void 
		{
			GameAPI.powerType = "TASTER";
		}
		
	}

}