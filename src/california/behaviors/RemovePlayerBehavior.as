package california.behaviors {
    import california.PlayState;

    public class RemovePlayerBehavior extends Behavior {
        public function RemovePlayerBehavior(behaviorNode:XML):void {
        }

        override public function run():void {
            PlayState.removePlayer();
        }
    }
}