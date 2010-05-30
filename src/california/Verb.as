package california {
    import org.flixel.*;
    
    public class Verb extends FlxText {
        public var name:String;
        public var template:String;
        public var persist:Boolean;

        public var highlight:Boolean = false;
        
        public function Verb(_name:String):void {
            name = _name;
            
            super(0, 0, this.name.length * 8, name);
            
            setFormat(null, 8, 0xffffffff);

            height = 8;    
        }

        override public function update():void {
            if(highlight) {
                 alpha = 1.0;                
            } else {
                 alpha = 0.5;
            }
            
            super.update();
        }
    }
}