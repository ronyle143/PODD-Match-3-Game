package  
{
	import api.Constants;
	import starling.display.Button;
	import starling.display.Sprite;
	
	public class Candies extends Sprite 
	{
		private var obj:Button;
		
		public var type:String;
		public var size:Number = Constants.STAGE_WIDTH/12;
		
		
		public function Candies() 
		{
			obj = new Button(CandyFactory.assets.getTexture("btn_close"));
			obj.width = size;
			obj.height = size;
            addChild(obj);
			type = "candy";
		}
		public function getCandySize():Number {
			return size;
		}
		public function getType():String {
			return type;
		}
		
	}

}