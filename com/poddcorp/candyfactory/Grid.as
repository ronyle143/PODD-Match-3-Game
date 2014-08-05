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
		private var ary:Array = new Array(8); 
		private	var i:int;
		
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
			
			for (i = 0; i < ary.length; i ++) {
				ary[i] = [];
			}
			
			addStack();
			addStack();
			addStack();
			addStack();
			addStack();
			addStack();
			addStack();
			addStack();
			
			trace(ary);
		}
		
		private function addStack():void 
		{
			for ( i = 0; i < ary.length; i ++) {
				addBlock(i);
			}
		}
		
		private function addBlock(x:int):void 
		{
			
			var _obj:Candies = new Candies();
			var jj:int = ary[x].push(_obj) - 1;
			_obj.setXY(x, jj);
			addChild(_obj);
			arrange();
			if(_obj.getType() != "0"){
				_obj.addEventListener(Event.TRIGGERED, function rem():void {
						ary[_obj.xx].splice(_obj.yy, 1);
						_obj.removeFromParent(true);
						arrange();
						trace(""+_obj+" - +["+x+", "+jj +"] ("+ _obj.x+", "+_obj.y+")");//*/
						
						//checkFirst(_obj.xx,_obj.yy,_obj.type);
				});
			}
		}
		/*
		private function checkFirst(xx:int, yy:int,type:String):void 
		{
			var arry:Array = [];
			arry.push([xx, yy]);
			if (yy + 1 < ary[xx].length) {
				if (ary[xx][yy+1].type == type) {
					arry.push(check(xx, yy + 1, type));
				}
			}
			if (xx - 1 >= 0) {
				if (ary[xx-1][yy].type == type) {
					arry.push(check(xx - 1, yy, type));
				}
			}
			if (yy - 1 >= 0) {
				if (ary[xx][yy-1].type == type) {
					arry.push(check(xx, yy - 1, type));
				}
			}
			if (xx + 1 < ary.length) {
				if (ary[xx+1][yy].type == type) {
					arry.push(check(xx + 1, yy, type));
				}
			}
			
			trace(arry);
		}
		
		private function check(xx:int, yy:int,type:String):Array 
		{
			var arry:Array = [];
			arry.push([xx, yy]);
			if (yy + 1 < ary[xx].length) {
				if (ary[xx][yy+1].type == type) {
					arry.push(check(xx, yy + 1,type));
				}
			}
			if (xx - 1 >= 0) {
				if (ary[xx-1][yy].type == type) {
					arry.push(check(xx - 1, yy, type));
				}
			}
			if (yy - 1 >= 0) {
				if (ary[xx][yy-1].type == type) {
					arry.push(check(xx, yy - 1, type));
				}
			}
			if (xx + 1 < ary.length) {
				if (ary[xx+1][yy].type == type) {
					arry.push(check(xx + 1, yy, type));
				}
			}
			return arry;
		}//*/
		
		
		private function arrange():void 
		{
			var gap:Number = Constants.STAGE_WIDTH * 0.166;
			var objSize:Number = Constants.STAGE_WIDTH / 12;
			var baseY:Number = Constants.STAGE_HEIGHT * 0.77;
			var x:int;
			var y:int;
			var str:String = "ary: [";
			for ( x = 0; x < ary.length && ary.length != 0; x++) {
				for (y = 0; y < ary[x].length && ary[x].length != 0; y++ ) {
					ary[x][y].setXY(x, y);
					ary[x][y].x = gap + (objSize * x);
					ary[x][y].y = baseY - (objSize * y);
					str += " " + ary[x][y];
				}
			}
			trace(str);
			
		}
	}

}