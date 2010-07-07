package california.music {
    import org.flixel.*;

    import california.Main;
    import california.PlayState;

    public class MusicPlayer {
        // Static
        public static var musicPlayerClasses:Object;
        
        public static function getMusicPlayerClass(name:String):Class {
            if(MusicPlayer.musicPlayerClasses == null) {
                MusicPlayer.musicPlayerClasses = {};
            }
            
            if(!MusicPlayer.musicPlayerClasses.hasOwnProperty(name)) {
                throw new Error("No music player class registered with the name " + name);
            }

            return MusicPlayer.musicPlayerClasses[name];
        }

        public static function registerMusicPlayerClasses(_musicPlayerClasses:Object):void {
            if(MusicPlayer.musicPlayerClasses == null) {
                MusicPlayer.musicPlayerClasses = {};
            }

            for(var className:Object in _musicPlayerClasses) {
                MusicPlayer.musicPlayerClasses[className] = _musicPlayerClasses[className];
            }
        }
        
        // Instance
        protected var soundPlayers:Object;
        
        public function MusicPlayer(soundAssetNames:Array):void {
            soundPlayers = {};

            for each(var soundAssetName:String in soundAssetNames) {
                soundPlayers[soundAssetName] = new FlxSound();
                soundPlayers[soundAssetName].loadEmbedded(Main.library.getAsset(soundAssetName), true);
            }
        }

        public function playAll():void {
            for (var soundName:String in soundPlayers) {
                soundPlayers[soundName].play();
            }
        }
    }
}