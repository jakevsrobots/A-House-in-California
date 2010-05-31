package california.sprites {
    import org.flixel.*;

    import california.*;
    
    public class SmallFlowerPots extends GameSprite {
        [Embed(source='/../data/sprites/small-flower-pots.png')]
        private var SmallFlowerPotsImageClass:Class;
        
        public function SmallFlowerPots(X:Number, Y:Number):void {
            super('smallFlowerPots', X, Y, SmallFlowerPotsImageClass);
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