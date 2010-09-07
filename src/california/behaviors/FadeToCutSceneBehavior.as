package california.behaviors {
    import california.PlayState;

    public class FadeToCutSceneBehavior extends Behavior {
        private var delay:Number;
        private var cutSceneName:String;
        private var roomName:String;
        
        public function FadeToCutSceneBehavior(behaviorNode:XML):void {
            delay = Behavior.stringToNumber(behaviorNode.@delay);
            cutSceneName = behaviorNode.@cutSceneName;
            roomName = behaviorNode.@roomName;
        }

        override public function run():void {
            PlayState.instance.fadeToCutScene(delay, cutSceneName, roomName);
        }
    }
}