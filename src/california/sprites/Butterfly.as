package california.sprites {
    import org.flixel.*;
    import california.Main;

    public class Butterfly extends GameSprite {
        private var basePosition:FlxPoint;
        private var destination:FlxPoint;
        private var moveSpeed:uint = 20;
        
        public function Butterfly(name:String, X:Number, Y:Number):void {
            super(name, X, Y);
            
            basePosition = new FlxPoint(X, Y);
            destination = new FlxPoint();
            getNewDestination();
        }

        private function getNewDestination():void {
            destination.x = basePosition.x + ((Math.random() - 0.5) * 100);
            destination.y = basePosition.y + ((Math.random() - 0.5) * 50);

            if(destination.x < 0 || destination.x > FlxG.width ||
                destination.y < 0 || destination.y > FlxG.height - 16) {
                getNewDestination();
            }
        }

        override public function update():void {
            if(destination.x < x) {
                velocity.x -= moveSpeed * FlxG.elapsed;
            } else {
                velocity.x += moveSpeed * FlxG.elapsed;
            }

            if(destination.y < y) {
                velocity.y -= moveSpeed * FlxG.elapsed;
            } else {
                velocity.y += moveSpeed * FlxG.elapsed;
            }

            if(Math.abs(destination.y - y) < 4 &&
                Math.abs(destination.x - x) < 4) {
                
                getNewDestination();
            }

            super.update();
        }
    }
}