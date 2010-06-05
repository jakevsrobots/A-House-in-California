package california {
    import org.flixel.*;

    public class DialogWindow extends FlxGroup {
        private var overlay:FlxSprite;        
        private var backgroundLayer:FlxSprite;
        private var frameLayer:FlxSprite;        
        private var text:FlxText;
        private var labelText:FlxText;        

        private var visibilityState:String = 'invisible';

        private var fadeSpeed:Number;
        private var maxOverlayOpacity:Number;
        private var dialogWidth:uint;
        private var dialogHeight:uint;

        public function DialogWindow():void {
            super();

            dialogWidth = FlxG.width - 80;
            dialogHeight = FlxG.height - 80;
            maxOverlayOpacity = 0.8;
            fadeSpeed = 4.0;
            
            overlay = new FlxSprite(0,0);
            overlay.width = FlxG.width;
            overlay.height = FlxG.height;
            overlay.createGraphic(FlxG.width, FlxG.height, 0xff000000);
            overlay.alpha = 0.0;
            add(overlay);
            
            frameLayer = new FlxSprite(38,38);
            frameLayer.width = dialogWidth + 4;
            frameLayer.height = dialogHeight + 4;
            frameLayer.createGraphic(dialogWidth + 4, dialogHeight + 4, 0xffffffff);
            frameLayer.alpha = 0.0;
            add(frameLayer);
            
            backgroundLayer = new FlxSprite(40,40);
            backgroundLayer.width = dialogWidth;
            backgroundLayer.height = dialogHeight;
            backgroundLayer.createGraphic(dialogWidth, dialogHeight, 0xff000000);
            backgroundLayer.alpha = 0.0;
            add(backgroundLayer);
            
            text = new FlxText(48, 48, backgroundLayer.width - 16);
            text.alpha = 0.0;
            add(text);
            
            labelText = new FlxText(
                backgroundLayer.x + (backgroundLayer.width - 94),
                backgroundLayer.y + (backgroundLayer.height - 16),
                FlxG.width,
                '(click to continue)');
            labelText.alpha = 0.0;
            add(labelText);
        }

        override public function update():void {
            if(visibilityState == 'fading in') {
                PlayState.hasMouseFocus = false;                    

                overlay.alpha += fadeSpeed * FlxG.elapsed;
                if(overlay.alpha >= maxOverlayOpacity) {
                    overlay.alpha = maxOverlayOpacity;
                }
                
                backgroundLayer.alpha += fadeSpeed * FlxG.elapsed;
                if(backgroundLayer.alpha >= 1.0) {
                    backgroundLayer.alpha = 1.0;

                    visibilityState = 'visible';
                }
            } else if(visibilityState == 'fading out') {
                PlayState.hasMouseFocus = false;

                overlay.alpha -= fadeSpeed * FlxG.elapsed;
                if(overlay.alpha <= 0) {
                    overlay.alpha = 0;
                }
                
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
            frameLayer.alpha = backgroundLayer.alpha;
            super.update();
        }
        
        public function showText(text:String):void {
            FlxG.log('dialog showing: ' + text);
            this.text.text = text;
            visibilityState = 'fading in';
        }
    }
}