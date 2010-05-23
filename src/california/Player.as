package california {
    import org.flixel.*;

    public class Player extends FlxSprite {
        [Embed(source='/../data/newplayer.png')]
        private var PlayerImage:Class;

        private var _jump_power:uint = 150;
        private var _move_speed:uint;

        public var is_jumping:Boolean = false;

        public function Player(X:Number, Y:Number):void {
            super(X,Y);

            this.loadGraphic(PlayerImage, true, true, 12, 12);

            maxVelocity.x = 80;
            maxVelocity.y = 200;

            _move_speed = 800;
            acceleration.y = 420;
            drag.x = 600;

            addAnimation("walk", [0,1,2,3], 12);
            addAnimation("stopped", [9]);
            addAnimation("jump", [2,3,4],2);
            addAnimation("mid-air",[4]);

            width = 3;
            offset.x = 6;

            acceleration.y = 420;                
        }
        
        override public function update():void {
            // Controls
            if(FlxG.keys.LEFT) {
                facing = LEFT;
                velocity.x -= _move_speed * FlxG.elapsed;
            } else if (FlxG.keys.RIGHT) {
                facing = RIGHT;
                velocity.x += _move_speed * FlxG.elapsed;                
            }

            if(FlxG.keys.justPressed("Z") || FlxG.keys.justPressed("UP")) {
                if(velocity.y == 0) {
                    velocity.y = - _jump_power;
                }
            }
            
            // Animation
            if(velocity.y > 0) {
                if(!is_jumping) {
                    is_jumping = true;
                    play("mid-air");
                }
            } else if(velocity.y < 0) {
                play("jump");
            } else {
                is_jumping = false;
                if(velocity.x == 0) {
                    play("stopped");
                } else {
                    play("walk");
                }
            }

            super.update();
        }
    }
}