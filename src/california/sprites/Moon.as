package california.sprites {
    import org.flixel.*;

    import california.*;
    
    public class Moon extends GameSprite {
        [Embed(source='/../data/sprites/moon.png')]
        private var MoonImageClass:Class;
        
        public function Moon(X:Number, Y:Number):void {
            super('moon', X, Y, MoonImageClass);
        }

        override public function handleVerb(verb:Verb):void {
            switch (verb.name) {
                case 'Look':
                PlayState.dialog.showText("Enough moonlight to walk by, but that's about it.");
                break;
                
                case 'Remember':
                PlayState.transitionToRoom('fountainTest');
                break;
                
                //-------                
                default:
                verbFailure();
            }
        }
    }
}