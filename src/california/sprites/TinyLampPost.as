package california.sprites {
    import org.flixel.*;
    import california.Main;

    public class TinyLampPost extends GameSprite {
        public var glow:FlxSprite;

        // Glow states
        public static var GLOW_START:uint = 0;
        public static var GLOW_FADE:uint = 1;
        public static var GLOW_REST:uint = 2;
        
        private var glow_state:uint;

        private var glow_fade_up_speed:Number = 0.75;
        private var glow_fade_down_speed:Number = 0.25;

        private var glowMaxAlpha:Number;
        private var glowMinAlpha:Number;        
        
        public function TinyLampPost(name:String, X:Number, Y:Number):void {
            super(name, X, Y, true);

            glow = new FlxSprite(X, Y, Main.library.getAsset('fireflyGlow'));

            glow.x = (X + 1) - (glow.width / 2);
            glow.y = (Y + 2) - (glow.height / 2);

            glow.alpha = Math.random();
            glowMaxAlpha = 1.0;
            glowMinAlpha = 0.3;

            if(Math.random() > 0.5) {
                glow_state = GLOW_START;
            } else {
                glow_state = GLOW_FADE;
            }
        }

        override public function update():void {
            // Update glow state
            if(glow_state == GLOW_START) {
                if(glow.alpha < glowMaxAlpha) {
                    glow.alpha += glow_fade_up_speed * FlxG.elapsed;
                } else {
                    glow.alpha = glowMaxAlpha;
                    glow_state = GLOW_REST;
                }
            } else if(glow_state == GLOW_FADE) {
                if(glow.alpha > glowMinAlpha) {
                    glow.alpha -= glow_fade_down_speed * FlxG.elapsed;
                } else {
                    glow.alpha = glowMinAlpha;
                    glow_state = GLOW_REST;
                }
            } else {
                // Randomly choose to fade in/out.
                if(Math.random() > 0.99) {
                    if(glow.alpha >= glowMaxAlpha) {
                        glow_state = GLOW_FADE;
                    } else {
                        glow_state = GLOW_START;
                    }
                }
            }

            //alpha = glow.alpha;
            
            super.update();
        }
    }
}