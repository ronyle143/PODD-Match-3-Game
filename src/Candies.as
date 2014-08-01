package  
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Candies extends Sprite 
	{
		private var obj:Image;
		
		public var type:String;
		
		
		public function Candies() 
		{
			obj = new Image(CandyFactory.assets.getTexture("btn_close"));
			obj.width = Constants.STAGE_WIDTH/16;
			obj.height = obj.width;
            addChild(obj);
			type = "candy";
		}
		
	}

}