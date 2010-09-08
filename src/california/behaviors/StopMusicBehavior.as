package california.behaviors {
    import california.PlayState;
    import california.music.MusicPlayer;

    import org.flixel.FlxG;
    import org.flixel.FlxSound;    
    
    public class StopMusicBehavior extends Behavior {
        public function StopMusicBehavior(behaviorNode:XML):void {
        }

        override public function run():void {
            for each(var sound:FlxSound in FlxG.sounds) {
                sound.fadeOut(2);
            }
        }
    }
}