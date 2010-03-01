package net.dai5ychain.afterandbefore {
    import org.flixel.*;

    public class Firefly extends FlxSprite {
        [Embed(source="/../data/firefly.png")]
        private var FireflyImage:Class;
        
        public function Firefly(X:uint, Y:uint):void {
            super(X,Y,FireflyImage)
        }
    }
}