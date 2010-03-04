package net.dai5ychain.GlowingInsects {
    import org.flixel.*;

    [SWF(width="480", height="256", backgroundColor="#000000")];

    public class GlowingInsects extends FlxGame {
        public static var bgcolor:uint = 0xffb6fecd;

        public function GlowingInsects():void {
            super(120, 64, PlayState, 4);

            FlxState.bgColor = GlowingInsects.bgcolor;
        }
    }
}