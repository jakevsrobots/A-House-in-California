package california {
    import org.flixel.*;
    import california.sprites.GameSprite;
    import california.sprites.Player;    
    
    public class Room {
        public var sprites:FlxGroup;
        public var backgrounds:FlxGroup;
        
        private var width:uint;        
        private var height:uint;

        public var title:String;
        public var roomName:String;
        
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

                if(!GameSprite.spriteDatabase.hasOwnProperty(spriteNode.localName())) {
                    throw new Error('Could not find sprite definition for ' + spriteNode.localName());
                }
                
                var SpriteClass:Class = GameSprite.spriteDatabase[spriteNode.localName()]['spriteClass'];
                
                sprites.add(
                    new SpriteClass(spriteNode.localName(), spriteNode.@x, spriteNode.@y)
                );
            }

            // run init events, events that happen when the room
            // is first loaded/visited

            for each (var eventNode:XML in Main.gameXML.world[0].room.(@name==roomName).initEvent) {
                if(eventNode.@type.toString() == "vocabulary") {
                    // Re-set the active vocabulary to a specific list.
                    var verbList:Array = [];
                    for each (var verbNode:XML in eventNode.verb) {
                        verbList.push(verbNode.@name.toString());
                    }
                    PlayState.vocabulary.setCurrentVerbsByName(verbList);
                } else if(eventNode.@type.toString() == "setPlayer") {
                    if(PlayState.player.name != eventNode.@name) {
                        PlayState.player = new Player(eventNode.@name, PlayState.player.x, PlayState.player.y);
                    }
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