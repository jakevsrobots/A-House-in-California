package california.sprites {
    import org.flixel.*;

    import california.*;
    
    public class MoonStars extends GameSprite {
        [Embed(source='/../data/sprites/moon-stars.png')]
        private var MoonStarsImageClass:Class;
        
        public function MoonStars(X:Number, Y:Number):void {
            super('moonStars', X, Y, MoonStarsImageClass);

            verboseName = 'stars';
        }

        override public function handleVerb(verb:Verb):void {
            switch (verb.name) {
                case 'Look':
                PlayState.dialog.showText('More stars - so many stars!');
                break;
                
                //-------
                default:
                verbFailure();
            }
        }
    }
}