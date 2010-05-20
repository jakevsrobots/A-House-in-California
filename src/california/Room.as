package california {
    import org.flixel.*;

    public class Room {
        public var walls:FlxGroup;
        public var sprites:FlxGroup;
        public var background:FlxSprite;
        
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
            
            // Load walls
            for each (var wallNode:XML in xml.walls.children()) {
                    walls.add(new FlxTileblock(wallNode.@x, wallNode.@y,
                                               wallNode.@w, wallNode.@h));
                    FlxG.log('x' + wallNode.@x + 'y' + wallNode.@y);
                }

            FlxG.log("num walls: " + walls.members.length);
            
            // Load sprites
            /*
            for each (var spriteNode:XML in xml.sprites.children()) {
                    
                }
            */
        }
    }
}