package california.sprites {
    import org.flixel.*;

    import california.*;
    
    public class SmallFlowerPots2 extends GameSprite {
        [Embed(source='/../data/sprites/small-flower-pots-2.png')]
        private var SmallFlowerPotsImageClass:Class;
        
        public function SmallFlowerPots2(X:Number, Y:Number):void {
            super('smallFlowerPots2', X, Y, SmallFlowerPotsImageClass);
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