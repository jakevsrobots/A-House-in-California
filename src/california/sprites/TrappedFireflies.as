package california.sprites {
    import org.flixel.*;
    import california.Main;
    
    public class TrappedFireflies extends GameSprite {
        private var fireflies:FlxGroup;
        
        public function TrappedFireflies(name:String, X:Number, Y:Number):void {
            super(name, X, Y, false);

            // A naive firefly setup, just for testing
            fireflies = new FlxGroup;

            var minPosition:FlxPoint = new FlxPoint(X, Y);
            var maxPosition:FlxPoint = new FlxPoint(X + 15, Y + 15);
            
            for(var i:uint = 0; i < 3; i++) {
                fireflies.add(new Firefly(X + (i*2), Y, minPosition, maxPosition));
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