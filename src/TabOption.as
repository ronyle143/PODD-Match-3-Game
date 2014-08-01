package  
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class TabOption extends Sprite 
	{		
		public var img_closeclipboard:Button;
		private var img_clipboard:Image;
		private var img_screen_mask:Quad;
		private var img_checkbox1:Button;
		private var img_checkbox2:Button;
		private var btn_resume:Button;
		private var btn_mainmenu:Button;
		private var img_checkbox1c:Button;
		private var img_checkbox2c:Button;
		
		public function TabOption() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.y = Constants.STAGE_HEIGHT;
			
			img_screen_mask = new Quad(Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT * 2, 0x000000, true);
			img_screen_mask.y = -Constants.STAGE_HEIGHT;
			img_screen_mask.visible = false;
			img_screen_mask.alpha = 0.5;
			this.addChild(img_screen_mask);
			
			if (GameAPI.GameState == 1) {
				img_clipboard = new Image(CandyFactory.assets.getTexture("clipboard_compact"));
			}else{
				img_clipboard = new Image(CandyFactory.assets.getTexture("clipboard"));
			}
			img_clipboard.width = Constants.STAGE_WIDTH*0.8;
			img_clipboard.height = Constants.STAGE_HEIGHT * 0.8;
			img_clipboard.x = (Constants.STAGE_WIDTH - img_clipboard.width) / 2;
			img_clipboard.y = 0;
            this.addChild(img_clipboard);
			
			img_checkbox1c = new Button(CandyFactory.assets.getTexture("img_box_checked"));
			img_checkbox1c.height = Constants.STAGE_WIDTH / 6;
			img_checkbox1c.width = img_checkbox1c.height;
			img_checkbox1c.x = Constants.STAGE_WIDTH * 0.2;
			img_checkbox1c.y = Constants.STAGE_HEIGHT * 0.2;
			this.addChild(img_checkbox1c);
			img_checkbox1c.addEventListener(Event.TRIGGERED, turnOffSFX);
			
			img_checkbox1 = new Button(CandyFactory.assets.getTexture("img_box_empty"));
			img_checkbox1.height = Constants.STAGE_WIDTH / 6;
			img_checkbox1.width = img_checkbox1.height;
			img_checkbox1.x = Constants.STAGE_WIDTH * 0.2;
			img_checkbox1.y = Constants.STAGE_HEIGHT * 0.2;
			this.addChild(img_checkbox1);
			img_checkbox1.addEventListener(Event.TRIGGERED, turnOnSFX);
			
			if (GameAudio.SFX) {
				img_checkbox1c.visible = true;
				img_checkbox1.visible = false;
			}else {
				img_checkbox1c.visible = false;
				img_checkbox1.visible = true;
			}
			
			//var textField:TextField = new TextField(100, 20, "SFX", "Arista 2.0", 12, Color.RED);
			var txt_SFX:TextField = new TextField(Constants.STAGE_WIDTH * 0.6, Constants.STAGE_HEIGHT / 10, "SFX", "Arista 2.0", Constants.STAGE_HEIGHT / 12, 0x333333);
			txt_SFX.x = img_checkbox1.x + img_checkbox1.width;
			txt_SFX.y = img_checkbox1.y;
			txt_SFX.hAlign = "left";
			this.addChild(txt_SFX);
			
			img_checkbox2c = new Button(CandyFactory.assets.getTexture("img_box_checked"));
			img_checkbox2c.height =img_checkbox1.height;
			img_checkbox2c.width = img_checkbox2c.height;
			img_checkbox2c.x = img_checkbox1.x;
			img_checkbox2c.y = Constants.STAGE_HEIGHT * 0.35;
			this.addChild(img_checkbox2c);
			img_checkbox2c.addEventListener(Event.TRIGGERED, turnOffBGM);
			
			img_checkbox2 = new Button(CandyFactory.assets.getTexture("img_box_empty"));
			img_checkbox2.height =img_checkbox1.height;
			img_checkbox2.width = img_checkbox2.height;
			img_checkbox2.x = img_checkbox1.x;
			img_checkbox2.y = Constants.STAGE_HEIGHT * 0.35;
			this.addChild(img_checkbox2);
			img_checkbox2.addEventListener(Event.TRIGGERED, turnOnBGM);
			
			if (GameAudio.BGM) {
				img_checkbox2c.visible = true;
				img_checkbox2.visible = false;
			}else {
				img_checkbox2c.visible = false;
				img_checkbox2.visible = true;
			}
			
			var txt_BMG:TextField = new TextField(Constants.STAGE_WIDTH * 0.6, Constants.STAGE_HEIGHT / 10, "BMG", "Arista 2.0", Constants.STAGE_HEIGHT / 12, 0x333333);
			txt_BMG.x = img_checkbox2.x + img_checkbox2.width;
			txt_BMG.y = img_checkbox2.y;
			txt_BMG.hAlign = "left";
			this.addChild(txt_BMG);
			
			if (GameAPI.GameState == 1) {
				img_closeclipboard = new Button(CandyFactory.assets.getTexture("btn_close"));
				img_closeclipboard.height = Constants.STAGE_WIDTH / 8;
				img_closeclipboard.width = img_closeclipboard.height;
				img_closeclipboard.x = (Constants.STAGE_WIDTH - img_closeclipboard.width)*0.8
				img_closeclipboard.y = img_closeclipboard.width*1.3;
				this.addChild(img_closeclipboard);
				img_closeclipboard.addEventListener(Event.TRIGGERED, onButtonClickClose);
			}else {	
				btn_resume = new Button(CandyFactory.assets.getTexture("btn_resume"));
				btn_resume.height =img_checkbox1.height*1.2;
				btn_resume.width = btn_resume.height*2.2;
				btn_resume.x = (Constants.STAGE_WIDTH - btn_resume.width)/2;
				btn_resume.y = Constants.STAGE_HEIGHT * 0.6;
				this.addChild(btn_resume);
				btn_resume.addEventListener(Event.TRIGGERED, onButtonClickClose);
				
				btn_mainmenu = new Button(CandyFactory.assets.getTexture("btn_mainmenu"));
				btn_mainmenu.height =btn_resume.height;
				btn_mainmenu.width = btn_resume.width;
				btn_mainmenu.x = btn_resume.x;
				btn_mainmenu.y = btn_resume.y-btn_mainmenu.height;
				this.addChild(btn_mainmenu);
				btn_mainmenu.addEventListener(Event.TRIGGERED, optionMenu);
				
			}
			
			
			
		}
		
		private function turnOnSFX(e:Event):void 
		{
			GameAudio.SFX = true;
			img_checkbox1c.visible = true;
			img_checkbox1.visible = false;
			GameAPI.Note("S", "SFX set to "+GameAudio.SFX);
		}
		private function turnOffSFX(e:Event):void 
		{
			GameAudio.SFX = false;
			img_checkbox1c.visible = false;
			img_checkbox1.visible = true;
			GameAPI.Note("S", "SFX set to "+GameAudio.SFX);
		}
		private function turnOnBGM(e:Event):void 
		{
			GameAudio.BGM = true;
			img_checkbox2c.visible = true;
			img_checkbox2.visible = false;
			GameAPI.Note("S", "BGM set to "+GameAudio.BGM);
		}
		private function turnOffBGM(e:Event):void 
		{
			GameAudio.BGM = false;
			img_checkbox2c.visible = false;
			img_checkbox2.visible = true;
			GameAPI.Note("S", "BGM set to "+GameAudio.BGM);
		}
		
		public function popUp():void {
			if (GameAPI.GameState == 1) {
				GameAPI.Note("!", "Opened OptionsTab");
			}else {
				GameAPI.Note("!", "Game Paused");
				GameAPI.paused = true;
			}
			var popup:Tween = new Tween(this, 0.5, "easeOutBack");
			popup.moveTo(0,Constants.STAGE_HEIGHT*0.1);
			Starling.juggler.add(popup);
			img_screen_mask.visible = true;
		}
		private function onButtonClickClose(e:Event):void 
		{
			if (GameAPI.GameState == 1) {
				GameAPI.Note("!", "Closed OptionsTab");
			}else {
				GameAPI.Note("!", "Game Unpaused");
				GameAPI.paused = false;
			}
			var popup:Tween = new Tween(this, 0.5, "easeOutBounce");
			popup.moveTo(0,Constants.STAGE_HEIGHT);
			Starling.juggler.add(popup);
			img_screen_mask.visible = false;
		}
		
		private function optionMenu(e:Event):void 
		{
			GameAPI.GameState = 1;
			GameAPI.StateChange = true;
		}
		
	}
}