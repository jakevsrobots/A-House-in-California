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
                soundPlayers[soundAssetName] = new PannableSound();
                soundPlayers[soundAssetName].loadEmbedded(Main.library.getAsset(soundAssetName), true);
            }
        }

        public function playAll():void {
            for (var soundName:String in soundPlayers) {
                soundPlayers[soundName].play();
            }
        }

        public function playAsset(soundAssetName:String):void {
            if(!soundPlayers.hasOwnProperty(soundAssetName)) {
                throw new Error('No such sound asset added to this player: ' + soundAssetName);
            }
            soundPlayers[soundAssetName].play();            
        }

        public function setAssetVolume(soundAssetName:String, volume:Number):void {
            if(!soundPlayers.hasOwnProperty(soundAssetName)) {
                throw new Error('No such sound asset added to this player: ' + soundAssetName);
            }
            
            soundPlayers[soundAssetName].volume = volume;
        }

        public function setAssetPanning(soundAssetName:String, panning:Number):void {
            if(!soundPlayers.hasOwnProperty(soundAssetName)) {
                throw new Error('No such sound asset added to this player: ' + soundAssetName);
            }
            
            soundPlayers[soundAssetName].setPanning(panning);
        }

        public function isPlaying(soundAssetName:String):Boolean {
            if(!soundPlayers.hasOwnProperty(soundAssetName)) {
                throw new Error('No such sound asset added to this player: ' + soundAssetName);
            }
            
            return soundPlayers[soundAssetName].playing;
        }
    }
}