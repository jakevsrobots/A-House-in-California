package california.behaviors {
    import california.PlayState;

    public class AddVerbBehavior extends Behavior {
        private var newVerbName:String;

        public function AddVerbBehavior(behaviorNode:XML):void {
            this.newVerbName = behaviorNode.@newVerb.toString();
        }

        override public function run():void {
            PlayState.addVerb(newVerbName);
        }
    }
}