package california {
    import org.flixel.*;

    public class World {

        /*
        [Embed(source="/../data/rooms/a-train-station-in-toledo-background.png")]
        private var HomeRoomBackground:Class;
        [Embed(source="/../data/rooms/a-train-station-in-toledo-walls.png")]
        private var HomeRoomWalls:Class;*/

        [Embed(source="/../data/rooms/outside-train-station-background.png")]
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