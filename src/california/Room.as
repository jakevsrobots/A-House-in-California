package california {
    import org.flixel.*;
    
    public class Room {
        public var sprites:FlxGroup;
        public var backgrounds:FlxGroup;
        
        private var width:uint;        
        private var height:uint;

        public var title:String;
        private var roomName:String;

        public function Room(RoomData:Class, _title:String, _roomName:String):void {
            title = _title;
            roomName = _roomName;
            
            var xml:XML = new XML(new RoomData());

            width = xml.width;
            height = xml.height;

            sprites = new FlxGroup();
            backgrounds = new FlxGroup();            

            // Load backgrounds
            for each (var backgroundNode:XML in xml.background.children()) {
                    var background:Background = new Background(backgroundNode.localName(),
                                                               backgroundNode.@x, backgroundNode.@y);
                    backgrounds.add(background.image);
                }
            // Load sprites
            for each (var spriteNode:XML in xml.sprites.children()) {
                FlxG.log('loading sprite ' + spriteNode.localName());

                sprites.add(
                    new GameSprite(spriteNode.localName(), spriteNode.@x, spriteNode.@y)
                );
            }

        }
    }
}