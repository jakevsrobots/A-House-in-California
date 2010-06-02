package california {
    import org.flixel.*;
    
    public class Background {
        public var image:FlxSprite;
        public var name:String;
    
        public function Background(_name:String, _x:Number=0, _y:Number=0):void {
            name = _name;
            image = new FlxSprite(_x, _y, Main.library.getAsset(name));
        }
    }
}