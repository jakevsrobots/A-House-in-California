package california.behaviors {
    import california.PlayState;

    public class ReplaceVerbBehavior extends Behavior {
        private var oldVerbName:String;
        private var newVerbName:String;

        public function ReplaceVerbBehavior(behaviorNode:XML):void {
            this.oldVerbName = behaviorNode.@oldVerb.toString();
            this.newVerbName = behaviorNode.@newVerb.toString();
        }

        override public function run():void {
            //PlayState.vocabulary.replaceVerb(oldVerbName, newVerbName);
            PlayState.instance.replaceVerb(oldVerbName, newVerbName);
        }
    }
}