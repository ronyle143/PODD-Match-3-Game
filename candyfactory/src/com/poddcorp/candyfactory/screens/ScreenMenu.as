package  com.poddcorp.candyfactory.screens
{
	import com.poddcorp.candyfactory.api.Constants;
	import com.poddcorp.candyfactory.api.GameAPI;
	import com.poddcorp.candyfactory.api.GameAudio;
	import com.poddcorp.candyfactory.api.GameData;
	import com.poddcorp.candyfactory.core.CandyFactory;
	import com.poddcorp.candyfactory.popups.TabOption;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	
	public class ScreenMenu extends Sprite 
	{
		//public var var_GameState:int=1;
		
		private var _imgmenubg:Image;
		private var _imgmenutitle:Image;
		private var _btnstart:Button;
		
		private var _option:TabOption;
		private var _spriteholdertitle:Sprite;
		private var _btnshop:Button;
		private var _btnHighScore:Button;
		private var _btnCred:Button;
		
		public function ScreenMenu() 
		{
			GameAPI.note("!", "Switched to ScreenMenu");
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			GameAudio.stopBGM();
			GameAudio.playBGM();
			
			_imgmenubg = new Image(CandyFactory.assets.getTexture("img_bg"));
			_imgmenubg.width = Constants.STAGE_WIDTH;
			_imgmenubg.height = Constants.STAGE_HEIGHT;
            this.addChild(_imgmenubg);
			
			
			_spriteholdertitle = new Sprite();
			_imgmenutitle = new Image(CandyFactory.assets.getTexture("img_title"));
			_imgmenutitle.width = Constants.STAGE_WIDTH;
			_imgmenutitle.height = Constants.STAGE_HEIGHT / 3;
            _spriteholdertitle.addChild(_imgmenutitle);
			var txt_SFX:TextField = new TextField(Constants.STAGE_WIDTH * 0.5, Constants.STAGE_HEIGHT*0.05, ""+Constants.GAME_VERSION, "BubbleBud", Constants.STAGE_HEIGHT*0.03, 0xEEEEEE);
			txt_SFX.x = (_imgmenutitle.width - txt_SFX.width*1.15);
			txt_SFX.y = _imgmenutitle.height*0.9;
			txt_SFX.hAlign = "right";
			//txt_SFX.border = true;
			_spriteholdertitle.addChild(txt_SFX);
			addChild(_spriteholdertitle);
			
			_btnHighScore = new Button(CandyFactory.assets.getTexture("btn_highscore"));
			_btnHighScore.fontName = "BubbleBud"
			_btnHighScore.fontSize *= 1.8;
			_btnHighScore.fontColor = 0xFFFFFF;
			_btnHighScore.width = Constants.STAGE_WIDTH * 0.425;
			_btnHighScore.height = Constants.STAGE_WIDTH * 0.132;
			_btnHighScore.x = (Constants.STAGE_WIDTH - _btnHighScore.width) / 2;
			_btnHighScore.y = (Constants.STAGE_HEIGHT - _btnHighScore.height) / 2;
			_btnHighScore.filter = BlurFilter.createDropShadow();
			this.addChild(_btnHighScore);
			
			_btnshop = new Button(CandyFactory.assets.getTexture("btn_shop"));
			_btnshop.fontName = "BubbleBud";
			_btnshop.fontSize *= 1.8;
			_btnshop.fontColor = 0xFFFFFF;
			_btnshop.width = Constants.STAGE_WIDTH * 0.425;
			_btnshop.height = Constants.STAGE_WIDTH * 0.132;
			_btnshop.x = (Constants.STAGE_WIDTH - _btnshop.width) / 2;
			_btnshop.y = (Constants.STAGE_HEIGHT - _btnshop.height) / 2;
			_btnshop.filter = BlurFilter.createDropShadow();
			this.addChild(_btnshop);
			
			_btnstart = new Button(CandyFactory.assets.getTexture("btn_play"));
			_btnstart.width = Constants.STAGE_WIDTH * 0.7;
			_btnstart.height = Constants.STAGE_WIDTH * 0.20;
			_btnstart.x = (Constants.STAGE_WIDTH - _btnstart.width) / 3;
			_btnstart.y = (Constants.STAGE_HEIGHT - _btnstart.height) / 2;
			_btnstart.filter = BlurFilter.createDropShadow();
            this.addChild(_btnstart);
			
			_option = new TabOption();
			_option.x = 0;
			_option.y = 0;
			this.addChild(_option);
			
			animateMenu();
			
			_btnCred = new Button(CandyFactory.assets.getTexture("info_button"));
			_btnCred.width = Constants.STAGE_WIDTH / 8;
			_btnCred.height = _btnCred.width;
			_btnCred.x = Constants.STAGE_WIDTH - _btnCred.width;
			_btnCred.y = Constants.STAGE_HEIGHT - _btnCred.height;
			_btnCred.filter = BlurFilter.createDropShadow();
			this.addChild(_btnCred);
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
			_btnstart.y = Constants.STAGE_HEIGHT / 2;
			var popup1:Tween = new Tween(_btnstart, 1, "easeOut");
			popup1.moveTo((Constants.STAGE_WIDTH - _btnstart.width) * 0.5, (Constants.STAGE_HEIGHT - _btnstart.height) * 0.65);
			popup1.fadeTo(1);
			_btnstart.filter = BlurFilter.createDropShadow();
			Starling.juggler.add(popup1);
			
			
			
			_btnshop.alpha = 0;
			_btnshop.y = Constants.STAGE_HEIGHT/2;
			var popup3:Tween = new Tween(_btnshop, 1, "easeOut");
			popup3.moveTo(Constants.STAGE_WIDTH - _btnshop.width - _btnHighScore.width - (Constants.STAGE_WIDTH*0.1), (Constants.STAGE_HEIGHT - _btnstart.height) * 0.90);
			popup3.fadeTo(1);
			_btnstart.filter = BlurFilter.createDropShadow();
			Starling.juggler.add(popup3);
			
			_btnHighScore.alpha = 0;
			_btnHighScore.y = Constants.STAGE_HEIGHT/2;
			var popup4:Tween = new Tween(_btnHighScore, 1, "easeOut");
			popup4.moveTo(Constants.STAGE_WIDTH - _btnHighScore.width - (Constants.STAGE_WIDTH*0.05), (Constants.STAGE_HEIGHT - _btnstart.height) * 0.90);
			popup4.fadeTo(1);
			_btnHighScore.filter = BlurFilter.createDropShadow();
			Starling.juggler.add(popup4);
			
			popup0.onComplete = function():void {
				_btnstart.addEventListener(Event.TRIGGERED, onButtonClickStart);
				_btnshop.addEventListener(Event.TRIGGERED, onButtonClickShop);
				_btnHighScore.addEventListener(Event.TRIGGERED, animateHS);
				_btnCred.addEventListener(Event.TRIGGERED, animateCredits);
			}
			
		}
		
		private function onButtonClickStart(e:Event):void 
		{
			GameAudio.playSound("pop");
			GameAPI.GameState = 2;
			GameAPI.StateChange = true;
			this.removeFromParent(true);
		}
		
		private function onButtonClickShop(e:Event):void 
		{
			GameAudio.playSound("pop");
			GameAPI.GameState = 4;
			GameAPI.StateChange = true;
			this.removeFromParent(true);
		}
		
		private function animateHS():void 
		{
			GameAudio.playSound("pop");
			var _mask:Quad;
			var placeholder:Sprite;
			
			_mask = new Quad(Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT, 0x000000, true);
			_mask.alpha = 0.5;
			this.addChild(_mask);
			
			placeholder = new Sprite();
			this.addChild(placeholder);
			
			///////score
			
			var _clip:Image = new Image(CandyFactory.assets.getTexture("clipboard_blank"));
			_clip.height = Constants.STAGE_HEIGHT * 0.4;
			_clip.width = _clip.height*1.5;
			_clip.x = (Constants.STAGE_WIDTH - _clip.width) / 2;
			_clip.y = (Constants.STAGE_HEIGHT - _clip.height) / 2;
            placeholder.addChild(_clip);
			
			var temp:int =  0+GameData.saveDataObject.data.Highscore;
			var txt_SFX:TextField = new TextField(Constants.STAGE_WIDTH * 0.7, Constants.STAGE_HEIGHT * 0.3, "Your High score is: \n"+(temp), "BubbleBud", Constants.STAGE_HEIGHT * 0.04, 0x000000);
			txt_SFX.x = ((Constants.STAGE_WIDTH) - txt_SFX.width)/2;
			txt_SFX.y =_clip.y;
	//txt_SFX.border = true;
			placeholder.addChild(txt_SFX);
			
			var _imgcloseclipboard:Button = new Button(CandyFactory.assets.getTexture("ok"));
			_imgcloseclipboard.height = Constants.STAGE_WIDTH / 8;
			_imgcloseclipboard.width = _imgcloseclipboard.height;
			_imgcloseclipboard.x = (Constants.STAGE_WIDTH - _imgcloseclipboard.width) / 2;
			_imgcloseclipboard.y = txt_SFX.y + txt_SFX.height;
			placeholder.addChild(_imgcloseclipboard);
			_imgcloseclipboard.addEventListener(Event.TRIGGERED, function closeBuy():void 
				{
					GameAudio.playSound("pop");
					_mask.visible = false;
					var popup:Tween = new Tween(placeholder, 0.5, "easeOutBack");
					popup.moveTo(0,Constants.STAGE_HEIGHT);
					Starling.juggler.add(popup);
					popup.onComplete = function():void {
						placeholder.visible = false;
						placeholder.y = 0;
						
						_mask.removeFromParent(true);
						placeholder.removeFromParent(true);
					}
				}
			);
			
			/////////////////////////////////
			placeholder.y = Constants.STAGE_HEIGHT
			var popup:Tween = new Tween(placeholder, 0.5, "easeOutBack");
			popup.moveTo(0,0);
			Starling.juggler.add(popup);
			_imgcloseclipboard.alpha = 0.25;
			popup.onComplete = function():void {
				_imgcloseclipboard.alpha = 1;
			}
		}
		
		private function animateCredits():void 
		{
			GameAudio.playSound("pop");
			var _mask:Quad;
			var placeholder:Sprite;
			
			_mask = new Quad(Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT, 0x000000, true);
			_mask.alpha = 0.5;
			this.addChild(_mask);
			
			placeholder = new Sprite();
			this.addChild(placeholder);
			
			///////score
			
			var _clip:Image = new Image(CandyFactory.assets.getTexture("credit_board"));
			
			_clip.height = Constants.STAGE_WIDTH;
			_clip.width = _clip.height*0.8;
			_clip.x = (Constants.STAGE_WIDTH - _clip.width) / 2;
			_clip.y = 0;
            placeholder.addChild(_clip);
			
			var _imgcloseclipboard:Button = new Button(CandyFactory.assets.getTexture("ok"));
			_imgcloseclipboard.height = Constants.STAGE_WIDTH / 8;
			_imgcloseclipboard.width = _imgcloseclipboard.height;
			_imgcloseclipboard.x = (Constants.STAGE_WIDTH - _imgcloseclipboard.width) / 2;
			_imgcloseclipboard.y = _imgcloseclipboard.y + (_clip.height * 0.8);
			placeholder.addChild(_imgcloseclipboard);
			_imgcloseclipboard.addEventListener(Event.TRIGGERED, function closeBuy():void 
				{
					GameAudio.playSound("pop");
					_mask.visible = false;
					var popup:Tween = new Tween(placeholder, 0.5, "easeOutBack");
					popup.moveTo(0,Constants.STAGE_HEIGHT);
					Starling.juggler.add(popup);
					popup.onComplete = function():void {
						placeholder.visible = false;
						placeholder.y = 0;
						
						_mask.removeFromParent(true);
						placeholder.removeFromParent(true);
					}
				}
			);
			
			/////////////////////////////////
			placeholder.y = Constants.STAGE_HEIGHT
			var popup:Tween = new Tween(placeholder, 0.5, "easeOutBack");
			popup.moveTo(0,(Constants.STAGE_HEIGHT-placeholder.height)/2);
			Starling.juggler.add(popup);
			_imgcloseclipboard.alpha = 0.25;
			popup.onComplete = function():void {
				_imgcloseclipboard.alpha = 1;
			}
		}
	}

}