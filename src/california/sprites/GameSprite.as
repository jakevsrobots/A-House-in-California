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
        public var interactive:Boolean; // Whether this sprite can be interacted with
                                        // (if set to 'false', it will not even appear 
                                        // to mouseover
        private var data:Object; // locally store this sprite's data for ease of lookup
        
        [Embed(source="/../data/sound/fail.mp3")]
        private var FailSound:Class;
        
        public function GameSprite(name:String, X:Number, Y:Number, loadImage:Boolean=true):void {
            this.name = name;
            this.data = GameSprite.spriteDatabase[name];

            this.interactive = this.data['interactive']
            
            var ImageClass:Class
            if(loadImage) {
                ImageClass = Main.library.getAsset(this.data['assetName']);
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
                    PlayState.player.setWalkTarget((this.x + this.width * 0.5), aggregateBehaviorFunction);
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

        public static function registerSpriteClasses(_spriteClasses:Object):void {
            if(GameSprite.spriteClasses == null) {
                GameSprite.spriteClasses = {};
            }
            
            for(var className:Object in _spriteClasses) {
                GameSprite.spriteClasses[className] = _spriteClasses[className];
            }
        }
        
        // Parse the XML sprite database into an actionscript Object
        // for easy inflation into an actual GameSprite instance as needed.
        
        public static function createSpriteDatabase():void {
            GameSprite.spriteDatabase = {};
            
            var xml:XML = Main.gameXML.sprites[0];

            for each(var spriteNode:XML in xml.sprite) {
                var spriteObject:Object = {};

                // Core info
                spriteObject['name'] = spriteNode.@name.toString();
                if(spriteNode.@verboseName.toString()) {
                    spriteObject['verboseName'] = spriteNode.@verboseName.toString();
                } else {
                    spriteObject['verboseName'] = spriteNode.@name.toString();
                }

                if(spriteNode.@assetName.toString()) {
                    spriteObject['assetName'] = spriteNode.@assetName.toString();
                } else {
                    spriteObject['assetName'] = spriteObject['name'];
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

                if(spriteNode.@interactive == "0") {
                    spriteObject['interactive'] = false;
                } else {
                    spriteObject['interactive'] = true;
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
                    spriteObject['verbs']['Look'] = {'behaviors': [new DialogBehavior(spriteNode.look[0])]}
                }
                
                spriteDatabase[spriteObject['name']] = spriteObject;
            }
        }
        
    }
}