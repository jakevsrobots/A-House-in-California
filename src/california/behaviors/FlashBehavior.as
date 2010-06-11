package california.behaviors {
    import org.flixel.FlxG;
        
    public class FlashBehavior extends Behavior {
        public function FlashBehavior():void {
        }

        override public function run():void {
            FlxG.flash.start(0xffffffff, 0.5, function():void {
                    FlxG.flash.stop();
                });
        }
    }
}