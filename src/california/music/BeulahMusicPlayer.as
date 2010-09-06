package california.music {
    public class BeulahMusicPlayer extends MusicPlayer {
        public function BeulahMusicPlayer():void {
            super([
                    'loisWhiteNoise', 'loisCrickets',
                    
                    'pigeonSong', 'doveSong', 'magpieSong',
                    'robinSong', 'cardinalSong', 'bluebirdSong',
                    'sparrowSong', 'goldfinchSong', 'chickadeeSong'
                ]);

            soundPlayers['loisWhiteNoise'].play();
            soundPlayers['loisCrickets'].play();
            soundPlayers['loisCrickets'].volume = 0.6;
        }
    }
}