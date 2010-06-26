package california.behaviors {
    import california.PlayState;

    public class FadeToMenuBehavior extends Behavior {
        private var delay:Number;

        public function FadeToMenuBehavior(behaviorNode:XML):void {
            this.delay = Behavior.stringToNumber(behaviorNode.@delay);
        }

        override public function run():void {
            PlayState.instance.fadeToMenu(delay);
        }
    }
}