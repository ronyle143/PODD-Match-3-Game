package
{
	import api.Constants;
	import api.GameAPI;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
    import starling.display.Image;
    import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
    import starling.textures.Texture;
    import starling.utils.AssetManager;
 
    public class CandyFactory extends Sprite
    {
        private static var 		sAssets			:AssetManager;
		private var 			nav				:ScreenNavigator;
		private const			SCREEN_MENU		:String 				= "screenMenu";
		private const 			SCREEN_PLAY		:String 				= "screenPlay";
		private var 			mainMenu		:ScreenNavigatorItem;
		private var 			gameplay		:ScreenNavigatorItem;
		
        public function CandyFactory()
        {
        }
 
        public function start(background:Texture, assets:AssetManager):void
        {
            sAssets = assets;
            assets.loadQueue(function onProgress(ratio:Number):void
            {
                if (ratio == 1)
                {
					GameAPI.note("!", "Screen size is : "+Constants.STAGE_WIDTH+"x"+Constants.STAGE_HEIGHT);
					
					nav = new ScreenNavigator();
					nav.width = Constants.STAGE_WIDTH;
					nav.height = Constants.STAGE_HEIGHT*2;
					addChild(nav);
					
					mainMenu = new ScreenNavigatorItem(new ScreenMenu, null, null);
					nav.addScreen(SCREEN_MENU, mainMenu);
					
					gameplay = new ScreenNavigatorItem(new ScreenPlay, null, null);
					nav.addScreen(SCREEN_PLAY, gameplay);
					
					nav.showScreen(SCREEN_MENU);
					addEventListener(EnterFrameEvent.ENTER_FRAME, displayScreen);
					var transition:ScreenSlidingStackTransitionManager = new ScreenSlidingStackTransitionManager(nav);
                }
            });
        }
		
		
		private function displayScreen(e:EnterFrameEvent):void 
		{
			if (GameAPI.StateChange && GameAPI.GameState == 1) {
				nav.removeScreen(SCREEN_MENU);
				
				mainMenu = new ScreenNavigatorItem(new ScreenMenu, null, null);
				nav.addScreen(SCREEN_MENU, mainMenu);
				nav.showScreen(SCREEN_MENU);
				GameAPI.StateChange = false;
			}
			else if (GameAPI.StateChange && GameAPI.GameState == 2) {
				nav.removeScreen(SCREEN_PLAY);
				//gameplay.removeFromParent(true);
				gameplay = new ScreenNavigatorItem(new ScreenPlay, null, null);
				nav.addScreen(SCREEN_PLAY, gameplay);
				nav.showScreen(SCREEN_PLAY);
				GameAPI.StateChange = false;
			}
			else if (GameAPI.StateChange && GameAPI.GameState == 3) {
				
				GameAPI.StateChange = false;
			}
		}//*/
 
        public static function get assets():AssetManager { return sAssets; }
    }
}