package california.music {
    
    public class LoisMusicPlayer extends MusicPlayer {
        public function LoisMusicPlayer():void {
            super([
                    "loisCrickets",
                    "loisCrickets2",                    
                    //"loisWhiteNoise",
                    //"loisWhiteNoise2",                    
//                    "loisSynth"
                ]);
            
            playAll();
        }
    }
}