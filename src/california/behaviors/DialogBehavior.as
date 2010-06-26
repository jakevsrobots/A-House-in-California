package california.behaviors {
    import california.PlayState;
    
    public class DialogBehavior extends Behavior {
        private var text:String;
        
        public function DialogBehavior(behaviorNode:XML):void {
            this.text = behaviorNode.toString();
        }

        override public function run():void {
            PlayState.dialog.showText(this.text);
        }
    }
}