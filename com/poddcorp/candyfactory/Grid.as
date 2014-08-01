package  
{
	import api.Constants;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	public class Grid extends Sprite 
	{
		private var _imgstagecontainer:Image;
		private var level:Array = new Array( 4 );    //there are four rows
			
		
		public function Grid() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_imgstagecontainer = new Image(CandyFactory.assets.getTexture("stage_container"));
			_imgstagecontainer.width = Constants.STAGE_WIDTH;
			_imgstagecontainer.height = Constants.STAGE_HEIGHT;
            this.addChild(_imgstagecontainer);
			
			
			level[0] = [1, 2, 3, 4, 5];
			level[1] = [6, 7, 8, 10];
			level[2] = [11, 12, 13, 14, 15];
			level[3] = [16, 19, 20];
			for ( var row:int = 0; row < 4; row++ )
			{
				var str:String = " ";
				for ( var column:int = 0; column < level[row].length; column++ )
				{
					str += "" + level[row][column] + "";
				} 
				trace( str );
			}
			
		}
		
		/*private function addStack():void 
		{
			
			moveUp();
			for (var i:int = 0; i < 8; i++) {
				addBlock(i);
			}
		}
		
		private function moveUp():void 
		{
			if (ary.length != 0) {
				for ( var xi:int; xi < ary.length; xi++) {
					for( var xj:int; xj < ary[xi].length; xj++) {
						ary[xi][xj].y -= ary[xi][xj].getCandySize;
					}
				}
			}
		}
		
		private function addBlock(x:int):void 
		{
			var _obj:Candies = new Candies();
			
			var gap:Number = Constants.STAGE_WIDTH * 0.165;
			var xpos:Number = (_obj.getCandySize()) * x;
			_obj.x = gap + xpos;
			_obj.y = Constants.STAGE_HEIGHT * 0.82 - _obj.getCandySize();
			addChild(_obj);
			ary.push(_obj);
		}//*/
		
	}

}