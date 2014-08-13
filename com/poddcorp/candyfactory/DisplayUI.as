package  
{
	import api.Constants;
	import api.GameAPI;
	import api.GameData;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class DisplayUI extends Sprite 
	{
		private var _txtScore:TextField = new TextField(Constants.STAGE_WIDTH*0.8,Constants.STAGE_HEIGHT*0.05, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 48, 0xFF6666);
		private var _txtCPM  :TextField = new TextField(Constants.STAGE_WIDTH*0.6,Constants.STAGE_HEIGHT*0.05, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 48, 0xFF6666);
		private var txxt1:TextField = new TextField(Constants.STAGE_WIDTH / 8,Constants.STAGE_WIDTH / 6, "0", "Showcard Gothic", Constants.STAGE_HEIGHT / 24, 0xFFF6666);
		private var _timebar:Quad;
		private var _imgscoregoal:Image;
		private var _imgcpm:Image;
		private var _imggauge:Image;
		private var _imgscreenmask:Quad;
		public var timeInit:int;
		public var timeNow:int;
		private var gaugehieght:Number = -(Constants.STAGE_HEIGHT * 0.058*8);
		private var txxt:TextField;
		
		public function DisplayUI() 
		{
			init();
		}
		
		public function init():void 
		{
			removeEventListeners();
			
			_imgscoregoal = new Image(CandyFactory.assets.getTexture("score_goal"));
			_imgscoregoal.width = Constants.STAGE_WIDTH*0.8;
			_imgscoregoal.height = Constants.STAGE_HEIGHT * 0.05;
			_imgscoregoal.filter = BlurFilter.createDropShadow();
			_imgscoregoal.x = Constants.STAGE_WIDTH*0.1;
			_imgscoregoal.y = _imgscoregoal.height*0.5;
			this.addChild(_imgscoregoal);
			
			_imgcpm = new Image(CandyFactory.assets.getTexture("CPMboard"));
			_imgcpm.width = Constants.STAGE_WIDTH*0.6;
			_imgcpm.height = Constants.STAGE_HEIGHT * 0.05;
			_imgcpm.filter = BlurFilter.createDropShadow();
			_imgcpm.x = Constants.STAGE_WIDTH*0.2;
			_imgcpm.y = _imgscoregoal.height*1.60;
			this.addChild(_imgcpm);
			
			_txtScore.text = "" + GameData.score + " / " + GameData.goal;
			_txtScore.x = _imgscoregoal.x;
			_txtScore.y = _imgscoregoal.y;
			//_txtScore.filter = BlurFilter.createDropShadow();
			//_txtScore.border = true;
			addChild(_txtScore);
			
			_txtCPM.text = ""+GameData.production;
			_txtCPM.x = _imgcpm.x;
			//_txtCPM.border = true;
			//_txtCPM.filter = BlurFilter.createDropShadow();
			_txtCPM.y = _imgcpm.y;
			addChild(_txtCPM);
			
			var gap:Number = Constants.STAGE_WIDTH * 0.166;
			var objX:Number = Constants.STAGE_WIDTH * 0.673;
			var objY:Number = Constants.STAGE_WIDTH * 0.04;
			var baseY:Number = Constants.STAGE_HEIGHT * 0.88;
			_timebar = new Quad(objX, objY, 0xFF8888, true);
			_timebar.x = gap;
			_timebar.y = baseY ;
			_timebar.alpha = 0.5;
			this.addChild(_timebar);
			
			_imggauge = new Image(CandyFactory.assets.getTexture("gauge"));
			_imggauge.width = Constants.STAGE_HEIGHT * 0.070;
			_imggauge.height = _imggauge.width * 8;
			_imggauge.x = Constants.STAGE_WIDTH - _imggauge.width;
			_imggauge.y = Constants.STAGE_HEIGHT * 0.9-  _imggauge.height;
			addChild(_imggauge);
			
			_imgscreenmask = new Quad(objX, objY, 0xFF8888, true);
			_imgscreenmask.width = Constants.STAGE_HEIGHT * 0.058;
			_imgscreenmask.height = -_imgscreenmask.width*8;
			_imgscreenmask.y = Constants.STAGE_HEIGHT * 0.808;
			_imgscreenmask.x = (Constants.STAGE_WIDTH - Constants.STAGE_HEIGHT * 0.0655);
			_imgscreenmask.color = Color.RED;
			//_imgscreenmask.pivotY = Constants.STAGE_HEIGHT * 0.058;
			
			txxt1.text = "x" + GameData.multiplier;
			txxt1.x = Constants.STAGE_WIDTH - txxt1.width;
			txxt1.y = Constants.STAGE_HEIGHT * 0.25;
			//txxt1.filter = BlurFilter.createDropShadow();
			addChild(txxt1);
			
			_imgscreenmask.alpha = 0.5;
			addChild(_imgscreenmask);
			
			timeInit = 600;
			timeNow = (timeInit / GameData.production * 60);
			
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
				_txtCPM.text = ""+GameData.production;
				_timebar.width = (Constants.STAGE_WIDTH * 0.673) / (timeneeded / timeNow);
				timeNow++;
			}
			GameData.checkGoal();
			_imgscreenmask.height = gaugehieght / 100 * GameData.gauge;
			GameData.checkGauge();
			txxt1.text = "x" + GameData.multiplier;
			//trace(GameData.gauge);
		}
		
		public function updateData():void {
			_txtScore.text = ""+GameData.score+" / "+GameData.goal;
		}
		
	}

}