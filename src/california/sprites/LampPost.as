package california.sprites {
    import org.flixel.*;

    import california.*;
    
    public class LampPost extends GameSprite {
        [Embed(source='/../data/sprites/lamppost.png')]
        private var LampPostImageClass:Class;
        
        public function LampPost(X:Number, Y:Number):void {
            super('lampPost', X, Y, LampPostImageClass);

            verboseName = 'lamp post';
        }

        override public function handleVerb(verb:Verb):void {
            switch (verb.name) {
                case 'Look':
                PlayState.dialog.showText('The light was out. It was dark, and a little scary.');
                break;
                //-------
            }
        }
    }
}