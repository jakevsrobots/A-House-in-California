// Base class for phenomena: entities that can alter the world
// in some way, in relation to the player's position.

package net.dai5ychain.afterandbefore.phenomena {
    import org.flixel.*;
    import net.dai5ychain.afterandbefore.*;
    
    public class Phenomenon {
        protected var fx:FlxSprite;
        protected var position:FlxPoint;
        protected var player:Player;
        
        public function Phenomenon(x:uint, y:uint, player:Player):void {
            fx = new FlxSprite();
            fx.createGraphic(FlxG.width, FlxG.height, 0x44b6fecd);

            position = new FlxPoint(x,y);
            this.player = player;
        }

        protected var get_distance():uint {
            return uint(Math.sqrt(Math.pow(player.x - x, 2) + Math.pow(player.y - y, 2)));
        }
        
        public function preProcess():void {
            
        }

        public function postProcess():void {
            
        }
    }
}