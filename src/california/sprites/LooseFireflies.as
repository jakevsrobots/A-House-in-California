package california.sprites {
    import org.flixel.*;
    import california.Main;
    
    public class LooseFireflies extends GameSprite {
        private var fireflies:FlxGroup;
        public var glow:FlxGroup;

        private var minPosition:FlxPoint;
        private var maxPosition:FlxPoint;        

        public function LooseFireflies(name:String, X:Number, Y:Number, width:Number=NaN, height:Number=NaN):void {
            super(name, X, Y, false);

            // A naive firefly setup, just for testing
            fireflies = new FlxGroup;

            this.width = !isNaN(width) ? width : 30;
            this.height = !isNaN(height) ? height : 20;

            minPosition = new FlxPoint(X, Y);
            maxPosition = new FlxPoint(X + this.width, Y + this.height);

            glow = new FlxGroup();
            
            for(var i:uint = 0; i < 10; i++) {
                var firefly:Firefly = new Firefly(X + (i*2), Y, minPosition, maxPosition);
                fireflies.add(firefly);
                glow.add(firefly.glow);
            }

            //getNewSwarmCenter();

            // for some reason overlap() needs this graphic?
            createGraphic(this.width, this.height, 0xffff0000);
        }

        override public function update():void {
            // Randomly update swarm center
            /*
            if(Math.random() > 0.99) {
                getNewSwarmCenter();
            }*/
            
            fireflies.update();
        }

        override public function render():void {
            fireflies.render();

            // for debugging, to see where the swarm is            
            //super.render();
        }

        public function getNewSwarmCenter():void {
            // Find a new swarm center
            var maxDistance:uint = 10;
            minPosition.x = uint((Math.random() * maxDistance * 2)) - maxDistance + minPosition.x;
            minPosition.y = uint((Math.random() * maxDistance * 2)) - maxDistance + minPosition.y;

            maxPosition.x = minPosition.x + width;
            maxPosition.y = minPosition.y + height;

            this.x = minPosition.x;
            this.y = minPosition.y;

            // Contain the swarm within the screen
            if(maxPosition.x >= FlxG.width || minPosition.x < 0 || maxPosition.y > 146 || minPosition.y < 0) {
                getNewSwarmCenter();
            } else {
                // Update individual fireflies with swarm destination
                for each(var firefly:Firefly in fireflies.members) {
                    firefly.minPosition = minPosition;
                    firefly.maxPosition = maxPosition;                
                }
            }
        }
    }
}