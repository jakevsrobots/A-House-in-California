package net.dai5ychain.glowinginsects {
    import org.flixel.*;

    public class Firefly extends FlxSprite {
        [Embed(source="/../data/firefly.png")]
        private var FireflyImage:Class;

        private var destination:FlxPoint;

        private var move_speed:uint = 200;
        
        public function Firefly(X:uint, Y:uint):void {
            super(X,Y,FireflyImage);

            maxVelocity.x = maxVelocity.y = 200;

            get_new_destination();

            drag.x = drag.y = 150;
        }

        override public function update():void {
            if(destination.x < this.x) {
                velocity.x -= move_speed * FlxG.elapsed;
            } else {
                velocity.x += move_speed * FlxG.elapsed;
            }

            if(destination.y < this.y) {
                velocity.y -= move_speed * FlxG.elapsed;
            } else {
                velocity.y += move_speed * FlxG.elapsed;
            }

            if(Math.abs(destination.y - this.y) < 30 &&
                Math.abs(destination.x - this.x) < 30) {
                get_new_destination();
            }
            
            super.update();
        }

        public function get_new_destination():void {
            destination = new FlxPoint(
                this.x + (Math.floor(Math.random() * 100) - 50),
                this.y + (Math.floor(Math.random() * 100) - 50)
            );
            
            if(destination.x <=0 || destination.y <= 0 ||
                destination.x >= PlayState.WORLD_LIMITS.x ||
                destination.y >= PlayState.WORLD_LIMITS.y) {
                
                get_new_destination();
            }
        }
    }
}