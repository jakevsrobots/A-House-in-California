package california.behaviors {
    import california.PlayState;
    import org.flixel.FlxG;
    
    public class UpdateBirdsBehavior extends Behavior {
        public static var birds:Object = {
            // A House in California
            'pigeon': {
                'x': 174,
                'y': 61,
                'song': 'pigeonSong'
            },
            'dove': {
                'x': 199,
                'y': 63,
                'song': 'doveSong'
            },
            'magpie': {
                'x': 306,
                'y': 68,
                'song': 'magpieSong'
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

                        if(!PlayState.music.isPlaying(birdData['song'])) {
                            PlayState.music.playAsset(birdData['song']);
                        }
                    }
                }
            }
        }
    }
}