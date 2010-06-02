package california {
    import org.flixel.*;

    public class Player extends GameSprite {
        private var moveSpeed:uint;
        private var walkTarget:uint;
        private var minTargetDistance:uint;
        
        public function Player(name:String, X:Number, Y:Number):void {
            super(name,X,Y);

            moveSpeed = 64;
            minTargetDistance = 2; // At this point the character will stop accelerating towards its target.
            drag.x = 700;

            width = 3;
            offset.x = 6;
            
            walkTarget = X;
        }
        
        override public function update():void {
            if(Math.abs(walkTarget - x) > minTargetDistance) {
                if(walkTarget < x) {
                    play("walk");
                    
                    facing = LEFT;
                    x -= moveSpeed * FlxG.elapsed;
                } else {
                    play("walk");
                    
                    facing = RIGHT;
                    x += moveSpeed * FlxG.elapsed;
                }
            } else {
                play("stopped");
            }
            
            super.update();
        }

        public function setWalkTarget(X:uint):void {
            walkTarget = X;
        }
    }
}