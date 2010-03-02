package net.dai5ychain.afterandbefore.phenomena {
    import org.flixel.*;
    import net.dai5ychain.afterandbefore.*;
    
    public class Trails extends Phenomenon {
        public function Trails(x:uint, y:uint, player:Player):void {
            super(x,y, player);
            
            fx.createGraphic(FlxG.width, FlxG.height, 0xffb6fecd);
        }

        override public function preProcess():void {
            //fx.draw(FlxState.screen);
            //FlxState.screen.fill(0xffb6fecd);
            //FlxState.screen.draw(fx);
        }
        
        override public function postProcess():void {
            get_distance();
            FlxState.screen.draw(fx);
        }
    }
}