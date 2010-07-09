package california.music {
    import org.flixel.FlxSound;

    public class PannableSound extends FlxSound {

        public function setPanning(pan:Number):void {
            _transform.pan = pan;
        }
    }
}