package california {
    import org.flixel.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;    
	import flash.text.TextFormat;

    public class GameCursor extends FlxGroup {
        [Embed(source="/../data/cursor.png")] private var CursorImage:Class;

        private var alphaDir:int = -1;
        private var fadeSpeed:Number = 5;
        private var minAlpha:Number = 0.5;
        private var maxAlpha:Number = 0.9;

        private var label:FlxText;
        public var graphic:FlxSprite
        public var spriteHitBox:FlxObject;

        // A dummy text object for getting line lengths
        private var dummyText:TextField;
        
        public function GameCursor():void {
            super();
            
            graphic = new FlxSprite(0, 0, CursorImage);
            graphic.visible = true;
            add(graphic);
            
            label = new FlxText(0,0,FlxG.width);
            label.setFormat(Main.gameFontFamily, Main.gameFontSize, 0xffcccccc);
            label.visible = false;
            add(label);
            
            graphic.alpha = maxAlpha;

            // A special hit box for colliding the cursor with sprites
            spriteHitBox = new FlxObject(0,0,8,8);
        }

        override public function update():void {
            graphic.x = FlxG.mouse.x - (graphic.width / 2);
            graphic.y = FlxG.mouse.y - (graphic.height / 2);
            label.x = FlxG.mouse.x - ((label.text.length * 6) / 2 );
            label.y = FlxG.mouse.y - 8;
            
            spriteHitBox.x = FlxG.mouse.x - spriteHitBox.width / 2;
            spriteHitBox.y = FlxG.mouse.y - spriteHitBox.height / 2;            
            
            graphic.alpha += alphaDir * fadeSpeed * FlxG.elapsed;
            label.alpha += alphaDir * fadeSpeed * FlxG.elapsed;            

            if(alphaDir == -1 && graphic.alpha <= minAlpha) {
                graphic.alpha = minAlpha;
                label.alpha = minAlpha;
                alphaDir = 1;
            } else if(alphaDir == 1 && graphic.alpha >= maxAlpha) {
                graphic.alpha = maxAlpha;
                label.alpha = maxAlpha;
                alphaDir = -1;
            }

            // Check if this text is hanging off the edge of the screen.
            if(label.visible) {
                var labelWidth:Number = getLineWidth(label.text);
                var labelOffset:Number = FlxG.mouse.x - (labelWidth / 2);
                
                if(labelOffset + labelWidth > FlxG.width) {
                    label.x = FlxG.width - labelWidth;
                } else if(labelOffset < 0) {
                    label.x = 0;
                }
            }
            
            super.update();
        }

        // Set or clear text (use image)
        public function setText(newText:String = null):void {
            if((label.visible && newText == label.text) ||
               (!label.visible && newText == null)) {
               return;
            }
            
            if(newText == null) {
                graphic.visible = true;
                label.visible = false;
            } else {
                graphic.visible = false;
                label.visible = true;
                label.text = newText;
            }
        }

        private function getLineWidth(line:String):uint {
            dummyText = new TextField();
            dummyText.autoSize = TextFieldAutoSize.LEFT;
            dummyText.embedFonts = true;
            dummyText.sharpness = label._tf.sharpness;
            dummyText.defaultTextFormat = label._tf.defaultTextFormat;
            dummyText.setTextFormat(label._tf.defaultTextFormat);
            
            dummyText.text = line;
            
            return dummyText.width;
        }

    }
}