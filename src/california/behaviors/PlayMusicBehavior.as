package california.behaviors {
    import california.PlayState;
    import california.music.MusicPlayer;

    import org.flixel.FlxG;
    
    public class PlayMusicBehavior extends Behavior {
        private var musicName:String;
        
        public function PlayMusicBehavior(behaviorNode:XML):void {
            musicName = behaviorNode.@musicName.toString();
        }

        override public function run():void {
            var musicPlayerClass:Class = MusicPlayer.getMusicPlayerClass(this.musicName);
            PlayState.musicPlayer = new musicPlayerClass();
        }
    }
}