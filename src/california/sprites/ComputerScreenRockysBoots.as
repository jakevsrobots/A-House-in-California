package california.sprites {
    import org.flixel.*;
    import california.Main;

    public class ComputerScreenRockysBoots extends GameSprite {
        public var glow:FlxSprite;

        public function ComputerScreenRockysBoots(name:String, X:Number, Y:Number):void {
            super(name, X, Y);

            glow = new FlxSprite(X,Y,Main.library.getAsset('computerScreenRockysBootsGlow'));
            glow.scale = new FlxPoint(4,4);
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

        override public function update():void {
            super.update();

            if(Math.random() > 0.88) {
                glow.alpha = 0.2 + (Math.random() * 0.8);
            }
        }
    }
}