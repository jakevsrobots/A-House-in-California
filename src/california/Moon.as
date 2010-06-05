package california {
    import org.flixel.*;

    public class Moon extends GameSprite {
        public var glow:FlxSprite;
        
        public function Moon(name:String, X:Number, Y:Number):void {
            super(name, X, Y);
            
            glow = new FlxSprite(X,Y,Main.library.getAsset('moonGlow'));
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