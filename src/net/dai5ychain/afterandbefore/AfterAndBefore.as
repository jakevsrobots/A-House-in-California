package net.dai5ychain.afterandbefore {
    import org.flixel.*;

    [SWF(width="480", height="256", backgroundColor="#000000")];

    public class AfterAndBefore extends FlxGame {
        public static var bgcolor:uint = 0xffb6fecd;

        public function AfterAndBefore():void {
            super(120, 64, PlayState, 4);

            FlxState.bgColor = AfterAndBefore.bgcolor;
        }
    }
}