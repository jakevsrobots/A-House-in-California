package california {
    import org.flixel.*;

    public class Room {
        public var sprites:FlxGroup;
        public var backgrounds:FlxGroup;
        
        private var width:uint;        
        private var height:uint;

        public var title:String;
        private var roomName:String;

        public var verbList:Array;        
        
        public function Room(RoomData:Class, _title:String, _roomName:String):void {
            title = _title;
            roomName = _roomName;
            
            var xml:XML = new XML(new RoomData());

            width = xml.width;
            height = xml.height;

            sprites = new FlxGroup();
            backgrounds = new FlxGroup();            

            // Populate the list of verbs for this room. 
           verbList = World.verbs.global.concat(World.verbs.rooms[roomName]);
            
            // Load backgrounds
            for each (var backgroundNode:XML in xml.background.children()) {
                    var background:Background = new Background(backgroundNode.localName(),
                                                               backgroundNode.@x, backgroundNode.@y);
                    backgrounds.add(background.image);
                }
            
            // Load walls
            // for each (var wallNode:XML in xml.walls.children()) {
            //         walls.add(new FlxTileblock(wallNode.@x, wallNode.@y,
            //                                    wallNode.@w, wallNode.@h));
            //     }

            // Load sprites
            /*
            for each (var spriteNode:XML in xml.sprites.children()) {
                    
                }
            */
        }
    }
}