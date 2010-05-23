package california {
    import org.flixel.*;

    public class Room {
        public var walls:FlxGroup;
        public var sprites:FlxGroup;
        public var backgrounds:FlxGroup;
        
        private var width:uint;        
        private var height:uint;

        public var title:String;
        
        public function Room(RoomData:Class, _title:String):void {
            title = _title;
            
            var xml:XML = new XML(new RoomData());

            width = xml.width;
            height = xml.height;

            walls = new FlxGroup();
            sprites = new FlxGroup();
            backgrounds = new FlxGroup();            
            
            // Load backgrounds
            for each (var backgroundNode:XML in xml.background.children()) {
                    var background:Background = new Background(backgroundNode.localName(),
                                                               backgroundNode.@x, backgroundNode.@y);
                    backgrounds.add(background.image);
                }
            
            // Load walls
            for each (var wallNode:XML in xml.walls.children()) {
                    walls.add(new FlxTileblock(wallNode.@x, wallNode.@y,
                                               wallNode.@w, wallNode.@h));
                }

            // Load sprites
            /*
            for each (var spriteNode:XML in xml.sprites.children()) {
                    
                }
            */
        }
    }
}