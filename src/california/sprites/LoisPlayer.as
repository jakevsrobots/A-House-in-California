package california.sprites {
    import org.flixel.*;

    import california.*;
    
    public class LoisPlayer extends Player {
        [Embed(source='/../data/newplayer.png')]
        private var PlayerImage:Class;

        public function LoisPlayer(X:Number, Y:Number):void {
            super('Lois',X,Y);

            this.loadGraphic(PlayerImage, true, true, 12, 12);

            addAnimation("walk", [0,1,2,3], 12);
            addAnimation("stopped", [9]);
        }

        override public function handleVerb(verb:Verb):void {
            switch (verb.name) {
                case 'Look':
                PlayState.dialog.showText('It is Lois.');
                break;
                
                //-------
                default:
                verbFailure();
            }
        }
    }
}