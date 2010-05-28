package california {
    import org.flixel.*;

    public class GameCursor extends FlxGroup {
        [Embed(source="/../data/cursor.png")] private var CursorImage:Class;

        private var alphaDir:int = -1;
        private var fadeSpeed:Number = 5;
        private var minAlpha:Number = 0.5;
        private var maxAlpha:Number = 0.9;

        private var label:FlxText;

        private var graphic:FlxSprite
        
        public function GameCursor():void {
            super();
            
            graphic = new FlxSprite(0, 0, CursorImage);
            graphic.visible = true;
            add(graphic);
            
            label = new FlxText(0,0,FlxG.width);
            label.setFormat(null, 8, 0xffcccccc);
            label.visible = false;
            add(label);
            
            graphic.alpha = maxAlpha;
        }

        override public function update():void {
            graphic.x = FlxG.mouse.x - (graphic.width / 2);
            graphic.y = FlxG.mouse.y - (graphic.height / 2);
            label.x = FlxG.mouse.x - ((label.text.length * 4) / 2 );
            label.y = FlxG.mouse.y - 8;

            graphic.alpha += alphaDir * fadeSpeed * FlxG.elapsed;

            if(alphaDir == -1 && graphic.alpha <= minAlpha) {
                graphic.alpha = minAlpha;
                alphaDir = 1;
            } else if(alphaDir == 1 && graphic.alpha >= maxAlpha) {
                graphic.alpha = maxAlpha;
                alphaDir = -1;
            }
            
            super.update();
        }

        // Set or clear text (use image)
        public function setText(newText:String = null):void {
            if(newText == null) {
                graphic.visible = true;
                label.visible = false;
            } else {
                graphic.visible = false;
                label.visible = true;
                label.text = newText;
            }
        }

    }
}