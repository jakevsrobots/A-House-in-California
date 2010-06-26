package california.behaviors {
    import california.PlayState;

    public class SetFlagBehavior extends Behavior {
        private var setFlagName:String;
        private var value:Boolean;

        public function SetFlagBehavior(behaviorNode:XML):void {
            this.setFlagName = behaviorNode.@flagName.toString();
            this.value = behaviorNode.@value.toString() == "1" ? true : false;
        }

        override public function run():void {
            PlayState.setFlag(setFlagName, value);
        }
    }
}