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
                soundPlayers[soundAssetName].survive = true;
            }
        }

        public function playAll():void {
            for (var soundName:String in soundPlayers) {
                soundPlayers[soundName].play();
                FlxG.sounds.push(soundPlayers[soundName]);
            }
        }

        public function playAsset(soundAssetName:String):void {
            if(!soundPlayers.hasOwnProperty(soundAssetName)) {
                throw new Error('No such sound asset added to this player: ' + soundAssetName);
            }
            soundPlayers[soundAssetName].play();
            FlxG.sounds.push(soundPlayers[soundAssetName]);
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

        public function fadeOut(seconds:Number=5):void {
            for (var soundAssetName:String in soundPlayers) {
                if(soundPlayers[soundAssetName]) {
                    if(soundPlayers[soundAssetName].playing) {
                        FlxG.log('fading out: ' + soundAssetName);
                        soundPlayers[soundAssetName].fadeOut(seconds);
                    } else {
                        FlxG.log('not playing: ' + soundAssetName);
                    }
                } else {
                    FlxG.log('no sound: ' + soundAssetName);
                }
            }
        }
    }
}