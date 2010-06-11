package california.sprites {
    import org.flixel.*;
    import california.Main;
    
    public class Firefly extends FlxSprite {
        public var glow:FlxSprite;
        
        private var startPoint:FlxPoint;
        private var destination:FlxPoint;
        private var moveSpeed:uint = 120;

        public var minPosition:FlxPoint;
        public var maxPosition:FlxPoint;        

        private var glowOffset:FlxPoint;

        // Glow states
        public static var GLOW_START:uint = 0;
        public static var GLOW_FADE:uint = 1;
        public static var GLOW_REST:uint = 2;
        
        private var glow_state:uint;

        private var glow_fade_up_speed:Number = 3.0;
        private var glow_fade_down_speed:Number = 2.0;
        
        public function Firefly(X:Number, Y:Number, minPosition:FlxPoint, maxPosition:FlxPoint):void {
            var FireflyImage:Class = Main.library.getAsset('oneFirefly');
            super(X, Y, FireflyImage);

            glow = new FlxSprite(X,Y,Main.library.getAsset('fireflyGlow'));
            glow.blend = "screen";

            var spriteCenter:FlxPoint = new FlxPoint(
                this.width / 2,
                this.height / 2
            );
            
            var glowCenter:FlxPoint = new FlxPoint(
                glow.width / 2,
                glow.height / 2
            );

            glowOffset = new FlxPoint(
                spriteCenter.x - glowCenter.x,
                spriteCenter.y - glowCenter.y
            );

            glow.x = this.x + glowOffset.x;
            glow.y = this.y + glowOffset.y;
            
            startPoint = new FlxPoint(x,y);
            maxVelocity.x = maxVelocity.y = 200;
            drag.x = drag.y = 80;
            this.minPosition = minPosition;
            this.maxPosition = maxPosition;            

            getNewDestination();

            glow_state = GLOW_REST;
        }

        override public function update():void {
            if(destination.x < this.x) {
                velocity.x -= moveSpeed * FlxG.elapsed;
            } else {
                velocity.x += moveSpeed * FlxG.elapsed;
            }

            if(destination.y < this.y) {
                velocity.y -= moveSpeed * FlxG.elapsed;
            } else {
                velocity.y += moveSpeed * FlxG.elapsed;
            }

            if(Math.abs(destination.y - this.y) < 4 &&
                Math.abs(destination.x - this.x) < 4) {
                
                getNewDestination();
            }

            // Animation
            if(velocity.x > 0) {
                facing = RIGHT;
            } else if(velocity.x < 0) {
                facing = LEFT;
            }

            glow.x = this.x + glowOffset.x;
            glow.y = this.y + glowOffset.y;

            // Update glow state
            if(glow_state == GLOW_START) {
                if(glow.alpha < 1.0) {
                    glow.alpha += glow_fade_up_speed * FlxG.elapsed;
                } else {
                    glow_state = GLOW_FADE;
                }
            } else if(glow_state == GLOW_FADE) {
                if(glow.alpha > 0) {
                    glow.alpha -= glow_fade_down_speed * FlxG.elapsed;
                } else {
                    glow.alpha = 0;
                    glow_state = GLOW_REST;
                }
            } else {
                // Randomly choose to fade in.
                if(Math.random() > 0.99) {
                    glow_state = GLOW_START;
                }
            }

            alpha = glow.alpha;
            
            super.update();
        }

        public function getNewDestination():void {
            destination = new FlxPoint();
            
            destination.x = minPosition.x + uint(Math.random() * (maxPosition.x - minPosition.x));
            destination.y = minPosition.y + uint(Math.random() * (maxPosition.y - minPosition.y));

            moveSpeed = 90 + (Math.random() * 20);
        }
    }
}