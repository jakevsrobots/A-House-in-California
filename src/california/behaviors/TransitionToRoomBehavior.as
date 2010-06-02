package california.behaviors {
    import california.PlayState;
    
    public class TransitionToRoomBehavior extends Behavior {
        private var targetRoomName:String;
        
        public function TransitionToRoomBehavior(targetRoomName:String):void {
            this.targetRoomName = targetRoomName;
        }

        override public function run():void {
            PlayState.transitionToRoom(targetRoomName);
        }
    }
}