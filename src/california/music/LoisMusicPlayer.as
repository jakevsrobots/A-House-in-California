package california.music {
    
    public class LoisMusicPlayer extends MusicPlayer {
        public function LoisMusicPlayer():void {
            super([
                    "loisCrickets",
                    "loisWhiteNoise",
                    "loisSynth"
                ]);
            
            playAll();
        }
    }
}