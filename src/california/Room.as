package california {
    import org.flixel.*;
    import california.sprites.GameSprite;
    import california.sprites.Player;
    import california.behaviors.Behavior;
    
    public class Room {
        public var sprites:FlxGroup;
        public var backgrounds:FlxGroup;
        
        private var width:uint;        
        private var height:uint;

        public var title:String;
        public var roomName:String;

        private var enterBehaviors:Array;
        
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

            // load room 'enter behaviors', behaviors that run when the room is entered
            enterBehaviors = [];
            
            for each (var behaviorNode:XML in Main.gameXML.world[0].room.(@name==roomName).behavior) {
                enterBehaviors.push(Behavior.getBehaviorFromXML(behaviorNode));
            }
        }

        // Run any entrance behaviors, or any other initialization stuff that needs
        // to run every time a room is entered.
        public function enterRoom():void {
            for each(var behavior:Behavior in enterBehaviors) {
                if(!behavior.conditional || PlayState.getFlag(behavior.flagName) == behavior.flagValue) {
                    behavior.run();
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