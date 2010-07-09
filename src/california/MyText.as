package california {
    import org.flixel.FlxText;
	import flash.text.TextFormat;    
    
    public class MyText extends FlxText {
        public function MyText(X:Number, Y:Number, Width:uint, Text:String=null):void {
            super(X, Y, Width, Text);
        }

        public function get textWidth():Number {
            return _tf.textWidth;
        }

        public function setWidth(width:Number):void {
            this.width = width;
            this.frameWidth = width;
            _regen = true;
            calcFrame();
        }
    }
}