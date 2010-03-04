package net.dai5ychain.afterandbefore.phenomena {
    import org.flixel.*;
    import net.dai5ychain.afterandbefore.*;
    
    public class Trails extends Phenomenon {
        private var fx2:FlxSprite;
        
        public function Trails(x:uint, y:uint, player:Player):void {
            super(x,y, player);
            
            fx.createGraphic(FlxG.width, FlxG.height, 0xffb6fecd);
            fx2 = new FlxSprite();
            fx2.createGraphic(FlxG.width, FlxG.height, 0x22b6fecd);
            
            max_player_distance = 100;
        }

        override public function update():void {
            super.update();

            var max_alpha:Number = 0.9;
            fx.alpha = Math.pow(max_alpha * (Number(distance_to_player) / Number(max_player_distance)), 2);
            //fx2.alpha = max_alpha - (max_alpha * (Number(distance_to_player) / Number(max_player_distance)));
            
            //trace(distance_to_player, max_player_distance, fx.alpha, active);
            //trace(fx2.alpha);
        }
        
        override public function preProcess():void {
            fx.draw(FlxState.screen);
            fx.draw(fx2);
        }
        
        override public function postProcess():void {
            FlxState.screen.draw(fx);
        }
    }
}