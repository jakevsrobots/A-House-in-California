package california.sprites {
    import org.flixel.*;
    import california.Main;

    public class Car extends GameSprite {
        public var glow:FlxSprite;
        private var light:FlxSprite;
        
        public function Car(name:String, X:Number, Y:Number):void {
            super(name, X, Y);
            
            glow = new FlxSprite(X,Y, Main.library.getAsset('carGlow'));
            glow.blend = "screen";

            var spriteCenter:FlxPoint = new FlxPoint(
                this.width / 2,
                this.height / 2
            );
            
            var glowCenter:FlxPoint = new FlxPoint(
                glow.width / 2,
                glow.height / 2
            );

            var glowOffset:FlxPoint = new FlxPoint(
                spriteCenter.x - glowCenter.x,
                spriteCenter.y - glowCenter.y
            );

            glow.x = x + width - 3;
            glow.y = y + glowOffset.y;

            light = new FlxSprite(X,Y, Main.library.getAsset('carGlow'));
            light.alpha = 0.1;

            light.x = glow.x;
            light.y = glow.y;
        }


        override public function render():void {
            light.render();
            super.render();
        }
     }
}