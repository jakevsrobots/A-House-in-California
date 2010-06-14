package california.behaviors {
    import org.flixel.FlxG;
    import california.PlayState;
    
    public class AddFireflyBehavior extends Behavior {
        public function FlashBehavior():void {
        }

        override public function run():void {
            PlayState.instance.fireflyCount += 1;
            if(PlayState.instance.fireflyCount >= PlayState.instance.firefliesNeeded) {
                PlayState.addVerb("Light");
            }
        }
    }
}