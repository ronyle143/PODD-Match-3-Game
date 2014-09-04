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
		public static const GAME_VERSION:String = "v0.8.5"
		public static const GAME_TIME:Number = 1;
		
		public static const CANDY1:int = 6;
		public static const CANDY2:int = 6;
		public static const CANDY3:int = 6;
		public static const CANDY4:int = 3;
		public static const CANDY5:int = 1;
    }
}