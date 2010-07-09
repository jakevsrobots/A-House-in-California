package california {
    import org.flixel.*;
    
    public class Verb extends MyText {
        public var name:String;
        public var template:String;
        public var highlight:Boolean = false;
        
        public function Verb(_name:String):void {
            name = _name;
            
            super(0, 0, FlxG.width, name);
            //super(0, 0, name.length * 8, name);
            setFormat(Main.gameFontFamily, Main.gameFontSize, 0xffffffff);
            height = 8;

            setWidth(textWidth + 8);
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