package california {
    import org.flixel.*;

    public class World {
        private var roomStates:Object; // The actual current states of the rooms
        private var roomDescriptions:Object; // Original data about rooms

        public function World():void {
            roomStates = {};
            roomDescriptions = {};
            
            for each(var roomNode:XML in Main.gameXML.world[0].room) {
                var roomObject:Object = {
                    'name': roomNode.@name.toString(),
                    'title': roomNode.@title.toString(),
                    'data': Main.library.getAsset(roomNode.@name)
                };

                roomDescriptions[roomObject['name']] = roomObject;
            }
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