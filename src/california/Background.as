package california {
    import org.flixel.*;
    
    public class Background {
        public var image:FlxSprite;
        public var name:String;

        // Image classes
        [Embed(source='/../data/backgrounds/home-background.png')]
            private var HouseBackgroundImage:Class;
        [Embed(source='/../data/backgrounds/a-fountain-in-a-back-yard-background.png')]
            private var FountainBackgroundImage:Class;
    
        public function Background(_name:String, _x:Number=0, _y:Number=0):void {
            // Background data
            var backgroundData:Object = {
                'houseBackground': HouseBackgroundImage,
                'fountainBackground': FountainBackgroundImage
            }
            
            name = _name;
            image = new FlxSprite(_x, _y, backgroundData[name]);
        }
    }
}