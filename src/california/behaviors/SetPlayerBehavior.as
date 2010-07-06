package california.behaviors {
    import california.PlayState;
    import california.sprites.Player;
    import org.flixel.*;
    
    public class SetPlayerBehavior extends Behavior {
        private var playerName:String;

        public function SetPlayerBehavior(behaviorNode:XML):void {
            playerName = behaviorNode.@name.toString();
        }

        override public function run():void {
            var newPlayer:Player = new Player(playerName, PlayState.player.x, PlayState.player.y);
            PlayState.changePlayer(newPlayer);
        }
    }
}