package california {
    import org.flixel.*;

    public class GameCursor extends FlxSprite {
        [Embed(source="/../data/cursor.png")] private var CursorImage:Class;

        private var alphaDir:int = -1;
        private var fadeSpeed:Number = 5;
        private var minAlpha:Number = 0.5;
        private var maxAlpha:Number = 0.9;
        
        public function GameCursor():void {
            super(0, 0, CursorImage);

            alpha = maxAlpha;
        }

        override public function update():void {
            alpha += alphaDir * fadeSpeed * FlxG.elapsed;

            if(alphaDir == -1 && alpha <= minAlpha) {
                alpha = minAlpha;
                alphaDir = 1;
            } else if(alphaDir == 1 && alpha >= maxAlpha) {
                alpha = maxAlpha;
                alphaDir = -1;
            }
            
            super.update();
        }
    }
}