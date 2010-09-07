package california.behaviors {
    import california.PlayState;
    import california.sprites.GameSprite;
    import california.sprites.Butterfly;

    public class CatchButterfliesBehavior extends Behavior {
        private var color:String
        
        public function CatchButterfliesBehavior(behaviorNode:XML):void {
            color = behaviorNode.@color;
        }

        override public function run():void {
            PlayState.setFlag(color + 'ButterfliesCaught', true);

            if(PlayState.getFlag('greenButterfliesCaught') && PlayState.getFlag('orangeButterfliesCaught')) {
                if(!PlayState.getFlag('createdSleepyBoy')) {
                    PlayState.setFlag('readyToCreateSleepyBoy', true);
                }
            }
            
            for each(var sprite:GameSprite in PlayState.instance.currentRoom.sprites.members) {
                if(sprite is Butterfly) {
                    var butterfly:Butterfly = sprite as Butterfly;
                    if(butterfly.name == color + 'Butterfly') {
                        butterfly.flyToRestingPlace();
                    }
                }
            }
        }
    }
}