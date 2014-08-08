package
{
	import api.Constants;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.utils.Color;
	
	public class Candies extends Sprite
	{
		private var obj:Button;
		public var type:String;
		public var size:Number = Constants.STAGE_WIDTH / 13.5;
		
		public var xx:int;
		public var yy:int;
		
		public function Candies(pickednumber:int)
		{
			obj = new Button(CandyFactory.assets.getTexture("all_white"));
			var randomnum:int = Math.random() * 3 + 1;
			if (pickednumber != 0) {
				randomnum = pickednumber;
			}else {
				pickednumber = randomnum;
			}
			obj.width = size;
			obj.height = size;
			addChild(obj);
			if (randomnum == 0)
			{
				obj.alpha = 0.1;
			}
			type = "" + randomnum;
			xx = 0;
			yy = 0;
			var txtt:Image
			if (randomnum == 1)
			{
				txtt = new Image(CandyFactory.assets.getTexture("all_white"));
				txtt.color = Color.RED;
				obj.addChild(txtt);
			}
			if (randomnum == 2)
			{
				txtt = new Image(CandyFactory.assets.getTexture("all_white"));
				txtt.color = Color.BLUE;
				obj.addChild(txtt);
			}
			if (randomnum == 3)
			{
				txtt = new Image(CandyFactory.assets.getTexture("all_white"));
				txtt.color = Color.GREEN;
				obj.addChild(txtt);
			}
			if (randomnum == 4)
			{
				txtt = new Image(CandyFactory.assets.getTexture("all_white"));
				txtt.color = Color.YELLOW;
				obj.addChild(txtt);
			}
			if (randomnum == 5)
			{
				txtt = new Image(CandyFactory.assets.getTexture("all_white"));
				txtt.color = Color.WHITE;
				obj.addChild(txtt);
			}
			txtt.alpha = 0.5;
			
			obj.text = "" + pickednumber;
			obj.fontSize *= 3;
		}
		
		public function getCandySize():Number
		{
			return size;
		}
		
		public function getType():String
		{
			return type;
		}
		
		public function setXY(xxx:int, yyy:int):void
		{
			xx = xxx;
			yy = yyy;
		}
		
		public function getXY():Array
		{
			return [xx, yy];
		}
		
		public function toString():String
		{
			return type;
		}
		
		public function ping():Boolean {
			return true;
		}
	}

}