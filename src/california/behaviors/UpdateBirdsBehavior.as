package california.behaviors {
    import california.PlayState;
    import org.flixel.FlxG;
    
    public class UpdateBirdsBehavior extends Behavior {
        public static var birds:Object = {
            // A House in California
            'pigeon': {
                'x': 174,
                'y': 61,
                'song': 'pigeonSong',
                'panning': -1
            },
            'dove': {
                'x': 206,
                'y': 64,
                'song': 'doveSong',
                'panning': -0.7
            },
            'magpie': {
                'x': 280,
                'y': 65,
                'song': 'magpieSong',
                'panning': 1
            }
            
        };
        
        public function UpdateBirdsBehavior(behaviorNode:XML):void {
        }

        override public function run():void {
            for (var birdName:String in UpdateBirdsBehavior.birds) {
                
                if(PlayState.getFlag(birdName + 'Befriended')) {
                    if(PlayState.instance.currentRoom.getSprite(birdName) == null) {
                        var birdData:Object = UpdateBirdsBehavior.birds[birdName];
                        
                        PlayState.addSprite(birdName, birdData['x'], birdData['y']);

                        if(!PlayState.musicPlayer.isPlaying(birdData['song'])) {
                            PlayState.musicPlayer.playAsset(birdData['song']);
                            PlayState.musicPlayer.setAssetVolume(birdData['song'], 0.3);
                            PlayState.musicPlayer.setAssetPanning(birdData['song'], birdData['panning']);
                        }
                    }
                }
            }
        }
    }
}