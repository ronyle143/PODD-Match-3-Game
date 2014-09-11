package  com.poddcorp.candyfactory.screens.ui
{
	import com.poddcorp.candyfactory.api.Constants;
	import com.poddcorp.candyfactory.api.GameAPI;
	import com.poddcorp.candyfactory.api.GameData;
	import com.poddcorp.candyfactory.core.CandyFactory;
	import feathers.controls.ImageLoader;
	import feathers.controls.text.TextFieldTextRenderer;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class DisplayUI extends Sprite 
	{		
		private var _txtScore:TextField = new TextField(Constants.STAGE_WIDTH*0.8,Constants.STAGE_HEIGHT*0.05, "0", "BubbleBud", Constants.STAGE_HEIGHT * 0.04, 0xFFFF11); //0xFF6666 0xFFFFFF
		public var _txtmultiplier:TextField = new TextField(Constants.STAGE_WIDTH * 0.125,Constants.STAGE_HEIGHT*0.08, "0", "BubbleBud", Constants.STAGE_HEIGHT * 0.04, 0xFFFFFF);
		private var _timebar:Quad;
		private var _imgtimebarframe:Image;
		private var _imgscoregoal:Image;
		private var _imgcpm:Image;
		private var _imggauge:Image;
		private var _imggaugeindicator:Image;
		public var timeInit:int;
		public var timeNow:Number;
		private var gaugehieght:Number = -(Constants.STAGE_HEIGHT * 0.464);
		private var timerDefault:Number;
		
		private var _imgtimerindicator:MovieClip;
		
		private var _timerswirl:Image;
		private var _timerfill:Quad;
		private var _gaugefill:Quad;
		private var _multicase:Image;
		private var _swirlX:Number;
		public var powerUpUI:PowerUp;
		
		private var _casehider:Array = [];
		
		public function DisplayUI() 
		{
			init();
		}
		
		public function init():void 
		{
			removeEventListeners();
			
			updateData();
			addChild(_txtScore);
			
			var gap:Number = Constants.STAGE_WIDTH * 0.166;
			var objX:Number = Constants.STAGE_WIDTH * 0.673;
			var objY:Number = Constants.STAGE_WIDTH * 0.04;
			var baseY:Number = Constants.STAGE_HEIGHT * 0.9;
			_timebar = new Quad(objX, objY, 0xFF8888, true);
			_timebar.x = gap;
			_timebar.y = baseY ;
			_timebar.alpha = 0.7;
			//this.addChild(_timebar);
			
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			_imgtimebarframe = new Image(CandyFactory.assets.getTexture("timer_frame"));
			_imgtimebarframe.width = Constants.STAGE_WIDTH * 0.74;
			_imgtimebarframe.height = _imgtimebarframe.width / 8;
			_imgtimebarframe.x = (Constants.STAGE_WIDTH - _imgtimebarframe.width) / 2;
			_imgtimebarframe.y =Constants.STAGE_HEIGHT - ((GameData.gridgap + _imgtimebarframe.height) / 2);
			//Constants.STAGE_HEIGHT * 0.1 ;//
			_timerfill = new Quad(_imgtimebarframe.width * 0.01, _imgtimebarframe.height * 0.5, 0xFFA526);
			//_timerfill.width = _imgtimebarframe.width;
			//_timerfill.height = _imgtimebarframe.height;
			_timerfill.x = _imgtimebarframe.x + (_timerfill.height * 0.5);
			_timerfill.y = _imgtimebarframe.y + (_timerfill.height * 1);
			_timerfill.pivotY = _timerfill.height / 2;
			
			_swirlX = _imgtimebarframe.x - (_imgtimebarframe.height / 2);
			
			//_imgtimerindicator = new Quad(_imgtimebarframe.width / 8, _imgtimebarframe.width / 8, 0xFFA526); _imgtimerindicator.alpha = 0.5;
			_imgtimerindicator = new MovieClip(CandyFactory.assets.getTextures("swirl_0"), 18);
			_imgtimerindicator.width = _imgtimebarframe.height;
			_imgtimerindicator.height = _imgtimebarframe.height;
			_imgtimerindicator.x = _swirlX;
			timerDefault = _imgtimerindicator.x;
			_imgtimerindicator.y = _imgtimebarframe.y;
			//_imgtimerindicator.pivotX = (_imgtimerindicator.width / 2);
			//_imgtimerindicator.pivotY = (_imgtimerindicator.height / 2);
			
			
//_imgtimerindicator.alpha = 0.2;
			
			this.addChild(_timerfill);
			this.addChild(_imgtimebarframe);
			this.addChild(_imgtimerindicator);
			
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			_imggauge = new Image(CandyFactory.assets.getTexture("gauge"));
			_imggauge.width = Constants.STAGE_HEIGHT * 0.070;
			_imggauge.height =_imggauge.width * 8;
			_imggauge.x = Constants.STAGE_WIDTH - _imggauge.width;
			_imggauge.y = (Constants.STAGE_HEIGHT -  _imggauge.height +_txtmultiplier.height) /2;
			
			_gaugefill = new Quad(_imggauge.width * 0.6, _imggauge.height * 0.05, 0x1B3060);
			//_gaugefill.width = _imggauge.width;
			//_gaugefill.height = _imggauge.height;
			_gaugefill.pivotX = _gaugefill.width / 2;
			_gaugefill.x = _imggauge.x + (_imggauge.width / 2);
			_gaugefill.y = _imggauge.y + (_imggauge.height * 0.97);
			
			gaugehieght = -_imggauge.height + (_imggauge.width);
			
			_imggaugeindicator = new Image(CandyFactory.assets.getTexture("timer_swirl"));
			_imggaugeindicator.width = _imggauge.width;
			_imggaugeindicator.height = _imggaugeindicator.width;
			_imggaugeindicator.x = (Constants.STAGE_WIDTH - _imggaugeindicator.width);
			_imggaugeindicator.y = (Constants.STAGE_HEIGHT * 0.9 -  _imggaugeindicator.height);
			_imggaugeindicator.visible = false;
			
			this.addChild(_gaugefill);
			this.addChild(_imggauge);
			this.addChild(_imggaugeindicator);
			//_imggaugeindicator.alpha = 0.5;
			
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			_multicase = new Image(CandyFactory.assets.getTexture("box_100"));
			_multicase.width = _imggauge.width*1.1;
			_multicase.height = _txtmultiplier.height;
			_multicase.x = Constants.STAGE_WIDTH - _multicase.width;
			_multicase.y = _imggauge.y - _txtmultiplier.height;
			this.addChild(_multicase);
			
			_txtmultiplier.text = "x" + GameData.multiplier;
			_txtmultiplier.width = _imggauge.width*1.1;
			_txtmultiplier.x = Constants.STAGE_WIDTH - _txtmultiplier.width;
			_txtmultiplier.y = _imggauge.y - _txtmultiplier.height;
			_txtmultiplier.hAlign = "center";
			_txtmultiplier.filter = BlurFilter.createDropShadow();
	//_txtmultiplier.border = true;
			addChild(_txtmultiplier);
			
			powerUpUI = new PowerUp();
			addChild(powerUpUI);
			
			
			timeInit = 600;
			timeNow = 0;
			
			
			_txtScore.x = (Constants.STAGE_WIDTH - _txtScore.width ) /2;
			_txtScore.y = (GameData.gridgap - _txtScore.height) / 2 ;
		//_txtScore.border = true;
			_txtScore.filter = BlurFilter.createDropShadow();
			_txtmultiplier.filter = BlurFilter.createDropShadow();
			
			//_imggaugeindicator.y += _imggaugeindicator.height;
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, time);
		}
		
		private function time(e:EnterFrameEvent):void 
		{
			if (!GameAPI.paused) {
				var timeneeded:Number = (timeInit / GameData.production * 60);
				if (timeNow > timeneeded) {
					timeNow = 0;
					GameAPI.checktheBlock = true;
				}
				//_txtCPM.text = ""+GameData.production;
				//_imgtimerindicator.rotation += 0.1;
				Starling.juggler.add(_imgtimerindicator);
				//_imgtimerindicator.x = timerDefault + ((_imgtimebarframe.width - (_imgtimerindicator.width)) * (timeNow / timeneeded)) ;
				_timerfill.width = (_imgtimebarframe.width - (_imgtimerindicator.width / 2)) * (timeNow / timeneeded);
				
				
				_imgtimerindicator.x = _timerfill.x + _timerfill.width - (_imgtimerindicator.width/2);
				
				
				//_imgtimerindicator.x = ((_imgtimebarframe.x + (_imgtimerindicator.width / 2)) + _timerfill.width);
				
				//trace(_imgtimerindicator.x);
				if (GameAPI.timechange) {
					if (GameData.timeMod != 1) {
						_timerfill.color = 0xA5B1FF;
					}else {
						_timerfill.color = 0xFFA526;
					}
					GameAPI.timechange = false;
				}
				timeNow += GameData.timeMod;
			}else {
				Starling.juggler.remove(_imgtimerindicator);
			}
			GameData.checkGoal();
			//_imggaugeindicator.pivotY = 0;
			var tween1:Tween = new Tween(_imggaugeindicator, 0.5, "easeOut")
			_imggaugeindicator.visible = true;
			tween1.moveTo(_imggauge.x, (gaugehieght / ((20 + (GameData.multiplier*10)) ) * GameData.gauge)+(_imggauge.y +_imggauge.height) -  _imggaugeindicator.height);
			_gaugefill.height = -((_imggauge.y + _imggauge.height) - (_imggaugeindicator.y+(_imggaugeindicator.height*0.75)));
			Starling.juggler.add(tween1);
			//GameData.checkGauge();
			
			//  #######
			//  #  X  #
			//  #######
			if (GameData.gauge >= 20 + (10*GameData.multiplier)) {
			//if (GameData.gauge >= 1) {	
				GameData.increaseMultiplier();						
				GameData.gauge = 0;	
				var timp:String = "x" + GameData.multiplier;
				popper(_txtmultiplier, timp,0xFFFF00);
			}
			
			_txtmultiplier.text = "x" + GameData.multiplier;
		}
		
		public function updateData():void {
			_txtScore.text = ""+GameData.score+" / "+GameData.goal;
			//_txtScore.text = ""+GameData.score;
		}
		
		public function popper(x:Object, str:String, col:uint = 0xFFFFFF, duration:int = 2 ):void {
			if (_casehider.length > 0) {
				_casehider[0].visible = 0;
			}
			var txxt:TextField = new TextField(Constants.STAGE_WIDTH * 0.5,Constants.STAGE_HEIGHT*0.16, "0", "BubbleBud", Constants.STAGE_HEIGHT * 0.15, col);
			txxt.x = ((x.x + x.width) - (txxt.width * 0.1) / 2);
	//txxt.border = true;
			txxt.y = x.y
			txxt.text = "" + str;
			txxt.touchable = false;
			txxt.filter = BlurFilter.createGlow(Color.BLACK);
			_casehider.unshift(txxt);
			this.addChild(txxt);
			
			var temp:Number = txxt.width;
			
			var popup:Tween = new Tween(txxt, 0.01, "easeOut");
			popup.scaleTo(0.1);
			Starling.juggler.add(popup);
			popup.onComplete = function():void {
				
				var popup0:Tween = new Tween(txxt, duration/2, "easeOut");
				//popup0.moveTo(txxt.x,txxt.y - (txxt.height * 2));
				popup0.moveTo((Constants.STAGE_WIDTH - (temp))/2, txxt.y - (txxt.height));
				popup0.scaleTo(1);
				Starling.juggler.add(popup0);
				
				popup0.onComplete = function():void {
					
					var popup1:Tween = new Tween(txxt, duration, "easeOut");
					popup1.fadeTo(0);
					Starling.juggler.add(popup1);
				
					var pointkill:Timer = new Timer(duration * 750, 1);
					pointkill.addEventListener(TimerEvent.TIMER, PKtimer);
					function PKtimer (e:TimerEvent):void {
						_casehider.pop();
						txxt.removeFromParent(true);
						trace(_casehider.length);
					}
					pointkill.start();
				}
			}
		}
	}

}