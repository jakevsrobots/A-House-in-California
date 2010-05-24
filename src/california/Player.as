package california {
    import org.flixel.*;

    public class Player extends FlxSprite {
        [Embed(source='/../data/newplayer.png')]
        private var PlayerImage:Class;

        private var moveSpeed:uint;
        private var walkTarget:uint;
        private var minTargetDistance:uint;
        
        public function Player(X:Number, Y:Number):void {
            super(X,Y);

            this.loadGraphic(PlayerImage, true, true, 12, 12);

            maxVelocity.x = 80;

            moveSpeed = 800;
            minTargetDistance = 2; // At this point the character will stop accelerating towards its target.
            drag.x = 700;

            addAnimation("walk", [0,1,2,3], 12);
            addAnimation("stopped", [9]);

            width = 3;
            offset.x = 6;
            
            walkTarget = X;
        }
        
        override public function update():void {
            if(Math.abs(walkTarget - x) > minTargetDistance) {
                if(walkTarget < x) {
                    velocity.x -= moveSpeed * FlxG.elapsed;
                } else {
                    velocity.x += moveSpeed * FlxG.elapsed;
                }
            }
            
            super.update();
        }

        public function setWalkTarget(X:uint):void {
            walkTarget = X;
        }
    }
}