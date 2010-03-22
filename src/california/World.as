package net.dai5ychain.glowinginsects {
    import org.flixel.*;

    public class World {

        [Embed(source="/../data/rooms/home-background.png")]
        private var HomeRoomBackground:Class;
        [Embed(source="/../data/rooms/home-walls.png")]
        private var HomeRoomWalls:Class;

        public var rooms:Object;
        
        public function World():void {
            rooms = {
                'home': {
                    'background': HomeRoomBackground,
                    'walls': HomeRoomWalls
                }
            };
        }
     }
}