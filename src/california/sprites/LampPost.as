package california.sprites {
    import org.flixel.*;

    public class LampPost extends GameSprite {
        [Embed(source='/../data/sprites/lamppost.png')]
        private var LampPostImageClass:Class;
        
        public function LampPost(X:Number, Y:Number):void {
            super('lampPost', X, Y, LampPostImageClass);

            verboseName = 'lamp post';
        }
    }
}