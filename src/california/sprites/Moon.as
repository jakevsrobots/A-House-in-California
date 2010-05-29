package california.sprites {
    import org.flixel.*;

    public class Moon extends GameSprite {
        [Embed(source='/../data/sprites/moon.png')]
        private var MoonImageClass:Class;
        
        public function Moon(X:Number, Y:Number):void {
            super('moon', X, Y, MoonImageClass);
        }
    }
}