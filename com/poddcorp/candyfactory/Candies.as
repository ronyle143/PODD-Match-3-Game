package  
{
	import api.Constants;
	import api.GameAPI;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	public class Candies extends Sprite 
	{
		private var obj:Button;
		public var type:String;
		public var size:Number = Constants.STAGE_WIDTH / 12;
		
		public var xx:int;
		public var yy:int;
		
		public function Candies() 
		{
			obj = new Button(CandyFactory.assets.getTexture("btn_close"));
			var randomnum:int = Math.random() * 5 +1;
			obj.text = "" + randomnum;
			obj.fontSize *= 3;
			obj.width = size;
			obj.height = size;
            addChild(obj);
			if (randomnum == 0) {
				obj.alpha = 0.1;
			}
			type = "" + randomnum;
			xx = 0;
			yy = 0;
		}
		public function getCandySize():Number {
			return size;
		}
		public function getType():String {
			return type;
		}
		public function setXY(xxx:int, yyy:int):void {
			xx = xxx;
			yy = yyy;
		}
		public function getXY():Array {
			return [xx,yy];
		}
		public function toString():String {
			return type;
		}
	}

}