// Base class for phenomena: entities that can alter the world
// in some way, in relation to the player's position.

package net.dai5ychain.afterandbefore.phenomena {
    import org.flixel.*;
    import net.dai5ychain.afterandbefore.*;
    
    public class Phenomenon {
        protected var fx:FlxSprite;
        protected var position:FlxPoint;
        protected var player:Player;
        protected var distance_to_player:uint;

        // The maximum player distance at which this phenomenon should be active
        // (in pixels)
        protected var max_player_distance:uint = 256;

        public var active:Boolean = false;
        
        public function Phenomenon(x:uint, y:uint, player:Player):void {
            fx = new FlxSprite();
            fx.createGraphic(FlxG.width, FlxG.height, 0x44b6fecd);

            position = new FlxPoint(x,y);
            this.player = player;
        }

        protected function get_distance():uint {
            return uint(Math.sqrt(Math.pow(player.x - position.x, 2) + Math.pow(player.y - position.y, 2)));
        }

        public function update():void {
            distance_to_player = get_distance();

            if(distance_to_player < max_player_distance) {
                active = true;
            } else {
                active = false;
            }
        }
        
        public function preProcess():void {
            
        }

        public function postProcess():void {
            
        }
    }
}