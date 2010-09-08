package california.music {
    
    public class MenuMusicPlayer extends MusicPlayer {
        public function MenuMusicPlayer():void {
            super([
                    //"loisCrickets",
                    "loisWhiteNoise",
                    "loisWhiteNoise2",                    
                    //"loisSynth"
                ]);
            
            playAll();
        }
    }
}