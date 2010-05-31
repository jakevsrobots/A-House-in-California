package california {
    import org.flixel.*;

    public class World {
        [Embed(source="/../data/maps/Level-1-1-AHouseInCalifornia.oel",
               mimeType="application/octet-stream")]
            private var Level_1_1_MapFile:Class;
            
        [Embed(source="/../data/maps/Level-1-2-TheSurfaceOfTheMoon.oel",
               mimeType="application/octet-stream")]
            private var Level_1_2_MapFile:Class;
            
        private var roomStates:Object; // The actual current states of the rooms
        private var roomDescriptions:Object; // A map of room names to level files

        public function World():void {
            roomStates = {};
            
            // Map room names to map files
            roomDescriptions = {
                'loisHome': {
                    'data': Level_1_1_MapFile,
                    'title': "A House in California"
                },
                'theSurfaceOfTheMoon': {
                    'data': Level_1_2_MapFile,
                    'title': "The Surface of the Moon"
                }
            };
        }
        
        public function getRoom(roomName:String):Room {
            if(roomStates.hasOwnProperty(roomName)) {
                // Return the existing room
                return roomStates[roomName];
            } else {
                // Create a new room
                roomStates[roomName] = new Room(roomDescriptions[roomName]['data'],
                                                roomDescriptions[roomName]['title'],
                                                roomName);
                return roomStates[roomName];
            }
        }
     }
}