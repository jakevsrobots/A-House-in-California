package california.sprites {
    import org.flixel.*;

    import california.*;
    
    public class MoonFountain extends GameSprite {
        [Embed(source='/../data/sprites/moon-fountain.png')]
        private var MoonFountainImageClass:Class;
        
        public function MoonFountain(X:Number, Y:Number):void {
            super('moonFountain', X, Y, MoonFountainImageClass);

            verboseName = 'small fountain';
        }

        override public function handleVerb(verb:Verb):void {
            switch (verb.name) {
                case 'Look':
                PlayState.dialog.showText("It looks familiar but somehow ... smaller.");
                break;

                case 'Remember':
                PlayState.transitionToRoom('aFountainInABackYard');
                break;

                //-------
                default:
                verbFailure();
            }
        }
    }
}