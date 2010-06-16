package california.behaviors {
    import california.PlayState;

    public class FadeToMenuBehavior extends Behavior {
        private var delay:Number;

        public function FadeToMenuBehavior(delay:Number):void {
            this.delay = delay;
        }

        override public function run():void {
            PlayState.instance.fadeToMenu(delay);
        }
    }
}