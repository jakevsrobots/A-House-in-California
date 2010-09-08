package california.music {
    
    public class CutSceneMusicPlayer extends MusicPlayer {
        public function CutSceneMusicPlayer():void {
            super([
                    "loisSynth",
                    "loisSynth2"                    
                ]);
            
            playAll();
        }
    }
}
