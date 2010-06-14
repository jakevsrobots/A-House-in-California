package california.behaviors {
    import california.PlayState;

    public class ReplaceVerbBehavior extends Behavior {
        private var oldVerbName:String;
        private var newVerbName:String;

        public function ReplaceVerbBehavior(oldVerbName:String, newVerbName:String):void {
            this.oldVerbName = oldVerbName;
            this.newVerbName = newVerbName;
        }

        override public function run():void {
            PlayState.vocabulary.replaceVerb(oldVerbName, newVerbName);
        }
    }
}