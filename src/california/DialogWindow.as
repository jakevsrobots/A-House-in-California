package california {
    import org.flixel.*;

    public class DialogWindow extends FlxGroup {
        private var backgroundLayer:FlxSprite;
        private var text:FlxText;
        private var labelText:FlxText;        

        private var visibilityState:String = 'invisible';

        private var fadeSpeed:Number;
        
        public function DialogWindow():void {
            super();

            backgroundLayer = new FlxSprite(0,0);
            backgroundLayer.width = FlxG.width;
            backgroundLayer.height = FlxG.height;
            backgroundLayer.createGraphic(FlxG.width, FlxG.height, 0xff000000);
            backgroundLayer.alpha = 0.0;
            
            add(backgroundLayer);

            text = new FlxText(8, 8, FlxG.width - 8);
            text.alpha = 0.0;
            add(text);
            
            labelText = new FlxText(FlxG.width - 108, FlxG.height - 16, FlxG.width, '(click to continue)');
            labelText.alpha = 0.0;
            add(labelText);

            fadeSpeed = 4.0;
        }

        override public function update():void {
            if(visibilityState == 'fading in') {
                PlayState.hasMouseFocus = false;                    
                
                backgroundLayer.alpha += fadeSpeed * FlxG.elapsed;
                if(backgroundLayer.alpha >= 1.0) {
                    backgroundLayer.alpha = 1.0;
                    visibilityState = 'visible';
                }
            } else if(visibilityState == 'fading out') {
                PlayState.hasMouseFocus = false;
                
                backgroundLayer.alpha -= fadeSpeed * FlxG.elapsed;
                if(backgroundLayer.alpha <= 0.0) {
                    backgroundLayer.alpha = 0.0;
                    visibilityState = 'invisible';
                    PlayState.hasMouseFocus = true;
                }
            } else if(visibilityState == 'visible') {
                PlayState.hasMouseFocus = false;
                
                if(FlxG.mouse.justPressed()) {
                    visibilityState = 'fading out';
                }
            }

            text.alpha = backgroundLayer.alpha;
            labelText.alpha = backgroundLayer.alpha;
            super.update();
        }
        
        public function showText(text:String):void {
            FlxG.log('dialog showing: ' + text);
            this.text.text = text;
            visibilityState = 'fading in';
        }
    }
}