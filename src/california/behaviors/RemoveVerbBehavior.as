package california.behaviors {
    import california.PlayState;
    
    public class RemoveVerbBehavior extends Behavior {
        private var targetVerbName:String;        
        
        public function RemoveVerbBehavior(behaviorNode:XML):void {
            this.targetVerbName = behaviorNode.targetVerb.toString();
        }

        override public function run():void {
            PlayState.removeVerb(targetVerbName);
        }
    }
}