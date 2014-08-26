package  com.poddcorp.candyfactory.screens
{
	import com.poddcorp.candyfactory.api.Constants;
	import com.poddcorp.candyfactory.api.GameAPI;
	import com.poddcorp.candyfactory.core.CandyFactory;
	import com.poddcorp.candyfactory.popups.TabOption;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	
	public class ScreenMenu extends Sprite 
	{
		//public var var_GameState:int=1;
		
		private var _imgmenubg:Image;
		private var _imgmenutitle:Image;
		private var _btnstart:Button;
		private var _btnoptions:Button;
		private var _option:TabOption;
		private var _spriteholdertitle:Sprite;
		private var _btnshop:Button;
		
		public function ScreenMenu() 
		{
			GameAPI.note("!", "Switched to ScreenMenu");
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_imgmenubg = new Image(CandyFactory.assets.getTexture("img_bg"));
			_imgmenubg.width = Constants.STAGE_WIDTH;
			_imgmenubg.height = Constants.STAGE_HEIGHT;
            this.addChild(_imgmenubg);
			
			
			_spriteholdertitle = new Sprite();
			_imgmenutitle = new Image(CandyFactory.assets.getTexture("img_title"));
			_imgmenutitle.width = Constants.STAGE_WIDTH;
			_imgmenutitle.height = Constants.STAGE_HEIGHT / 3;
            _spriteholdertitle.addChild(_imgmenutitle);
			var txt_SFX:TextField = new TextField(Constants.STAGE_WIDTH * 0.5, Constants.STAGE_HEIGHT*0.05, ""+Constants.GAME_VERSION, "Showcard Gothic", Constants.STAGE_HEIGHT*0.03, 0xEEEEEE);
			txt_SFX.x = (_imgmenutitle.width - txt_SFX.width*1.15);
			txt_SFX.y = _imgmenutitle.height*0.9;
			txt_SFX.hAlign = "right";
			//txt_SFX.border = true;
			_spriteholdertitle.addChild(txt_SFX);
			addChild(_spriteholdertitle)
			
			_btnstart = new Button(CandyFactory.assets.getTexture("btn_play"));
			_btnoptions = new Button(CandyFactory.assets.getTexture("btn_option"));
			_btnstart.width = Constants.STAGE_WIDTH/3;
			_btnstart.height = Constants.STAGE_WIDTH / 6;
			_btnoptions.height = _btnstart.height;
			_btnoptions.width = _btnoptions.height;
            _btnstart.x = (Constants.STAGE_WIDTH - (_btnstart.width+_btnoptions.width))*0.5;
            _btnstart.y = (Constants.STAGE_HEIGHT - _btnstart.height)*0.65;
            _btnoptions.x = _btnstart.x+_btnstart.width;
            _btnoptions.y = _btnstart.y;
            this.addChild(_btnstart);
			this.addChild(_btnoptions);
			
			_btnshop = new Button(CandyFactory.assets.getTexture("btn_shop"));
			_btnshop.fontName = "Showcard Gothic"
			_btnshop.fontSize *= 1.8;
			_btnshop.fontColor = 0xFFFFFF;
			_btnshop.height = Constants.STAGE_WIDTH / 6;
			_btnshop.width = Constants.STAGE_WIDTH / 3;
            _btnshop.x = _btnstart.x;
            _btnshop.y = _btnstart.y + (_btnshop.height * 1.2);
			this.addChild(_btnshop);
			
			_option = new TabOption();
			this.addChild(_option);
			
			animateMenu();
		}
		
		public function animateMenu():void 
		{
			_spriteholdertitle.y = Constants.STAGE_HEIGHT/2;
			_spriteholdertitle.alpha = 0;
			_spriteholdertitle.filter = BlurFilter.createDropShadow();
			var popup0:Tween = new Tween(_spriteholdertitle, 1, "easeOut");
			popup0.fadeTo(1);
			popup0.moveTo(0,Constants.STAGE_HEIGHT/8);
			Starling.juggler.add(popup0);
			
			_btnstart.alpha = 0;
			_btnstart.y = Constants.STAGE_HEIGHT/2;
			var popup1:Tween = new Tween(_btnstart, 1, "easeOut");
			popup1.moveTo((Constants.STAGE_WIDTH - (_btnstart.width + _btnoptions.width)) * 0.5, (Constants.STAGE_HEIGHT - _btnstart.height) * 0.65);
			popup1.fadeTo(1);
			_btnstart.filter = BlurFilter.createDropShadow();
			Starling.juggler.add(popup1);
			
			_btnoptions.alpha = 0;
			_btnoptions.y = Constants.STAGE_HEIGHT/2;
			var popup2:Tween = new Tween(_btnoptions, 1, "easeOut");
			popup2.moveTo(_btnstart.x + _btnstart.width, (Constants.STAGE_HEIGHT - _btnstart.height) * 0.65);
			popup2.fadeTo(1);
			_btnoptions.filter = BlurFilter.createDropShadow();
			Starling.juggler.add(popup2);
			
			_btnshop.alpha = 0;
			_btnshop.y = Constants.STAGE_HEIGHT/2;
			var popup3:Tween = new Tween(_btnshop, 1, "easeOut");
			popup3.moveTo((Constants.STAGE_WIDTH - (_btnstart.width + _btnoptions.width)) * 0.5, (Constants.STAGE_HEIGHT - _btnstart.height) * 0.80);
			popup3.fadeTo(1);
			_btnstart.filter = BlurFilter.createDropShadow();
			Starling.juggler.add(popup3);
			
			popup0.onComplete = function():void {
				_btnstart.addEventListener(Event.TRIGGERED, onButtonClickStart);
				_btnoptions.addEventListener(Event.TRIGGERED, onButtonClickOption);
				_btnshop.addEventListener(Event.TRIGGERED, onButtonClickShop);
			}
			
		}
		
		private function onButtonClickStart(e:Event):void 
		{
			GameAPI.GameState = 2;
			GameAPI.StateChange = true;
			this.removeFromParent(true);
		}
		
		private function onButtonClickShop(e:Event):void 
		{
			GameAPI.GameState = 4;
			GameAPI.StateChange = true;
			this.removeFromParent(true);
		}
		
		private function onButtonClickOption(e:Event):void 
		{
			_option.popUp();
		}
		
		
	}

}