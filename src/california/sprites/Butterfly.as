package california.sprites {
    import org.flixel.*;
    import california.Main;

    public class Butterfly extends GameSprite {
        private var restingPlace:FlxPoint;
        private var basePosition:FlxPoint;
        private var destination:FlxPoint;
        private var moveSpeed:uint = 20;
        private var flyToDestinationSpeed:uint = 40;

        public static var FLYING_AROUND:uint = 0;
        public static var FLYING_TO_RESTING_PLACE:uint = 1;
        public static var RESTING:uint = 2;
        
        private var flightState:uint = 0;

        private var maxY:Number = FlxG.height - 64;
        
        public function Butterfly(name:String, X:Number, Y:Number):void {
            super(name, X, Y);

            restingPlace = new FlxPoint(X, Y);
            
            maxVelocity.x = maxVelocity.y = 200;
            
            basePosition = new FlxPoint(Math.random() * FlxG.width, Math.random() * maxY);
            x = basePosition.x;
            y = basePosition.y;
            
            destination = new FlxPoint();
            getNewDestination();
        }

        private function getNewDestination():void {
            destination.x = basePosition.x + ((Math.random() - 0.5) * 100);
            destination.y = basePosition.y + ((Math.random() - 0.5) * 50);

            if(destination.x < 0 || destination.x > FlxG.width ||
                destination.y < 0 || destination.y > maxY) {
                getNewDestination();
            }
        }

        override public function update():void {
            if(flightState == Butterfly.FLYING_AROUND) {
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

                if(x < 0 || x > FlxG.width || y < 0 || y > maxY) {
                    velocity.x = 0;
                    velocity.y = 0;

                    if(x < 0) {
                        x = width / 2;
                    } else if(x > FlxG.width) {
                        x = FlxG.width - (width / 2);
                    } if(y < 0) {
                        y = height / 2;
                    } else if(y > maxY) {
                        y = maxY - (height / 2);
                    }
                    
                    getNewDestination();
                }
            } else if(flightState == Butterfly.FLYING_TO_RESTING_PLACE) {
                adjustVelocityToDestination();

                if(Math.abs(destination.y - y) < 2 &&
                    Math.abs(destination.x - x) < 2) {
                    
                    x = destination.x;
                    y = destination.y;

                    velocity.x = 0;
                    velocity.y = 0;
                    
                    flightState = Butterfly.RESTING;
                }
            }

            super.update();
        }

        private function adjustVelocityToDestination():void {
            if(destination.y > y) {
                velocity.y = flyToDestinationSpeed;
            } else if(destination.y < y) {
                velocity.y = -flyToDestinationSpeed;
            } else {
                velocity.y = 0;
            }
            
            if(destination.x > x) {
                velocity.x = flyToDestinationSpeed;
            } else if(destination.x < x) {
                velocity.x = -flyToDestinationSpeed;
            } else {
                velocity.x = 0;
            }

            if(destination.x != x) {
                var slope:Number = Math.abs((destination.y - y) / (destination.x - x));
                if(slope >= 1) {
                    velocity.x *= 1.0 / slope;
                } else {
                    velocity.y *= slope;
                }
            }

            if(velocity.y > flyToDestinationSpeed) {
                velocity.y = flyToDestinationSpeed;
            } else if(velocity.y < -flyToDestinationSpeed) {
                velocity.y = -flyToDestinationSpeed;
            }
            
            if(velocity.x > flyToDestinationSpeed) {
                velocity.x = flyToDestinationSpeed;
            } else if(velocity.x < -flyToDestinationSpeed) {
                velocity.x = -flyToDestinationSpeed;
            }            
        }

        public function flyToRestingPlace():void {
            maxVelocity.x = maxVelocity.y = 300;
            
            flightState = FLYING_TO_RESTING_PLACE;
            destination.x = restingPlace.x;
            destination.y = restingPlace.y;
            velocity.x = 0;
            velocity.y = 0;
            interactive = false;

            /*
            flightState = Butterfly.RESTING;
            x = restingPlace.x;
            y = restingPlace.y;
            velocity.x = 0;
            velocity.y = 0;
            interactive = false;
            */
        }
    }
}