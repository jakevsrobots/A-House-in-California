package california {
    import org.flixel.*;
    
    public class TrappedFireflies extends GameSprite {
        private var fireflies:FlxGroup;
        
        public function TrappedFireflies(name:String, X:Number, Y:Number):void {
            super(name, X, Y, false);

            // A naive firefly setup, just for testing
            fireflies = new FlxGroup;
            
            var FireflyImage:Class = Main.library.getAsset('oneFirefly');
            
            for(var i:uint = 0; i < 3; i++) {
                fireflies.add(new FlxSprite(X + (i*2), Y, FireflyImage));
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