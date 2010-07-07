package california.sprites {
    import org.flixel.*;
    import california.Main;

    public class LightedLampPost extends GameSprite {
        private var fireflies:FlxGroup;
        public var glow:FlxGroup;

        public function LightedLampPost(name:String, X:Number, Y:Number):void {
            super(name, X, Y, true);

            fireflies = new FlxGroup;

            var minPosition:FlxPoint = new FlxPoint(X, Y + 4);
            var maxPosition:FlxPoint = new FlxPoint(X + 12, Y + 12);

            glow = new FlxGroup();
            
            for(var i:uint = 0; i < 10; i++) {
                var firefly:Firefly = new Firefly(X, Y, minPosition, maxPosition, 1.0, 0.6);
                fireflies.add(firefly);
                glow.add(firefly.glow);
            }
        }

        override public function update():void {
            fireflies.update();
        }

        override public function render():void {
           fireflies.render();
           super.render();
           
         }
    }
}