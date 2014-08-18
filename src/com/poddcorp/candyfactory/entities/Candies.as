package com.poddcorp.candyfactory.entities
{
	import com.poddcorp.candyfactory.api.Constants;
	import com.poddcorp.candyfactory.api.GameAPI;
	import com.poddcorp.candyfactory.core.CandyFactory;
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
			obj = new Button(CandyFactory.assets.getTexture("mesh_candy_holder"));
			var randomnum:int = Math.random() * GameAPI.difficulty + 1;
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
				txtt = new Image(CandyFactory.assets.getTexture("candy_red"));
				//txtt.color = Color.RED;
			}
			if (randomnum == 2)
			{
				txtt = new Image(CandyFactory.assets.getTexture("candy_blue"));
				//txtt.color = Color.BLUE;
			}
			if (randomnum == 3)
			{
				txtt = new Image(CandyFactory.assets.getTexture("candy_green"));
				//txtt.color = Color.GREEN;
			}
			if (randomnum == 4)
			{
				txtt = new Image(CandyFactory.assets.getTexture("candy_yellow"));
				//txtt.color = Color.YELLOW;
			}
			if (randomnum == 5)
			{
				txtt = new Image(CandyFactory.assets.getTexture("candy_orange"));
				//txtt.color = Color.WHITE;
			}
			//txtt.alpha = 0.5;
			obj.addChild(txtt);
			//obj.text = "" + pickednumber;
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