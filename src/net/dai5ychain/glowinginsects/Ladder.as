package net.dai5ychain.glowinginsects {
    import org.flixel.*;
    
    public class Ladder extends FlxSprite {
        [Embed(source="/../data/ladder.png")]
        private var LadderImage:Class;

        public function Ladder(X:uint, Y:uint) {
            super(X, Y, LadderImage);
        }
    }
}
