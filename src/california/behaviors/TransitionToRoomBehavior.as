package california.behaviors {
    import california.PlayState;
    
    public class TransitionToRoomBehavior extends Behavior {
        private var targetRoomName:String;
        
        public function TransitionToRoomBehavior(behaviorNode:XML):void {
            this.targetRoomName = behaviorNode.@targetRoom.toString();
        }

        override public function run():void {
            PlayState.transitionToRoom(targetRoomName);
        }
    }
}