package california {
    import org.flixel.*;

    public class Firefly extends FlxSprite {
        [Embed(source="/../data/glow-light.png")]
        private var GlowImage:Class;
        
        private var destination:FlxPoint;

        private var move_speed:uint = 120;

        public var behavior_state:uint = 0;

        // Behavioral states:
        public static var TRAPPED:uint = 0;
        public static var FLYING_TO_FIRST_POINT:uint = 1;
        public static var FLYING_FREE:uint = 2;

        public var glow:FlxSprite;

        // Glow states
        public static var GLOW_START:uint = 0;
        public static var GLOW_FADE:uint = 1;
        public static var GLOW_REST:uint = 2;
        
        private var glow_state:uint;

        private var glow_fade_up_speed:Number = 2.0;
        private var glow_fade_down_speed:Number = 2.0;

        public var darkness:FlxSprite;
        
        public function Firefly(X:uint, Y:uint, darkness:FlxSprite):void {
            super(X,Y);

            this.darkness = darkness;
            
            createGraphic(1,1,0xffffffff);

            glow = new FlxSprite(X,Y,GlowImage);
            glow.alpha = 0;
            glow.blend = "screen";
            
            maxVelocity.x = maxVelocity.y = 200;

            behavior_state = FLYING_FREE;
            get_new_destination();

            drag.x = drag.y = 100;

            glow_state = GLOW_REST;
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

            // update glow status
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
                if(Math.random() > 0.98) {
                    glow_state = GLOW_START;
                }
            }
            
            super.update();
        }

        override public function render():void {
            if(!dead && glow.alpha > 0) {
                var firefly_point:FlxPoint = new FlxPoint;
                getScreenXY(firefly_point);
                darkness.draw(
                        glow,
                        firefly_point.x - (glow.width / 2),
                        firefly_point.y - (glow.height/ 2)
                    );
            }
            
            super.render();
        }

        override public function kill():void {
            glow.kill();
            super.kill();
        }

        public function get_new_destination():void {
            if(behavior_state == TRAPPED) {
                /*
                destination = new FlxPoint(
                    PlayState.JAR_POSITION.x + 3 + uint(Math.random() * 9),
                    PlayState.JAR_POSITION.y + 3 + uint(Math.random() * 11)
                );
                */
            } else {
                destination = new FlxPoint(
                    this.x + (uint(Math.random() * 100) - 50),
                    this.y + (uint(Math.random() * 100) - 50)
                );

                move_speed = 140 + (Math.random() * 20);
                
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
            get_new_destination();
            super.hitLeft(Contact,Velocity);            
        }
        
        override public function hitTop(Contact:FlxObject, Velocity:Number):void {
            get_new_destination();
            super.hitTop(Contact,Velocity);
        }
        override public function hitBottom(Contact:FlxObject, Velocity:Number):void {
            get_new_destination();
            super.hitBottom(Contact,Velocity);
        }
    }
}