package california {
    import org.flixel.*;
    import california.sprites.GameSprite;
    
    public class Room {
        public var sprites:FlxGroup;
        public var backgrounds:FlxGroup;
        
        private var width:uint;        
        private var height:uint;

        public var title:String;
        private var roomName:String;
        public var darkness:Boolean;
        
        public function Room(RoomData:Class, _title:String, _roomName:String, _darkness:Boolean=false):void {
            title = _title;
            roomName = _roomName;
            darkness = _darkness;
            
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

                var SpriteClass:Class = GameSprite.spriteDatabase[spriteNode.localName()]['spriteClass'];
                
                sprites.add(
                    new SpriteClass(spriteNode.localName(), spriteNode.@x, spriteNode.@y)
                );
            }

            // run init events, events that happen when the room
            // is first loaded/visited
            for each (var eventNode:XML in Main.gameXML.world[0].room.(@name==roomName).initEvent) {
                FlxG.log('processing event node ' + eventNode.toString());
                
                if(eventNode.@type.toString() == "vocabulary") {
                    // Re-set the active vocabulary to a specific list.
                    var verbList:Array = [];
                    for each (var verbNode:XML in eventNode.verb) {
                        verbList.push(verbNode.@name.toString());
                    }
                    PlayState.vocabulary.setCurrentVerbsByName(verbList);
                }
            }
        }

        public function getSprite(spriteName:String):GameSprite {
            for each(var sprite:GameSprite in sprites.members) {
                if(sprite.name == spriteName) {
                    return sprite;
                }
            }
            
            return null;
        }
    }
}