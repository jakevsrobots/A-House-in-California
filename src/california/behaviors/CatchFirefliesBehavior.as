package california.behaviors {
    import california.PlayState;

    public class CatchFirefliesBehavior extends Behavior {
        public function CatchFirefliesBehavior():void {
        }

        override public function run():void {
            /*
            // Set up the fireflyRoomStatus object to track which fireflies have
            // been caught.
            if(PlayState.instance.fireflyRoomStatus == null) {
                PlayState.instance.fireflyRoomStatus = {
                    //'loisHome': false,
                    'theSurfaceOfTheMoon': false,
                    'aFountainInABackYard': false,
                    'aComputerInAGuestRoom': false
                };
            }

            if(!PlayState.instance.fireflyRoomStatus[PlayState.instance.currentRoom]) {
                PlayState.instance.fireflyRoomStatus[PlayState.instance.currentRoom] = true;
                //PlayState.instance.player.increaseGlow();
            }

            // Check if all the fireflies have been caught
            if(
                PlayState.instance.fireflyRoomStatus['theSurfaceOfTheMoon'] &&
                PlayState.instance.fireflyRoomStatus['aFountainInABackYard'] &&
                PlayState.instance.fireflyRoomStatus['aComputerInAGuestRoom'] ) {
                PlayState.vocabulary.replaceVerb('Catch', 'Light');
            }

            */
        }
    }
}