package california.sprites {
    import org.flixel.*;
    import california.Main;
    
    public class LoisPlayer extends Player {
        public function LoisPlayer(X:Number, Y:Number):void {
            super('Lois',X,Y);

            var PlayerImage:Class = Main.library.getAsset('loisPlayer');

            this.loadGraphic(PlayerImage, true, true, 12, 12);

            addAnimation("walk", [0,1,2,3], 12);
            addAnimation("stopped", [9]);
         }

     }
}