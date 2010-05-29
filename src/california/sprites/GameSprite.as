package california.sprites {
    import org.flixel.*;
    
    import california.*;
    
    // Base class for game sprites
    public class GameSprite extends FlxSprite {
        public var name:String;
        public var verboseName:String;
        
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
    }
}