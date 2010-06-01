package california {
    import org.flixel.*;

    import AssetLibrary;
    
    [SWF(width="640", height="340", backgroundColor="#000000")];
    //[SWF(width="640", height="440", backgroundColor="#000000")];

    public class Main extends FlxGame {
        public static var bgcolor:uint = 0xff303030;
        public static var bug_color:uint = 0xffffa000;
        public static var bug_count:uint = 24;

        public static var library:AssetLibrary;
        
        public function Main():void {
            library = new AssetLibrary();
            
            super(320, 170, PlayState, 2);
            
            FlxState.bgColor = Main.bgcolor;
        }
    }
}