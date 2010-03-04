package net.dai5ychain.glowinginsects {
    import org.flixel.*;

    public class Firefly extends FlxSprite {
        [Embed(source="/../data/firefly.png")]
        private var FireflyImage:Class;

        private var destination:FlxPoint;

        private var move_speed:uint = 200;

        public var behavior_state:uint = 0;

        // behavioral states:
        public static var TRAPPED_IN_JAR:uint = 0;
        public static var FLYING_TO_FIRST_POINT:uint = 1;
        public static var FLYING_FREE:uint = 2;
        
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

            if(Math.abs(destination.y - this.y) < 4 &&
                Math.abs(destination.x - this.x) < 4) {
                if(behavior_state == FLYING_TO_FIRST_POINT) {
                    behavior_state = FLYING_FREE;
                }
                get_new_destination();
            }
            
            super.update();
        }

        public function get_new_destination():void {
            if(behavior_state == TRAPPED_IN_JAR) {
                destination = new FlxPoint(
                    PlayState.JAR_POSITION.x + 3 + uint(Math.random() * 9),
                    PlayState.JAR_POSITION.y + 3 + uint(Math.random() * 11)
                );
            } else {
                destination = new FlxPoint(
                    this.x + (uint(Math.random() * 100) - 50),
                    this.y + (uint(Math.random() * 100) - 50)
                );
                
                if(destination.x <=0 || destination.y <= 0 ||
                    destination.x >= PlayState.WORLD_LIMITS.x ||
                    destination.y >= PlayState.WORLD_LIMITS.y) {
                    
                    get_new_destination();
                }
            }
        }

        public function fly_to_first_point():void {
            behavior_state = FLYING_TO_FIRST_POINT;
            
            destination = new FlxPoint(
                uint(Math.random() * PlayState.WORLD_LIMITS.x),
                uint(Math.random() * PlayState.WORLD_LIMITS.y)
            );
        }

        override public function hitLeft(Contact:FlxObject, Velocity:Number):void {
            if(behavior_state == FLYING_FREE) {
                get_new_destination();
                super.hitLeft(Contact,Velocity);
            }
        }
        override public function hitTop(Contact:FlxObject, Velocity:Number):void {
            if(behavior_state == FLYING_FREE) {            
                get_new_destination();
                super.hitTop(Contact,Velocity);
            }
        }
        override public function hitBottom(Contact:FlxObject, Velocity:Number):void {
            if(behavior_state == FLYING_FREE) {
                get_new_destination();
                super.hitBottom(Contact,Velocity);
            }
        }
    }
}