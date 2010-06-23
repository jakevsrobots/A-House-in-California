package california.sprites {
    import org.flixel.*;
    import california.Main;
    import california.PlayState;    
    
    public class LampFireflies extends GameSprite {
        private var fireflies:FlxGroup;
        public var glow:FlxGroup;
        
        public function LampFireflies(name:String, X:Number, Y:Number):void {
            super(name, X, Y, false);

            fireflies = new FlxGroup;

            var minPosition:FlxPoint = new FlxPoint(X, Y);
            var maxPosition:FlxPoint = new FlxPoint(X + 8, Y + 8);

            glow = new FlxGroup();
            
            for(var i:uint = 0; i < 10; i++) {
                var firefly:Firefly = new Firefly(X, Y, minPosition, maxPosition, 2)
                fireflies.add(firefly);
                glow.add(firefly.glow);
            }
        }

        override public function update():void {
            fireflies.update();
        }

        override public function render():void {
            fireflies.render();
        }
    }
}