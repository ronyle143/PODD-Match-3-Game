package  com.poddcorp.candyfactory.screens.ui
{
	import com.poddcorp.candyfactory.api.Constants;
	import com.poddcorp.candyfactory.api.GameAPI;
	import com.poddcorp.candyfactory.api.GameData;
	import com.poddcorp.candyfactory.core.CandyFactory;
	import feathers.controls.text.TextFieldTextRenderer;
	import flash.text.TextFormat;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class DisplayUI extends Sprite 
	{		
		private var _txtScore:TextField = new TextField(Constants.STAGE_WIDTH*0.8,Constants.STAGE_HEIGHT*0.1, "0", "BubbleBud", Constants.STAGE_HEIGHT / 24, 0xFFFFFF); //0xFF6666
		private var txxt1:TextField = new TextField(Constants.STAGE_WIDTH / 8,Constants.STAGE_WIDTH / 6, "0", "BubbleBud", Constants.STAGE_HEIGHT / 24, 0xFFFFFF);
		private var _timebar:Quad;
		private var _imgscoregoal:Image;
		private var _imgcpm:Image;
		private var _imggauge:Image;
		private var _imggaugefill:Image;
		public var timeInit:int;
		public var timeNow:Number;
		private var gaugehieght:Number = -(Constants.STAGE_HEIGHT * 0.058*8);
		private var txxt:TextField;
		public var powerUpUI:PowerUp;
		
		public function DisplayUI() 
		{
			init();
		}
		
		public function init():void 
		{
			removeEventListeners();
			
			updateData();
			_txtScore.x = Constants.STAGE_WIDTH * 0.1;
			_txtScore.y = (Constants.STAGE_WIDTH * 0.1) * 0.5;
			addChild(_txtScore);
			
			var gap:Number = Constants.STAGE_WIDTH * 0.166;
			var objX:Number = Constants.STAGE_WIDTH * 0.673;
			var objY:Number = Constants.STAGE_WIDTH * 0.04;
			var baseY:Number = Constants.STAGE_HEIGHT * 0.9;
			_timebar = new Quad(objX, objY, 0xFF8888, true);
			_timebar.x = gap;
			_timebar.y = baseY ;
			_timebar.alpha = 0.7;
			this.addChild(_timebar);
			
			_imggauge = new Image(CandyFactory.assets.getTexture("gauge"));
			_imggauge.width = Constants.STAGE_HEIGHT * 0.070;
			_imggauge.height =_imggauge.width * 8;
			_imggauge.x = Constants.STAGE_WIDTH - _imggauge.width;
			_imggauge.y = Constants.STAGE_HEIGHT * 0.9 -  _imggauge.height;
			addChild(_imggauge);
			
			_imggaugefill = new Image(CandyFactory.assets.getTexture("timer_swirl"));
			_imggaugefill.width = Constants.STAGE_HEIGHT * 0.070;
			_imggaugefill.height = _imggaugefill.width;
			_imggaugefill.x = Constants.STAGE_WIDTH - _imggaugefill.width;
			_imggaugefill.y = Constants.STAGE_HEIGHT * 0.9 -  _imggaugefill.height;
			_imggaugefill.visible = false;
			this.addChild(_imggaugefill);
			
			txxt1.text = "x" + GameData.multiplier;
			txxt1.x = Constants.STAGE_WIDTH - txxt1.width;
			txxt1.y = Constants.STAGE_HEIGHT * 0.25;
			//txxt1.filter = BlurFilter.createDropShadow();
			addChild(txxt1);
			
			powerUpUI = new PowerUp();
			addChild(powerUpUI);
			
			
			timeInit = 600;
			timeNow = 0;
			
			_txtScore.filter = BlurFilter.createDropShadow();
			txxt1.filter = BlurFilter.createDropShadow();
			
			//_imggaugefill.y += _imggaugefill.height;
			
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
				_timebar.width = (Constants.STAGE_WIDTH * 0.673) / (timeneeded / timeNow);
				if (GameData.timeMod != 1) {
					_timebar.color = 0xBFCFFE;
				}else {
					_timebar.color = 0xFF8888;
				}
				timeNow += GameData.timeMod;
			}
			GameData.checkGoal();
			//_imggaugefill.pivotY = 0;
			var tween1:Tween = new Tween(_imggaugefill, 0.2, "easeOut")
				_imggaugefill.visible = true;
				tween1.moveTo(Constants.STAGE_WIDTH - _imggaugefill.width, (gaugehieght / (50 * GameData.multiplier) * GameData.gauge)+Constants.STAGE_HEIGHT * 0.9 -  _imggaugefill.height);
				Starling.juggler.add(tween1);
			GameData.checkGauge();
			txxt1.text = "x" + GameData.multiplier;
			//trace(GameData.gauge);
		}
		
		public function updateData():void {
			_txtScore.text = ""+GameData.score+" / "+GameData.goal;
			//_txtScore.text = ""+GameData.score;
		}
		
	}

}