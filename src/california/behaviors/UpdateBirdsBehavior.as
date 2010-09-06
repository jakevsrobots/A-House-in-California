package california.behaviors {
    import california.PlayState;
    import org.flixel.FlxG;
    
    public class UpdateBirdsBehavior extends Behavior {
        public static var birds:Object = {
            // A House in California
            'pigeon': {
                'x': 179,
                'y': 62,
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
            },

            // Up in the Clouds
            'robin': {
                'x': 248,
                'y': 64,
                'song': 'robinSong',
                'panning': 0
            },
            'cardinal': {
                'x': 306,
                'y': 66,
                'song': 'cardinalSong',
                'panning': 1
            },
            'bluebird': {
                'x': 169,
                'y': 60,
                'song': 'bluebirdSong',
                'panning': -0.8
            },

            // A House at the Top of a Hill
            'sparrow': {
                'x': 190,
                'y': 65,
                'song': 'sparrowSong',
                'panning': -1
            },
            'goldfinch': {
                'x': 232,
                'y': 70,
                'song': 'goldfinchSong',
                'panning': 0
            },
            'chickadee': {
                'x': 270,
                'y': 63,
                'song': 'chickadeeSong',
                'panning': 0.5
            }
        };
        
        public function UpdateBirdsBehavior(behaviorNode:XML):void {
        }

        override public function run():void {
            for (var birdName:String in UpdateBirdsBehavior.birds) {
                if(PlayState.getFlag(birdName + 'Befriended')) {
                    var birdData:Object = UpdateBirdsBehavior.birds[birdName];
                    
                    if(PlayState.instance.currentRoom.roomName == 'beulahHome') {
                        if(PlayState.instance.currentRoom.getSprite(birdName) == null) {                        
                            PlayState.addSprite(birdName, birdData['x'], birdData['y']);
                        }
                    }

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