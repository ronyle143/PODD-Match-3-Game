package  
{
	import api.Constants;
	import api.GameData;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class DisplayUI extends Sprite 
	{
		private var _txtScore:TextField = new TextField(Constants.STAGE_WIDTH * 0.6, Constants.STAGE_HEIGHT / 10, "0", "Arista 2.0", Constants.STAGE_HEIGHT / 12, 0xFF5555);
		
		public function DisplayUI() 
		{
			init();
		}
		
		public function init():void 
		{
			_txtScore.text = "0";
			_txtScore.x = 0;
			_txtScore.y = 0;
			addChild(_txtScore);
		}
		
		public function updateData():void {
			_txtScore.text = ""+GameData.getScore();
		}
		
	}

}