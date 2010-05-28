package california {
    import org.flixel.*;

    [SWF(width="480", height="320", backgroundColor="#000000")];
    //[SWF(width="640", height="440", backgroundColor="#000000")];

    public class Main extends FlxGame {
        public static var bgcolor:uint = 0xff303030;
        public static var bug_color:uint = 0xffffa000;
        public static var bug_count:uint = 24;
        
        public function Main():void {
            //super(160, 80, PlayState, 4);
            super(320, 160, PlayState, 2);
            
            //FlxG.mouse.cursor = new GameCursor();
            //FlxG.mouse.show();
            
            FlxState.bgColor = Main.bgcolor;
        }
    }
}