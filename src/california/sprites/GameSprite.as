package california.sprites {
    import org.flixel.*;

    import california.behaviors.Behavior;
    import california.behaviors.DialogBehavior;

    import california.Verb;
    import california.Main;
    import california.PlayState;
    
    public class GameSprite extends FlxSprite {
        //--------------------------------------------------------------------
        // Instance
        //--------------------------------------------------------------------
        public var name:String;
        private var data:Object; // locally store this sprite's data for ease of lookup
        
        [Embed(source="/../data/sound/fail.mp3")]
        private var FailSound:Class;
        
        public function GameSprite(name:String, X:Number, Y:Number, loadImage:Boolean=true):void {
            this.name = name;
            this.data = GameSprite.spriteDatabase[name];

            var ImageClass:Class
            if(loadImage) {
                ImageClass = Main.library.getAsset(name);
            } else {
                ImageClass = null;
            }
            
            super(X,Y,ImageClass);
        }

        public function getVerbText(verb:Verb):String {
            if(this.data.verbs.hasOwnProperty(verb.name)) {
                if(this.data.verbs[verb.name].hasOwnProperty('verbText')) {
                    return this.data.verbs[verb.name]['verbText'];
                }
            }
            
            return verb.template + ' ' + this.data.verboseName;
        }

        public function handleVerb(verb:Verb):void {
            if(this.data.verbs.hasOwnProperty(verb.name)) {
                var aggregateBehaviorFunction:Function = function():void {
                    for each(var behavior:Behavior in data.verbs[verb.name].behaviors) {
                        if(!behavior.conditional || PlayState.getFlag(behavior.flagName) == behavior.flagValue) {
                            behavior.run();
                        }
                    }
                }
                
                if(this.data.verbs[verb.name].moveTo) {
                    // Walk to the sprite before any behaviors
                    PlayState.player.setWalkTarget(this.x + this.width * 0.5, aggregateBehaviorFunction);
                } else {
                    // Just perform the behaviors now
                    aggregateBehaviorFunction();
                }
            } else {
                verbFailure();
            }
        }
 
        protected function verbFailure():void {
            FlxG.play(FailSound);
        }

        //--------------------------------------------------------------------
        // Static
        //--------------------------------------------------------------------
        public static var spriteDatabase:Object;
        public static var spriteClasses:Object;
        
        // Parse the XML sprite database into an actionscript Object
        // for easy inflation into an actual GameSprite instance as needed.
        
        public static function createSpriteDatabase():void {
            // Any custom sprite classes
            spriteClasses = {
                "TrappedFireflies": TrappedFireflies,
                "Moon": Moon,
                "Window": Window,
                "ComputerScreenBoy": ComputerScreenBoy,
                "ComputerScreenRockysBoots": ComputerScreenRockysBoots,
                "JarOfBugs": JarOfBugs,
                "LooseFireflies": LooseFireflies
            };
            
            GameSprite.spriteDatabase = {};
            
            var xml:XML = Main.gameXML.sprites[0];

            for each(var spriteNode:XML in xml.sprite) {
                var spriteObject:Object = {};

                // Core info
                spriteObject['name'] = spriteNode.name.toString();
                if(spriteNode.verboseName.length()) {
                    spriteObject['verboseName'] = spriteNode.verboseName.toString();
                } else {
                    spriteObject['verboseName'] = spriteNode.name.toString();
                }

                if(spriteNode.@spriteClass.toString()) {
                    if(spriteClasses.hasOwnProperty(spriteNode.@spriteClass.toString())) {
                        spriteObject['spriteClass'] = spriteClasses[spriteNode.@spriteClass.toString()];
                    } else {
                        throw new Error('No sprite class registered under the name ' + spriteNode.@spriteClass.toString());
                    }
                } else {
                    spriteObject['spriteClass'] = GameSprite;
                }

                // Verbs that this sprite can respond to
                spriteObject['verbs'] = {};
                for each(var verbNode:XML in spriteNode.verb) {
                    var verbObject:Object = {};

                    if(verbNode.@moveTo.toString() == "1") {
                        verbObject['moveTo'] = true;
                    } else {
                        verbObject['moveTo'] = false;                        
                    }
                    
                    verbObject['behaviors'] = [];
                    for each(var behaviorNode:XML in verbNode..behavior) {
                        verbObject['behaviors'].push(Behavior.getBehaviorFromXML(behaviorNode));
                    }
                    
                    if(verbNode.@verbText.toString()) {
                        verbObject['verbText'] = verbNode.@verbText.toString();
                    }
                    
                    spriteObject['verbs'][verbNode.@name] = verbObject;
                }

                // Add a special 'look' shortcut, since it's so common
                if(spriteNode.look.length()) {
                    spriteObject['verbs']['Look'] = {'behaviors': [new DialogBehavior(spriteNode.look.toString())]}
                }
                
                spriteDatabase[spriteObject['name']] = spriteObject;
            }
        }
        
    }
}