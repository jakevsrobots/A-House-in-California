package california.sprites {
    import org.flixel.*;

    import california.*;
    
    public class Dome extends GameSprite {
        [Embed(source='/../data/sprites/dome.png')]
        private var DomeImageClass:Class;
        
        public function Dome(X:Number, Y:Number):void {
            super('moonFountain', X, Y, DomeImageClass);

            verboseName = 'dome';
        }

        override public function handleVerb(verb:Verb):void {
            switch (verb.name) {
                case 'Look':
                PlayState.dialog.showText("It's a protective dome.");
                break;
                
                //-------
                default:
                verbFailure();
            }
        }
    }
}