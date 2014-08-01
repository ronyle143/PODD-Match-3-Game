package api 
{
    import starling.errors.AbstractClassError;

    public class Constants
    {
        public function Constants() { throw new AbstractClassError(); }
        
        public static const STAGE_WIDTH:int  = 360;
        public static const STAGE_HEIGHT:int = 600;
		public static const GAME_STATE:int = 1;
		public static const STATE_CHANGE:Boolean = true;
		public static const GAME_SFX:Boolean = true;
		public static const GAME_BMG:Boolean = true;
    }
}