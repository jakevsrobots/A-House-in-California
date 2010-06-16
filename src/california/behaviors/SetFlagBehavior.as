package california.behaviors {
    import california.PlayState;

    public class SetFlagBehavior extends Behavior {
        private var setFlagName:String;
        private var value:Boolean;

        public function SetFlagBehavior(setFlagName:String, rawValue:String):void {
            this.setFlagName = setFlagName;
            this.value = rawValue == "1" ? true : false;
        }

        override public function run():void {
            PlayState.setFlag(setFlagName, value);
        }
    }
}