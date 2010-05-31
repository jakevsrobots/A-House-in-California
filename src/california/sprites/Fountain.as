package california.sprites {
    import org.flixel.*;

    import california.*;
    
    public class Fountain extends GameSprite {
        [Embed(source='/../data/sprites/back-yard-fountain.png')]
        private var FountainImageClass:Class;
        
        public function Fountain(X:Number, Y:Number):void {
            super('fountain', X, Y, FountainImageClass);
        }

        override public function handleVerb(verb:Verb):void {
            switch (verb.name) {
                case 'Look':
                break;
                
                //-------
                default:
                verbFailure();
            }
        }
    }
}