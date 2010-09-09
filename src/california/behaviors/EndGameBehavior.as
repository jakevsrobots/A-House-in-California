package california.behaviors {
    import california.PlayState;

    public class EndGameBehavior extends Behavior {

        public function EndGameBehavior(behaviorNode:XML):void {
        }

        override public function run():void {
            PlayState.instance.endGame();
        }
    }
}