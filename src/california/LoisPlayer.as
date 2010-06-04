package california {
    import org.flixel.*;
    
    public class LoisPlayer extends Player {
        [Embed(source='/../data/newplayer.png')]
        private var PlayerImage:Class;

        public function LoisPlayer(X:Number, Y:Number):void {
            super('Lois',X,Y);

            this.loadGraphic(PlayerImage, true, true, 12, 12);

            addAnimation("walk", [0,1,2,3], 12);
            addAnimation("stopped", [9]);
        }
    }
}