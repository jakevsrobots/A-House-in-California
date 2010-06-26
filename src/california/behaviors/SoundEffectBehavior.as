package california.behaviors {
    import org.flixel.FlxG;
    import california.Main;
    
    public class SoundEffectBehavior extends Behavior {
        private var soundName:String;
        
        public function SoundEffectBehavior(behaviorNode:XML):void {
            this.soundName = behaviorNode.@soundName.toString();
        }

        override public function run():void {
            FlxG.play(Main.library.getAsset(soundName));
        }
    }
}