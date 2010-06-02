package california {
    import org.flixel.*;

    import california.behaviors.Behavior;

    public class GameSprite extends FlxSprite {
        //--------------------------------------------------------------------
        // Instance
        //--------------------------------------------------------------------
        public var name:String;
        private var data:Object; // locally store this sprite's data for ease of lookup
        
        [Embed(source="/../data/sound/fail.mp3")]
        private var FailSound:Class;
        
        public function GameSprite(name:String, X:Number, Y:Number):void {
            this.name = name;
            this.data = GameSprite.spriteDatabase[name];

            var ImageClass:Class = Main.library.getAsset(name);
            
            super(X,Y,ImageClass);
        }

        public function getVerbText(verb:Verb):String {
            return verb.template + ' ' + this.data.verboseName;
        }

        public function handleVerb(verb:Verb):void {
            if(this.data.verbs.hasOwnProperty(verb.name)) {
                for each(var behavior:Behavior in this.data.verbs[verb.name].behaviors) {
                    //FlxG.log('found behavior ' + behavior + ' for verb ' + verb.name);
                    behavior.run();
                }
            } else {
                verbFailure();
            }
        }

        protected function verbFailure():void {
            FlxG.play(FailSound);
        }

        override public function update():void {
            super.update();
        }
        
        //--------------------------------------------------------------------
        // Static
        //--------------------------------------------------------------------
        [Embed(source="/../data/sprites.xml",
                mimeType="application/octet-stream")]
        public static var SpritesXML:Class;
        public static var spriteDatabase:Object;
        
        // Parse the XML sprite database into an actionscript Object
        // for easy inflation into an actual GameSprite instance as needed.
        
        public static function createSpriteDatabase():void {
            GameSprite.spriteDatabase = {};
            
            var xml:XML = new XML(new GameSprite.SpritesXML());

            for each(var spriteNode:XML in xml.sprite) {
                var spriteObject:Object = {};

                // Core info
                spriteObject['name'] = spriteNode.name.toString();
                if(spriteNode.verboseName.length()) {
                    spriteObject['verboseName'] = spriteNode.verboseName.toString();
                } else {
                    spriteObject['verboseName'] = spriteNode.name.toString();
                }

                // Verbs that this sprite can respond to
                spriteObject['verbs'] = {};
                for each(var verbNode:XML in spriteNode.verbs.verb) {
                    var verbObject:Object = {};

                    verbObject['behaviors'] = [];
                    for each(var behaviorNode:XML in verbNode.behavior) {
                        verbObject['behaviors'].push(Behavior.getBehaviorFromXML(behaviorNode));
                    }

                    spriteObject['verbs'][verbNode.@name] = verbObject;
                }

                spriteDatabase[spriteObject['name']] = spriteObject;
            }
        }
        
    }
}