package  
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	public class Grid extends Sprite 
	{
		private var img_stage_container:Image;
		static var ary:Array = [];
		
		public function Grid() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			img_stage_container = new Image(CandyFactory.assets.getTexture("stage_container"));
			img_stage_container.width = Constants.STAGE_WIDTH;
			img_stage_container.height = Constants.STAGE_HEIGHT;
            this.addChild(img_stage_container);
			
			createGrid();
		}
		
		
		private function createGrid():void 
		{
			addStack();
		}
		
		private function addStack():void 
		{
			addBlock(0);
			/*for (var i:int = 0; i < 10; i++) {
				addBlock(i);
			}//*/
		}
		
		private function addBlock(x:int):void 
		{
			
		}
		
	}

}