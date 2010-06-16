package california.behaviors {
    import california.PlayState;

    public class CatchFirefliesBehavior extends Behavior {
        public function CatchFirefliesBehavior():void {
        }

        override public function run():void {
            var flagName:String = PlayState.instance.currentRoom.roomName + '-firefliesCaught';
            if(!PlayState.getFlag(flagName)) {
                PlayState.setFlag(flagName, true);
                //PlayState.instance.player.increaseGlow();
            }

            // Check if all the fireflies have been caught
            if(
                PlayState.getFlag('theSurfaceOfTheMoon-firefliesCaught') &&
                PlayState.getFlag('aFountainInABackYard-firefliesCaught') &&
                PlayState.getFlag('aComputerInAGuestRoom-firefliesCaught') ) {
                PlayState.vocabulary.replaceVerb('Catch', 'Light');
            }
        }
    }
}