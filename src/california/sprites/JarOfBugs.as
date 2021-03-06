package california.sprites {
    import org.flixel.*;
    import california.Main;
    
    public class JarOfBugs extends GameSprite {
        private var fireflies:FlxGroup;
        public var glow:FlxGroup;
        
        public function JarOfBugs(name:String, X:Number, Y:Number):void {
            super(name, X, Y);

            // A naive firefly setup, just for testing
            fireflies = new FlxGroup;

            var minPosition:FlxPoint = new FlxPoint(X, Y);
            var maxPosition:FlxPoint = new FlxPoint(X + 7, Y + 15);

            glow = new FlxGroup();
            
            for(var i:uint = 0; i < 5; i++) {
                var firefly:Firefly = new Firefly(X + (i*2), Y, minPosition, maxPosition)
                fireflies.add(firefly);
                glow.add(firefly.glow);
            }
        }

        override public function update():void {
            super.update();
            fireflies.update();
        }

        override public function render():void {
            super.render();
            fireflies.render();
        }
    }
}