package california.music {
    
    public class AllBirdsMusicPlayer extends MusicPlayer {
        public function AllBirdsMusicPlayer():void {
            super([
                    "allBirdsMusic"
                ]);
            
            playAll();
        }
    }
}