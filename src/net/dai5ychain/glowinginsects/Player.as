package net.dai5ychain.glowinginsects {
    import org.flixel.*;

    public class Player extends FlxSprite {
        [Embed(source='/../data/newplayer.png')]
        private var PlayerImage:Class;

        private var _jump_power:uint = 150;
        private var _move_speed:uint;

        private var climb_speed:uint = 25;
        public var is_jumping:Boolean = false;

        public var on_ladder:Boolean = false;
        public var is_climbing:Boolean = false;

        public var firefly_count:uint = 0;

        private var color_stages:Array;

        public function Player(X:Number, Y:Number):void {
            super(X,Y);

            this.loadGraphic(PlayerImage, true, true, 12, 12);

            maxVelocity.x = 80;
            maxVelocity.y = 200;

            _move_speed = 800;
            acceleration.y = 420;
            drag.x = 600;

            addAnimation("walk", [0,1,2,3], 12);
            addAnimation("climbing", [10,12,11], 9);
            addAnimation("climbing-stopped", [12]);
            addAnimation("stopped", [9]);
            addAnimation("jump", [2,3,4],2);
            addAnimation("mid-air",[4]);

            width = 3;
            offset.x = 6;

            color_stages = get_color_increments();

            alpha = 1.0;
            //color = 0x5080a0;
        }

        public function add_firefly():void {
            firefly_count += 1;
            _jump_power += 10;
            color = color_stages[firefly_count];
            alpha -= (0.25 / GlowingInsects.bug_count);
            
        }

        private function get_color_increments():Array {
            var color_increments:Array = [];

            // Borrowed from http://www.pixelwit.com/blog/2008/05/color-fading-array/
            function fadeHex (hex1:uint, hex2:uint, steps:uint):Array {
                //
                // Create an array to store all colors.
                var newArry:Array = [hex1];
                //
                // Break Hex1 into RGB components.
                var r:Number = hex1 >> 16;
                var g:Number = hex1 >> 8 & 0xFF;
                var b:Number = hex1 & 0xFF;
                //
                // Determine RGB differences between Hex1 and Hex2.
                var rd:Number = (hex2 >> 16)-r;
                var gd:Number = (hex2 >> 8 & 0xFF)-g;
                var bd:Number = (hex2 & 0xFF)-b;
                //
                steps++;
                // For each new color.
                for (var i:uint=1; i<steps; i++){
                    //
                    // Determine where the color lies between the 2 end colors.
                    var ratio:Number = i/steps;
                    //
                    // Calculate new color and add it to the array.
                    newArry.push((r+rd*ratio)<<16 | (g+gd*ratio)<<8 | (b+bd*ratio));
                }

                //
                // Add Hex2 to the array and return it.
                newArry.push(hex2);
                return newArry;
            }

            return fadeHex(color, 0xd12d16, GlowingInsects.bug_count);
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
                if(!on_ladder) {
                    if(velocity.y == 0) {
                        velocity.y = - _jump_power;
                    }
                }
            }

            if(on_ladder) {
                if(FlxG.keys.UP || FlxG.keys.DOWN) {
                    is_climbing = true;
                }
            } else {
                is_climbing = false;
            }

            if(is_climbing) {
                acceleration.y = 0;
                
                if(FlxG.keys.UP) {
                    velocity.y = - climb_speed;
                } else if(FlxG.keys.DOWN) {
                    velocity.y = climb_speed;
                } else {
                    velocity.y = 0;
                }

                // Nudge the player toward the center of the ladder, if they're
                // already in motion.
                var x_offset:uint = this.x % PlayState.TILE_SIZE;
                if(x_offset < 4 && velocity.y != 0) {
                    x += 1;
                } else if(x_offset > 4 && velocity.y != 0) {
                    x -= 1;
                }
            } else {
                acceleration.y = 420;                
            }
            
            // Animation
            if(is_climbing) {
                if(velocity.y == 0) {
                    play("climbing-stopped");
                } else {
                    play("climbing");
                }
            } else {
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
            }
            
            super.update();
        }
    }
}