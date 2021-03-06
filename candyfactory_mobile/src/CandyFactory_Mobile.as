package 
{
	import com.poddcorp.candyfactory.api.Constants;
	import com.poddcorp.candyfactory.api.GameAPI;
	import com.poddcorp.candyfactory.core.CandyFactory;
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import starling.utils.formatString;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
    
    
    [SWF(frameRate="60", backgroundColor="#000")]
    public class CandyFactory_Mobile extends Sprite
    {    
		[Embed(source="../assets/fonts/Bobbleboddy.ttf",fontName="BubbleBud",fontFamily="testfontfamily",mimeType="application/x-font-truetype",embedAsCFF="false")]
		private var BubbleBud:Class;
		
        private var mStarling:Starling;
        
        public function CandyFactory_Mobile()
        {
			Constants.STAGE_WIDTH = stage.fullScreenWidth;
            Constants.STAGE_HEIGHT = stage.fullScreenHeight;
			
            var stageWidth:int   = Constants.STAGE_WIDTH;
            var stageHeight:int  = Constants.STAGE_HEIGHT;
            var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
            
            Starling.multitouchEnabled = false; 
            Starling.handleLostContext = !iOS; 
            
            var viewPort:Rectangle = RectangleUtil.fit(
				new Rectangle(0, 0, stageWidth, stageHeight), 
                //new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
                new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
                ScaleMode.SHOW_ALL);
            
			var scaleFactor:int = 1;
			scaleFactor = getScaleFactor(stage.fullScreenWidth, stage.fullScreenHeight);
			trace(scaleFactor);
			
			var appDir:File = File.applicationDirectory;
			var assets:AssetManager = new AssetManager(scaleFactor);
		   
			assets.verbose = Capabilities.isDebugger;
			assets.enqueue(
				//appDir.resolvePath(formatString("assets/fonts/{0}x", scaleFactor)), 
				appDir.resolvePath(formatString("textures/{0}x", scaleFactor)));
			
            /*var scaleFactor:int = viewPort.width < (Constants.STAGE_WIDTH*1.5) ? 1 : 2 ? 2 : 4; // midway between 320 and 640
            var appDir:File = File.applicationDirectory;
            var assets:AssetManager = new AssetManager(scaleFactor);
            
            assets.verbose = Capabilities.isDebugger;
            assets.enqueue(
                appDir.resolvePath("audio"),
                appDir.resolvePath(formatString("fonts/{0}x", scaleFactor)),
                appDir.resolvePath(formatString("textures/{0}x", scaleFactor))
            );*/
            mStarling = new Starling(CandyFactory, stage, viewPort, null, "auto", "auto");
            mStarling.stage.stageWidth  = stageWidth;
            mStarling.stage.stageHeight = stageHeight;
			trace(mStarling.stage.stageWidth, stage.fullScreenWidth, scaleFactor, stageWidth);
            mStarling.simulateMultitouch  = false;
            mStarling.enableErrorChecking = Capabilities.isDebugger;
            
            mStarling.addEventListener(starling.events.Event.ROOT_CREATED, 
                function(event:Object, app:CandyFactory):void
                {
                    mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, arguments.callee);
                    app.start(null, assets);
                    mStarling.start();
                });
            
            NativeApplication.nativeApplication.addEventListener(
                flash.events.Event.ACTIVATE, function (e:*):void { mStarling.start(); });
            
            NativeApplication.nativeApplication.addEventListener(
                flash.events.Event.DEACTIVATE, function (e:*):void { mStarling.stop(true); });
        }
		
		public function getScaleFactor(screenWidth:Number, screenHeight:Number):int
		{
			var value:Number = Math.min(screenWidth, screenHeight);
			trace(screenWidth, screenHeight, value);
			if (value < 480)
				return 1;
			else if (value < 800)
				return 2;
			else
				return 4;
			
		}
    }
}