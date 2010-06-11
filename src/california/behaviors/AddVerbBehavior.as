package california.behaviors {
    import california.PlayState;

    public class AddVerbBehavior extends Behavior {
        private var newVerbName:String;

        public function AddVerbBehavior(newVerbName:String):void {
            this.newVerbName = newVerbName;
        }

        override public function run():void {
            PlayState.addVerb(newVerbName);
        }
    }
}