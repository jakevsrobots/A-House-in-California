package california.sprites {
    import org.flixel.*;

    import california.Main;

    public class Television extends GameSprite {
        public var glow:FlxSprite;

        public function Television(name:String, X:Number, Y:Number):void {
            super(name, X, Y);

            glow = new FlxSprite(X, Y, Main.library.getAsset('windowGlow'));
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

            glow.x = this.x + glowOffset.x;
            glow.y = this.y + glowOffset.y;
         }
    }
}