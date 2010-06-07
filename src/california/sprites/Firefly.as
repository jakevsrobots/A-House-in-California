package california.sprites {
    import org.flixel.*;
    import california.Main;
    
    public class Firefly extends FlxSprite {
        private var startPoint:FlxPoint;
        private var destination:FlxPoint;
        private var moveSpeed:uint = 120;

        private var minPosition:FlxPoint;
        private var maxPosition:FlxPoint;        
        
        public function Firefly(X:Number, Y:Number, minPosition:FlxPoint, maxPosition:FlxPoint):void {
            var FireflyImage:Class = Main.library.getAsset('oneFirefly');
            super(X, Y, FireflyImage);

            startPoint = new FlxPoint(x,y);
            maxVelocity.x = maxVelocity.y = 200;
            drag.x = drag.y = 100;
            this.minPosition = minPosition;
            this.maxPosition = maxPosition;            

            getNewDestination();
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
            
            super.update();
        }

        public function getNewDestination():void {
            destination = new FlxPoint();
            
            destination.x = minPosition.x + uint(Math.random() * (maxPosition.x - minPosition.x));
            destination.y = minPosition.y + uint(Math.random() * (maxPosition.y - minPosition.y));

            moveSpeed = 140 + (Math.random() * 20);
        }
    }
}