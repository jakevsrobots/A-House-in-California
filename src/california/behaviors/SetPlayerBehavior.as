package california.behaviors {
    import california.PlayState;
    import california.sprites.Player;

    public class SetPlayerBehavior extends Behavior {
        private var playerName:String;

        public function SetPlayerBehavior(behaviorNode:XML):void {
            playerName = behaviorNode.@name.toString();
        }

        override public function run():void {
            PlayState.player = new Player(playerName, PlayState.player.x, PlayState.player.y);
        }
    }
}