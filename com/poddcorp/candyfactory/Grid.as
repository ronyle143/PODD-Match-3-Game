package
{
	import api.Constants;
	import api.GameAPI;
	import api.GameData;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	
	public class Grid extends Sprite
	{
		private var _imgstagecontainer:Image;
		private var ary:Array = new Array(9);
		private var i:int;
		private var picked:Array = [];
		private var nullary:Array = [];
		private var delivery:Array = [];
		private var idle:Boolean = true;
		private var clear:Button;
		private var clearNull:Button;
		private var rem:Button;
		private var gib:Array = [];
		private var _imgtank:Image;
		public var addd:Button;
		
		public var _displayUI:DisplayUI;
		
		public function Grid()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_imgtank = new Image(CandyFactory.assets.getTexture("tank"));
			_imgtank.width = Constants.STAGE_HEIGHT * 0.1
			_imgtank.height = _imgtank.width * 2;
			this.addChild(_imgtank);
			_imgtank.x = Constants.STAGE_WIDTH - _imgtank.width*1.5;
			_imgtank.y = Constants.STAGE_HEIGHT * 0.87 -  _imgtank.height;
			_imgtank.filter = BlurFilter.createDropShadow();
			
			_imgstagecontainer = new Image(CandyFactory.assets.getTexture("stage_container"));
			_imgstagecontainer.width = Constants.STAGE_WIDTH;
			_imgstagecontainer.height = Constants.STAGE_HEIGHT;
			this.addChild(_imgstagecontainer);
			_imgstagecontainer.filter = BlurFilter.createDropShadow();
			
			//-----------------------------------------------------------
			
			addd = new Button(CandyFactory.assets.getTexture("btn_blank"));
			addd.height = Constants.STAGE_WIDTH / 8;
			addd.width = addd.height;
			addd.text = "Add";
			addd.fontSize *= 1.5;
			addd.fontName = "Showcard Gothic";
            addd.x = 0;
            addd.y = this.height - addd.height;
			//this.addChild(addd);
			addd.addEventListener(Event.TRIGGERED, adddStack);
			
			rem = new Button(CandyFactory.assets.getTexture("btn_blank"));
			rem.height = Constants.STAGE_WIDTH / 8;
			rem.width = rem.height;
			rem.text = "Del";
			rem.fontSize *= 1.5;
			rem.fontName = "Showcard Gothic";
            rem.x = rem.width;
            rem.y = this.height - addd.height;
			//this.addChild(rem);
			rem.addEventListener(Event.TRIGGERED, deleteAll);
			
			//--------------------------------------------------------------
			
			for (i = 0; i < ary.length; i++)
			{
				ary[i] = [];
			}
			
			/*addCustomStack([ 1, 1, 1, 3, 3, 3, 1, 1, 1, 1]);
			addCustomStack([ 1, 1, 1, 2, 3, 2, 1, 1, 1, 1]);
			addCustomStack([ 1, 1, 1, 2, 3, 2, 1, 1, 1, 1]);
			addCustomStack([ 1, 1, 2, 2, 3, 2, 2, 1, 1, 1]);
			addCustomStack([ 1, 1, 1, 1, 3, 1, 1, 1, 1, 1]);//*/
			addStack();
			addStack();
			addStack();
			addStack();//*/
			
			_displayUI = new DisplayUI();
			addChild(_displayUI);
			_displayUI.init();
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, looop);
		}
		
		private function adddStack(e:Event):void 
		{
			addStack();
		}
		
		public function addStack():void
		{
			for (i = 0; i < ary.length; i++)
			{
				addBlock(i,0);
			}
			arrange();
		}
		
		private function addCustomStack(x:Array):void
		{
			while (x.array <= ary.length) {
				x.push(0);
			}
			for (i = 0; i < ary.length; i++)
			{
				addBlock(i,x[i]);
			}
			arrange();
		}
		
		private function addBlock(x:int,type:int):void
		{
			
			var _obj:Candies = new Candies(type);
			var jj:int = ary[x].unshift(_obj) - 1;
			_obj.setXY(x, jj);
			addChild(_obj);
			_obj.x = (Constants.STAGE_WIDTH - _obj.width) / 2;
			_obj.y = (Constants.STAGE_HEIGHT * 0.77) + _obj.height;
			if (_obj.getType() != "0")
			{
				_obj.addEventListener(Event.TRIGGERED, function rem():void
					{						
						clickedObject(_obj.xx, _obj.yy, _obj.type);
					});
			}
		}
		
		private function clickedObject(xx:int, yy:int, type:String): void {
			if (GameAPI.powerType == "BURST") {
				clickBurst(xx, yy, type);
			}
			if (GameAPI.powerType == "TASTER") {
				clickTaster(xx, yy, type);
			}
			if (GameAPI.powerType == "REJECT") {
				
			}
			GameAPI.powerType == "BURST";
			
			trace("=========================================");
		}
		
		private function clickTaster(xx:int, yy:int, type:String):void 
		{
			if (idle) {
				
			}
		}
		
		private function clickBurst(xx:int, yy:int, type:String):void
		{
			if(idle){
				idle = false;
				picked = []; //reset list
				var arry:Array = [];
				var tmp:Array = [];
				arry.push([xx, yy]); // push this
				picked.push([xx, yy]); // add to list
				try{
					if (yy + 1 < ary[xx].length) // check if not off course
					{
						GameAPI.note("!", "[" + xx + "," + yy + "] checked: [" + xx + ", " + (yy + 1) + "]");
						if (ary[xx][yy + 1].type == type) //check if the type is the same
						{
							tmp = check(xx, yy + 1, type); 
							if (tmp.length != 0 ){ //check if it didn't return an empty array
								arry.push(tmp); //push the next
							}
						}
					}
				}
				catch (err:Error)
				{
					trace(picked[i]+" - Checking - up    "+err.message);
				}
				try
				{
					if (yy - 1 >= 0) // check if not off course
					{
						GameAPI.note("!", "["+xx+","+yy+"] checked: ["+xx+", "+(yy-1)+"]");
						if (ary[xx][yy - 1].type == type) //check if the type is the same
						{
							tmp = check(xx, yy - 1, type); 
							if (tmp.length != 0 ){ //check if it didn't return an empty array
								arry.push(tmp); //push the next
							}
						}
					}
				}
				catch (err:Error)
				{
					trace(picked[i]+" - Checking - down    "+err.message);
				}
				try
				{
					if (xx - 1 >= 0) // check if not off course
					{
						GameAPI.note("!", "["+xx+","+yy+"] checked: ["+(xx-1)+", "+yy+"]");
						if (ary[xx - 1][yy].type == type) //check if the type is the same
						{
							tmp = check(xx - 1, yy, type); 
							if (tmp.length != 0 ){ //check if it didn't return an empty array
								arry.push(tmp); //push the next
							}
						}
					}
				}
				catch (err:Error)
				{
					trace(picked[i]+" - Checking - left    "+err.message);
				}
				try
				{
					if (xx + 1 < ary.length) // check if not off course
					{
						GameAPI.note("!", "["+xx+","+yy+"] checked: ["+(xx+1)+", "+yy+"]");
						if (ary[xx + 1][yy].type == type) //check if the type is the same
						{
							tmp = check(xx + 1, yy, type); 
							if (tmp.length != 0 ){ //check if it didn't return an empty array
								arry.push(tmp); //push the next
							}
						}
					}
				}catch (err:Error)
				{
					trace(picked[i] + " - 1st Check - right    " + err.message);
				}//*/
					idle = true;
					delivery = [xx, yy];
					clearBlock(picked);
				trace("[" + picked.length + "] " + picked);
				
			}
		}
		
		private function check(xx:int, yy:int, type:String):Array
		{
			var arry:Array = [];
			var tmp:Array =[];
			var hasThis:Boolean = false;
			for (var i:int = 0; i < picked.length; i++) {
				if (picked[i][0] == xx && picked[i][1] == yy) {
					hasThis = true;
				}
			}
			if (!hasThis) {
				picked.push([xx, yy]);
				//trace(picked.length+" [" + xx + "," + yy + "] "+ type);
				arry.push([xx, yy]);
				try
				{
					if (yy + 1 < ary[xx].length) // check if not off course
					{
						GameAPI.note("!", "["+xx+","+yy+"] checked: ["+xx+", "+(yy+1)+"]");
						if (ary[xx][yy + 1].type == type) //check if the type is the same
						{
							tmp = check(xx, yy + 1, type); 
							if (tmp.length != 0 ){ //check if it didn't return an empty array
								arry.push(tmp); //push the next
							}
						}
					}
				}
				catch (err:Error)
				{
					trace(picked[i]+" - Checking - up    "+err.message);
				}
				try
				{
					if (yy - 1 >= 0) // check if not off course
					{
						GameAPI.note("!", "["+xx+","+yy+"] checked: ["+xx+", "+(yy-1)+"]");
						if (ary[xx][yy - 1].type == type) //check if the type is the same
						{
							tmp = check(xx, yy - 1, type); 
							if (tmp.length != 0 ){ //check if it didn't return an empty array
								arry.push(tmp); //push the next
							}
						}
					}
				}
				catch (err:Error)
				{
					trace(picked[i]+" - Checking - down    "+err.message);
				}
				try
				{
					if (xx - 1 >= 0) // check if not off course
					{
						GameAPI.note("!", "["+xx+","+yy+"] checked: ["+(xx-1)+", "+yy+"]");
						if (ary[xx - 1][yy].type == type) //check if the type is the same
						{
							tmp = check(xx - 1, yy, type); 
							if (tmp.length != 0 ){ //check if it didn't return an empty array
								arry.push(tmp); //push the next
							}
						}
					}
				}
				catch (err:Error)
				{
					trace(picked[i]+" - Checking - left    "+err.message);
				}
				try
				{
					if (xx + 1 < ary.length) // check if not off course
					{
						GameAPI.note("!", "["+xx+","+yy+"] checked: ["+(xx+1)+", "+yy+"]");
						if (ary[xx + 1][yy].type == type) //check if the type is the same
						{
							tmp = check(xx + 1, yy, type); 
							if (tmp.length != 0 ){ //check if it didn't return an empty array
								arry.push(tmp); //push the next
							}
						}
					}//*/
				}
				catch (err:Error)
				{
					trace(picked[i]+" - Checking - right    "+err.message);
				}
			}
			return arry;
		} //*/
		
		private function clearBlock(picked:Array):void 
		{
			trace(picked);
			picked.sort();
			trace("-------------");
			trace(picked);
			var counter:int = picked.length;
			var deleted:int = 0;
			var min:int = 3;
			if (picked.length >= min) {
				deliver(delivery[0], delivery[1]);
				pointShow(delivery[0], delivery[1],""+((picked.length-2)*10)*GameData.multiplier);
				var str:String = "To be deleted: ";
				for (i = picked.length-1; i >= 0 ; i--) {
					var xx:int = picked[i][0];
					var yy:int = picked[i][1];
					str += "[" + xx + ", " + yy + "]";
					try {
						//ary[xx][yy].visible = false;
						if (ary[xx][yy] != null) {
							deleted ++;
							trace("deletion at [" + xx + "," + yy + "]");
							ary[xx][yy].removeFromParent(true); 
						}else {
							trace("problem at [" + xx + "," + yy + "] - null reference");
							ary[xx].splice(yy, 1);
							ary[xx][yy].visible = false;
						}
						ary[xx].splice(yy, 1);
					}catch (err:Error)
					{
						trace(picked[i], " - Removing - ", err.message);
					}
				}
				for (var t:int = 0; t < ary.length; t++) {
					giveWay();
				}
				arrange();
				GameData.updateScore((deleted - 2) * 10);
				GameData.gauge += (deleted - 2)*GameData.multiplier;
				_displayUI.updateData();
			}else {
				GameData.multiplier = 1;
				GameData.gauge = 0;
				_displayUI.timeNow += (((_displayUI.timeInit / GameData.production * 60)) * 0.5);
			}
			
			trace("Deleted " + deleted + "/" + picked.length + " objects");
			
			
		}
		
		private function giveWay():void {
			try {
				var p:int = 0;
				var missing:int = 0;
				for (p = ary.length-1; p >=0; p--) {
					if (ary[p].length == 0 ) {
						ary.splice(p,1);
						ary.push([]);
						missing++;
					}
				}
				missing /= 2;
				for (; missing > 0; missing--) {
					ary.pop();
					ary.unshift([]);
				}
				/*for (p = 3; p >= 0; p--) {
					if (ary[p].length == 0 ) {
						ary.splice(p,1);
						ary.unshift([]);
					}
				}
				for (p = 4; p < 8; p++) {
					if (ary[p].length == 0 ) {
						ary.splice(p,1);
						ary.push([]);
					}
				}
				if (ary[3].length == 0 && ary[5].length != 0) {
					ary.splice(1,1);
					ary.push([]);
				}
				if (ary[4].length == 0 && ary[2].length != 0) {
					ary.splice(7,1);
					ary.unshift([]);
				}//*/
			}catch (err:Error)
			{
				
			}
		}
		
		private function arrange():void
		{
			if(idle){
				idle = false;
				var gap:Number = Constants.STAGE_WIDTH * 0.166;
				var objSize:Number = Constants.STAGE_WIDTH / 13.5;
				var baseY:Number = Constants.STAGE_HEIGHT * 0.78;
				var x:int;
				var y:int;
				var str:String = "ary: [";
				for (x = 0; x < ary.length && ary.length != 0; x++)
				{
					for (y = 0; y < ary[x].length && ary[x].length != 0; y++)
					{
						
						if (checkMax(y + 1)) {
							if (ary[x][y] == null) {
								ary[x].splice(y, 1);
							}
							ary[x][y].setXY(x, y);
							var popup:Tween = new Tween(ary[x][y], 0.5, "easeOutBounce");
							popup.moveTo(gap + (objSize * x),baseY - (objSize * y));
							Starling.juggler.add(popup);
							str += " " + ary[x][y];
							//var glow:Tween = new Tween(ary[x][y], 0.5, "easeOutBounce");
							//popup.moveTo(gap + (objSize * x),baseY - (objSize * y));
						}
					}
				}
				idle = true;
			}
		}
		
		private function checkMax(cols:int):Boolean 
		{
			var checkingMax:Boolean = true;
			if (cols > 15) {
				GameAPI.checktheMax = true;
				checkingMax = false
			}
			return checkingMax;
		}
		
		private function pointShow(x:int, y:int,str:String):void {
			var gap:Number = Constants.STAGE_WIDTH * 0.166;
			var objSize:Number = Constants.STAGE_WIDTH / 13.5;
			var baseY:Number = Constants.STAGE_HEIGHT * 0.77;
			var txxt:TextField = new TextField(objSize*2,objSize*2, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 24, 0xFF5555);
			txxt.x = gap + (objSize * x);
			txxt.y = baseY - (objSize * y);
			txxt.text = "" + str;
			addChild(txxt);
			var popup0:Tween = new Tween(txxt, 2, "easeOut");
			popup0.fadeTo(0);
			popup0.moveTo(txxt.x,txxt.y-(objSize*5));
			Starling.juggler.add(popup0);
			gib.push(txxt);
		}
		
		private function deliver(x:int, y:int):void {
			var gap:Number = Constants.STAGE_WIDTH * 0.166;
			var objSize:Number = Constants.STAGE_WIDTH / 13.5;
			var baseY:Number = Constants.STAGE_HEIGHT * 0.77;
			var _imgcrate:Image = new Image(CandyFactory.assets.getTexture("Crate"));
			_imgcrate.width = Constants.STAGE_WIDTH/12;
			_imgcrate.height = _imgcrate.width;
			_imgcrate.x = gap + (objSize * x);
			_imgcrate.y = baseY - (objSize * y);
			addChild(_imgcrate);
			var popup0:Tween = new Tween(_imgcrate, 1, "easeOut");
			popup0.fadeTo(0);
			popup0.moveTo(Constants.STAGE_WIDTH * 0.95,Constants.STAGE_HEIGHT * 0.9);
			Starling.juggler.add(popup0);
			gib.push(_imgcrate);
		}
		
		private function looop(e:EnterFrameEvent):void 
		{
			if (gib.length > 0) {
				if (gib[0].alpha <= 0) {
					gib.splice(0, 1);
				}
			}
		}
		
		private function deleteAll():void {
			if(idle){
				idle = false;
				for ( var i:int = ary.length-1; i >= 0; i--) {
					for ( var j:int = ary[i].length-1; j >= 0; j--) {
						//ary[i][j].pop();
						//ary[xx][yy].visible = false;
						ary[i][j].removeFromParent(true);
						ary[i].splice(j, 1);
					}
				}
				idle = true;
			}
		}
	}

}