package net.dai5ychain.glowinginsects {
    import org.flixel.*;

    public class Player extends FlxSprite {
        [Embed(source='/../data/newplayer.png')]
        private var PlayerImage:Class;
        [Embed(source="/../data/glow-light.png")]
        private var GlowImage:Class;

        private var _jump_power:uint = 150;
        private var _move_speed:uint;

        public var is_jumping:Boolean = false;

        public var firefly_count:uint = 0;

        public var darkness:FlxSprite;
        public var glow:FlxSprite;
        
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

            alpha = 1.0;

            glow = new FlxSprite(X,Y,GlowImage);
            glow.alpha = 0;
            glow.blend = "screen";

            acceleration.y = 420;                
        }

        public function add_firefly():void {
            firefly_count += 1;
            _jump_power += 10;
            alpha -= (0.25 / GlowingInsects.bug_count);
            glow.alpha += 1.0 / GlowingInsects.bug_count;
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

        override public function render():void {
            if(glow.alpha > 0) {
                var player_point:FlxPoint = new FlxPoint;
                getScreenXY(player_point);
                darkness.draw(
                    glow,
                    (player_point.x - (glow.width / 2)) + 6,
                    (player_point.y - (glow.height/ 2)) + 6
                );
            }
            
            super.render();
        }
    }
}