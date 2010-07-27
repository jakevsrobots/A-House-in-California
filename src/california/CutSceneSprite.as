package california {
    import org.flixel.*;
    
    public class CutSceneSprite extends FlxSprite {
        public static var FADING_IN:uint = 0;
        public static var FADING_OUT:uint = 1;
        
        private var fadeState:uint;
        private var fadeSpeed:Number;
        private var maxAlpha:Number = 0.3;
        
        public function CutSceneSprite(assetName:String):void {
            super(0, 0, Main.library.getAsset(assetName));

            this.alpha = Math.random() * maxAlpha;

            if(Math.random() > 0.5) {
                fadeState = CutSceneSprite.FADING_IN;
            } else {
                fadeState = CutSceneSprite.FADING_OUT;                
            }
            
            newPosition();
        }

        override public function update():void {
            if(fadeState == CutSceneSprite.FADING_IN) {
                alpha += fadeSpeed * FlxG.elapsed;

                if(alpha >= maxAlpha) {
                    alpha = maxAlpha;
                    fadeState = CutSceneSprite.FADING_OUT;
                }
            } else if(fadeState == CutSceneSprite.FADING_OUT) {
                alpha -= fadeSpeed * FlxG.elapsed;

                if(alpha <= 0.0) {
                    newPosition();
                    alpha = 0.0;
                    fadeState = CutSceneSprite.FADING_IN;
                }
            }

            
            super.update();
        }

        private function newPosition():void {
            fadeSpeed = Math.random() * 0.075;

            x = y = 0;

            /*
            x = uint(Math.random() * FlxG.width) - (width / 2);
            y = uint(Math.random() * FlxG.height) - (height / 2);

            var scales:Array = [
                0.25,
                0.5, 0.5, 0.5,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                2.0, 2.0,
                4.0
            ];
            
            var scaleIndex:uint = uint(Math.random() * scales.length);

            scale.x = scale.y = scales[scaleIndex];
            */
        }
    }
}