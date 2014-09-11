package com.poddcorp.candyfactory.api 
{
    import starling.errors.AbstractClassError;

    public class Constants
    {
        public function Constants() { throw new AbstractClassError(); }
        
        public static var STAGE_WIDTH:int  = 320;
        public static var STAGE_HEIGHT:int = 480;
		public static const GAME_STATE:int = 1;
		public static const STATE_CHANGE:Boolean = true;
		public static const GAME_SFX:Boolean = true;
		public static const GAME_BMG:Boolean = true;
		public static const GAME_VERSION:String = "v0.9.0";
		public static const GAME_TIME:Number = 1;
		
		public static var CANDY1:int = 70;
		public static var CANDY2:int = 70;
		public static var CANDY3:int = 70;
		public static var CANDY4:int = 0;
		public static var CANDY5:int = 0;
    }
}