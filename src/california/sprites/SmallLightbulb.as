package california.sprites {
    import org.flixel.*;
    import california.Main;

    public class SmallLightbulb extends GameSprite {
        public var glow:FlxSprite;

        public function SmallLightbulb(name:String, X:Number, Y:Number):void {
            super(name, X, Y);

            glow = new FlxSprite(X, Y, Main.library.getAsset('smallLightbulbGlow'));
            glow.x -= (glow.width / 2) - 2;
        }
    }
}