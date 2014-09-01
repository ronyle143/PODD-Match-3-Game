package com.poddcorp.candyfactory.screens.ui
{
	import com.poddcorp.candyfactory.api.Constants;
	import com.poddcorp.candyfactory.api.GameAPI;
	import com.poddcorp.candyfactory.api.GameAudio;
	import com.poddcorp.candyfactory.api.GameData;
	import com.poddcorp.candyfactory.core.CandyFactory;
	import com.poddcorp.candyfactory.entities.Candies;
	import com.poddcorp.candyfactory.screens.ui.DisplayUI;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.utils.Timer;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
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
		private var _imgtank:Image;
		private var _imgscreenmask:Quad;
		public var addd:Button;
		private var _timerTxt:TextField = new TextField(Constants.STAGE_WIDTH*0.2,Constants.STAGE_HEIGHT*0.3, "3", "Showcard Gothic", Constants.STAGE_HEIGHT / 5, 0xFFFFFF);
		private var timeEstaato:Number;
		
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
			
			/*addCustomStack([ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
			addCustomStack([ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
			addCustomStack([ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
			addCustomStack([ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
			/*addCustomStack([ 1, 1, 1, 2, 3, 2, 1, 1, 1, 1]);
			addCustomStack([ 1, 1, 1, 2, 3, 2, 1, 1, 1, 1]);
			addCustomStack([ 1, 1, 2, 2, 3, 2, 2, 1, 1, 1]);
			addCustomStack([ 1, 1, 1, 1, 3, 1, 1, 1, 1, 1]);//*/
			addStack();
			
			addStack();
			addStack();
			addStack();
			/*addStack();
			
			addStack();
			addStack();
			addStack();
			addStack();
			
			addStack();
			addStack();
			addStack();
			addStack();//*/
			
			_displayUI = new DisplayUI();
			this.addChild(_displayUI);
			_displayUI.init();
						
			_imgscreenmask = new Quad(Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT, 0x000000, true);
			_imgscreenmask.alpha = 0.5;
			this.addChild(_imgscreenmask);
			
			timeEstaato = 3;
			_timerTxt.text = ""+timeEstaato;
			_timerTxt.x = (Constants.STAGE_WIDTH - _timerTxt.width) / 2;
			_timerTxt.y = (Constants.STAGE_HEIGHT - _timerTxt.height) / 2;
			//_timerTxt.filter = BlurFilter.createDropShadow();
			//_timerTxt.border = true;
			this.addChild(_timerTxt);
			
			GameAPI.checktheBlock = false;
			GameAPI.paused = true;
			var myTimer:Timer = new Timer(1000, 3);
			myTimer.addEventListener(TimerEvent.TIMER, timerListener);
			function timerListener (e:TimerEvent):void{
				timeEstaato--;
				_timerTxt.text = "" + timeEstaato;
				if (timeEstaato == 0) {
					_timerTxt.text = "";
				}
			}
			myTimer.start();
			myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, estaato);
		}
		
		private function estaato(e:TimerEvent):void 
		{
			GameAPI.paused = false;
			_imgscreenmask.removeFromParent(true);
			_timerTxt.removeFromParent(true);
		}
		
		private function adddStack(e:Event):void 
		{
			GameData.useTaster++;
			GameData.saveData();
			
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
			this.addChild(_obj);
			_obj.x = (Constants.STAGE_WIDTH - _obj.width) / 2;
			_obj.y = (Constants.STAGE_HEIGHT * 0.77) + _obj.height;
			if (_obj.getType() != "0")
			{
				_obj.addEventListener(TouchEvent.TOUCH, 
					function rem(event:TouchEvent):void {		
						//trace(_obj.xx,_obj.yy);
						pass(event, _obj.xx, _obj.yy, _obj.type);
					}
				);
			}
		}
		
		private function pass(event:TouchEvent, xx:int, yy:int, type:String):void 
		{
			var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				clickedObject(xx, yy, type);
			}
			
		}
		
		private function clickedObject(xx:int, yy:int, type:String): void {
			if(idle && !GameAPI.paused){
				if (GameAPI.powerType == "BURST") {
					clickBurst(xx, yy, type);
				}
				if (GameAPI.powerType == "TASTER" && GameData.useTaster > 0) {
					clickTaster(xx, yy, type);
					_displayUI.powerUpUI._power1.filter = BlurFilter.createDropShadow();
				}
				if (GameAPI.powerType == "REJECT") {
					
				}
				GameAPI.powerType = "BURST";
				
				trace("========================================="+ GameAPI.powerType);
			}
		}
		
		private function clickTaster(xx:int, yy:int, type:String):void 
		{
			if (idle) 
			{
				idle = false;
				picked = [];
				try 
				{
					var g:int = 0;
					for (g = 0; g < ary[xx].length; g++) {
						picked.push([xx,g]);
					}
					for (g = 0; g < 9; g++) {
						if (ary[g].length - 1 >= yy) {
							picked.push([g,yy]);
						}
					}
				}catch (err:Error) 
				{
					
				}
				idle = true;
				delivery = [xx, yy];
				clearBlock(picked, 2);
				GameData.useTaster--;
				GameAPI.powerType = "BURST";
				GameData.saveData();
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
						ary[xx][yy+1].ping();
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
						ary[xx][yy-1].ping();
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
					if (xx - 1 >= 0 && ary[xx-1].length > yy) // check if not off course
					{
						ary[xx-1][yy].ping();
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
					if (xx + 1 < ary.length && ary[xx+1].length > yy) // check if not off course
					{
						ary[xx+1][yy].ping();
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
					var min:int = 3;
					if (picked.length >= 9) {
							colorBomb(type);
							pointShow(delivery[0], delivery[1]+ 1, "COLOR BOMB!");
							clearBlock(picked);
					}
					else if (picked.length >= min) {
							clearBlock(picked);
					}else{
							if (GameData.multiplier > 1) {
								GameData.multiplier--;
							};
							GameData.gauge = 0;
							_displayUI.timeNow += (((_displayUI.timeInit / GameData.production * 60)) * 0.5);
					}
					/*
					if (picked.length >= min) {
							clearBlock(picked);
					}else {
						if (GameData.multiplier > 1) {
							GameData.multiplier--;
						};
						GameData.gauge = 0;
						_displayUI.timeNow += (((_displayUI.timeInit / GameData.production * 60)) * 0.5);
					}*/
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
						ary[xx][yy+1].ping();
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
						ary[xx][yy-1].ping();
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
					if (xx - 1 >= 0 && ary[xx-1].length > yy) // check if not off course
					{
						ary[xx-1][yy].ping();
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
					if (xx + 1 < ary.length && ary[xx+1].length > yy) // check if not off course
					{
						ary[xx+1][yy].ping();
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
		
		private function clearBlock(picked:Array,bonus:int=0):void 
		{
			trace(picked);
			picked.sortOn(["0","1"], Array.NUMERIC);
			trace("-------------");
			trace(picked);
			var counter:int = picked.length;
			var deleted:int = 0;
			//deliver(delivery[0], delivery[1]);
			pointShow(delivery[0], delivery[1],""+((picked.length-2+bonus)*10)*GameData.multiplier);
			var str:String = "To be deleted: ";
			for (i = picked.length-1; i >= 0 ; i--) {
				var xx:int = picked[i][0];
				var yy:int = picked[i][1];
				str += "[" + xx + ", " + yy + "]";
				try {
					//ary[xx][yy].visible = false;
					if (ary[xx][yy] != null) {
						deleted ++;
						GameAudio.playSound("pop");
						particle(ary[xx][yy]);
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
					trace("Removing"+ " @ "+picked[i], " - ", err.message);
				}
			}
			for (var t:int = 0; t < ary.length; t++) {
				giveWay();
			}
			arrange();
			GameData.updateScore(((deleted - 2) * 10)*GameData.multiplier);
			GameData.gauge += (deleted - 2)*GameData.multiplier;
			_displayUI.updateData();
			trace("Deleted " + deleted + "/" + picked.length + " objects");
			
			var thalos:Boolean = true;
			for ( var k:int = 0; k < ary.length; k++) {
				if ( ary[k].length != 0) {
					thalos = false;
				}
			}
			if (thalos) {
				trace("trigger",delivery[0], delivery[1]);
				pointShow(delivery[0], delivery[1]+ 1, "EXCELLENT!");
				addStack();
				GameAPI.checktheBlock = false;
			}
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
				missing = (missing/2);
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
				var total:int = 0;
				var gap:Number = Constants.STAGE_WIDTH * 0.166;
				var objSize:Number = Constants.STAGE_WIDTH / 13.5;
				var baseY:Number = Constants.STAGE_HEIGHT * 0.77;
				var x:int;
				var y:int;
				var str:String = "ary: [";
				for (x = 0; x < ary.length && ary.length != 0; x++)
				{
					for (y = 0; y < ary[x].length && ary[x].length != 0; y++)
					{
						
						if (checkMax(y + 1)) {
							ary[x][y].ping();
							if (ary[x][y] == null) {
								ary[x].splice(y, 1);
							}
							total++;
							ary[x][y].setXY(x, y);
							var popup:Tween = new Tween(ary[x][y], 0.3, "easeOutBounce");
							popup.moveTo(gap + (objSize * x),baseY - (objSize * y));
							Starling.juggler.add(popup);
							str += " " + ary[x][y];
							//var glow:Tween = new Tween(ary[x][y], 0.5, "easeOutBounce");
							//popup.moveTo(gap + (objSize * x),baseY - (objSize * y));
						}
					}
				}
				idle = true;
				if (total == 0) {
					
					//GameData.useTaster += 3;
					//GameData.useFreeze += 1;
					pointShow(delivery[0], delivery[1]+ 2, "+"+GameData.score/2);
					GameData.score += GameData.production*GameData.multiplier;
					//pointShow( -2, 12, "+3");
					//pointShow(-2, 8, "+1");
					GameData.saveData();
				}
			}
		}
		
		private function checkMax(cols:int):Boolean 
		{
			var checkingMax:Boolean = true;
			if (cols > 13) {
				GameAPI.checktheMax = true;
				checkingMax = false
			}
			return checkingMax;
		}
		
		private function pointShow(x:int, y:int,str:String):void {
			var gap:Number = Constants.STAGE_WIDTH * 0.166;
			var objSize:Number = Constants.STAGE_WIDTH / 13.5;
			var baseY:Number = Constants.STAGE_HEIGHT * 0.77;
			var txxt:TextField = new TextField(Constants.STAGE_WIDTH/2,objSize*2, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 24, 0xFFFFFF);
			txxt.x = (gap + (objSize * x)) + objSize/2 - txxt.width / 2;
			//txxt.border = true;
			txxt.y = baseY - (objSize * y);
			txxt.text = "" + str;
			this.addChild(txxt);
			var popup0:Tween = new Tween(txxt, 2, "easeOut");
			popup0.fadeTo(0);
			popup0.moveTo(txxt.x,txxt.y-(objSize*5));
			Starling.juggler.add(popup0);
			txxt.touchable = false;
			
			var pointkill:Timer = new Timer(1500, 1);
			pointkill.addEventListener(TimerEvent.TIMER, PKtimer);
			function PKtimer (e:TimerEvent):void{
				txxt.removeFromParent(true);
			}
			pointkill.start();
		}
		
		private function particle(x:Candies):void {
			/*var xx:Number = x.x;
			var yy:Number = x.y;
			var size:Number = x.size;*/
			
			var star:Image = new Image(CandyFactory.assets.getTexture("img_star"));
			star.width = x.size;
			star.height = x.size;
			star.x = x.x;
			star.y = x.y;
			star.touchable = false;
			this.addChild(star);
			
			var starTween:Tween = new Tween(star, 0.5, "easeOut");
			starTween.fadeTo(0);
			starTween.moveTo(star.x - (star.width*1.5), star.y - (star.height *1.5));
			starTween.scaleTo(2);
			Starling.juggler.add(starTween);
			
			var starkill:Timer = new Timer(1500, 1);
			starkill.addEventListener(TimerEvent.TIMER, starTimer);
			function starTimer (e:TimerEvent):void{
				star.removeFromParent(true);
			}
			starkill.start();
		}
		
		public function colorBomb(type:String):void {
			for ( var ii:int = ary.length-1; ii >= 0; ii--) {
				for ( var jj:int = ary[ii].length - 1; jj >= 0; jj--) {
					
					
					
					if (ary[ii][jj].type == type) {
						
						var hasThis:Boolean = false;
						for (var iii:int = 0; iii < picked.length; iii++) {
							if (picked[iii][0] == ii && picked[iii][1] == jj) {
								hasThis = true;
							}
						}
						if (!hasThis) {
							picked.push([ii, jj]);
						}
					}
					
					
					
					
				}
			}
		}
		
		public function deleteAll():void {
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