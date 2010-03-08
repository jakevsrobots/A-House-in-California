package net.dai5ychain.glowinginsects {
    import org.flixel.*;

    [SWF(width="480", height="320", backgroundColor="#000000")];

    public class GlowingInsects extends FlxGame {
        public static var bgcolor:uint = 0xff303030;
        public static var bug_count:uint = 20;
        
        public function GlowingInsects():void {
            //super(120, 80, PlayState, 4);
            //super(240, 160, PlayState, 2);
            super(480, 320, PlayState, 1);

            FlxState.bgColor = GlowingInsects.bgcolor;
        }
    }
}