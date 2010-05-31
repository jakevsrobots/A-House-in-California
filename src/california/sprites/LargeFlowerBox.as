package california.sprites {
    import org.flixel.*;

    import california.*;
    
    public class LargeFlowerBox extends GameSprite {
        [Embed(source='/../data/sprites/large-flower-box.png')]
        private var FlowerBoxImageClass:Class;
        
        public function LargeFlowerBox(X:Number, Y:Number):void {
            super('largeFlowerBox', X, Y, FlowerBoxImageClass);
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