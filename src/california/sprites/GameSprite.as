package california.sprites {
    import org.flixel.*;
    
    import california.*;

    // Base class for game sprites
    public class GameSprite extends FlxSprite {
        public var name:String;
        public var verboseName:String;

        [Embed(source='/../data/sound/fail.mp3')]
        private var FailSound:Class;
        
        public function GameSprite(name:String, X:Number, Y:Number, SimpleGraphic:Class=null):void {
            this.name = name;
            this.verboseName = name;
            
            super(X,Y,SimpleGraphic);
        }

        public static function getSpriteClass(name:String):Class {
            var sprites:Object = {
                'moon': Moon,
                'lampPost': LampPost
            }
            
            return sprites[name];
        }

        public function getVerbText(verb:Verb):String {
            return verb.template + ' ' + this.verboseName;
        }

        public function handleVerb(verb:Verb):void {
            // this should be overridden by subclasses; just fail
            verbFailure();
        }

        protected function verbFailure():void {
            FlxG.play(FailSound);
        }
    }
}