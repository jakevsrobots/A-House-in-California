package california {
    import org.flixel.*;
    
    public class Verb extends FlxText {
        public var name:String;
        public var template:String;
        public var persist:Boolean;

        public function Verb(_name:String):void {
            FlxG.log('init verb ' + _name);
            
            name = _name
            
            super(20, 20, FlxG.width, name);
            
            setFormat(null, 8, 0xffffffff);
        }
    }
}