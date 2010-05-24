package california {
    import org.flixel.*;

    public class Player extends FlxSprite {
        [Embed(source='/../data/newplayer.png')]
        private var PlayerImage:Class;

        private var _move_speed:uint;

        public function Player(X:Number, Y:Number):void {
            super(X,Y);

            this.loadGraphic(PlayerImage, true, true, 12, 12);

            maxVelocity.x = 80;
            maxVelocity.y = 200;

            _move_speed = 800;
            drag.x = 600;

            addAnimation("walk", [0,1,2,3], 12);
            addAnimation("stopped", [9]);

            width = 3;
            offset.x = 6;
        }
        
        override public function update():void {
            super.update();
        }
    }
}